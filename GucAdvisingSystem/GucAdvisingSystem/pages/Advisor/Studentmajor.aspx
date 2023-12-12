<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Studentmajor.aspx.cs" Inherits="GucAdvisingSystem.pages.Advisor.Studentmajor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../Styles/mainPageStyles.css" rel="stylesheet" />
    <link href="../Styles/GridStyle.css" rel="stylesheet" />
         <link href="../Styles/addStyles.css" rel="stylesheet" />

</head>
<body>
                <aside style="background: linear-gradient(159deg, rgba(37,124,216,1) 0%, rgba(23,54,249,1) 100%);">
    <h1>Controls</h1>
    <div id="controls">
        <ul class="menu-list">
            <li>
                <button class="collapsible"><a href="AdvisorPage.aspx" style="color:white;text-decoration:none">Home</a></button>
                <div>
                    <br />
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">View <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                 <p><a href="Viewadvising.aspx" style="color:white;text-decoration:none">Advising Students</a></p>
                 <p><a href="Studentmajor.aspx" style="color:white;text-decoration:none">Students based on Major</a></p>
                    <p><a href="AdvisorRequests.aspx" style="color:white;text-decoration:none">Requests</a></p>
                    <p><a href="Advisorpendingrequests.aspx" style="color:white;text-decoration:none">Pending Requests</a></p>
                </div>
            </li>
           <li class="menu-item">
                <button class="collapsible">Graduation Plan <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                    <p><a href="CreateGradplan.aspx" style="color:white;text-decoration:none">Create Grad Plan</a></p>
                    <p><a href="UpdateGradplan.aspx" style="color:white;text-decoration:none">Update Grad Plan</a></p>
                    <p><a href="InsertCourses.aspx" style="color:white;text-decoration:none">Insert Courses</a></p>
                    <p><a href="DeleteCourses.aspx" style="color:white;text-decoration:none">Delete Courses</a></p>
                </div>
            </li>
            <li class="menu-item">
                <button class="collapsible">Approve/Reject <img src="../styles/assets/menu-down.svg" width="40" height="40"/></button>
                <div class="content">
                        <p><a href="AppRejCHRequest.aspx" style="color:white;text-decoration:none">Credit Hours Request</a></p>
                        <p><a href="AppRejCourseRequest.aspx" style="color:white;text-decoration:none">Course Request</a></p>
                </div>
            </li>
        </ul>
    </div>
</aside>
    <form id="form1" runat="server" style="padding-bottom:300px">
     
       
                 <div class="TableContainer">       
             
              <div class="inputContainer" style="flex-direction:row; min-width: 500px;min-height:100px">
                  
              <asp:TextBox ID="Major" runat="server" placeholder="Major" CssClass="input"></asp:TextBox>
              <asp:Button ID="Button1" runat="server" Text="View" OnClick="Viewadvstud" CssClass="AddButton" style="margin-top:0px"/>
                     
               </div>
             
                       
            <asp:GridView ID="GridV" runat="server" CssClass="myGridClass" style="margin-top:0px"></asp:GridView>

                </div>
          
        
   
    </form>

     
        
    <script src="../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
