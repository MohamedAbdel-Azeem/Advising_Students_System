<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="telephone_number.aspx.cs" Inherits="GucAdvisingSystem.pages.Student.telephone_number" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                <p><a href="../Student_Menu.aspx" style="color:white;text-decoration:none">Home</a></p>
            </li>
            <li class="menu-item">
                <button class="collapsible">View Courses<img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../Courses_Views/Optional_Courses.aspx" style="color:white;text-decoration:none"> Optional Courses </a></p>
                    <p><a href="../Courses_Views/Required_Courses.aspx" style="color:white;text-decoration:none"> Required Courses </a></p>
                    <p><a href="../Courses_Views/Available.aspx" style="color:white;text-decoration:none"> Available Courses </a></p>
                    <p><a href="../Courses_Views/Missing.aspx" style="color:white;text-decoration:none"> Missing Courses </a></p>
                </div>
            </li>
          <li class="menu-item">
     <button class="collapsible">Send Request<img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
     <div class="content">
         <p><a href="../Requests/Course_Request.aspx" style="color:white;text-decoration:none"> Send Course Request </a></p>
        <p><a href="../Requests/CHR_request.aspx" style="color:white;text-decoration:none"> Send Extra credit hours Request </a></p>
     </div>
 </li>
            <li class="menu-item">
                <button class="collapsible">Link <img src="../../Styles/Assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                        <p><a href="#" style="color:white;text-decoration:none">Instructor to Course in a Slot</a></p>
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
               <p> <a href="telephone_number.aspx" style="color:white;text-decoration:none">Add Mobile Number</a></p>
            </li>
        </ul>
    </div>
</aside>
    <form id="form1" runat="server">
        <div>
     <div class="inputContainer">
         <h2>Add Mobile Number</h2>
         <div class="inputGroup" id="credit_hours">
             <asp:TextBox ID="mobile_number" runat="server" CssClass="input" placeholder="Number"></asp:TextBox>
             <asp:Label ID="CHR" runat="server" Text="Mobile Number" CssClass="userLabel"></asp:Label>
         </div>
         <div>
             <asp:Button ID="AddButton" OnClick="Add_number" runat="server"  Text="Save Number" class="AddButton"/>
         </div>
     </div>
        </div>
    </form>
        <script src="../../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>