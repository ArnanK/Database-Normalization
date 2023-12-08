-- =============================================
-- Author: Arnan Khan
-- Table: Location.BuildingLocation
-- Create date: 12/05/2023
-- Description: BuildingLocation Table 
-- =============================================
-- Check if [Location] schema exists before creating
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Location')
BEGIN
    EXEC('CREATE SCHEMA [Location]')
END
DROP TABLE IF EXISTS Location.BuildingLocation
CREATE TABLE [Location].[BuildingLocation](
    BuildingLocationId [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RoomBuilding [Udt].[Building]  NULL
    
    CONSTRAINT CHK_Building_Length CHECK (LEN(RoomBuilding) <= 5)
)