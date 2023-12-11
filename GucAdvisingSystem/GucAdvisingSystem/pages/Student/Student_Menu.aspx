<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Menu.aspx.cs" Inherits="GucAdvisingSystem.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Studnt Main Page</title>
        <link href="../Styles/mainPageStyles.css" rel="stylesheet" />
</head>
<body>
    <aside style="background:linear-gradient(159deg, rgba(255,30,5,1) 0%, rgba(179,0,69,1) 100%);">
        <h1>Controls</h1>
        <div id="controls">
            <ul class="menu-list">
                <li>
                    <p><a href="Student_Menu.aspx" style="color:white;text-decoration:none">Home</a></p>
                </li>
                <li class="menu-item">
                    <button class="collapsible">View Courses <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p><a href="Courses_Views/Optional_Courses.aspx" style="color:white;text-decoration:none"> Optional Courses </a></p>
                        <p><a href="Courses_Views/Required_Courses.aspx" style="color:white;text-decoration:none"> Required Courses </a></p>
                        <p><a href="Courses_Views/Available.aspx" style="color:white;text-decoration:none"> Available Courses </a></p>
                        <p><a href="Courses_Views/Missing.aspx" style="color:white;text-decoration:none"> Missing Courses </a></p>
                    </div>
                </li>
               <li class="menu-item">
                    <button class="collapsible">Send Request<img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p><a href="Requests/Course_Request.aspx" style="color:white;text-decoration:none"> Send Course Request </a></p>
                        <p><a href="Requests/CHR_request.aspx" style="color:white;text-decoration:none"> Send Extra credit hours Request </a></p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">Link <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                            <p>Instructor to Course in a Slot</p>
                            <p>Student to Advisor</p>
                            <p>Student to Course with Instructor</p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">View <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Instructors details</p>
                        <p>Students' Payment details</p>
                        <p>Graduation Plans</p>
                        <p>Student's Transcript</p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">Fetch <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Semesters along with offered Courses</p>
                        <p>Active Students details</p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">Delete <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Course with its Slots</p>
                        <p>Not offered Course Slots</p>
                    </div>
                </li>
                <li class="menu-item">
                   <p><a href="telephone_number/telephone_number.aspx" style="color:white;text-decoration:none">Add Mobile number</a></p>
                    
                </li>
            </ul>
        </div>
        
    </aside>
    <script src="../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>