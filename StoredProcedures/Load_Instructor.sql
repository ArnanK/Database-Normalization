USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 12/04/2023
-- Description:	Loads Data into Dept.Instructor
-- =============================================
CREATE PROCEDURE [Project3].[Load_Instructor]
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

    INSERT INTO [Dept].[Instructor](InstructorFirstName,InstructorLastName, InstructorFullName)
    SELECT DISTINCT 
        SUBSTRING(Instructor, 1, CHARINDEX(',', Instructor) - 1),
        SUBSTRING(Instructor, CHARINDEX(',', Instructor) + 2, LEN(Instructor)),
		Instructor
    FROM Uploadfile.CurrentSemesterCourseOfferings
	WHERE SUBSTRING(Instructor, 1, CHARINDEX(',', Instructor) - 1) != ' ' and SUBSTRING(Instructor, CHARINDEX(',', Instructor) + 2, LEN(Instructor)) != ' ';
	


	
	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM Dept.Instructor);
	
	DECLARE @endT DATETIME2;
    set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Distinct Instructors with the concatnation of their first name and last name.',
		@startT,
		 @endT,
		@rowCount
	);


END
