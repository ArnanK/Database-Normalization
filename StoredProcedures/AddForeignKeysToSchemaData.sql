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
	ADD CONSTRAINT FK_DepartmentId Foreign Key(DepartmentIdId)
	REFERENCES [Dept].[Department](DepartmentId);
	
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
