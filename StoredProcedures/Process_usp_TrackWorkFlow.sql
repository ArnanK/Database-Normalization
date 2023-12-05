USE [QueensClassSchedule]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author: Arnan Khan
-- Procedure: [Process].[usp_TrackWorkFlow]
-- Create date: 11/10/2023
-- Description:	Allows you to track Work Flow Proceudres as a parametirzed table.
-- ===========================================================

CREATE PROCEDURE [Process].[usp_TrackWorkFlows]
    @UserAuthorizationKey [Udt].[SurrogateKeyInt],
    @WorkFlowStepDescription [Udt].[Description],
    @StartTime [Udt].[DateAdded],
    @EndTime [Udt].[DateAdded],
    @WorkFlowStepTableRowCount [Udt].[Row]
AS 
BEGIN
    INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
    VALUES (@UserAuthorizationKey, @WorkFlowStepDescription, @StartTime, @EndTime, @WorkFlowStepTableRowCount)
END;