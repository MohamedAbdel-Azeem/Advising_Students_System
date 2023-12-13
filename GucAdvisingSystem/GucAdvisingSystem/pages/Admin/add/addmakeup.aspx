<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addmakeup.aspx.cs" Inherits="Admin.addmakeup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Makeup Exame</title>
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
                    <p><a href="semesterAdd.aspx" style="color:white;text-decoration:none">Semester</a></p>
                    <p><a href="courseAdd.aspx" style="color:white;text-decoration:none">Course</a></p>
                    <p><a href="addmakeup.aspx" style="color:white;text-decoration:none">Makeup Exam</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Link <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                        <p><a href="../link/InstructorCourseSlot.aspx" style="color:white;text-decoration:none">Instructor to Course in a Slot</a></p>
                        <p><a href="../link/StudentAdvisor.aspx" style="color:white;text-decoration:none">Student to Advisor</a></p>
                        <p><a href="../link/StudentCourseInstructor.aspx" style="color:white;text-decoration:none">Student to Course with Instructor</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">View <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../view/InstructorCourses.aspx" style="color:white;text-decoration:none">Instructors details</a></p>
                    <p><a href="../view/ViewPayments.aspx" style="color:white;text-decoration:none">Students' Payment details</a></p>
                    <p><a href="../view/Grad_advisor.aspx" style="color:white;text-decoration:none">Graduation Plans</a></p>
                    <p><a href="../view/Stud_Transcript.aspx" style="color:white;text-decoration:none">Student's Transcript</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Fetch <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../fetch/CoursesSemesters.aspx" style="color:white;text-decoration:none">Semesters along with offered Courses</a></p>
                    <p><a href="../fetch/Student_details.aspx" style="color:white;text-decoration:none">Active Students details</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Delete <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../delete/Delete.aspx" style="color:white;text-decoration:none">Course with its Slots</a></p>
                    <p><a href="../delete/slotdeletion.aspx" style="color:white;text-decoration:none">Not offered Course Slots</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Payment <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../misc/Issue_installment.aspx" style="color:white;text-decoration:none">Issue Installments</a></p>
                    <p><a href="../misc/Update_status.aspx" style="color:white;text-decoration:none">Update Student Financial Status</a></p>
                </div>
            </li>
        </ul>
    </div>
</aside>
    <form id="form1" runat="server">
        <div class="inputContainer">
            <h2>Add Makeup Exam</h2>
            <div class="inputGroup">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="input" placeholder="Exam Type"></asp:TextBox>
                <asp:Label runat="server" Text="Exam Type" CssClass="userLabel"></asp:Label>
            </div>
            <div class="inputGroup">
                <input type="date" id="ExamDateInput" class="input" runat="server" />
                <span class="styledText">Exam Date</span>
            </div>
            <div class="inputGroup">
                <asp:TextBox ID="TextBox3" runat="server" CssClass="input" placeholder="Course"></asp:TextBox>
                <asp:Label runat="server" Text="Course" CssClass="userLabel"></asp:Label>
            </div>
            <div>
                <asp:Button ID="Button1" runat="server" OnClick="add_makeup" Text="Add makeup" class="AddButton"/>
            </div>
        </div>
    </form>
    <script src="../../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
