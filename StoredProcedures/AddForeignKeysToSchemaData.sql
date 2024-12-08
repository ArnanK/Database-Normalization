USE [QueensClassSchedule]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:       Arnan Khan debugged: Inderpreet Singh
-- Create date: 11/10/2023
-- Description:  Adds Foreign Keys back to tables.
-- =============================================

-- Drop the procedure if it already exists
IF OBJECT_ID('[Project3].[AddForeignKeysToSchemaData]', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Project3].[AddForeignKeysToSchemaData];
END
GO

-- Create the procedure
CREATE PROCEDURE [Project3].[AddForeignKeysToSchemaData]
@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    DECLARE @startT DATETIME2;
    DECLARE @endT DATETIME2;

    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Foreign Keys for .Instructor_Department_Bridge table.
    ALTER TABLE [Dept].[Instructor_Department_Bridge] 
    ADD CONSTRAINT FK_InstructorId FOREIGN KEY (InstructorId)
    REFERENCES [Dept].[Instructor](InstructorId);

    ALTER TABLE [Dept].[Instructor_Department_Bridge] 
    ADD CONSTRAINT FK_DepartmentId FOREIGN KEY (DepartmentId)
    REFERENCES [Dept].[Department](DepartmentId);
    
    -- Foreign Keys for .Class Table
    ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Courses] FOREIGN KEY ([CourseId])
    REFERENCES [Dept].[Course] ([CourseId]);
    
    ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_BuildingLocation] FOREIGN KEY ([BuildingLocationId])
    REFERENCES [Location].[BuildingLocation] ([BuildingLocationId]);
    
    ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_RoomLocation] FOREIGN KEY ([RoomLocationId])
    REFERENCES [Location].[RoomLocation] ([RoomLocationId]);
    
    ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_DepartmentInstructorBridge] FOREIGN KEY ([BridgeId])
    REFERENCES [Dept].[Instructor_Department_Bridge] ([BridgeId]);

    ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Mode] FOREIGN KEY ([ModeId])
    REFERENCES [Dept].[ModeOfInstruction]([ModeId]);

    -- Log the workflow step
    DECLARE @rowCount INT;
    SET @rowCount = 0;
    SET @startT = SYSDATETIME();
    SET @endT = SYSDATETIME();

    INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
    VALUES (
        @GroupMemberUserAuthorizationKey,
        N'Adds all the foreign key constraints to the tables.',
        @startT,
        @endT,
        @rowCount
    );
END;
GO
