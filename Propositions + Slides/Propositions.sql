--Query 1: Show all instructors who are teaching in classes in multiple departments
SELECT
    I.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName
FROM Dept.Instructor I
JOIN Dept.Instructor_Department_Bridge B ON I.InstructorId = B.InstructorId
GROUP BY I.InstructorId, I.InstructorFirstName, I.InstructorLastName
HAVING COUNT(DISTINCT B.DepartmentId) > 1;

--Query 2: How many instructors are in each department?
SELECT
    D.DepartmentName,
    COUNT(DISTINCT IDB.InstructorId) AS NumberOfInstructors
FROM Dept.Department D
LEFT JOIN Dept.Instructor_Department_Bridge IDB ON D.DepartmentId = IDB.DepartmentId
GROUP BY D.DepartmentName;

--Query 3: How many classes are being taught this semester, grouped by course, and aggregating the total enrollment, total class limit, and the percentage of enrollment.
SELECT
    U.Code AS CourseCode,
    U.Description AS CourseDescription,
    COUNT(*) AS TotalClasses,
    SUM(CAST(U.Enrolled AS INT)) AS TotalEnrollment,
    SUM(CAST(U.Limit AS INT)) AS TotalClassLimit,
    (SUM(CAST(U.Enrolled AS FLOAT)) / NULLIF(SUM(CAST(U.Limit AS FLOAT)), 0)) * 100 AS EnrollmentPercentage
FROM Uploadfile.CurrentSemesterCourseOfferings U
GROUP BY U.Code, U.Description;

--Rank all the professors who teach in the 'CSCI' department for total enrolled
SELECT
    I.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName,
    SUM(CAST(C.Enrolled AS INT)) AS TotalEnrolled
FROM Dept.Instructor I
JOIN Dept.Instructor_Department_Bridge B ON I.InstructorId = B.InstructorId
JOIN Dept.Class C ON B.BridgeId = C.BridgeId
JOIN Dept.Course Co ON C.CourseId = Co.CourseId
WHERE B.DepartmentId = (SELECT DepartmentId FROM Dept.Department WHERE DepartmentName = 'CSCI')
GROUP BY I.InstructorId, I.InstructorFirstName, I.InstructorLastName
ORDER BY TotalEnrolled DESC;



--Retrieve all courses and their enrollment percentages for the current semester.
SELECT
    U.Code AS CourseCode,
    U.Description AS CourseDescription,
    (SUM(CAST(U.Enrolled AS FLOAT)) / NULLIF(SUM(CAST(U.Limit AS FLOAT)), 0)) * 100 AS EnrollmentPercentage
FROM Uploadfile.CurrentSemesterCourseOfferings U
GROUP BY U.Code, U.Description;

--Find the total number of classes taught by each instructor in the CSCI department.
SELECT
    I.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName,
    COUNT(DISTINCT C.ClassId) AS TotalClassesTaught
FROM Dept.Instructor I
JOIN Dept.Instructor_Department_Bridge B ON I.InstructorId = B.InstructorId
JOIN Dept.Class C ON B.BridgeId = C.BridgeId
JOIN Dept.Course Co ON C.CourseId = Co.CourseId
WHERE B.DepartmentId = (SELECT DepartmentId FROM Dept.Department WHERE DepartmentName = 'CSCI')
GROUP BY I.InstructorId, I.InstructorFirstName, I.InstructorLastName
ORDER BY TotalClassesTaught DESC;

-- Identify instructors who are not assigned to any department. (Should be null)
SELECT
    I.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName
FROM Dept.Instructor I
LEFT JOIN Dept.Instructor_Department_Bridge B ON I.InstructorId = B.InstructorId
WHERE B.InstructorId IS NULL;

--List all courses along with the total enrollment and class limit for the current semester.
SELECT
    U.Code AS CourseCode,
    U.Description AS CourseDescription,
    SUM(CAST(U.Enrolled AS INT)) AS TotalEnrollment,
    SUM(CAST(U.Limit AS INT)) AS TotalClassLimit
FROM Uploadfile.CurrentSemesterCourseOfferings U
GROUP BY U.Code, U.Description;

--Retrieve the total number of classes and total enrollment for each day section of the week.
SELECT
    U.Day,
    COUNT(*) AS TotalClasses,
    SUM(CAST(U.Enrolled AS INT)) AS TotalEnrollment
FROM Uploadfile.CurrentSemesterCourseOfferings U
GROUP BY U.Day;

--List all courses along with the number of classes that have reached full capacity.
SELECT
    U.Code AS CourseCode,
    U.Description AS CourseDescription,
    COUNT(*) AS ClassesAtFullCapacity
FROM Uploadfile.CurrentSemesterCourseOfferings U
WHERE CAST(U.Enrolled AS INT) >= CAST(U.Limit AS INT)
GROUP BY U.Code, U.Description;

--Find the instructors who are teaching the most classes in the CSCI  department.
DECLARE @TargetDepartmentId INT = 5; -- CSCI department ID

SELECT TOP 1
    B.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName,
    COUNT(C.ClassId) AS TotalClassesTaught
FROM Dept.Instructor_Department_Bridge B
JOIN Dept.Class C ON C.BridgeId = B.BridgeId
JOIN Dept.Instructor I ON I.InstructorId = B.InstructorId
WHERE B.DepartmentId = @TargetDepartmentId
GROUP BY B.InstructorId, I.InstructorFirstName, I.InstructorLastName
ORDER BY TotalClassesTaught DESC;

--Find the instructors who are teaching classes in multiple buildings.
SELECT
    I.InstructorId,
    I.InstructorFirstName,
    I.InstructorLastName
FROM Dept.Instructor I
JOIN Dept.Class C ON C.BridgeId = I.InstructorId  -- Assuming the BridgeId in Class table is the link
JOIN Location.BuildingLocation BL ON C.BuildingLocationId = BL.BuildingLocationId
GROUP BY I.InstructorId, I.InstructorFirstName, I.InstructorLastName
HAVING COUNT(DISTINCT BL.RoomBuilding) > 1;


--Rank all the departments by the total enrolled.
SELECT
    D.DepartmentName,
    SUM(CAST(U.Enrolled AS INT)) AS TotalEnrolled
FROM Dept.Department D
JOIN Dept.Instructor_Department_Bridge B ON D.DepartmentId = B.DepartmentId
JOIN Dept.Class C ON B.BridgeId = C.BridgeId
JOIN Uploadfile.CurrentSemesterCourseOfferings U ON C.Code = U.Code
GROUP BY D.DepartmentName
ORDER BY TotalEnrolled DESC;
