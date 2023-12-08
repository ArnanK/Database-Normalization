Drop Table if exists [Dept].[Class]
Create Table [Dept].[Class](
	[ClassId] [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	[Section] [Udt].[InsMode] NOT NULL,
	[Code] [Udt].[InsMode] NOT NULL,
	[CourseId] [Udt].[SurrogateKeyInt] NOT NULL, 
	[Day] [Udt].[InsMode],
	[Time] [Udt].[InsMode],
	[BridgeId] [Udt].[SurrogateKeyInt], 
	[BuildingLocationId] [Udt].[SurrogateKeyInt],
	[RoomLocationId] [Udt].[SurrogateKeyInt],
	[Enrolled] [Udt].[Number],
	[Limit] [Udt].[Number],
	ModeId [Udt].[SurrogateKeyInt]
) 
ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Courses] FOREIGN KEY ([CourseId])
References [Dept].[Course] ([CourseId])
GO
ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_BuildingLocation] FOREIGN KEY ([BuildingLocationId])
References [Location].[BuildingLocation] ([BuildingLocationId])
GO
ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_RoomLocation] FOREIGN KEY ([RoomLocationId])
References [Location].[RoomLocation] ([RoomLocationId])
GO
ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_DepartmentInstructorBridge] FOREIGN KEY ([BridgeId])
References [Dept].[Instructor_Department_Bridge] ([BridgeId])
GO
ALTER TABLE [Dept].[Class] WITH CHECK ADD CONSTRAINT [FK_Mode] FOREIGN KEY ([ModeId])
REFERENCES [Dept].ModeOfInstruction([ModeId])

SELECT *
FROM Uploadfile.CurrentSemesterCourseOfferings