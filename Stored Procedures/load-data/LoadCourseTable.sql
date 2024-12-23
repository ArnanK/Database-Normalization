-- =============================================
-- Author: Dillon Chen
-- Create date: 12/3/2024
-- Description: Load Course Stored Procedure
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [Project3].[LoadCourse]
GO

CREATE PROCEDURE [Project3].[LoadCourse]
	@UserAuthorizationKey INT
AS 
BEGIN 
	DECLARE @WorkFlowStepTableRowCount INT;
	INSERT INTO [Project3].[Course]
	(CourseName, CourseNum, DepartmentID, Hours, Credits, WritingIntensive, UserAuthorizationKey)
		(   
			SELECT DISTINCT
				C.[Description],
                SUBSTRING(C.[Course (hr, crd)], CHARINDEX(' ', C.[Course (hr, crd)]), CHARINDEX('(', C.[Course (hr, crd)]) - CHARINDEX(' ', C.[Course (hr, crd)])-1),
                D.DepartmentID,
                CAST(SUBSTRING(C.[Course (hr, crd)], CHARINDEX('(', C.[Course (hr, crd)])+1, CHARINDEX(',', C.[Course (hr, crd)]) - CHARINDEX('(', C.[Course (hr, crd)])-1) AS DECIMAL(5,2)),
                CAST(SUBSTRING(C.[Course (hr, crd)], CHARINDEX(',', C.[Course (hr, crd)])+1, CHARINDEX(')', C.[Course (hr, crd)]) - CHARINDEX(',', C.[Course (hr, crd)])-1) AS DECIMAL(5,2)),
                (CASE
                    WHEN C.[Course (hr, crd)] LIKE N'%[0-9]%W%' THEN 1
                    ELSE 0
                 END),
				@UserAuthorizationKey
			FROM Uploadfile.CurrentSemesterCourseOfferings AS C
            INNER JOIN [Project3].[Department] AS D
                ON SUBSTRING(C.[Course (hr, crd)],0,CHARINDEX(' ',C.[Course (hr, crd)], 0)) = D.DeptName
		)
	SELECT @WorkFlowStepTableRowCount = @@ROWCOUNT;
		-- Track workflow for the operation
    EXEC [Process].[usp_TrackWorkFlow]
        @WorkFlowStepDescription = 'Load Course Data',
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepTableRowCount = @WorkFlowStepTableRowCount;
END
GO

-- SELECT C.[Description]
-- FROM Uploadfile.CurrentSemesterCourseOfferings AS C