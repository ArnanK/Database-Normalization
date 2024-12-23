SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON
GO 

-- =============================================
-- Author: Benjamin Zhong
-- Create date: 12/1/2024
-- Description: Create Room Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[CreateRoomTable]
GO

CREATE PROCEDURE [Project3].[CreateRoomTable]
	@UserAuthorizationKey INT
AS
BEGIN
	DROP TABLE IF EXISTS [Project3].[Room]
	CREATE TABLE [Project3].[Room]
		(
			RoomID [Udt].[P3Key] NOT NULL CONSTRAINT [DF_Room] DEFAULT (NEXT VALUE FOR [Project3].[RoomID_Seq]) PRIMARY KEY,
			RoomNumber [Udt].[P3NameString] NOT NULL,
			UserAuthorizationKey INT  NULL
		)

	-- Track workflow for the operation
    EXEC [Process].[usp_TrackWorkFlow]
        @WorkFlowStepDescription = 'Create Room Table',
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepTableRowCount = -1;
END
GO 

