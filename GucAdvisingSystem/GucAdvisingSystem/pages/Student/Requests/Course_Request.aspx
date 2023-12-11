<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_Request.aspx.cs" Inherits="GucAdvisingSystem.pages.Student.Requests.Course_Request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="../../Styles/mainPageStyles.css" rel="stylesheet" />
<link href="../../Styles/addStyles.css" rel="stylesheet" />
</head>
<body>
    <aside style="background:linear-gradient(159deg, rgba(255,30,5,1) 0%, rgba(179,0,69,1) 100%);">
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
         <p><a href="Course_Request.aspx" style="color:white;text-decoration:none"> Send Course Request </a></p>
         <p><a href="CHR_request.aspx" style="color:white;text-decoration:none"> Send Extra credit hours Request </a></p>

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
                   <p><a href="../telephone_number/telephone_number.aspx" style="color:white;text-decoration:none">Add Mobile number</a></p>
            </li>
        </ul>
    </div>
</aside>
    <form id="form1" runat="server">
        <div>
     <div class="inputContainer">
         <h2>Send Course Request</h2>
         <div class="inputGroup" id="courseID">
             <asp:TextBox ID="courseIDInput" runat="server" CssClass="input" placeholder="CourseID"></asp:TextBox>
             <asp:Label ID="CID" runat="server" Text="Course ID" CssClass="userLabel"></asp:Label>
         </div>
         <div class="inputGroup" id="CreditHours">
             <asp:TextBox ID="CommentInput" runat="server" CssClass="input" placeholder="Comment"></asp:TextBox>
             <asp:Label ID="Comment" runat="server" Text="Comment" CssClass="userLabel"></asp:Label> 
         </div>
       
         <div>
             <asp:Button ID="AddButton" OnClick="Course_requested" runat="server"  Text="Send Request" class="AddButton"/>
         </div>
     </div>
        </div>
    </form>
        <script src="../../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
