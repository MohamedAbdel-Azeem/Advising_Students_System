insert into Advisor (name, email, office, password)
    values ('David Johnson', 'david.johnson@guc.edu.eg', 'B-201', 'password456'),
           ('Dominic Johnson', 'dominic.johnson@guc.edu.eg', 'B-202', 'password789');



insert into Student (f_name, l_name, gpa, faculty, email, major, password, financial_status, semester, acquired_hours, assigned_hours, advisor_id)
    values ('Ahmed', 'Zidane', 3.5 , 'MET', 'ahmedzidane@guc', 'CS', 'password123', 1 , 3 , 159 , 10 , 1),
           ('Mariam', 'Saleh', 3.6 , 'MET', 'mariamsaleh@guc', 'CS', 'password456', 1 , 3 , 186 , 10 , 1),
           ('Nadia', 'Hassan', 3.8, 'MET', 'nadiahassan@guc', 'CS', 'password789', 1 , 3 , 163 , 10 , 2),
           ('Sama', 'mohamed', 2.2 , 'MET', 'samamohamed@guc', 'CS', 'password101112', 1 , 3 , 170 , 10 , 2),
           ('Khaled', 'mohamed', 3.7 , 'MET', 'khaledmohamed@guc', 'CS', 'password13141516', 1 , 3 , 159 , 10 , 2);



insert into Course (name, major, is_offered, credit_hours, semester)
     values ('Math1', 'CS', 1, 8, 1),
            ('CS1' , 'CS' , 1, 6, 1),
            ('PHY1' , 'CS' , 1, 6 , 1),
            ('Production' , 'CS' , 1,4 ,1),
            ('Chemistry' , 'CS' , 1,4 ,1),
      
           ('Math2', 'CS', 0, 8, 2),
           ('CS2' , 'CS' , 0, 6, 2),
           ('PHY2' , 'CS' , 0, 6 , 2),
           ('Drawing' , 'CS' , 0,4 ,2),
           ('DLD' , 'CS' , 0,4 ,2),

           ('Math3', 'CS', 1, 8, 3),
           ('CS3' , 'CS' , 1, 6, 3),
           ('PHY3' , 'CS' , 1, 6 , 3),
           ('Circuits1' , 'CS' , 1,4 ,3),

           ('Math4', 'CS', 0, 8, 4),
           ('CS4' , 'CS' , 0, 6, 4),
           ('Signals' , 'CS' , 0, 6 , 4),
           ('Circuits2' , 'CS' , 0,4 ,4);

    

insert into PreqCourse_course(  prerequisite_course_id , course_id)
      values( 1,6),
            (6,11),
            (11,15),

             (2,7),
             (7,12),
             (12,16),

             (3,8),
             (8,13),
             (14,18);

     

       

insert into Instructor (name, email, faculty, office)
    values ('Jane Smith', 'jane.smith@guc.edu.eg', 'MET', 'A-101'),
           ('Will Smith', 'will.smith@guc.edu.eg', 'MET', 'A-102');

insert into Instructor_Course( course_id , instructor_id )
    values ( 1 , 1),
           ( 2 , 1),
           ( 3 , 1),
           ( 4 , 1),
           ( 5 , 1),
           ( 6 , 1),
           ( 7 , 1),
           ( 8 , 1),
           ( 9 , 1),
           ( 10 , 1),

           ( 11 , 2),
           ( 12, 2),
           ( 13, 2),
           ( 14 , 2),
           ( 15, 2),
           ( 16, 2),
           ( 17, 2),
           ( 18, 2);
 
    
    

insert into Semester (semester_code, start_date, end_date)
    values ('W22', '2022-09-01', '2022-12-31'),
           ('S22', '2023-01-20', '2023-06-20'),
           ('W23', '2023-09-01', '2023-12-31'),
           ('S23', '2024-01-20', '2024-06-20');

    

insert into Student_Instructor_Course_Take (student_id, course_id, instructor_id, semester_code, exam_type, grade)
    values (1,1,1,'W22', 'Normal', 'A'),
           (1,2,1, 'W22', 'Normal' , 'A' ),
           (1,3,1, 'W22', 'Normal' , 'F' ),
           (1,4,1, 'W22', 'Normal' , 'F' ),
           (1,5,1, 'W22', 'Normal' , 'F' ),
           (1,5,1,'S22', 'First_makeup' , 'FA' ),

           (1,6,1,'S22', 'Normal', 'D'),
           (1,7,1, 'S22', 'Normal' , 'FA' ),
           (1,8,1, 'S22', 'Normal' , 'B' ),
           (1,9,1, 'S22', 'Normal' , 'C' ),
           (1,10,1, 'S22', 'Normal' , 'B' ),

          (1,11,2,'W23', 'Normal', null),
          (1,13,2, 'W23', 'Normal' , null ),


          --first student should not be eligible for second makeup for course 5 , due to number of failed courses >=2 in odd semesters
          --first student should not be eligible for second makeup for course 7 , due to not entering a first makeup for it
          --first student course request of course 12 should be rejected for not sastisfying it's prereq course 
          --(heads up a prereq course is not sastsfied if grade is null or FA or it's not in Student_Instructor_Course_Take table obviously)
          --first student credit hour request of 6 should be rejected due to it being above 3
          --first student required courses for Winter2023 should be course 3,4,5 
          --first student required courses for Spring2023 should be course 7
          --first student optional courses should be course 14 and 17

          (2,1,1,'W22', 'Normal', 'A'),
          (2,2,1, 'W22', 'Normal' , 'C' ),
          (2,3,1, 'W22', 'Normal' , 'A' ),
          (2,4,1, 'W22', 'Normal' , 'F' ),
          (2,5,1, 'W22', 'Normal' , 'FF' ),
          (2,5,1,'S22', 'First_makeup' , 'FA' ),

          (2,6,1,'S22', 'Normal', 'D'),
          (2,7,1, 'S22', 'Normal' , 'C' ),
          (2,8,1, 'S22', 'Normal' , 'B' ),
          (2,9,1, 'S22', 'Normal' , 'FA' ),
          (2,10,1, 'S22', 'Normal' , 'F' ),

          (2,11,2,'W23', 'Normal', null),
          (2,12,2, 'W23', 'Normal' , null),
          (2,13,2, 'W23', 'Normal' , null ),
          (2,14,2, 'W23', 'Normal' , null ),

          --second student should be eligibe for second makeup for course 5
          --second student credit hour request for Winter2023 should be accepted , check her payment , installment and assigned hours after it 
          --second student required courses for Winter2023 should be 4,5 before registering for second makeup for course 5
          --second student required courses for Winter2023 should be 4   after registering for second makeup for course 5
          --second student required courses for Spring2023 should be 9,10
          --second student optional course should be course 17

         (3,1,1,'W22', 'Normal', 'A'),
         (3,2,1, 'W22', 'Normal' , 'A' ),
         (3,3,1, 'W22', 'Normal' , 'A' ),
         (3,4,1, 'W22', 'Normal' , 'F' ),
         (3,5,1, 'W22', 'Normal' , 'FF' ),

         (3,6,1,'S22', 'Normal', 'D'),
         (3,7,1, 'S22', 'Normal' , 'C' ),
         (3,8,1, 'S22', 'Normal' , 'B' ),
         (3,9,1, 'S22', 'Normal' , 'C' ),
         (3,10,1, 'S22', 'Normal' , 'B' ),

   
        
         (3,13,2, 'W23', 'Normal' , null ),
         (3,14,2, 'W23', 'Normal' , null ),

         --third student should be eligible for first makeup for course 5
         --third student credit hour request should be rejected , due to third student having gpa>3.7
         --third student course request for course 11 should be accepted , check Student_Instructor_Course_Take table and student's assigned hours after it
         --third student course request for course 12 should be rejected, if he requested after course request for course 11 being accepted ,due to not having assigned hours for it 
         --third student required courses for Winter2023 should be 4,5 before registering for first makeup for course 5
         --third student required course  for Winter2023 should be 4 after registering for first makeup for course 5
         --third student optional course should be course 12,17
    

         (4,1,1,'W22', 'Normal', 'A'),
         (4,2,1, 'W22', 'Normal' , 'A' ),
         (4,3,1, 'W22', 'Normal' , 'A' ),
     

         (4,6,1,'W22', 'Normal', 'D'),
         (4,7,1, 'W22', 'Normal' , 'C' ),
         (4,8,1, 'W23', 'Normal' , 'B' ),
         (4,9,1, 'W23', 'Normal' , 'C' ),
         (4,10,1, 'W23', 'Normal' , 'B' ),
         
         (4,4,1, 'W23', 'Normal' , 'C' ),
         (4,5,1, 'W23', 'Normal' , 'A' ),
         (4,11,2,'W23', 'Normal', 'A'),
         (4,12,2, 'W23', 'Normal' ,'A'),
         (4,13,2, 'W23', 'Normal' , 'A' ),
         (4,14,2, 'W23', 'Normal' , 'A' ),
    
         --fourth student has no required courses
         --fourth student optional courses should be course 15,16,17,28
         --fourth student credit hour request should be rejected due to having to much credit hours already (larger than 34)


         (5,1,1,'W22', 'Normal', 'A'),
         (5,2,1, 'W22', 'Normal' , 'A' ),
         (5,3,1, 'W22', 'Normal' , 'A' ),
         

        (5,6,1,'S22', 'Normal', 'D'),
        (5,7,1, 'S22', 'Normal' , 'C' ),
        (5,8,1, 'S22', 'Normal' , 'B' ),
        (5,9,1, 'S22', 'Normal' , 'C' ),
        (5,10,1, 'S22', 'Normal' , 'B' ),

        (5,4,1, 'W23', 'Normal' , 'C' ),
        (5,5,1, 'W23', 'Normal' , 'D' );

        --fifth student is not active



insert Course_Semester(course_id , semester_code)
   values(1,'W22'),
         (2,'W22'),
         (3,'W22'),
         (4,'W22'),
         (5,'W22'),

         (1,'W23'),
         (2,'W23'),
         (3,'W23'),
         (4,'W23'),
         (5,'W23'),

         (6, 'S22'),
         (7, 'S22'),
         (8, 'S22'),
         (9, 'S22'),
         (10, 'S22'),

         (6, 'S23'),
         (7, 'S23'),
         (8, 'S23'),
         (9, 'S23'),
         (10, 'S23'),

         (11,'W22'),
         (12,'W22'),
         (13,'W22'),
         (14,'W22'),
         (15,'W22'),

        (11 , 'W23'),
        (12 , 'W23'),
        (13 , 'W23'),
        (14 , 'W23'),

        (15, 'S22'),
        (16, 'S22'),
        (17, 'S22'),
        (18, 'S22'),
  
        (15, 'S23'),
        (16, 'S23'),
        (17, 'S23'),
        (18, 'S23');
  


insert into Slot (day, time, location, course_id, instructor_id)
    values ('Mon', '10:00 AM', 'Room 101', 11, 2),--when calling AdminDeleteSlots with spring semester course will be removed from slot
           ('Tue', '10:00 AM', 'Room 102', 12, 2),--when calling AdminDeleteSlots with spring semester course will be removed from slot
           ('Wen', '10:00 AM', 'Room 103', 13, 2),--so when calling AdminDeleteSlots with spring semester course will be removed from slot 
           ('Thu', '10:00 AM', 'Room 104', 15, 1);--so when calling AdminDeleteSlots with winter semester course will be removed from slot
    
insert into Graduation_Plan (semester_code, semester_credit_hours, expected_grad_date, advisor_id, student_id)
    values ('W23', 32 , '2023-06-01', 2, 4),
           ('W23', 30 , '2023-06-01', 2, 5);

    

insert into GradPlan_Course(plan_id,semester_code,course_id)
    values ( 1 , 'W23' , 17),
           ( 2 , 'W23' , 11);

   

insert into Request (type, comment, status , credit_hours, student_id, advisor_id, course_id)
    values ('Add Course', 'add a course.', 'pending' , 0 , 1 , 1 , 12), --should be rejected 
           ('Add Course', 'add a course.', 'pending' , 0 , 3 , 2, 11), --should be accepted
           ('Add Course', 'add a course.', 'pending' , 0 , 3 , 2, 12), --should be rejected (if reequest 2 got accepted first)
   
           ('Add Credit Hours', 'credit hours.', 'pending' , 6 , 1 , 1 , 1), --should be rejected
           ('Add Credit Hours', 'credit hours.', 'pending' , 3 , 4 , 1, 1), --should be rejected
           ('Add Credit Hours', 'credit hours.', 'pending' , 3 , 3 , 1, 1), --should be rejected
           ('Add Credit Hours', 'credit hours.', 'pending' , 3 , 2 , 1, 1); --should be accepted


insert into MakeUp_Exam (date, type, course_id)
    values ('2023-12-30 10:00 AM', 'Second_makeup', 5),
           ('2022-12-30 10:00 AM', 'Second_makeup', 5),
           ('2023-12-30 10:00 AM', 'First_makeup', 5),
           ('2022-12-30 10:00 AM', 'First_makeup', 5);

insert into Exam_Student (exam_id, student_id, course_id)
    values (1, 5 , 5);

insert into Payment (amount, deadline, n_installments, status , fund_percentage, start_date, student_id, semester_code)
    values
           (1000000 , '2023-12-01 10:00 AM', 6 , 'Paid' , 0.5 , '2023-06-01 10:00 AM', 1 , 'W23'),
           (1000000 , '2023-12-01 10:00 AM', 6 , 'Paid' , 0.5 , '2023-06-01 10:00 AM', 2 , 'W23'),
           (1000000 , '2023-12-01 10:00 AM', 6 , 'Paid' , 0.5 , '2023-06-01 10:00 AM', 3 , 'W23'),
           (1000000 , '2023-12-01 10:00 AM', 6 , 'Paid' , 0.5 , '2023-06-01 10:00 AM', 4 , 'W23'),
           (1000000 , '2023-12-01 10:00 AM', 6 , 'NotPaid' , 0.5 , '2023-06-01 10:00 AM', 5 , 'W23');
          
        

--make installment table using Procedures_AdminIssueInsallment and alter table to try different unpaid and paid installments 

EXEC Procedures_ViewRequiredCourses