/*
== Signing up a new user ==
INSERT INTO [USER]([USER_FNAME], [USER_LNAME], [USER_EMAIL])
VALUES ('pedro', 'elfnan', 'engz@mail.com');

/* = If student */
INSERT INTO [STUDENT]([USER_ID], [USER_FNAME], [USER_LNAME], [USER_EMAIL], [ENROLLMENT_YEAR])
SELECT @UserID, [USER].[USER_FNAME], [USER].[USER_LNAME], [USER].[USER_EMAIL], 2015
FROM [USER] 
WHERE @UserID = [USER].[USER_ID];

/* = If instructor */
INSERT INTO [INSTRUCTOR]([USER_ID], [USER_FNAME], [USER_LNAME], [USER_EMAIL], [OFFICE_HOURS])
SELECT @UserID, [USER].[USER_FNAME], [USER].[USER_LNAME], [USER].[USER_EMAIL], '2024-05-15 14:30:00'
FROM [USER] 
WHERE @UserID = [USER].[USER_ID];
*/


/*
== Updating a user details ==
UPDATE [USER]
SET [USER_FNAME] = 'Pedro',
	[USER_LNAME] = 'ElFanan',
	[USER_EMAIL] = 'abdelrahmanyr05@gmail.com'
WHERE USER_ID = 3;
*/

/*
== Add a new course with visibility 1 (shown) ==
INSERT INTO [COURSE]([USER_ID], [NAME], [DURATION], [VISIBILITY])
VALUES (2, 'Embedded Systems', '3', 1);

/* = Add a new category = */
INSERT INTO CATEGORY(NAME)
VALUES ('SOFTWARE')

/* = Assign a category to a course = */
INSERT INTO CONTAIN (COURSE_ID, CATEGORY_ID)
VALUES (1, 1);
*/


/*
=== ADDING EXAM FOR A COURSE (BY INSTRUCTOR)
Insert INTO [dbo].[EXAM] ([dbo].[EXAM].[COURSE_ID],[dbo].[EXAM].[EXAM_DURATION],[dbo].[EXAM].[EXAM_TYPE])
VALUES (1,2,'TEST')
*/

/*
=== SELECT THE COURSE CATEGORY

SELECT c.COURSE_ID,c.NAME,cat.NAME
FROM [dbo].[COURSE] c ,  [dbo].[CATEGORY] cat , [dbo].[CONTAIN] co
WHERE co.[COURSE_ID] = c.[COURSE_ID]
AND co.CATEGORY_ID = cat.CATEGORY_ID
AND cat.NAME = 'IS'
Order by c.NAME
*/

/*
=== SELECT THE COURSE SEMESTER
SELECT c.COURSE_ID,c.NAME,s.START_DATE,s.END_DATE
FROM [dbo].[COURSE] c ,[dbo].[SEMESTER] s,[dbo].[REGISTERS] r
WHERE r.COURSE_ID = c.COURSE_ID
AND r.SEMESTER_ID = s.SEMESTER_ID
AND s.SEMESTER_ID = 5 OR s.IS_CURRENT = 1
Order by c.NAME;
*/

/*
=== SELECT A SPECIFIC YEAR FOR COURSE
SELECT c.COURSE_ID, C.NAME,st.ENROLLMENT_YEAR
FROM [dbo].[COURSE] c , [dbo].[STUDENT] st , [dbo].[REGISTERS] r
WHERE r.COURSE_ID = c.COURSE_ID
AND r.USER_ID = st.USER_ID
AND st.ENROLLMENT_YEAR = 2023
ORDER BY c.NAME;
*/
/*
=== Student registeration
SELECT COUNT(*)
FROM [dbo].[REGISTERS]
WHERE USER_ID = @StudentID
AND COURSE_ID = @CourseID
AND SEMESTER_ID = @SemesterID

INSERT INTO REGISTERS(FINAL_GRADE,COURSE_ID,SEMESTER_ID,USER_ID)
VALUES (
	NULL,
	@CourseID,
	@SemesterID,
	@StudentID
);
*/
/*

===STUDNETS THAT ARE registered in a course
SELECT st.USER_ID ,st.USER_FNAME +  ' ' + st.USER_LNAME as stName , st.USER_EMAIL ,c.COURSE_ID,c.NAME,r.COURSE_ID
FROM [dbo].[STUDENT] st , [dbo].[COURSE] c , [dbo].[REGISTERS] r
WHERE r.USER_ID = st.USER_ID
AND r.COURSE_ID = c.COURSE_ID
AND c.NAME = 'DATABASE 2'
ORDER BY stName

===get a specific grade,
SELECT st.USER_ID , st.USER_FNAME +  ' ' + st.USER_LNAME as stName , r.COURSE_ID,r.FINAL_GRADE,c.NAME
FROM [dbo].[STUDENT] st , [dbo].[COURSE] c , [dbo].[REGISTERS] r
WHERE r.USER_ID = st.USER_ID
AND r.COURSE_ID = c.COURSE_ID
AND r.FINAL_GRADE = 90
ORDER BY stName

===passed a specific exam
SELECT st.USER_ID , st.USER_FNAME +  ' ' + st.USER_LNAME as stName , t.GRADE,ex.EXAM_ID,c.COURSE_ID,c.NAME
FROM [dbo].[STUDENT] st , [dbo].[COURSE] c , [dbo].[TAKES] t , [dbo].[EXAM] ex
WHERE t.USER_ID = st.USER_ID
AND t.EXAM_ID = ex.EXAM_ID
AND ex.COURSE_ID = c.COURSE_ID
AND t.GRADE >= 50
ORDER BY stName

SET THE COURSE TO BE NOT VISIBLE
UPDATE [dbo].[COURSE]
SET [dbo].[COURSE].VISIBILITY = 0
WHERE [dbo].[COURSE].COURSE_ID = 55

SET THE COURSE TO BE VISIBLE
UPDATE [dbo].[COURSE]
SET [dbo].[COURSE].VISIBILITY = 1
WHERE [dbo].[COURSE].COURSE_ID = 55
*/

SELECT COUNT(st.USER_ID)
FROM [dbo].[STUDENT] st, [dbo].[REGISTERS] r,[dbo].[COURSE] c
WHERE r.COURSE_ID = c.COURSE_ID
GROUP BY c.COURSE_ID
ORDER BY COUNT(st.USER_ID) DESC

SELECT COUNT(c.COURSE_ID)
FROM [dbo].[COURSE] c, [dbo].[SEMESTER] s,[dbo].[REGISTERS] r
WHERE s.SEMESTER_ID = r.SEMESTER_ID
GROUP BY s.SEMESTER_ID
HAVING COUNT(c.COURSE_ID) = 0

SELECT TOP 5 st.USER_ID , r.FINAL_GRADE,st.USER_FNAME +  ' ' + st.USER_LNAME as stName
FROM [dbo].[STUDENT] st , [dbo].[SEMESTER] s , [dbo].[REGISTERS] r
WHERE r.SEMESTER_ID = s.SEMESTER_ID
AND r.USER_ID = st.USER_ID
AND  YEAR(s.START_DATE)  = 2023
GROUP BY r.COURSE_ID
ORDER BY r.FINAL_GRADE DESC


SELECT COUNT (c.USER_ID)
FROM [dbo].[CONTAIN] co,[dbo].[COURSE] c,[dbo].[CATEGORY] cat
WHERE cat.CATEGORY_ID = co.CATEGORY_ID
GROUP BY cat.NAME
ORDER BY COUNT (c.USER_ID) ASC

SELECT st.USER_ID , st.USER_FNAME +  ' ' + st.USER_LNAME as stName , r.COURSE_ID
FROM [dbo].[STUDENT] st
JOIN [dbo].[REGISTERS] r ON r.USER_ID = st.USER_ID 
JOIN [dbo].[COURSE] c ON r.COURSE_ID = c.COURSE_ID
WHERE
c.COURSE_ID = 20
AND NOT EXISTS (
	SELECT 1
	FROM [dbo].[TAKES] t
	JOIN [dbo].[EXAM] ex ON t.EXAM_ID=ex.EXAM_ID
	WHERE t.USER_ID = st.USER_ID
	AND ex.COURSE_ID = c.COURSE_ID
	
) 
ORDER BY stName

