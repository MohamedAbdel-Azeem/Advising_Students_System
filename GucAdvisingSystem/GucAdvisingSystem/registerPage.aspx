<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/registerPage.aspx.cs" Inherits="GucAdvisingSystem.registerPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Register Page</title>
    <link rel="stylesheet" href="./styles/registerStyles.css"/>
</head>
<body>
    <form id="form2" runat="server" class="SignUpform">
        <h2>GUC Advising System</h2>
            <div id="inputs">
                <div class="radio" id="radioButtons">
                    <input label="Student" type="radio" id="student" name="role" value="student" checked="checked" />
                    <input label="Advisor" type="radio" id="advisor" name="role" value="advisor" />
                </div>
                <div class="inputGroup student" id="StudentFname">
                    <asp:TextBox ID="FnameInput" runat="server" CssClass="input" placeholder="First Name"></asp:TextBox>
                    <asp:Label ID="Fname" runat="server" Text="First Name" CssClass="userLabel"></asp:Label>
                </div>
                <div class="inputGroup student" id="StudentLname">
                    <asp:TextBox ID="LnameInput" runat="server" CssClass="input" placeholder="Last Name"></asp:TextBox>
                    <asp:Label ID="Lname" runat="server" Text="Last Name" CssClass="userLabel"></asp:Label>
                </div>
                <div class="inputGroup advisor" id="Advisorname">
                    <asp:TextBox ID="AdvisornameInput" runat="server" CssClass="input" placeholder="Name"></asp:TextBox>
                    <asp:Label ID="AdvisorName" runat="server" Text="Name" CssClass="userLabel"></asp:Label> 
                </div>
                <div class="inputGroup" id="password">
                    <asp:TextBox ID="passwordInput" runat="server" CssClass="input" placeholder="Password" TextMode="Password"></asp:TextBox>
                    <asp:Label ID="pass" runat="server" Text="Password" CssClass="userLabel"></asp:Label>       
                </div>
                <div class="inputGroup student" id="faculty">
                    <select id="facultyInput" class="Signinput" name="facultyInput">
                        <option value="Engineering" selected ="selected">Engineering</option>
                        <option value="Bussines">Bussines</option>
                        <option value="Pharmacy">Pharmacy</option>
                        <option value="Applied Arts">Applied Arts</option>
                    </select>
                </div>
                <div class="inputGroup" id="email">
                    <asp:TextBox ID="emailInput" runat="server" CssClass="input" placeholder="Email"></asp:TextBox>
                    <asp:Label ID="emailL" runat="server" Text="Email" CssClass="userLabel"></asp:Label>
                </div>
                <div class="inputGroup student" id="major">
                    <asp:TextBox ID="majorInput" runat="server" CssClass="input" placeholder="Major"></asp:TextBox>
                    <asp:Label ID="majorL" runat="server" Text="Major" CssClass="userLabel"></asp:Label>
                </div>
                <div class="inputGroup student" id="semester">
                    <asp:TextBox ID="semesterInput" runat="server" CssClass="input" placeholder="Semester"></asp:TextBox>
                    <asp:Label ID="semL" runat="server" Text="Semester" CssClass="userLabel"></asp:Label>
                </div>
                <div class="inputGroup advisor" id="office">
                    <asp:TextBox ID="officeInput" runat="server" CssClass="input" placeholder="Office"></asp:TextBox>
                    <asp:Label ID="officeL" runat="server" Text="Office" CssClass="userLabel"></asp:Label>
                </div>
            </div>
            <asp:Button ID="LoginButton" runat="server" Text="Register" OnClick="Register" />
            <a href="LoginPage.aspx" id="SignupButton" target="_self"><i>Login</i></a>
    </form>
    <script src="/scripts/registerScript.js" defer="defer"></script>
</body>
</html>