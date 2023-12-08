<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="GucAdvisingSystem.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Control Room</title>
    <link href="./styles/adminPageStyles.css" rel="stylesheet" />
</head>
<body>
    <aside>
        <h1>Controls</h1>
        <div id="controls">
            <ul class="menu-list">
                <li class="menu-item">
                    <button class="collapsible">List <img src="./styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Student</p>
                        <p>Advisor</p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">Link <img src="./styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Student</p>
                        <p>Advisor</p>
                    </div>
                </li>
                <li class="menu-item">
                    <button class="collapsible">ADD <img src="./styles/assets/menu-down.svg" width="40" height="40"/></button>
                    <div class="content">
                        <p>Student</p>
                        <p>Advisor</p>
                    </div>
                </li>
            </ul>
        </div>
    </aside>
    <script src="./scripts/adminSidebarScript.js" defer="defer"></script>
</body>
</html>
