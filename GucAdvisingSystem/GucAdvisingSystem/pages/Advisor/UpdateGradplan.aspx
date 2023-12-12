<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateGradplan.aspx.cs" Inherits="GucAdvisingSystem.pages.Advisor.UpdateGradplan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <link href="../Styles/mainPageStyles.css" rel="stylesheet" />
    <link href="../Styles/addStyles.css" rel="stylesheet" />
</head>
<body>
                <aside style="background: linear-gradient(159deg, rgba(37,124,216,1) 0%, rgba(23,54,249,1) 100%);">
    <h1>Controls</h1>
    <div id="controls">
        <ul class="menu-list">
            <li>
                <button class="collapsible"> <a href="AdvisorPage.aspx" style="color:white;text-decoration:none">Home</a></button>
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
    <form id="form1" runat="server">
        <div>
            <div class="inputContainer"  >
                <h2>Update Grad Plan</h2>

                                                     
                                   
                                          <div class="inputGroup" >               
                                   <asp:TextBox ID="studentId2" runat="server" placeholder="Student Id" CssClass="input"></asp:TextBox>
                                              <asp:Label ID="Label2" runat="server" Text="Student Id" CssClass="userLabel"></asp:Label>
                                              </div>
                                        <div class="inputGroup">
                        <asp:TextBox ID="grad_date1" runat="server" type="date" placeholder="Graduation Date" CssClass="input" style="width:200px"></asp:TextBox>
                                             <asp:Label ID="Label1" runat="server" Text="Graduation Date" CssClass="userLabel"></asp:Label>
                                            </div>
                                      <div class="inputGroup">
                                  <asp:Button ID="Button7" runat="server" Text="Update" OnClick="UpdateGP" CssClass="AddButton" />
                                           </div>

                </div>
        </div>
    </form>
    <script src="../Scripts/sidebarScript.js" defer="defer"></script>
</body>
</html>
