<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/LoginPage.aspx.cs" Inherits="GucAdvisingSystem.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Screen</title>
    <link rel="stylesheet" href="./styles/loginStyles.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <h2>GUC Advising System</h2>
        <div id="inputs">
            <div class="radio">
                <input label="Student" type="radio" id="Student" name="role" value="Student" checked="checked"/>
                <input label="Advisor" type="radio" id="Advisor" name="role" value="Advisor"/>
                <input label="Admin" type="radio" id="Admin" name="role" value="Admin"/>
            </div> 
            <div class="inputGroup">
                <asp:TextBox ID="UsernameInput" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                <asp:Label ID="Username" runat="server" Text="Username" CssClass="userLabel"></asp:Label>
            </div>
            <div class="inputGroup">
                <asp:TextBox ID="PasswordInput" runat="server" CssClass="input" placeholder="Password"></asp:TextBox>
                <asp:Label ID="Password" runat="server" Text="Password" CssClass="userLabel"></asp:Label>
            </div>
            <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="login" />
        </div>
         <a href="registerPage.aspx" id="SignupButton" target="_self"><i>Register</i></a>
    </form>
</body>
</html>