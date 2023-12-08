USE [QueensClassSchedule]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Project3].[LoadQueensCourseSchedule]
    -- Add the parameters for the stored procedure here
AS
BEGIN
    SET NOCOUNT ON;

    --
    --	Drop All of the foreign keys prior to truncating tables in the star schema
 	--
    EXEC  [Project3].[DropForeignKeysFromSchemaData] @GroupMemberUserAuthorizationKey = 2;
	--
	--	Check row count before truncation
	EXEC	[Project3].[ShowTableStatusRowCount]
		@GroupMemberUserAuthorizationKey = 2,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Pre-truncate of tables''';
    --
    --	Always truncate the Star Schema Data
    --
    EXEC  [Project3].[TruncateSchemaData] @GroupMemberUserAuthorizationKey = 2;
    --
    --	Load the star schema
    --
    EXEC  [Project3].[Load_Instructor] @GroupMemberUserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project3].[Load_Department] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project3].[Load_DeptInstructorDepartmentBridge] @GroupMemberUserAuthorizationKey = 2;
    EXEC  [Project3].[Load_ModeOfInstruction] @GroupMemberUserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_Course] @GroupMemberUserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_RoomLocation] @GroupMemberUserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_BuildingLocation] @GroupMemberUserAuthorizationKey= 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project3].[Load_Class] @GroupMemberUserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
  --
    --	Recreate all of the foreign keys prior after loading the star schema
    --
 	--
	--	Check row count before truncation
	EXEC	[Project3].[ShowTableStatusRowCount]
		@GroupMemberUserAuthorizationKey = 2,  -- Change -1 to the appropriate UserAuthorizationKey
        @TableStatus = N'''Row Count after loading the star schema''';
	--
   EXEC [Project3].[AddForeignKeysToSchemaData] @GroupMemberUserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    --
END;
