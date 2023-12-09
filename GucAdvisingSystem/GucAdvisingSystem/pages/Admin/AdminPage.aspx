<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="GucAdvisingSystem.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Control Room</title>
    <link href="../Styles/mainPageStyles.css" rel="stylesheet" />
</head>
<body>
    <aside>
        <h1>Controls</h1>
        <div id="controls">
            <ul class="menu-list">
                <li>
                    <button class="collapsible">Home</button>
                </li>
                <li class="menu-item">
                    <button class="collapsible">List <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Advisors</p>
                        <p>Students</p>
                        <p>Requests</p>
                    </div>
                </li>
               <li class="menu-item">
                    <button class="collapsible">ADD <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Semester</p>
                        <p>Course</p>
                        <p>Makeup Exam</p>
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
                    <button class="collapsible">Issue Installments.</button>
                </li>
            </ul>
        </div>
    </aside>
    <script src="../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
