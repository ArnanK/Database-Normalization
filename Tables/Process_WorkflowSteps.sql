-- =============================================
-- Author: Arnan Khan
-- Table: Process.WorkflowSteps
-- Create date: 12/04/2023
-- Description: Info about workflow for project 3.
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Process')
BEGIN
    EXEC('CREATE SCHEMA Process')
END
GO
DROP TABLE IF EXISTS Process.WorkflowSteps;
CREATE TABLE Process.WorkflowSteps
(
	WorkFlowStepKey [Udt].[SurrogateKeyInt] NOT NULL IDENTITY(1,1),
	UserAuthorizationKey [Udt].[SurrogateKeyInt] NOT NULL,
	WorkFlowStepDescription [Udt].[Description] NOT NULL,
	WorkFlowStepTableRowCount [Udt].[Row] NULL
		CONSTRAINT DFT_WorkflowSteps_WorkFlowStepTableRowCount DEFAULT(0),
	StartingDateTime [Udt].[DateAdded] NULL
		CONSTRAINT DFT_WorkflowSteps_StartingDateTime DEFAULT(SYSDATETIME()),
	EndingDateTime [Udt].[DateAdded] NULL
		CONSTRAINT DFT_WorkflowSteps_EndingDateTime DEFAULT(SYSDATETIME()),
	ClassTime [Udt].[ClassTime] NULL
		CONSTRAINT DFT_WorkflowSteps_ClassTime DEFAULT('09:15'),
	CONSTRAINT PK_Workflowsteps Primary Key(WorkFlowStepKey),
	CONSTRAINT FK_UserAuthorizationKey Foreign Key(UserAuthorizationKey)
		REFERENCES DbSecurity.UserAuthorization(UserAuthorizationKey)
);
