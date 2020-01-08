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
<title>Account Self Management</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("account", lang);

function CheckValue()
{
	var accountSelf_user = document.getElementById("accountSelf_user").value;
	var accountSelf_oldPwd = document.getElementById("accountSelf_oldPwd").value;
	var accountSelf_newPwd = document.getElementById("accountSelf_newPwd").value;
	var accountSelf_newPwd2 = document.getElementById("accountSelf_newPwd2").value;
	var minPwdLen = 8;

	if (!CheckNotNull(accountSelf_user)) {
//		alert("用户名不能为空!");
		alert(_("accountSelf_userNullAlert"));
		getElement("accountSelf_user").focus();
		return false;
	}
	
	if (!CheckNotNull(accountSelf_oldPwd)) {
//		alert("原密码不能为空!");
		alert(_("accountSelf_oldPwdNullAlert"));
		getElement("accountSelf_oldPwd").focus();
		return false;
	}
	
	if (!CheckNotNull(accountSelf_newPwd)) {
//		alert("新密码不能为空!");
		alert(_("accountSelf_newPwdNullAlert"));
		getElement("accountSelf_newPwd").focus();
		return false;
	}
	else if(len(accountSelf_newPwd) < minPwdLen|| len(accountSelf_newPwd) > 32)
	{
//		alert("密码最多输入32个字符，包括：字母 数字 . / - _");
		alert(_("accountSelf_newPwdIllegalAlert"));
		getElement("accountSelf_newPwd").focus();
		getElement("accountSelf_newPwd").select();
		return false;
	}
	else if(accountSelf_newPwd.indexOf(" ") >= 0)	/* no space */
	{
		alert(_("accountSelf_newPwdSpaceAlert"));
		getElement("accountSelf_newPwd").focus();
		getElement("accountSelf_newPwd").select();
		return false;
	}
	
	if (accountSelf_newPwd != accountSelf_newPwd2) {
//		alert("新密码与确认密码不一致!");
		alert(_("accountSelf_pwdMismatchedAlert"));
		getElement("accountSelf_newPwd2").focus();
		getElement("accountSelf_newPwd2").select();
		return false;
	}
	
	return true;
}

function initTranslation()  
{
    var e = document.getElementById("account_manage_title");
	e.innerHTML = _("account_manage_title");
    e = document.getElementById("accountSelf_userTitle");
	e.innerHTML = _("name_title");
    e = document.getElementById("accountSelf_oldPwdTitle");
	e.innerHTML = _("accountSelf_oldPwdTitle");
	e = document.getElementById("accountSelf_newPwdTitle");
	e.innerHTML = _("ac_pwd");
	e = document.getElementById("accountSelf_newPwd2Title");
	e.innerHTML = _("ac_pwd2");
	e = document.getElementById("accountSelf_prompt");
	e.innerHTML = _("accountSelf_prompt");
	e = document.getElementById("accountSelf_pwdTips");
	e.innerHTML = _("accountSelf_pwdTips");
	
    e = document.getElementById("accountSelf_Apply");
	e.value = _("btnApply1");
    e = document.getElementById("accountSelf_Cancel");
	e.value = _("cancelValue");
}

function initValue()
{
	initTranslation();

	/* delete by 吴小娟, 20160310, 原因: 自动填充登录用户名到accountSelf_user输入框。需求来源:朱崇银 */
//	document.getElementById("accountSelf_user").value = "";
	document.getElementById("accountSelf_oldPwd").value = "";
	document.getElementById("accountSelf_newPwd").value = "";
	document.getElementById("accountSelf_newPwd2").value = "";
	
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
              <td id="accountSelf_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<!-- ================= Own Account Adm Settings ================= -->
<form method="post" name="Adm" action="/goform/setAccountSelfPwd_toTr069">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="account_manage_title" colspan="2">Account Management</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="accountSelf_userTitle">Username</td>
        <td class="tabal_right"><input type="text" name="accountSelf_user" id="accountSelf_user" size="16" maxlength="32" value="<% getCfgGeneral(1, 'login_user'); %>">
          <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_oldPwdTitle">Old Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_oldPwd" id="accountSelf_oldPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwdTitle">New Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd" id="accountSelf_newPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong><span id="accountSelf_pwdTips" class="gray"></span> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwd2Title">Password Confirm</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd2" id="accountSelf_newPwd2" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="accountSelf_Apply" class="submit" onClick="return CheckValue();">
          &nbsp; &nbsp;
          <input type="reset" name="Cancel" value="Cancel" id="accountSelf_Cancel" class="submit" onClick="window.location.reload()">
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
