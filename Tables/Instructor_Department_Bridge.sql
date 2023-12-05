-- =============================================
-- Author: Arnan Khan
-- Table: Dept.Instructor_Department_Bridge
-- Create date: 12/04/2023
-- Description: Bridge Table for Instructor and Department to establish 1 to many relation between Instructor and Department.
-- =============================================
DROP IF EXISTS [Dept].[Instructor_Department_Bridge]
CREATE TABLE [Dept].[Instructor_Department_Bridge](
    BridgeId [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULl PRIMARY KEY,
    InstructorId [Udt].[SurrogateKeyInt] NOT NULL,
    CONSTRAINT FK_InstructorId Foreign Key(InstructorId)
		REFERENCES [Dept].[Instructor](InstructorId),
    DepartmentId [Udt].[SurrogateKeyInt] NOT NULL,
    CONSTRAINT FK_DepartmentId Foreign Key(DepartmentId)
		REFERENCES [Dept].[Department](DepartmentId)

)