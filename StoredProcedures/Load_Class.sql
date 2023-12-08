USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aureljo Pepa
-- Create date: 12/05/2023
-- Description:	Loads Data into Dept.Class
-- =============================================\
DROP PROCEDURE IF EXISTS [Project3].[Load_Class];
go
CREATE PROCEDURE [Project3].[Load_Class]
@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();
		DECLARE @startT DATETIME2;
    set @startT = SYSDATETIME();
	
    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

INSERT INTO [Dept].[Class](Section, Code, CourseId, Day, Time, BridgeId, BuildingLocationId, RoomLocationId, Enrolled, Limit, ModeId)
SELECT 
    DISTINCT 
    CSCO.Sec,
    CSCO.Code,
    C.CourseId,
    CSCO.[Day],
    CSCO.[Time],
    IDB.BridgeId,
    BL.BuildingLocationId,
    RL.RoomLocationId,
    CSCO.Enrolled,
    CSCO.Limit,
    MOI.ModeId
FROM Uploadfile.CurrentSemesterCourseOfferings as CSCO
INNER JOIN Dept.Course as C on C.CourseName = SUBSTRING([Course (hr, crd)], 1, CHARINDEX(' (', [Course (hr, crd)]) - 1)
INNER JOIN Dept.Instructor as I on I.InstructorFullName=CSCO.Instructor
INNER JOIN Dept.Department as D on D.DepartmentName = substring(CSCO.[Course (hr, crd)], 1, 4)
INNER JOIN Dept.Instructor_Department_Bridge as IDB on IDB.InstructorId=I.InstructorId AND IDB.DepartmentId=D.DepartmentId
INNER JOIN Location.BuildingLocation as BL on BL.RoomBuilding = SUBSTRING(CSCO.[Location], 1, CHARINDEX(' ', CSCO.[Location]))
INNER JOIN Location.RoomLocation as RL on RL.RoomNumber = SUBSTRING(CSCO.Location, CHARINDEX(' ', CSCO.Location), LEN(CSCO.Location)) 
INNER JOIN Dept.ModeOfInstruction as MOI on MOI.[Mode Of Instruction] = CSCO.[Mode of Instruction];

declare @rowCount as INT;
set @rowCount = (SELECT COUNT(*) FROM Dept.Class);
	
DECLARE @endT DATETIME2;
set @endT = SYSDATETIME();

INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
VALUES(
	@GroupMemberUserAuthorizationKey,
	N'Loads the class and attributes',
	@startT,
		@endT,
	@rowCount
);


END