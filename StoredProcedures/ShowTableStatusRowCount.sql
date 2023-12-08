USE [QueensClassSchedule]
GO
/****** Object:  StoredProcedure [Project2].[ShowTableStatusRowCount]    Script Date: 11/10/2023 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project3].[ShowTableStatusRowCount] 
@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt],
@TableStatus VARCHAR(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	select TableStatus = @TableStatus,TableName ='Course', COUNT(*) as [RowCount] FROM [Dept].Course;
    select TableStatus = @TableStatus,TableName ='Department', COUNT(*)as [RowCount] FROM [Dept].Department;
    select TableStatus = @TableStatus,TableName ='Instructor', COUNT(*)as [RowCount] FROM [Dept].Instructor;
    select TableStatus = @TableStatus,TableName ='Instructor_Department_Bridge', COUNT(*)as [RowCount] FROM [Dept].Instructor_Department_Bridge;
    select TableStatus = @TableStatus,TableName = 'Class', COUNT(*)as [RowCount] FROM [Dept].Class;
    select TableStatus = @TableStatus,TableName ='RoomLocation', COUNT(*)as [RowCount] FROM [Location].RoomLocation;
    select TableStatus = @TableStatus,TableName = 'BuildingLocation', COUNT(*)as [RowCount] FROM [Location].BuildingLocation;
    select TableStatus = @TableStatus,TableName = 'ModeOfInstruction', COUNT(*)as [RowCount] FROM [Dept].ModeOfInstruction;
END;