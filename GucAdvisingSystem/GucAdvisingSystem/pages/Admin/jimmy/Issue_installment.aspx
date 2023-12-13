<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Issue_installment.aspx.cs" Inherits="Admin.Issue_installment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Choose Installment:</div>
        <asp:DropDownList ID="DropDownList1" runat="server">
        </asp:DropDownList>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <asp:Button ID="Button1" runat="server" OnClick="issue_installments" Text="Issue Installment" />
    </form>
</body>
</html>
