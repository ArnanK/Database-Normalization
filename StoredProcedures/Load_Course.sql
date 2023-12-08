USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abdul Mohammed
-- Create date: 12/05/2023
-- Description:	Loads Data into Dept.Course
-- =============================================\
DROP PROCEDURE IF EXISTS [Project3].[Load_Course];
go
CREATE PROCEDURE [Project3].[Load_Course]
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

INSERT INTO Dept.Course(CourseName,CourseDescription)
SELECT DISTINCT 
	SUBSTRING([Course (hr, crd)], 1, CHARINDEX(' (', [Course (hr, crd)]) - 1) AS CourseCode,
	Description
--    SUBSTRING(Instructor, 1, CHARINDEX(',', Instructor) - 1),
--    SUBSTRING(Instructor, CHARINDEX(',', Instructor) + 2, LEN(Instructor)) 
FROM Uploadfile.CurrentSemesterCourseOfferings;
	

	
declare @rowCount as INT;
set @rowCount = (SELECT COUNT(*) FROM Dept.Course);
	
DECLARE @endT DATETIME2;
set @endT = SYSDATETIME();

INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
VALUES(
	@GroupMemberUserAuthorizationKey,
	N'Loads the course and attributes',
	@startT,
		@endT,
	@rowCount
);


END