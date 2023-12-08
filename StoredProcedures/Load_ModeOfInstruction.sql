USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aureljo Pepa
-- Create date: 12/05/2023
-- Description:	Loads Data into Dept.ModeOfInstruction
-- =============================================
DROP PROCEDURE IF EXISTS [Project3].[Load_ModeOfInstruction];
go
CREATE PROCEDURE [Project3].[Load_ModeOfInstruction]
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

Insert Into [Dept].[ModeOfInstruction] ([Mode Of Instruction])
Select Distinct [Mode Of Instruction] 
From Uploadfile.CurrentSemesterCourseOfferings;


declare @rowCount as INT;
set @rowCount = (SELECT COUNT(*) FROM [Dept].[ModeOfInstruction]);
	
DECLARE @endT DATETIME2;
set @endT = SYSDATETIME();

INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
VALUES(
	@GroupMemberUserAuthorizationKey,
	N'Loads the Mode of Instruction',
	@startT,
		@endT,
	@rowCount
)


END