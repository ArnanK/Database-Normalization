-- =============================================
-- Author: Abdul Mohammed
-- Table: Dept.Course
-- Create date: 12/05/2023
-- Description: Course Table | 
-- =============================================
-- Check if [Dept] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Dept')
BEGIN
    EXEC('CREATE SCHEMA [Dept]')
END
DROP TABLE IF EXISTS [Dept].[Course]
CREATE TABLE [Dept].[Course](
    CourseId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CourseName [Udt].[CourseName] NOT NULL,
	CourseDescription [Udt].[CourseDescription] NOT NULL,
	CourseDay [Udt].[CourseDay] NOT NULL,
	CourseTime [Udt].[CourseTime] NOT NULL,
	ClassId [Udt].[SurrogateKeyInt] NOT NULL,
	InstructorId [Udt].[SurrogateKeyInt] NOT NULL,
	CONSTRAINT FK_InstructorIdId Foreign Key(InstructorId)
		REFERENCES [Dept].[Instructor](InstructorId),
	RoomLocationId [Udt].[SurrogateKeyInt] NOT NULL,
		CONSTRAINT FK_RoomLocationId Foreign Key(RoomLocationId)
		REFERENCES [Location].[RoomLocation](RoomLocationId),
	Enrolled [Udt].[Enrolled] NOT NULL,
	Limit [Udt].[Limit] NOT NULL,
	CONSTRAINT CHK_Enrolled_Limit CHECK (Enrolled <= Limit)
)