USE [QueensClassSchedule]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 12/06/2023
-- Description:	@GroupMemberUserAuthorizationKey:
-- authorization key for stored procedure
-- =============================================
CREATE PROCEDURE [Project2].[TruncateStarSchemaData]
	@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]

AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	truncate table Dept.Instructor_Department_Bridge
    truncate table Dept.Instructor
    truncate table Dept.Department

    truncate table Location.RoomLocation

	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Products.',
		@startT,
		 @endT,
		@rowCount
	)

	
END;