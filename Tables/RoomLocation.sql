-- =============================================
-- Author: Mudabir Rizvi
-- Table: Location.RoomLocation
-- Create date: 12/05/2023
-- Description: RoomLocation Table 
-- =============================================
-- Check if [Location] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Location')
BEGIN
    EXEC('CREATE SCHEMA [Location]')
END
DROP TABLE IF EXISTS Location.RoomLocation
CREATE TABLE [Location].[RoomLocation](
    RoomLocationId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RoomNumber [Udt].[RoomNumber]  NULL,   
    CONSTRAINT CHK_Room_Length CHECK (LEN(RoomNumber) <= 10)
)

