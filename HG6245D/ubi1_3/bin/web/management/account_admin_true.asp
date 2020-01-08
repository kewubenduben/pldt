<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>User Account Management</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("account", lang);

function CheckValue(type)
{
	var wanNewPwdNode;
	var wanNewPwd2Node;
	if(type == 1)
	{
		wanNewPwdNode = getElement("accountSelf_newPwd");
		wanNewPwd2Node = getElement("accountSelf_newPwd2");	
	}
	else
	{
		wanNewPwdNode = getElement('accountSelf_newWanPwd');
		wanNewPwd2Node = getElement('accountSelf_newWanPwd2');
	}
	
	if (!CheckNotNull(wanNewPwdNode.value)) {//not null
		alert(_("accountSelf_newPwdNullAlert"));
		wanNewPwdNode.focus();
		return false;
	}
	else if(!checkManAdmPwd(wanNewPwdNode.value))	//pwd illegal
	{
		alert(_("accountSelf_newPwdIllegalAlert"));
		wanNewPwdNode.value = wanNewPwdNode.defaultValue;
		wanNewPwdNode.focus();
		wanNewPwdNode.select();
	}
	else if(len(wanNewPwdNode.value) < 8|| len(wanNewPwdNode.value) > 32)//check length
	{
		alert(_("accountSelf_newPwdIllegalAlert"));
		wanNewPwdNode.value = wanNewPwdNode.defaultValue;
		wanNewPwdNode.focus();
		wanNewPwdNode.select();
		return false;
	}
	
	if (wanNewPwdNode.value != wanNewPwd2Node.value) {
		alert(_("accountSelf_pwdMismatchedAlert"));
		wanNewPwd2Node.value = wanNewPwd2Node.defaultValue;
		wanNewPwd2Node.focus();
		wanNewPwd2Node.select();
		return false;
	}
	
	return true;
}

function initTranslation()  
{
	var e = document.getElementById("accountSelf_pwdTips");	
	e.innerHTML = _("accountSelf_pwdTips");
	
	e = document.getElementById("accountSelf_wanPwdTips");
	e.innerHTML = _("accountSelf_pwdTips");
	e = document.getElementById("accountSelf_wanPwdTips2");
	e.innerHTML = _("accountSelf_pwdTips_TL_TRUE");
}

function initValue()
{
	initTranslation();

	getElement("accountSelf_newPwd").value = "";
	getElement("accountSelf_newPwd2").value = "";	
	getElement("accountSelf_newWanPwd").value = "";
	getElement("accountSelf_newWanPwd2").value = "";	
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="account_promptTrue" class="title_01" style="padding-left: 10px;" width="100%">You could configure the LAN/WAN password of user account on this page.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<!-- ================= user lan/wan pwd settings ================= -->
<form method="post" name="Adm" action="/goform/set_user_lan_tl_true">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="account_manage_title" colspan="2">User Account Management</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="accountSelf_userTitle">Username</td>
        <td class="tabal_right"><input type="text" name="accountSelf_user" disabled='disabled' size="16" maxlength="32" value="admin">
          <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwdTitle">New LAN Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong><span id="accountSelf_pwdTips" class="gray"></span> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwd2Title">LAN Password Confirm</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd2" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="accountSelf_Apply" class="submit" onClick="return CheckValue(1);">
          &nbsp; &nbsp;
          <input type="reset" name="Cancel" value="Cancel" id="accountSelf_Cancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method="post" name="Adm2" action="/goform/set_user_wan_tl_true">
  <table id='tb_wanpwd' class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id='tr_newWanPwd'>
        <td class="tabal_left" width="25%" id="accountSelf_newWanPwdTitle">New WAN Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newWanPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong><span id="accountSelf_wanPwdTips" class="gray"></span>&nbsp;<span id="accountSelf_wanPwdTips2" class="gray"></span></td>
      </tr>
      <tr id='tr_newWanPwd2'>
        <td class="tabal_left" id="accountSelf_newWanPwd2Title">WAN Password Confirm</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newWanPwd2" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="accountSelf_Apply2" class="submit" onClick="return CheckValue(2);">
          &nbsp; &nbsp;
          <input type="reset" value="Cancel" id="accountSelf_Cancel2" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
