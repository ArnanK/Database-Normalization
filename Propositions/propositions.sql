--1
CREATE OR ALTER VIEW Project3.Prop1View AS

SELECT CONCAT_WS(' ',I.FirstName, I.LastName) as [Instructor], 
D.DeptName as [Department],
I.InstructorID,
D.DepartmentID
FROM [Project3].[InstructorDept] as ID
INNER JOIN [Project3].[Instructor] as I on ID.InstructorID = I.InstructorID
INNER JOIN [Project3].[Department] as D on ID.DepartmentID = D.DepartmentID

--GROUP BY CONCAT_WS(' ',I.FirstName, I.LastName)
--HAVING COUNT(ID.DepartmentID) > 1
--ORDER BY [# of Departments] DESC
 
GO

--2
SELECT D.DeptName as [Department], 
COUNT(ID.InstructorID) as [# of Instructors]
FROM [Project3].[InstructorDept] as ID
INNER JOIN [Project3].[Instructor] as I on ID.InstructorID = I.InstructorID
INNER JOIN [Project3].[Department] as D on ID.DepartmentID = D.DepartmentID
GROUP BY D.DeptName
ORDER BY [# of Instructors] DESC

GO
--3

CREATE OR ALTER VIEW Project3.Prop2View AS
SELECT  
    Co.CourseName, 
    SUM(D.Enrolled) AS [Total Enrollment], 
    SUM(D.Limit) AS [Total Class Limit],
    CASE 
        WHEN SUM(D.Limit) = 0 THEN (CAST(SUM(D.Enrolled) AS FLOAT) / 1) * 100 
        ELSE (CAST(SUM(D.Enrolled) AS FLOAT) / CAST(SUM(D.Limit) AS FLOAT)) * 100 
    END AS [Percentage of Enrollment]
FROM 
    [Project3].[Class] AS C 
INNER JOIN 
    Project3.Course AS Co ON C.CourseID = Co.CourseID
INNER JOIN 
    Project3.ClassDetails AS D ON C.ClassDetailsID = D.ClassDetailsID
GROUP BY 
    Co.CourseName



