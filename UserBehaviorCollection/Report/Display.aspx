<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display.aspx.cs" Inherits="UserBehaviorCollection.Report.Display" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Report information</title>
</head>

<script type="text/javascript">

    function ShowHidden(sid, ev) {
        ev = ev || window.event;
        var target = ev.target || ev.srcElement;
        var oTr = document.getElementById("tr" + sid);
        oTr.style.display = oTr.style.display == "none" ? "block" : "none";
        target.innerHTML = oTr.style.display == "none" ? "View" : "Hide";
    }

</script>

<body style="background: #E6F1FA; margin-top: 20px;">
    <form id="form1" runat="server">
        <div>
            Report Information:
            <br />
            <br />
            <asp:GridView ID="GVUsers" Width="98%" runat="server" AutoGenerateColumns="False" align="center"
                DataKeyNames="UserIdentity" OnRowCommand="GVUsers_RowCommand" OnRowDataBound="GVUsers_RowDataBound"
                HeaderStyle-HorizontalAlign="center"
                HeaderStyle-BackColor="#E0E0E0"
                HeaderStyle-Height="30"
                RowStyle-BackColor="#E6F1FA"
                RowStyle-Height="25"
                RowStyle-Font-Size="12px"
                RowStyle-HorizontalAlign="center">
                <Columns>
                    <%--<asp:TemplateField ItemStyle-Width="30" HeaderText="<input type=checkbox id='checkLeader' onClick='selectAll(this);' />">
                        <ItemTemplate>
                            <input id='<%#Eval("UserIdentity") %>' type="checkbox" name="delSelect" value="<%#Eval("UserIdentity") %>" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="User Key">
                        <ItemTemplate>
                            <%# Eval("UserIdentity")%>
                        </ItemTemplate>
                        <ItemStyle Width="210px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Operation System">
                        <ItemTemplate>
                            <%# Eval("os")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Browser">
                        <ItemTemplate>
                            <%# Eval("browser")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="IP Address">
                        <ItemTemplate>
                            <%# Eval("ip")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="View Page Information">
                        <ItemTemplate>
                            <!---点击用于列表展开，执行JS函数--->
                            <span id='btnShowHidden<%#Eval("UserIdentity") %>' style="cursor: pointer;" onclick="ShowHidden('<%#Eval("UserIdentity") %>',event)">View
                            </span>
                            <tr id='tr<%#Eval("UserIdentity") %>' style="display: none;">
                                <td colspan="5">
                                    <div>
                                        <div style="float: left; font-size: small">
                                            └
                                        </div>
                                        <div style="position: relative; left: 0px; overflow: auto;">
                                            <!---绑定内层Gridview--->
                                            <asp:GridView ID="GVPages"
                                                DataKeyNames="PageIdentity"
                                                Width="100%" Height="100%" runat="server" AutoGenerateColumns="false"
                                                HeaderStyle-HorizontalAlign="center"
                                                HeaderStyle-BackColor="#E0E0E0"
                                                HeaderStyle-Height="30"
                                                RowStyle-BackColor="#E6F1FA"
                                                RowStyle-Height="25"
                                                RowStyle-Font-Size="12px"
                                                RowStyle-HorizontalAlign="center">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Step">
                                                        <ItemTemplate>
                                                            <%#  Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Page Name">
                                                        <ItemTemplate>
                                                            <%# Eval("PagePath")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Access Time">
                                                        <ItemTemplate>
                                                            <%# Eval("StartAccess")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Last Active Time">
                                                        <ItemTemplate>
                                                            <%# Eval("LastActiveTime")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Stay Time">
                                                        <ItemTemplate>
                                                            <%# timeSpan(Eval("StartAccess"),Eval("LastActiveTime"))%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="View Actions">
                                                        <ItemTemplate>
                                                            <!---点击用于列表展开，执行JS函数--->
                                                            <span id='btnShowHidden<%#Eval("PageIdentity") %>' style="cursor: pointer;" onclick="ShowHidden('<%#Eval("PageIdentity") %>',event)">View</span>
                                                            <tr id='tr<%#Eval("PageIdentity") %>' style="display: none;">
                                                                <td colspan="6">
                                                                    <div>
                                                                        <div style="position: relative; left: 0px; overflow: auto; font-size:12px;">
                                                                          <%# nullDesri(Eval("Actions"),"There is no action!")%>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <%--<asp:LinkButton ID="lbtnbrowse" CommandName="lbtnbrowse" CommandArgument='<%# Eval("UserIdentity").ToString().Trim()%> ' runat="server">View</asp:LinkButton>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%--<asp:LinkButton ID="lbtnbrowse" CommandName="lbtnbrowse" CommandArgument='<%# Eval("UserIdentity").ToString().Trim()%> ' runat="server">View</asp:LinkButton>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
