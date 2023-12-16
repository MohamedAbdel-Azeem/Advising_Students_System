<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="telephone_number.aspx.cs" Inherits="GucAdvisingSystem.pages.Student.telephone_number" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/11.0.9/css/intlTelInput.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/11.0.9/js/intlTelInput.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/11.0.9/js/utils.js"></script>

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
                <button class="collapsible">View Courses <img src="../../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../Courses_Views/Optional_Courses.aspx" style="color:white;text-decoration:none"> Optional Courses </a></p>
                    <p><a href="../Courses_Views/Required_Courses.aspx" style="color:white;text-decoration:none"> Required Courses </a></p>
                    <p><a href="../Courses_Views/Available.aspx" style="color:white;text-decoration:none"> Available Courses </a></p>
                    <p><a href="../Courses_Views/Missing.aspx" style="color:white;text-decoration:none"> Missing Courses </a></p>
                    <p><a href="../Courses_Views/CoursesWithExam.aspx" style="color:white;text-decoration:none">Courses with Exams </a></p>
                    <p><a href="../Courses_Views/CourseSlotInsructor.aspx" style="color:white;text-decoration:none">Courses with Slots and Instructors </a></p>
                    <p><a href="../Courses_Views/CourseesPreq.aspx" style="color:white;text-decoration:none">Courses with thier Prerequisites </a></p>
                </div>
            </li>
           <li class="menu-item">
                <button class="collapsible">Send Request<img src="../../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="../Requests/Course_Request.aspx" style="color:white;text-decoration:none"> Send Course Request </a></p>
                    <p><a href="../Requests/CHR_request.aspx" style="color:white;text-decoration:none"> Send Extra credit hours Request </a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Register For Makeup<img src="../../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                       <p><a href="../Makeup/FirstMakeup.aspx" style="color:white;text-decoration:none">First Makeup </a></p>
                       <p><a href="../Makeup/SecondMakeup.aspx" style="color:white;text-decoration:none"> Second Makeup </a></p>
               
                </div>
            </li>
            
            <li class="menu-item">
               <p><a href="../telephone_number/telephone_number.aspx" style="color:white;text-decoration:none">Add Mobile Number</a></p>
                
            </li>
            <li class="menu-item">
                <p><a href="../Grad_plan/GradPlan_AssignedCourses.aspx" style="color:white;text-decoration:none">View Graduation Plan</a></p>

                </li>
            <li class="menu-item">
                 <p><a href="../Installment/Installment.aspx" style="color:white;text-decoration:none">View Upcoming Installment</a></p>

            </li>
            <li class="menu-item">
             <p><a href="../Slots/InputSlot.aspx" style="color:white;text-decoration:none">View Slots</a></p>
                </li>
            <li class="menu-item">
            <p><a href="../Instructor/InputInstructor.aspx" style="color:white;text-decoration:none">Chose Instructor</a></p>
                </li>
        </ul>
    </div>
    
</aside>
    <form id="form1" runat="server">
        <div>
     <div class="inputContainer">
         <h2>Add Mobile Number</h2>
         <h5>*Note:Do not add an existing telephone number</h5>
         <div class="inputGroup" id="credit_hours">
             <asp:TextBox ID="telephone" runat="server" CssClass="input" placeholder="Number" TextMode="Number" ></asp:TextBox>
             <asp:Label ID="CHR" runat="server" Text="Mobile Number" CssClass="userLabel"></asp:Label>
                
             <asp:HiddenField ID="hiddenCountryCode" runat="server" />
         </div>
         <div>
             <asp:Button ID="AddButton" OnClick="Add_number" runat="server"  Text="Save Number" class="AddButton"/>
         </div>
     </div>
        </div>
    </form>
        <script src="../../Scripts/sidebarScript.js" defer="defer"></script>
    <script src="../../Scripts/telephoneCodes.js" defer="defer"></script>
</body>
</html>