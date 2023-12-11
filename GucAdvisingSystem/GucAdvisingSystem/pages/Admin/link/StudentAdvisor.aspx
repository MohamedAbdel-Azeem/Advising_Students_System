<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentAdvisor.aspx.cs" Inherits="GucAdvisingSystem.pages.Admin.link.StudentAdvisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Link Student-Advisor</title>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link href="../../Styles/mainPageStyles.css" rel="stylesheet" />
    <link href="../../Styles/addStyles.css" rel="stylesheet" />
</head>
<body>
            <aside>
    <h1>Controls</h1>
    <div id="controls">
        <ul class="menu-list">
            <li>
                <p><a href="../AdminPage.aspx" style="color:white;text-decoration:none">Home</a></p>
            </li>
            <li class="menu-item">
                <button class="collapsible">List <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../lists/advisorsList.aspx" style="color:white;text-decoration:none">Advisors</a></p>
                    <p><a href="../lists/studentsList.aspx" style="color:white;text-decoration:none">Students</a></p>
                    <p><a href="../lists/PendingRequestsList.aspx" style="color:white;text-decoration:none">Requests</a></p>
                </div>
            </li>
           <li class="menu-item">
                <button class="collapsible">ADD <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../add/semesterAdd.aspx" style="color:white;text-decoration:none">Semester</a></p>
                    <p><a href="../add/semesterAdd.aspx" style="color:white;text-decoration:none">Course</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Makeup Exam</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Link <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                        <p><a href="InstructorCourseSlot.aspx" style="color:white;text-decoration:none">Instructor to Course in a Slot</a></p>
                        <p><a href="#" style="color:white;text-decoration:none">Student to Advisor</a></p>
                        <p><a href="#" style="color:white;text-decoration:none">Student to Course with Instructor</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">View <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="#" style="color:white;text-decoration:none">Instructors details</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Students' Payment details</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Graduation Plans</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Student's Transcript</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Fetch <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="#" style="color:white;text-decoration:none">Semesters along with offered Courses</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Active Students details</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Delete <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="#" style="color:white;text-decoration:none">Course with its Slots</a></p>
                    <p><a href="#" style="color:white;text-decoration:none">Not offered Course Slots</a></p>
                </div>
            </li>
            <li class="menu-item">
               <p> <a href="#" style="color:white;text-decoration:none">Issue Installments</a></p>
            </li>
        </ul>
    </div>
</aside>
    <form id="form1" runat="server">
        <div class="inputContainer">
            <h2>Link Student to Advisor</h2>
            <div class="inputGroup" id="SID">
                <asp:TextBox ID="StudentIDInput" runat="server" CssClass="input" placeholder="Student ID"></asp:TextBox>
                <asp:Label runat="server" Text="Student ID" CssClass="userLabel"></asp:Label>
            </div>
        <div class="inputGroup" id="AID">
            <asp:TextBox ID="AdvisorIDInput" runat="server" CssClass="input" placeholder="Advisor ID"></asp:TextBox>
            <asp:Label runat="server" Text="Advisor ID" CssClass="userLabel"></asp:Label>
        </div>
        <div>
            <asp:Button ID="AddButton" runat="server" Text="Link" OnClick="LinkStudentAdvisor" class="AddButton"/>
        </div>
        </div>
    </form>
    <script src="../../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
