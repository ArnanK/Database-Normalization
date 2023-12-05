-- =============================================
-- Author: Arnan Khan
-- Table: DbSecurity.UserAuthorization
-- Create date: 12/04/2023
-- Description: Info about workflow for project 3.
-- =============================================

-- Check if [DbSecurity] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'DbSecurity')
BEGIN
    EXEC('CREATE SCHEMA [DbSecurity]')
END
DROP TABLE IF EXISTS DbSecurity.UserAuthorization
CREATE TABLE DbSecurity.UserAuthorization(
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [ClassTime] [Udt].[ClassTime] DEFAULT ('09:15') NULL,
    [IndividualProject] [Udt].[IndividualProject] DEFAULT('Project 3') NULL,
    [GroupMemberLastName] [Udt].[LastName] NOT NULL,
    [GroupMemberFirstName] [Udt].[FirstName] NOT NULL,
    [GroupName] [Udt].[GroupName] DEFAULT('Group 4') NOT NULL,
    [DateAdded] [Udt].[DateAdded] DEFAULT (sysdatetime()) NULL
)

INSERT INTO DbSecurity.UserAuthorization(GroupMemberFirstName,GroupMemberLastName)
VALUES
('Samin', 'Chowdhury'),
('Arnan', 'Khan'),
('Abdul', 'Mohammed'),
('Aureljo', 'Pepa'),
('Akash', 'Ramkaran'),
('Mudabir', 'Rizvi')

SELECT *
FROM DbSecurity.UserAuthorization