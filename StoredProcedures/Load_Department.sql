USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Samin
-- Create date: 12/04/2023
-- Description:	Loads Data into Dept.Department
-- =============================================
CREATE PROCEDURE [Project3].[Load_Department]
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

    INSERT INTO [Dept].[Department](DepartmentName)
    SELECT DISTINCT substring([Course (hr, crd)], 1, 4)
    FROM Uploadfile.CurrentSemesterCourseOfferings;


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
