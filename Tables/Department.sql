-- =============================================
-- Author: Samin 
-- Table: Dept.Department
-- Create date: 12/04/2023
-- Description: Department Table | 
-- =============================================
-- Check if [Dept] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Dept')
BEGIN
    EXEC('CREATE SCHEMA [Dept]')
END
DROP TABLE IF EXISTS Dept.Department
CREATE TABLE [Dept].[Department](
    DepartmentId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DepartmentName [Udt].[DeptName] NOT NULL,
    CONSTRAINT CHK_DepartmentName_Length CHECK (LEN(DepartmentName) <= 4)
)


