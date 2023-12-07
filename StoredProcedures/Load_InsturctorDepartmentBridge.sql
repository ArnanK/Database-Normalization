USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan 
-- Create date: 12/04/2023
-- Description:	Loads
-- =============================================
CREATE PROCEDURE [Project3].[Load_DeptDepartment]
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

	INSERT INTO Dept.Instructor_Department_Bridge(InstructorId, DepartmentId)
	SELECT DISTINCT 
		I.InstructorId, D.DepartmentId
	FROM Uploadfile.CurrentSemesterCourseOfferings as O
	INNER JOIN Dept.Department as D on D.DepartmentName = substring(O.[Course (hr, crd)], 1, 4)
	INNER JOIN Dept.Instructor as I on I.InstructorFullName = O.Instructor

	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM Dept.Department);
	
	DECLARE @endT DATETIME2;
    set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all the distinct departments into the Dept.Department Table.',
		@startT,
		 @endT,
		@rowCount
	)


END
