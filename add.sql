create Database Advising_Team_66


-- Procedure for creating all Tables
Go
CREATE PROCEDURE CreateAllTables
    As

    -- Create the Advisor table
    CREATE TABLE  Advisor (
        advisor_id INT PRIMARY KEY,
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
        instructor_id INT PRIMARY KEY,
        name VARCHAR(40),
        email VARCHAR(40),
        faculty VARCHAR(40),
        office VARCHAR(40)
    );

    -- Create the Course table
    CREATE TABLE Course (
        course_id INT PRIMARY KEY,
        name VARCHAR(40),
        major VARCHAR(40),
        is_offered BIT,
        credit_hours INT,
        semester VARCHAR(40)
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
        student_id INT PRIMARY KEY,
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
        slot_id INT PRIMARY KEY,
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
        plan_id INT ,
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
        FOREIGN KEY (course_id) REFERENCES Course(course_id),
        primary key (plan_id,semester_code,course_id)
    );

    -- Create the Request table
    CREATE TABLE  Request (
        request_id INT PRIMARY KEY,
        type VARCHAR(40),
        comment VARCHAR(40),
        status VARCHAR(40) DEFAULT 'pending',
        credit_hours INT,
        student_id INT,
        advisor_id INT,
        course_id INT,
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
    );

    -- Create the MakeUp_Exam table
    CREATE TABLE MakeUp_Exam (
        exam_id INT PRIMARY KEY,
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
        payment_id INT PRIMARY KEY,
        amount DECIMAL(10, 2),
        deadline DATE,
        status VARCHAR(40) DEFAULT 'notPaid',
        fund_percentage DECIMAL(4, 3),
        student_id INT,
        semester_code VARCHAR(40),
        start_date DATE,
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
        deadline DATE,
        amount DECIMAL(10,2), -- Is Amount derived?
        status VARCHAR(40) DEFAULT 'notPaid',
        start_date DATE,
        FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        PRIMARY KEY (payment_id,deadline)
    );

GO


-- Procedure for Droping all Tables
GO
CREATE PROCEDURE DropAllTables
AS
    DROP Table Student,Student_Phone,Course,PreqCourse_course,Instructor,Instructor_Course,Student_Instructor_Course_Take,
    Semester,Course_Semester,Advisor,Slot,Graduation_Plan,GradPlan_Course,Request,MakeUp_Exam,Exam_Student,Payment,Installment
GO


-- Procedure for Clearing All Tables
GO
CREATE PROCEDURE  clearAllTables
AS
    TRUNCATE Table Student;
    TRUNCATE Table Student_Phone;
    TRUNCATE Table Course;
    TRUNCATE Table PreqCourse_course;
    TRUNCATE Table Instructor;
    TRUNCATE Table Instructor_Course;
    TRUNCATE Table Student_Instructor_Course_Take;
    TRUNCATE Table Semester;
    TRUNCATE Table Course_Semester;
    TRUNCATE Table Advisor;
    TRUNCATE Table Slot;
    TRUNCATE Table Graduation_Plan;
    TRUNCATE Table GradPlan_Course;
    TRUNCATE Table Request;
    TRUNCATE Table MakeUp_Exam;
    TRUNCATE Table Exam_Student;
    TRUNCATE Table Payment;
    TRUNCATE Table Installment;
GO
EXEC CreateAllTables
--Test______
--Ahmed----



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
    -- Declare variable for Student ID
    DECLARE @StudentID INT;

    -- Generate a unique student ID
    SELECT @StudentID = ISNULL(MAX(student_id), 0) + 1 FROM Student;

    -- Insert into the Student table
    INSERT INTO Student (student_id, f_name, l_name, faculty, email, major, password, semester)
    VALUES (@StudentID, @FirstName, @LastName, @Faculty, @Email, @Major, @Password, @Semester);

    -- Output the generated Student ID
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
    -- Insert into the Semester table
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
    -- Declare variables
    DECLARE @ExamID INT;

    -- Generate a unique exam ID
    SELECT @ExamID = ISNULL(MAX(exam_id), 0) + 1 FROM MakeUp_Exam;

    -- Insert into the MakeUp_Exam table
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
    -- Delete slots of courses not offered in the current semester
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
    -- Delete the specified course from the graduation plan
    DELETE FROM GradPlan_Course
    WHERE plan_id IN (
        SELECT plan_id
        FROM Graduation_Plan
        WHERE student_id = @StudentID
          AND semester_code = @SemesterCode
    ) AND course_id = @CourseID;
END;
