<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display.aspx.cs" Inherits="UserBehaviorCollection.Report.Display" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<style type="text/css">
.DataTable
{
    border: 1px solid #C8C7C7;
    background-color: #E0E0E0;
}
</style>

<body style="background: #E6F1FA; margin-top: 20px;">
    <form id="form1" runat="server">
        <div>
            Report Information:
            <br /><br />
            <asp:GridView ID="GVReport" Width="98%" runat="server" AutoGenerateColumns="False" CssClass="TablePanel" align="center"
                DataKeyNames="ID" OnRowCommand="GVReport_RowCommand" HeaderStyle-HorizontalAlign="center"
                RowStyle-BackColor="#E6F1FA" RowStyle-Height="25" HeaderStyle-Height="20" RowStyle-HorizontalAlign="center">
                <Columns>
                    <%--<asp:TemplateField ItemStyle-Width="30" HeaderText="<input type=checkbox id='checkLeader' onClick='selectAll(this);' />">
                        <ItemTemplate>
                            <input id='<%#Eval("HCID") %>' type="checkbox" name="delSelect" value="<%#Eval("HCID") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="用户标识">
                        <ItemTemplate>
                            <%# Eval("userkey").ToString().Trim()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作系统">
                        <ItemTemplate>
                            <%# Eval("os").ToString().Trim()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="IP地址">
                        <ItemTemplate>
                            <%# Eval("ip").ToString().Trim()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="浏览器">
                        <ItemTemplate>
                            <%# Eval("browser").ToString().Trim()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="查看页面信息">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnbrowse" CommandName="lbtnbrowse" CommandArgument='<%# Eval("ID").ToString().Trim()%> ' runat="server">查看</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
