-- Creating DataBase
Create Database Advising_Team_66


-- Procedure for creating all Tables
Go
CREATE PROCEDURE CreateAllTables
    As

    -- Create the Advisor table
    CREATE TABLE  Advisor (
        advisor_id INT PRIMARY KEY Identity(1,1),
        name VARCHAR(40),
        email VARCHAR(40),
        office VARCHAR(40),
        password VARCHAR(40)
    );

    -- Create the Semester table
    CREATE TABLE Semester (
        semester_code VARCHAR(40) PRIMARY KEY,
        start_date DATE,
        end_date DATE
    );

    -- Create the Instructor table
    CREATE TABLE Instructor (
        instructor_id INT PRIMARY KEY Identity(1,1),
        name VARCHAR(40),
        email VARCHAR(40),
        faculty VARCHAR(40),
        office VARCHAR(40)
    );

    -- Create the Course table
    CREATE TABLE Course (
        course_id INT PRIMARY KEY Identity(1,1),
        name VARCHAR(40),
        major VARCHAR(40),
        is_offered BIT,
        credit_hours INT,
        semester INT
    );

    -- Create the PreqCourse_course table
    CREATE TABLE PreqCourse_course (
        prerequisite_course_id INT,
        course_id INT,
        FOREIGN KEY (course_id) REFERENCES Course(course_id),        
        FOREIGN KEY (prerequisite_course_id) REFERENCES Course(course_id),      
        Primary Key (course_id,prerequisite_course_id)
    );

    -- Create the Student table
    CREATE TABLE  Student (
        student_id INT PRIMARY KEY Identity(1,1),
        f_name VARCHAR(40),
        l_name VARCHAR(40),
        gpa DECIMAL(3,2),
        faculty VARCHAR(40),
        email VARCHAR(40),
        major VARCHAR(40),
        password VARCHAR(40),
        financial_status BIT, -- don't forget to write the Deriving Formula!
        semester INT,
        acquired_hours INT,
        assigned_hours INT,
        advisor_id INT,
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id)
        ON Update CASCADE
        ON DELETE CASCADE,
    );

    -- Create the Student_Phone table
    CREATE TABLE Student_Phone (
        student_id INT,
        phone_number VARCHAR(40),
        FOREIGN KEY (student_id) REFERENCES Student(student_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        Primary Key (student_id,phone_number)
    );


    -- Create the Instructor_Course table
    CREATE TABLE Instructor_Course (
        course_id INT,
        instructor_id INT,
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        PRIMARY KEY (course_id,instructor_id)
    );

    -- Create the Student_Instructor_Course_Take table
    CREATE TABLE Student_Instructor_Course_Take (
        student_id INT,
        course_id INT,
        instructor_id INT,
        semester_code VARCHAR(40),
        exam_type VARCHAR(40) DEFAULT 'Normal',
        grade VARCHAR(40),
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY (course_id) REFERENCES Course(course_id)        
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)        
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        Primary Key (student_id,course_id,instructor_id)
    );


    -- Create the Course_Semester table
    CREATE TABLE Course_Semester (
        course_id INT,
        semester_code VARCHAR(40),
        FOREIGN KEY (course_id) REFERENCES Course(course_id)        
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        FOREIGN KEY (semester_code) REFERENCES Semester(semester_code)       
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        PRIMARY KEY (course_id,semester_code)
    );

    -- Create the Slot table
    CREATE TABLE  Slot (
        slot_id INT PRIMARY KEY Identity(1,1),
        day VARCHAR(40),
        time VARCHAR(40),
        location VARCHAR(40),
        course_id INT,
        instructor_id INT,
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
    );

    -- Create the Graduation_Plan table
    CREATE TABLE  Graduation_Plan (
        plan_id INT Identity(1,1),
        semester_code VARCHAR(40),
        semester_credit_hours INT,
        expected_grad_semester VARCHAR(40),
        advisor_id INT,
        student_id INT,
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        PRIMARY KEY (plan_id,semester_code)
    );

    -- Create the GradPlan_Course table
    CREATE TABLE  GradPlan_Course (
        plan_id INT,
        semester_code VARCHAR(40),
        course_id INT,
        FOREIGN KEY (plan_id,semester_code) REFERENCES Graduation_Plan(plan_id,semester_code),
        primary key (plan_id,semester_code,course_id)
    );

    -- Create the Request table
    CREATE TABLE  Request (
        request_id INT PRIMARY KEY Identity(1,1),
        type VARCHAR(40),
        comment VARCHAR(40),
        status VARCHAR(40) DEFAULT 'pending',
        credit_hours INT,
        student_id INT,
        advisor_id INT,
        course_id INT,
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
        FOREIGN KEY (course_id) REFERENCES Course(course_id),
    );

    -- Create the MakeUp_Exam table
    CREATE TABLE MakeUp_Exam (
        exam_id INT PRIMARY KEY Identity(1,1),
        date DATE,
        type VARCHAR(40),
        course_id INT,
        FOREIGN KEY (course_id) REFERENCES Course(course_id),
    );

    -- Create the Exam_Student table
    CREATE TABLE Exam_Student (
        exam_id INT,
        student_id INT,
        course_id INT,
        FOREIGN KEY (exam_id) REFERENCES MakeUp_Exam(exam_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        PRIMARY KEY (exam_id,student_id)
    );

    -- Create the Payment table
    CREATE TABLE Payment (
        payment_id INT PRIMARY KEY Identity(1,1),
        amount INT,
        deadline DATETIME,
        status VARCHAR(40) DEFAULT 'notPaid',
        fund_percentage DECIMAL(4, 3),
        student_id INT,
        semester_code VARCHAR(40),
        start_date DATETIME,
        n_installments INT, -- Is n_installments Derived?
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        FOREIGN KEY (semester_code) REFERENCES Semester(semester_code)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    );

    -- Create the Installment table
    CREATE TABLE Installment (
        payment_id INT,
        deadline DATETIME,
        amount INT, -- Is Amount derived?
        status VARCHAR(40) DEFAULT 'notPaid',
        start_date DATETIME,
        FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        PRIMARY KEY (payment_id,deadline)
    );

GO


-- Procedure for Droping all Tables
CREATE PROCEDURE DropAllTables
AS
    DROP Table Installment, Exam_Student, GradPlan_Course, Course_Semester,
        Student_Instructor_Course_Take, Instructor_Course, PreqCourse_course,
        Student_Phone, Request, Slot, Graduation_Plan, MakeUp_Exam, Payment,
        Student, Course, Instructor, Semester, Advisor;
GO


-- Procedure for Clearing All Tables
GO
CREATE PROCEDURE  clearAllTables
AS  

    Delete From Installment;
    Delete From Exam_Student;
    Delete From GradPlan_Course;
    Delete From Course_Semester;
    Delete From Student_Instructor_Course_Take;
    Delete From Instructor_Course;
    Delete From PreqCourse_course;
    Delete From Student_Phone;
    Delete From Request;
    Delete From Slot;
    Delete From Advisor;
    Delete From Payment;
    Delete From MakeUp_Exam;
    Delete From Student;
    Delete From Course;
    Delete From Instructor;
    Delete From Graduation_Plan;
    Delete From Semester;
GO

EXEC CreateAllTables



---List all Students with their Advisors 2.3.E
GO
create PROCEDURE AdminListStudentsWithAdvisors
AS
Select S.*,A.name AS ADVISOR_NAME,A.email AS ADVISOR_EMAIL,A.office AS ADVISOR_OFFICE , A.password AS ADVISOR_PASSWORD
From Student S inner join Advisor A on (S.advisor_id=A.advisor_id)
Go

Drop PROCEDURE AdminListStudentsWithAdvisors

Exec AdminListStudentsWithAdvisors 
Insert into Advisor(advisor_id,password) VALUES(1,1234)
Insert into Advisor(advisor_id,password) VALUES(2,1234)
Insert into Student (f_name) Values ('hello')
Insert into Student (advisor_id,f_name) Values (2,'ello')


GO 

---Link student to advisor 2.3.J
CREATE PROCEDURE  Procedures_AdminLinkStudentToAdvisor
@Student_ID int ,
@Advisor_ID int 
As
Update  Student 
Set advisor_id=@Advisor_ID
where student_id=@Student_ID
GO

Exec Procedures_AdminLinkStudentToAdvisor 1,1


--Update expected graduation date in a certain graduation plan 2.3.T
GO
CREATE PROCEDURE Procedures_AdvisorUpdateGP
@expected_grad_semster varchar (40),
@studentID int
AS
UPDATE Graduation_Plan
Set expected_grad_semester=@expected_grad_semster
where student_id=@studentID
Go
insert into Graduation_Plan VALUES(34,'SPRING 2014',30,'WINTER 2020',1,1)
EXEC Procedures_AdvisorUpdateGP 'SUMMER 2015',1
GO
----Approve/Reject courses request 2.3.Y
Create PROCEDURE Procedures_AdvisorApproveRejectCourseRequest
@RequestID int, 
@studentID int, 
@advisorID int
AS
---GET REQUIRED COURSE FOR REQUEST
Declare @Course_ID int
Select @Course_ID= Course_id
                 From Request R
                 where R.advisor_id=@advisorID AND R.student_id=@studentID AND R.request_id=@RequestID 
---GET COURSE CREDIT HOURS
DECLARE @CREDIT_HOURS int 
Select   @CREDIT_HOURS = credit_hours  From Course C
                 where c.course_id=@Course_ID
--GET TOTAL STUDENT CREDIT HOURS
DECLARE @ASSIGNED_HOURS INT 
SELECT @ASSIGNED_HOURS =S.assigned_hours FROM STUDENT S
WHERE S.student_id=@studentID
---CHECK FOR ITS PREREQUISITE SATISFIED AND BEING LESS THAN ALREADY ASSIGNED HOURS
DECLARE @SUM_HOURS int
SELECT @SUM_HOURS= sum(C.credit_hours)
FROM Student_Instructor_Course_Take SICT INNER JOIN Course C ON C.course_id=SICT.course_id 
WHERE SICT.student_id=@studentID AND SICT.grade IS NULL
IF @SUM_HOURS IS NULL
BEGIN
SET @SUM_HOURS=0
END
IF ((@SUM_HOURS+@CREDIT_HOURS<=@ASSIGNED_HOURS )AND NOT EXISTS(
SELECT PQ.prerequisite_course_id
   FROM PreqCourse_course PQ 
   WHERE PQ.course_id=@Course_ID
   EXCEPT
   (Select SICT.course_id
   FROM Student_Instructor_Course_Take SICT
   WHERE SICT.student_id=@studentID 
   AND SICT.grade IS NOT NULL AND 
   SICT.grade <> 'F'
   )
))
BEGIN 
UPDATE Request
SET status='accepted'
where request_id=@RequestID
DECLARE @INSTRUCTOR_ID INT
SELECT @INSTRUCTOR_ID= IC.instructor_id from Instructor_Course IC
WHERE IC.course_id=@Course_ID
DECLARE @SEMESTER_CODE VARCHAR(40)
SELECT @SEMESTER_CODE= S.semester_code FROM Semester S WHERE S.end_date>CURRENT_TIMESTAMP AND S.start_date<CURRENT_TIMESTAMP
INSERT into Student_Instructor_Course_Take(course_id,instructor_id,semester_code,student_id) VALUES(@Course_ID,@INSTRUCTOR_ID,@studentID,@SEMESTER_CODE) 
END
ELSE
BEGIN 
UPDATE Request
SET status='rejected'
where request_id=@RequestID
END
GO


DROP PROCEDURE Procedures_AdvisorApproveRejectCourseRequest



insert into Student(f_name,assigned_hours,advisor_id,gpa) VALUES('HELLO',26,1,2)
insert into Student(f_name,assigned_hours,advisor_id,gpa) VALUES('HELLO',32,1,2)
insert into Student(f_name,assigned_hours,advisor_id,gpa) VALUES('HELLO',32,1,2)
select * from Student
INSERT INTO Course (course_id,name,credit_hours) VALUES(1,'CSEN102',4)
INSERT INTO Course (course_id,name,credit_hours) VALUES(3,'CSEN301',4)
INSERT INTO Course (course_id,name,credit_hours) VALUES(2,'CSEN202',4)
INSERT INTO Course (course_id,name,credit_hours) VALUES(4,'CSEN402',10)
INSERT INTO Course (course_id,name,credit_hours) VALUES(5,'CSEN502',3)
INSERT INTO Course (course_id,name,credit_hours) VALUES(6,'CSEN602',45)
INSERT INTO PreqCourse_course VALUES(2,3),(1,2),(1,3)
INSERT INTO PreqCourse_course VALUES(3,4)
INSERT INTO Instructor (instructor_id) VALUES(40)
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id,grade) VALUES(1,40,2,'A')
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id,grade) VALUES(2,40,2,'A')
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id) VALUES(5,40,2)
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id,grade) VALUES(3,40,2,'A')
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id,grade) VALUES(2,40,4,'A')
INSERT INTO Student_Instructor_Course_Take (course_id,instructor_id,student_id,grade) VALUES(2,40,3,'A')
UPDATE Student_Instructor_Course_Take
SET grade='A'
WHERE student_id=2 AND course_id=3
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,2,1,2),(1,2,2,3),(1,3,3,2)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,2,4,4)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,3,5,1)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,2,6,4)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,2,7,6)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,1,8,6)
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,4,9,3)--Testing taking one preq but not the others
INSERT INTO Request(advisor_id,student_id,request_id,course_id) VALUES(1,2,9,3)
select * from PreqCourse_course
SELECT * FROM Request
SELECT * FROM Student_Instructor_Course_Take
select * from Student
EXEC Procedures_AdvisorApproveRejectCourseRequest 6,2,1
EXEC clearAllTables
DROP DATABASE Advising_Team_66
EXEC DropAllTables

