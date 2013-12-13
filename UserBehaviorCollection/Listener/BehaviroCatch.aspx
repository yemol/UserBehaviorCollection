<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BehaviroCatch.aspx.cs" Inherits="UserBehaviorCollection.Listener.BehaviroCatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="jquery-1.8.3.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
<script>
    var jsonData = "{\"UserVisit\":{\"UserIdentity\":\"7E73224B-13DE-4517-A5F7-00ED7046239E\",\"Browser\":\"IE\",\"OS\":\"Windows\",\"IP\":\"10.10.73.10\",\"OtherUserInfo\":\"No\"},\"PageVisit\":[{\"UserIdentity\":\"5E73224B-13DE-4517-A5F7-00ED7046239E\",\"PagePath\":\"Tpo.aspx\",\"StartAccess\":\"2013-12-13 08:21:21.000\",\"LastActiveTime\":\"2013-12-13 9:59:21.000\",\"Actions\":[{\"HTML\":\"<a href='www.google.com'></a>\",\"Behavior\":\"onclick\"},{\"HTML\":\"<input id='ctl00_PageContentPlaceHolder_CDWLoanSetting_creditReportOnExperianCheckBox' type='checkbox' name='ctl00$PageContentPlaceHolder$CDWLoanSetting$creditReportOnExperianCheckBox' checked='checked' disabled='disabled' />\",\"Behavior\":\"onclick\"}]}]}";
    
    $.post('ListenerHandler.ashx', { jsonData: jsonData }, function (data) { $("div").html(data) }, 'html');
</script>
