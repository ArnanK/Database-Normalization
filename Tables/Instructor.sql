-- =============================================
-- Author: Arnan Khan
-- Table: Dept.Instructor
-- Create date: 12/04/2023
-- Description: Instructor Table | Included concatanation of first and last name.
-- =============================================
-- Check if [Dept] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Dept')
BEGIN
    EXEC('CREATE SCHEMA [Dept]')
END
DROP TABLE IF EXISTS Dept.Instructor
CREATE TABLE [Dept].[Instructor](
    InstructorId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    InstructorFirstName [Udt].[FirstName] NOT NULL,
    InstructorLastName [Udt].[LastName] NOT NULL, 
    InstructorFullName AS (InstructorFirstName + ' ' + InstructorLastName) PERSISTED NOT NULL,
    CONSTRAINT CHK_InstructorName_Length CHECK (LEN(InstructorFullName) <= 55)
)


