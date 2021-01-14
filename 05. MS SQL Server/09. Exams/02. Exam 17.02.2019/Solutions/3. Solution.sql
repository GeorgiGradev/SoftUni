USE School
GO

--- 2.Insert ---
INSERT INTO Teachers(FirstName, LastName, [Address], Phone, SubjectId)
	VALUES
	('Ruthanne', 'Bamb', '84948 Mesta Junction', '3105500146', 6),
	('Gerrard',	'Lowin', '370 Talisman Plaza', '3324874824', 2),
	('Merrile', 'Lambdin', '81 Dahle Plaza', '4373065154', 5),
	('Bert', 'Ivie', '2 Gateway Circle', '4409584510', 4)

INSERT INTO Subjects([Name], Lessons)
	VALUES
	('Geometry', 12),
	('Health', 10),
	('Drama', 7),
	('Sports', 9)


--- 3.Update ---
UPDATE StudentsSubjects
	SET Grade = 6
		WHERE SubjectId IN (1,2) AND Grade >= 5.50


--- 4.Delete ---
DELETE 
	FROM StudentsTeachers
	WHERE TeacherId IN (SELECT 
							Id
							FROM Teachers
							WHERE Phone LIKE '%72%')

DELETE 
	Teachers
	WHERE Phone LIKE '%72%'


--- 5.Teen Students ---
SELECT 
	FirstName, 
	LastName,
	Age
	FROM Students
	WHERE Age >= 12
	ORDER BY FirstName, LastName


--- 6.Cool Addresses ---
SELECT 
	CASE
		WHEN MiddleName IS NULL THEN CONCAT(FirstName, ' ', LastName)
		ELSE CONCAT(FirstName, ' ', MiddleName, ' ', LastName)
		END AS [Full Name],
		Address
	FROM Students
	WHERE Address LIKE '%road%'
	ORDER BY FirstName, LastName, Address


--- 7.42 Phones ---
SELECT 
	FirstName,
	Address,
	Phone
	FROM Students
	WHERE Phone LIKE '42%' AND MiddleName IS NOT NULL
	ORDER BY FirstName


--- 8. Students Teachers ---
SELECT 
	s.FirstName,
	s.LastName,
	COUNT(st.TeacherId) AS TeachersCount
	FROM Students as s
	LEFT JOIN StudentsTeachers as st ON s.Id = st.StudentId
	GROUP BY s.FirstName, s.LastName


--- 9.Subjects with Students ---
SELECT 
	CONCAT(Teachers.FirstName, ' ', Teachers.LastName) AS FullName,
	CONCAT(Subjects.Name, '-', Subjects.Lessons) AS Subjects,
	COUNT(Students.Id) AS Students
	FROM Subjects
	JOIN Teachers ON Subjects.Id = Teachers.SubjectId
	JOIN StudentsTeachers ON Teachers.Id = StudentsTeachers.TeacherId
	JOIN Students ON StudentsTeachers.StudentId = Students.Id 
	GROUP BY CONCAT(Teachers.FirstName, ' ', Teachers.LastName), CONCAT(Subjects.Name, '-', Subjects.Lessons)
	ORDER BY Students DESC


--- 10.Students to Go ---
SELECT 
	CONCAT(stu.FirstName, ' ' ,stu.LastName) AS [Full Name]
	FROM Students AS stu
	LEFT JOIN StudentsExams AS se ON stu.Id = se.StudentId
	LEFT JOIN Exams as ex ON se.ExamId = ex.Id
	WHERE ex.Id IS NULL
	ORDER BY [Full Name]



--- 11.Busiest Teachers ---
SELECT TOP(10) 
	FirstName,
	LastName,
	COUNT(*) AS [StudentsCount]
	FROM (SELECT 
			Teachers.FirstName,
			Teachers.LastName
			FROM Teachers
			JOIN Subjects ON Teachers.SubjectId = Subjects.Id
			JOIN StudentsTeachers ON Teachers.Id = StudentsTeachers.TeacherId
		 ) AS TEMP
	GROUP BY FirstName, LastName
	ORDER BY [StudentsCount] DESC,
			 FirstName ASC,
			 LastName ASC


--- 12.Top Students ---
SELECT TOP (1000)
	FirstName AS [First Name], 
	LastName AS [Last Name],
	FORMAT(AVG(se.Grade), 'N2') as Grade
	FROM Students as s
	JOIN StudentsExams as se ON s.Id = se.StudentId
	GROUP BY FirstName, LastName
	ORDER BY Grade DESC, [First Name], [Last Name]
