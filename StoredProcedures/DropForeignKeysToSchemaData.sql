USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 12/04/2023
-- Description:	Drop the Foreign Keys From the Star Schema
-- =============================================
CREATE PROCEDURE [Project3].[DropForeignKeysFromSchemaData]
	@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
    SET NOCOUNT ON;
	--Remove the Foreign Keys for the [Dept].[Instructor_Department_Bridge] Table
    ALTER TABLE [Dept].[Instructor_Department_Bridge] DROP CONSTRAINT IF EXISTS FK_InstructorId
    ALTER TABLE [Dept].[Instructor_Department_Bridge] DROP CONSTRAINT IF EXISTS FK_DepartmentId

	--Remove FK for Dept.Class
	ALTER TABLE [Dept].[Class] DROP CONSTRAINT IF EXISTS FK_Courses
	ALTER TABLE [Dept].[Class] DROP CONSTRAINT IF EXISTS FK_BuildingLocation
	ALTER TABLE [Dept].[Class] DROP CONSTRAINT IF EXISTS FK_RoomLocation
	ALTER TABLE [Dept].[Class] DROP CONSTRAINT IF EXISTS FK_DepartmentInstructorBridge
	ALTER TABLE [Dept].[Class] DROP CONSTRAINT IF EXISTS FK_Mode


	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Drops All The Foreign Keys in the Tables.',
		@startT,
		 @endT,
		@rowCount
	)
END;