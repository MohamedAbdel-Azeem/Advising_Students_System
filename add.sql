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
            UPDATE Installment set amount = (SELECT Payment.amount/Payment.n_installments FROM Payment WHERE payment_id = @payment_id) WHERE payment_id = @payment_id
GO


-- 2.3)Z)   View pending requests of specific advisor students
Go
    CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
        @advisor_id INT
        AS
            SELECT * FROM Request WHERE advisor_id = @advisor_id AND status = 'pending'
Go
