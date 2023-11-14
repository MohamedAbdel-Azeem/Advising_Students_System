-- Creating DataBase
Create Database Advising_Team_66


-- Procedure for creating all Tables
Go
CREATE PROCEDURE CreateAllTables
    As

    -- Create the Advisor table
    CREATE TABLE  Advisor (
        advisor_id VARCHAR(40) PRIMARY KEY,
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
        instructor_id VARCHAR(40) PRIMARY KEY,
        name VARCHAR(40),
        email VARCHAR(40),
        faculty VARCHAR(40),
        office VARCHAR(40)
    );

    -- Create the Course table
    CREATE TABLE Course (
        course_id VARCHAR(40) PRIMARY KEY,
        name VARCHAR(40),
        major VARCHAR(40),
        is_offered BIT,
        credit_hours INT,
        semester VARCHAR(40)
    );

    -- Create the PreqCourse_course table
    CREATE TABLE PreqCourse_course (
        prerequisite_course_id VARCHAR(40),
        course_id VARCHAR(40),
        FOREIGN KEY (course_id) REFERENCES Course(course_id),        
        FOREIGN KEY (prerequisite_course_id) REFERENCES Course(course_id),      
        Primary Key (course_id,prerequisite_course_id)
    );

    -- Create the Student table
    CREATE TABLE  Student (
        student_id VARCHAR(40) PRIMARY KEY,
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
        advisor_id VARCHAR(40),
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id)
        ON Update CASCADE
        ON DELETE CASCADE,
    );

    -- Create the Student_Phone table
    CREATE TABLE Student_Phone (
        student_id VARCHAR(40),
        phone_number VARCHAR(40),
        FOREIGN KEY (student_id) REFERENCES Student(student_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        Primary Key (student_id,phone_number)
    );


    -- Create the Instructor_Course table
    CREATE TABLE Instructor_Course (
        course_id VARCHAR(40),
        instructor_id VARCHAR(40),
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
        student_id VARCHAR(40),
        course_id VARCHAR(40),
        instructor_id VARCHAR(40),
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
        course_id VARCHAR(40),
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
        slot_id VARCHAR(40) PRIMARY KEY,
        day VARCHAR(40),
        time VARCHAR(40),
        location VARCHAR(40),
        course_id VARCHAR(40),
        instructor_id VARCHAR(40),
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
    );

    -- Create the Graduation_Plan table
    CREATE TABLE  Graduation_Plan (
        plan_id VARCHAR(40) ,
        semester_code VARCHAR(40),
        semester_credit_hours INT,
        expected_grad_semester VARCHAR(40),
        advisor_id VARCHAR(40),
        student_id VARCHAR(40),
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        PRIMARY KEY (plan_id,semester_code)
    );

    -- Create the GradPlan_Course table
    CREATE TABLE  GradPlan_Course (
        plan_id VARCHAR(40),
        semester_code VARCHAR(40),
        course_id VARCHAR(40),
        FOREIGN KEY (plan_id,semester_code) REFERENCES Graduation_Plan(plan_id,semester_code),
        FOREIGN KEY (course_id) REFERENCES Course(course_id),
        primary key (plan_id,semester_code,course_id)
    );

    -- Create the Request table
    CREATE TABLE  Request (
        request_id VARCHAR(40) PRIMARY KEY,
        type VARCHAR(40),
        comment VARCHAR(40),
        status VARCHAR(40) DEFAULT 'pending',
        credit_hours INT,
        student_id VARCHAR(40),
        advisor_id VARCHAR(40),
        course_id VARCHAR(40),
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
    );

    -- Create the MakeUp_Exam table
    CREATE TABLE MakeUp_Exam (
        exam_id VARCHAR(40) PRIMARY KEY,
        date DATE,
        type VARCHAR(40),
        course_id VARCHAR(40),
        FOREIGN KEY (course_id) REFERENCES Course(course_id),
    );

    -- Create the Exam_Student table
    CREATE TABLE Exam_Student (
        exam_id VARCHAR(40),
        student_id VARCHAR(40),
        course_id VARCHAR(40),
        FOREIGN KEY (exam_id) REFERENCES MakeUp_Exam(exam_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
        PRIMARY KEY (exam_id,student_id)
    );

    -- Create the Payment table
    CREATE TABLE Payment (
        payment_id VARCHAR(40) PRIMARY KEY,
        amount DECIMAL(10, 2),
        deadline DATE,
        status VARCHAR(40) DEFAULT 'notPaid',
        fund_percentage DECIMAL(4, 3),
        student_id VARCHAR(40),
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
        payment_id VARCHAR(40),
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
--Test______yahia
