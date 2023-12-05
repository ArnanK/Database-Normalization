-- Check if [Udt] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Udt')
BEGIN
    EXEC('CREATE SCHEMA [Udt]')
END
-- Check if [Utils] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Utils')
BEGIN
    EXEC('CREATE SCHEMA [Utils]')
END
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Process')
BEGIN
    EXEC('CREATE SCHEMA Process')
END
-- Check if [DbSecurity] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'DbSecurity')
BEGIN
    EXEC('CREATE SCHEMA [DbSecurity]')
END
-- Check if [Dept] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Dept')
BEGIN
    EXEC('CREATE SCHEMA [Dept]')
END
-- Check if [Project3] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Project3')
BEGIN
    EXEC('CREATE SCHEMA [Project3]')
END