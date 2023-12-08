USE [QueensClassSchedule]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/10/2023
-- Description:	Adds Foreign Keys back to tables.
-- =============================================
CREATE PROCEDURE [Project3].[AddForeignKeysToSchemaData]
@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	
	--Foreign Keys for .Instructor_Department_Bridge table.
	ALTER TABLE [Dept].[Instructor_Department_Bridge] 
	ADD CONSTRAINT FK_InstructorId Foreign Key(InstructorId)
	REFERENCES [Dept].[Instructor](InstructorId);

	ALTER TABLE [Dept].[Instructor_Department_Bridge] 
	ADD CONSTRAINT FK_DepartmentId Foreign Key(DepartmentId)
	REFERENCES [Dept].[Department](DepartmentId);
	
	--Foreign Keys for .Class Table
	ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Courses] FOREIGN KEY ([CourseId])
	References [Dept].[Course] ([CourseId]);
	
	ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_BuildingLocation] FOREIGN KEY ([BuildingLocationId])
	References [Location].[BuildingLocation] ([BuildingLocationId]);
	
	ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_RoomLocation] FOREIGN KEY ([RoomLocationId])
	References [Location].[RoomLocation] ([RoomLocationId]);
	
	ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_DepartmentInstructorBridge] FOREIGN KEY ([BridgeId])
	References [Dept].[Instructor_Department_Bridge] ([BridgeId]);

	ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Mode] FOREIGN KEY ([ModeId])
	REFERENCES [Dept].ModeOfInstruction([ModeId]);



	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Adds all the foreign key constraints to the tables.',
		@startT,
		 @endT,
		@rowCount
	)


END;
