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

--2.3
--A)
go
CREATE PROCEDURE Procedures_StudentRegistration
    @FirstName VARCHAR(40),
    @LastName VARCHAR(40),
    @Password VARCHAR(40),
    @Faculty VARCHAR(40),
    @Email VARCHAR(40),
    @Major VARCHAR(40),
    @Semester INT
AS
BEGIN
    DECLARE @StudentID INT;
    SELECT @StudentID = ISNULL(MAX(student_id), 0) + 1 FROM Student;

    INSERT INTO Student (student_id, f_name, l_name, faculty, email, major, password, semester)
    VALUES (@StudentID, @FirstName, @LastName, @Faculty, @Email, @Major, @Password, @Semester);

    SELECT @StudentID AS 'Student ID';
END;
go
Exec Procedures_StudentRegistration 'John','Doe', 'password123', 'Engineering', 'john.doe@example.com','Computer Science', 1;
go
--F)
CREATE PROCEDURE AdminAddingSemester
    @StartDate DATE,
    @EndDate DATE,
    @SemesterCode VARCHAR(40)
AS
BEGIN
    INSERT INTO Semester (semester_code, start_date, end_date)
    VALUES (@SemesterCode, @StartDate, @EndDate);
END;

go
EXEC AdminAddingSemester '2023-1-1', '2023-12-31', 5


--K)
go
CREATE PROCEDURE Procedures_AdminAddExam
    @Type VARCHAR(40),
    @Date DATETIME,
    @CourseID INT
AS
BEGIN
    DECLARE @ExamID INT;

    SELECT @ExamID = ISNULL(MAX(exam_id), 0) + 1 FROM MakeUp_Exam;

    INSERT INTO MakeUp_Exam (exam_id, date, type, course_id)
    VALUES (@ExamID, @Date, @Type,@CourseID)
END;

Exec Procedures_AdminAddExam 'Normal', '2023-5-2', 9


--P)
GO
CREATE PROCEDURE Procedures_AdminDeleteSlots
    @CurrentSemester VARCHAR(40)
AS
BEGIN
    DELETE FROM Slot
    WHERE course_id IN (
        SELECT course_id
        FROM Course
        WHERE semester <> @CurrentSemester
    );
END;


--U)
go
CREATE PROCEDURE Procedures_AdvisorDeleteFromGP
    @StudentID INT,
    @SemesterCode VARCHAR(40),
    @CourseID INT
AS
BEGIN
    DELETE FROM GradPlan_Course
    WHERE plan_id IN (
        SELECT plan_id
        FROM Graduation_Plan
        WHERE student_id = @StudentID
          AND semester_code = @SemesterCode
    ) AND course_id = @CourseID;
END;

---List all Students with their Advisors 2.3.E
GO
create PROCEDURE AdminListStudentsWithAdvisors
AS
Select S.*,A.name AS ADVISOR_NAME,A.email AS ADVISOR_EMAIL,A.office AS ADVISOR_OFFICE , A.password AS ADVISOR_PASSWORD
From Student S inner join Advisor A on (S.advisor_id=A.advisor_id)
Go

---Link student to advisor 2.3.J
GO 
CREATE PROCEDURE  Procedures_AdminLinkStudentToAdvisor
@Student_ID int ,
@Advisor_ID int 
As
Update  Student 
Set advisor_id=@Advisor_ID
where student_id=@Student_ID
GO


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



----Approve/Reject courses request 2.3.Y
GO
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

 -- 2.3)B)  Advisor Registration
Go
    CREATE PROCEDURE Procedures_AdvisorRegistration
        @advisor_name VARCHAR(40),
        @password VARCHAR(40),
        @email VARCHAR(40),
        @office VARCHAR(40),
        @advisor_id INT OUTPUT
        AS
            Insert Into Advisor values (@advisor_name,@email,@office,@password);
            SELECT @advisor_id = Advisor.advisor_id FROM Advisor WHERE Advisor.email = @email AND Advisor.password = @password
Go
            
            

-- 2.3)G)   Add new course
Go
    CREATE PROCEDURE Procedures_AdminAddingCourse
        @major VARCHAR(40),
        @semester INT,
        @credit_hrs INT,
        @course_name VARCHAR(40),
        @offered BIT
        AS
            Insert INTO Course values (@course_name,@major,@offered,@credit_hrs,@semester);
Go

-- 2.3)L)   Issue installments as per the number of installments for a certain payment
Go
    CREATE PROCEDURE Procedures_AdminIssueInstallment
        @payment_id INT
        AS
            UPDATE Payment SET n_installments =  (SELECT DATEDIFF(MONTH,start_date,deadline) FROM Payment WHERE Payment.payment_id = @payment_id) WHERE payment_id = @payment_id;
            declare @installment_amount INT = (SELECT Payment.amount/Payment.n_installments FROM Payment WHERE payment_id = @payment_id);
            declare @installment_startDate DATETIME = (SELECT start_date from Payment WHERE payment_id = @payment_id);
            declare @n_installments INT =  (SELECT n_installments from Payment WHERE payment_id = @payment_id);
            declare @i INT;
            declare @installment_deadline DATETIME;
            SET @i = 0;
            WHILE @i < @n_installments
            BEGIN
                SET @installment_deadline = DATEADD(MONTH,1,@installment_startDate);
                INSERT INTO Installment (payment_id,deadline,amount,start_date) VALUES (@payment_id,@installment_deadline,@installment_amount,@installment_startDate);
                SET @i = @i + 1;
                SET @installment_startDate = DATEADD(MONTH,1,@installment_startDate);
            END;
GO


-- 2.3)Z)   View pending requests of specific advisor students
Go
    CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
        @advisor_id INT
        AS
            SELECT * FROM Request WHERE advisor_id = @advisor_id AND status = 'pending'
Go



-- 2.3)D)    List all Advisors
Go
create procedure Procedures_AdminListAdvisors
as
select * from Advisor;
Go


-- 2.3)I)   Link student to course with Specific instructor
Go
create procedure Procedures_AdminLinkStudent
@instructor_Id int, 
@student_ID int,
@course_ID int,
@semester_code varchar (40)
as
    insert into Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code) values(@student_id,@course_id,@instructor_Id,@semester_code)
Go


-- 2.3)N)   Update student's Status based on his/her financial status
Go
create procedure Procedures_AdvisorAddCourseGP
@student_id int,
@semester_code varchar (40),
@course_name varchar (40)
as
DECLARE @plan_id varchar(40)
Declare @course_id int 
select @plan_id=GP.plan_id,@semester_code=GP.semester_code From Graduation_plan GP where GP.student_id=@student_id;
select @course_id=C.course_id from Course C  where C.name=@course_name;

INSERT INTO GradPlan_Course values(@plan_id, @semester_code, @course_id);
go


-- 2.3)S)   Add course inside certain plan of specific student
Go
create procedure Procedures_AdvisorViewAssignedStudents
    @AdvisorID INT,
    @Major VARCHAR(40)
AS
    SELECT s.student_id, s.f_name, s.l_name, s.major, c.name AS course_name
    FROM Student s
         left outer JOIN Student_Instructor_Course_Take sic ON s.student_id = sic.student_id
         left outer join Course c ON sic.course_id = c.course_id
         INNER JOIN Advisor a ON s.advisor_id = a.advisor_id 
         WHERE   s.advisor_id = @AdvisorID AND s.major = @Major;
Go



-- 2.3)X)    View all students assigned to specific advisor from a certain major
Go
create procedure Procedure_AdminUpdateStudentStatus
@StudentID int
as
declare @i_status varchar(40)
Select @i_status=i.status
FROM Student s
    Inner Join Payment p ON s.student_id = p.student_id
    Inner Join Installment i ON p.payment_id = i.payment_id
    where s.student_id=@StudentID AND i.deadline<current_timestamp AND i.status='NotPaid';

if @i_status is null
Begin
Update Student
Set status = 1
Where student_id=@StudentID;
End
else
Begin
Update Student
Set status = 0
Where student_id=@StudentID;
End
Go


-- 2.3)C)    List all advising students
GO
CREATE PROCEDURE  Procedures_AdminListStudents  
AS 
    SELECT *
    FROM Student
GO


-- 2.3)H)   Link instructor to course on specific slot
GO
CREATE PROCEDURE Procedures_AdminLinkInstructor
    @InstructorId int,
    @courseId int,
    @slotID int
AS
    INSERT INTO Instructor_Course (instructor_id, course_id)
    VALUES (@InstructorId, @courseId)

    UPDATE Slot
    SET instructor_id = @InstructorId , course_id = @courseId
    WHERE slot_id = @slotID  
GO


-- 2.3)M)   Delete courses along with its related slots
GO
CREATE PROCEDURE Procedures_AdminDeleteCourse
    @courseID int
AS
    DELETE 
    FROM Course
    WHERE course_id=@courseID
GO


-- 2.3)R)   Insert graduation Plan
GO
CREATE PROCEDURE Procedures_AdvisorCreateGP
    @Semester_code varchar (40),
    @expected_graduation_date date,
    @sem_credit_hours int,
    @advisor_id int,
    @student_id int
AS
    INSERT INTO Graduation_Plan (semester_code, expected_grad_semester, semester_credit_hours, advisor_id, student_id)
    VALUES (@SemesterCode, @ExpectedGraduationDate, @SemCreditHours, @AdvisorId, @StudentId)
GO


-- 2.3)W)   Approve/Reject extra credit hours request
GO
CREATE PROCEDURE Procedures_AdvisorApproveRejectCHRequest
    @RequestID int,
    @Current_semester_code varchar (40)
AS
    DECLARE @SUM_HOURS int
            SELECT @SUM_HOURS= sum(C.credit_hours)
            FROM Request R INNER JOIN Student S ON R.student_id=S.student_id
            INNER JOIN Student_Instructor_Course_Take SC ON S.student_id=SC.student_id
            INNER JOIN Course C ON C.course_id=SC.course_id
            WHERE SC.semester_code=@Current_semester_code and R.request_id=@RequestID
            print @SUM_HOURS
      IF (SELECT credit_hours FROM Request WHERE request_id=@RequestID) >3    OR
           @SUM_HOURS+(SELECT credit_hours FROM Request WHERE request_id=@RequestID) >34    OR
           (SELECT S.assigned_hours FROM Student S INNER JOIN Request R ON S.student_id=R.student_id where r.request_id=@RequestID ) 
           +(SELECT credit_hours FROM Request WHERE request_id=@RequestID) >34   OR
           (SELECT S.gpa FROM Student S INNER JOIN Request R ON S.student_id=R.student_id where R.request_id=@RequestID )>3.7
             BEGIN
               UPDATE Request 
               SET status= 'rejected' 
               WHERE request_id =@RequestID
               END
       ELSE
              BEGIN
               UPDATE Request 
               SET status= 'accepted' 
               WHERE request_id =@RequestID
            END
GO
