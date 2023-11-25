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
        Primary Key (student_id,course_id,semester_code)
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
        expected_grad_date Date,
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
        date DATETIME,
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
        n_installments INT,
        status VARCHAR(40) DEFAULT 'notPaid',
        fund_percentage DECIMAL(4, 3),
        start_date DATETIME,
        student_id INT,
        semester_code VARCHAR(40),
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
        amount INT,
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

--  2.2)
-- 2.2)A)
 go
 create view view_Students
 as 
 select * from Student where financial_status=1
 go

  -- 2.2)B)

 go
 create view view_Course_prerequisites
 as select c.*, p.prerequisite_course_id from Course c left outer join PreqCourse_course p on c.course_id=p.course_id
 go

  -- 2.2)C)

 go
 create view Instructors_AssignedCourses
 as
 select s.*,i.course_id from Instructor_Course i inner join Instructor s on s.instructor_id=i.instructor_id
 go

  -- 2.2)D)

 go
 create view Student_Payment
 as
 select i.*,s.f_name+' '+s.l_name as'Full name' from Payment i inner join Student s on s.student_id=i.student_id
 go

  -- 2.2)E)

 go
 create view Courses_Slots_Instructor
 as select c.course_id,c.name, s.slot_id, s.day, s.time, s.location, i.name as'InstructorName' from Course c inner join slot s on s.course_id=c.course_id inner join Instructor i on s.instructor_id=i.instructor_id
 go

  -- 2.2)F)

 go
 create view Courses_MakeupExams(Course_Name,Course_Semester,Exam_id,Exam_date,Exam_type,Course_id)
 as
    Select C.name , C.semester , ME.exam_id , ME.date , ME.type , ME.course_id 
    From Course C INNER JOIN MakeUp_Exam ME on C.course_id = ME.course_id
go

 -- 2.2)G)

go
create view Students_Courses_transcript (Student_id, student_name, course_id, course_name, exam_type, course_grade, semester,  Instructors_name)
as select s.student_id,s.f_name+' '+s.l_name, sic.course_id, c.name,sic.exam_type,sic.grade,sic.semester_code,i.name
from Student s inner join Student_Instructor_Course_Take sic on s.student_id=sic.student_id inner join Course c on c.course_id=sic.course_id inner join Instructor i on i.instructor_id=sic.instructor_id
go

 -- 2.2)H)

 go
 create view Semster_offered_Courses (Course_id, Course_name, Semester_code)
 as 
 select c.course_id,c.name ,sc.semester_code from Course_Semester sc inner join course c on c.course_id=sc.course_id
 go


--2.2)I)    Fetch all graduation plans along with their initiated advisors
GO
CREATE VIEW Advisors_Graduation_Plan(Plan_id,Semester_code,Semester_credit_hrs,Expected_grad_date,Advisor_id,Student_id,Advisor_name)
AS
    SELECT GP.plan_id,GP.semester_code,GP.semester_credit_hours,GP.expected_grad_date,GP.advisor_id,GP.student_id,A.name 
    FROM Graduation_Plan GP INNER JOIN Advisor A ON GP.advisor_id=A.advisor_id
GO


--2.3
--A) (Tested)
Go
CREATE PROCEDURE Procedures_StudentRegistration
    @FirstName VARCHAR(40),
    @LastName VARCHAR(40),
    @Password VARCHAR(40),
    @Faculty VARCHAR(40),
    @Email VARCHAR(40),
    @Major VARCHAR(40),
    @Semester INT,
    @StudentID INT OUTPUT
    
AS
    INSERT INTO Student (f_name, l_name, faculty, email, major, password, semester)
    VALUES (@FirstName, @LastName, @Faculty, @Email, @Major, @Password, @Semester);
    SET @StudentID = SCOPE_IDENTITY() 
Go


 -- 2.3)B)  Advisor Registration (Tested)
Go
    CREATE PROCEDURE Procedures_AdvisorRegistration
        @advisor_name VARCHAR(40),
        @password VARCHAR(40),
        @email VARCHAR(40),
        @office VARCHAR(40),
        @advisor_id INT OUTPUT
        AS
            Insert Into Advisor values (@advisor_name,@email,@office,@password);
            SELECT @advisor_id = MAX(Advisor.advisor_id) FROM Advisor
Go

-- 2.3)C)    List all advising students (Tested)
GO
CREATE PROCEDURE  Procedures_AdminListStudents  
AS 
    SELECT *
    FROM Student
GO

-- 2.3)D)    List all Advisors (Tested)
Go
create procedure Procedures_AdminListAdvisors
as
select * from Advisor;
Go

--- 2.3)E)  List all Students with their Advisors (Tested)
GO
create PROCEDURE AdminListStudentsWithAdvisors
AS
Select S.*,A.name AS ADVISOR_NAME,A.email AS ADVISOR_EMAIL,A.office AS ADVISOR_OFFICE , A.password AS ADVISOR_PASSWORD
From Student S inner join Advisor A on (S.advisor_id=A.advisor_id)
Go

--F) (Tested)
CREATE PROCEDURE AdminAddingSemester
    @StartDate DATE,
    @EndDate DATE,
    @SemesterCode VARCHAR(40)
AS
    INSERT INTO Semester (semester_code, start_date, end_date)
    VALUES (@SemesterCode, @StartDate, @EndDate);
Go

-- 2.3)G)   Add new course (Tested)
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

-- 2.3)H)   Link instructor to course on specific slot (Tested)
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

-- 2.3)I)   Link student to course with Specific instructor (Tested)
Go
create procedure Procedures_AdminLinkStudent
@instructor_Id int, 
@student_ID int,
@course_ID int,
@semester_code varchar (40)
as
    insert into Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code) values(@student_id,@course_id,@instructor_Id,@semester_code)
Go

---2.3)J)   Link student to advisor (Tested)
GO 
CREATE PROCEDURE  Procedures_AdminLinkStudentToAdvisor
@Student_ID int ,
@Advisor_ID int 
As
Update  Student 
Set advisor_id=@Advisor_ID
where student_id=@Student_ID
GO

--K)    Admin add exam (Tested)
go
CREATE PROCEDURE Procedures_AdminAddExam
    @Type VARCHAR(40),
    @Date DATETIME,
    @CourseID INT
AS
    INSERT INTO MakeUp_Exam (date, type, course_id)
    VALUES (@Date, @Type,@CourseID)
Go

-- 2.3)L)   Issue installments as per the number of installments for a certain payment (Tested)
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

-- 2.3)M)   Delete courses along with its related slots (Tested)
GO
CREATE PROCEDURE Procedures_AdminDeleteCourse
    @courseID int
AS
    DELETE 
    FROM Course
    WHERE course_id=@courseID
GO

-- 2.3)N)   Update student's Status based on his/her financial status
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
Set financial_status = 1
Where student_id=@StudentID;
End
else
Begin
Update Student
Set financial_status = 0
Where student_id=@StudentID;
End
Go

-- 2.3) O)  List all pending requests (Tested)
GO
CREATE VIEW all_Pending_Requests
AS
    SELECT R.* , S.f_name + S.l_name As 'Student_Name' , A.name As 'Advisor_name' FROM
    Request R INNER JOIN Student S on R.student_id = S.student_id
    INNER JOIN Advisor A on R.advisor_id = A.advisor_id
GO


--P)Delete slots of certain courses if course isn’t offered in current sem (Tested)
GO
CREATE PROCEDURE Procedures_AdminDeleteSlots
    @current_semester VARCHAR(40)
AS
    DELETE FROM Slot
    WHERE course_id IN (
        SELECT CS.course_id
        FROM Course_Semester CS INNER JOIN Course C on CS.course_id = C.course_id
        WHERE CS.semester_code <> @current_semester OR C.is_offered = 0
    );
Go

-- 2.3)R)   Insert graduation Plan (Tested)
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

-- 2.3)S)   Add course inside certain plan of specific student (Tested)
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

--2.3)T)    Update expected graduation date in a certain graduation plan (Tested)
GO
CREATE PROCEDURE Procedures_AdvisorUpdateGP
@expected_grad_semster varchar (40),
@studentID int
AS
UPDATE Graduation_Plan
Set expected_grad_semester=@expected_grad_semster
where student_id=@studentID
Go


--2.3)U)    Delete course from certain graduation plan in certain semester (Tested)
Go
CREATE PROCEDURE Procedures_AdvisorDeleteFromGP
    @StudentID INT,
    @SemesterCode VARCHAR(40),
    @CourseID INT
AS
    DELETE FROM GradPlan_Course
    WHERE course_id = @CourseID AND semester_code = @SemesterCode AND plan_id IN (
        SELECT plan_id
        FROM Graduation_Plan
        WHERE student_id = @StudentID)
GO


-- 2.3)W)   Approve/Reject extra credit hours’ request
GO
CREATE PROCEDURE Procedures_AdvisorApproveRejectCHRequest
    @RequestID int,
    @Current_semester_code varchar (40)
AS
    DECLARE @SUM_HOURS int
    DECLARE @ASSIGN_HOURS int

    IF (SELECT S.assigned_hours FROM Student S INNER JOIN Request R ON S.student_id=R.student_id where r.request_id=@RequestID ) IS NULL
        BEGIN

            SET @ASSIGN_HOURS = 0
        END
    ELSE
        BEGIN
            SET @ASSIGN_HOURS = (SELECT S.assigned_hours FROM Student S INNER JOIN Request R ON S.student_id=R.student_id where r.request_id=@RequestID )
        END
            SELECT @SUM_HOURS= sum(C.credit_hours)
            FROM Request R INNER JOIN Student S ON R.student_id=S.student_id
            INNER JOIN Student_Instructor_Course_Take SC ON S.student_id=SC.student_id
            INNER JOIN Course C ON C.course_id=SC.course_id
            WHERE SC.semester_code=@Current_semester_code and R.request_id=@RequestID
      IF (SELECT credit_hours FROM Request WHERE request_id=@RequestID) >3    OR
           @SUM_HOURS+(SELECT credit_hours FROM Request WHERE request_id=@RequestID) >34      OR
           @SUM_HOURS+@ASSIGN_HOURS >34      OR
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

-- 2.3)X)    View all students assigned to specific advisor from a certain major (Tested)
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

--2.3)Y)    Approve/Reject courses request (ISA Tested)
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
   SICT.grade not in ('F','FA','FF')
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
            

-- 2.3)Z)   View pending requests of specific advisor students (Tested)
Go
    CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
        @advisor_id INT
        AS
            SELECT * FROM Request WHERE advisor_id = @advisor_id AND status = 'pending'
Go


-- BB)   Add Student mobile number(s)

go 
create procedure Procedures_StudentaddMobile 
@StudentID int, 
@mobile_number varchar (40)
as
insert into Student_phone values(@StudentID,@mobile_number);
go

-- DD)  Sending course’s request 

go 
create procedure Procedures_StudentSendingCourseRequest
@Student_ID int,
@course_ID int,
@type varchar (40),
@comment varchar (40) 
as
declare @advisor_Id int
select @advisor_Id=advisor_id from Student where @Student_ID=student_id
insert into Request(type,comment,course_id,student_id,advisor_id) values(@type, @comment, @course_id,@student_id,@advisor_Id);
go


-- EE)  Sending extra credit hours’ reques

go
create procedure Procedures_StudentSendingCHRequest
@Student_ID int,
@credit_hours int,
@type varchar (40),
@comment varchar (40) 
as
declare @advisor_Id int
select @advisor_Id=advisor_id from Student where @Student_ID=student_id
insert into Request(type,comment,credit_hours,student_id,advisor_id) values(@type, @comment, @credit_hours,@student_id,@advisor_Id);
go


-- 2.3)II)  Register for first makeup exam 
-- IF Student not in Make_up exam Table or if in SICT Table Then grade is F or Null TYPE IS NORMAL ?? 
-- 2 tables will have Insertions,exam_student and SICT (IN SICT do I get the Instructor_id? or Alter Data?)
-- DON'T INSERT INTO MAKEUP_EXAM!
GO
CREATE PROCEDURE Procedures_StudentRegisterFirstMakeup
    @studentID INT,
    @courseID INT,
    @student_current_sem VARCHAR(40)
    AS
        IF not Exists (SELECT * FROM
        MakeUp_Exam INNER JOIN Exam_Student on MakeUp_Exam.exam_id = Exam_Student.exam_id 
        WHERE Exam_Student.student_id = @studentID AND Exam_Student.course_id = @courseID) AND 
        @studentID IN (SELECT student_id FROM Student_Instructor_Course_Take
        WHERE semester_code=@student_current_sem AND (grade = 'FF') AND course_id = @courseID)
        BEGIN
            declare @exam_id INT;
            SELECT @exam_id = exam_id  from MakeUp_Exam WHERE course_id = @courseID and type = 'first';
            INSERT INTO Exam_Student(course_id,exam_id,student_id) VALUES (@courseID,@exam_id,@studentID);
            UPDATE Student_Instructor_Course_Take 
            SET exam_type = 'first' WHERE student_id = @studentID AND course_id = @courseID AND semester_code = @student_current_sem;
            UPDATE Student_Instructor_Course_Take 
            SET grade = null WHERE student_id = @studentID AND course_id = @courseID AND semester_code = @student_current_sem;
        END
GO


--2.3)KK)   Register for 2nd makeup exam
-- Eligible Only When failed or did not attend the first makeup and also has a maximum of TWO
-- failed courses per all odd or even semesters.
-- Is there a third Condition for Makeup Exams The Time in Which I am taking the 2nd Makeup?
GO
CREATE PROCEDURE Procedures_StudentRegisterSecondMakeup
    @student_ID INT,
    @courseID INT,
    @student_current_sem VARCHAR(40)
    AS
        IF (not Exists (SELECT * FROM MakeUp_Exam INNER JOIN Exam_Student on MakeUp_Exam.course_id = Exam_Student.course_id
        WHERE MakeUp_Exam.course_id = @courseID AND Exam_Student.student_id = @student_ID) OR Exists (SELECT * FROM Student_Instructor_Course_Take
        WHERE student_id = @student_ID AND course_id = @courseID AND semester_code = @student_current_sem AND (grade is Null OR grade = 'FF')) ) AND 
        Exists (SELECT Count(*) AS X FROM Student_Instructor_Course_Take WHERE student_id = @student_ID AND grade = 'FF' AND X > 2)
        BEGIN
            declare @exam_id INT;
            SELECT @exam_id = exam_id  from MakeUp_Exam WHERE course_id = @courseID and type = 'second';
            INSERT INTO Exam_Student(course_id,exam_id,student_id) VALUES (@courseID,@exam_id,@studentID);
            UPDATE Student_Instructor_Course_Take
            SET exam_type = 'second' WHERE student_id = @studentID AND course_id = @courseID AND semester_code = @student_current_sem;
            UPDATE Student_Instructor_Course_Take 
            SET grade = null WHERE student_id = @studentID AND course_id = @courseID AND semester_code = @student_current_sem;
        END
Go

-- 2.3)LL)  View required courses

GO 
CREATE PROCEDURE Procedures_ViewRequiredCourses
    @StudentID int,
    @CurrentSemesterCode varchar(40)
AS
    DECLARE @Major  VARCHAR(40)
    DECLARE @Semster  int
    DECLARE @count_failed int

    SELECT @count_failed=count(*) 
     FROM Student_Instructor_Course_Take
     WHERE student_id = @StudentID AND grade in('F','FA')

    SELECT  @Major=major ,@Semster=semester
    from Student where student_id=@StudentID

    SELECT C.*
    FROM Course C left outer join Student_Instructor_Course_Take SICT on c.course_id=SICT.course_id
    WHERE ( (SICT.student_id=@StudentID  AND SICT.grade in ('F','FA') OR (C.major=@Major AND C.semester<@Semster and c.course_id not in(select course_id from Student_Instructor_Course_Take where student_id=@StudentID)))) AND 
    C.is_offered=1 AND 
    NOT EXISTS( SELECT * 
                FROM MakeUp_Exam ME  
                WHERE ME.course_id=C.course_id AND ME.type='FIRST' AND ME.date>CURRENT_TIMESTAMP) AND 
    NOT EXISTS( SELECT * 
                FROM MakeUp_Exam ME  
                WHERE ME.course_id=C.course_id AND ME.type='SECOND' AND ME.date>CURRENT_TIMESTAMP AND @count_failed<3 )

GO

-- 2.3)MM)  View optional courses
go
create procedure Procedures_ViewOptionalCourse
@StudentID int, 
@Current_semester_code Varchar (40)
AS
DECLARE @Major  VARCHAR(40)
    DECLARE @Semster  int
    DECLARE @count_failed int

    SELECT @count_failed=count(*) 
     FROM Student_Instructor_Course_Take
     WHERE student_id = @StudentID AND grade in('F','FA')

     SELECT  @Major=major ,@Semster=semester
    from Student where student_id=@StudentID

select c.*
from Course c
where c.major=@major and not exists(select * from Student_Instructor_Course_Take s
 where s.student_id=@StudentID and c.course_id=s.course_id) and c.course_id 
 not in(
    

    SELECT C2.course_id
    FROM Course C2 left outer join Student_Instructor_Course_Take SICT on c2.course_id=SICT.course_id
    WHERE ( (SICT.student_id=@StudentID  AND SICT.grade in ('F','FA') OR (C2.major=@Major AND C2.semester<@Semster and c2.course_id not in(select course_id from Student_Instructor_Course_Take where student_id=@StudentID)))) AND 
    C2.is_offered=1 AND 
    NOT EXISTS( SELECT * 
                FROM MakeUp_Exam ME  
                WHERE ME.course_id=C2.course_id AND ME.type='FIRST' AND ME.date>CURRENT_TIMESTAMP) AND 
    NOT EXISTS( SELECT * 
                FROM MakeUp_Exam ME  
                WHERE ME.course_id=C2.course_id AND ME.type='SECOND' AND ME.date>CURRENT_TIMESTAMP AND @count_failed<3 )
 )
 go


--2.3)NN)   View missing/remaining courses to specific student. 
GO
CREATE PROCEDURE Procedures_ViewMS
    @StudentID INT
    AS
    Declare @student_major VARCHAR(40)
    select @student_major= s.major from Student S where s.student_id=@studentID
    
    SELECT * FROM Course C WHERE C.major = @student_major
    AND not Exists 
    (SELECT * FROM Student_Instructor_Course_Take 
    where student_id = @StudentID AND course_id = C.course_id AND grade not in ('FA','FF','F')) 
Go

--2.3) OO) 
GO
CREATE PROCEDURE Procedures_ChooseInstructor
@StudentID INT,
@InstructorID INT,
@CourseID INT
AS
INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id)
VALUES (@StudentID, @CourseID, @InstructorID);
INSERT INTO Instructor_Course(course_id, instructor_id)
VALUES (@CourseID, @InstructorID);
GO


