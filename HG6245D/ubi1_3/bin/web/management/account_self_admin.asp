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

var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check(checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("account", lang);

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var defaultpassword = '<% getCfgGeneral(1, "defaultpassword"); %>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

function CheckValue()
{
	var accountSelf_user = getElement("accountSelf_user");
	
	var accountSelf_oldPwd = getElement("accountSelf_oldPwd");
	var accountSelf_newPwd = getElement("accountSelf_newPwd");
	var accountSelf_newPwd2 = getElement("accountSelf_newPwd2");
	var minPwdLen;
	if(ispName == 6)	/* MALAY_TM要求密码18－32位 */
	{
		minPwdLen = 18;
	}
	else if(ispName == 16)	/* 越南要求密码6－32位 */
	{
		minPwdLen = 6;
	}
	else
	{
		minPwdLen = 8;
	}

	if (!CheckNotNull(accountSelf_user.value)) {
//		alert("用户名不能为空!");
		alert(_("accountSelf_userNullAlert"));
		accountSelf_user.focus();
		return false;
	}
	if(((ispName == 9) && (curUserType == 1)) || (ispName == 16))
	{
		var newNameNode = getElement("accountSelf_newname");
		if(newNameNode.value != "")
			if(checkManAdmName(newNameNode.value) == false)
			{
				alert(_("accountSelf_userIllegalAlert"));
				newNameNode.value = newNameNode.defaultValue;
				newNameNode.focus();
				newNameNode.select();
				return false;
			}
	}
	
	if (!CheckNotNull(accountSelf_oldPwd.value)) {
//		alert("原密码不能为空!");
		alert(_("accountSelf_oldPwdNullAlert"));
		accountSelf_oldPwd.focus();
		return false;
	}
	
	if (!CheckNotNull(accountSelf_newPwd.value)) {
//		alert("新密码不能为空!");
		alert(_("accountSelf_newPwdNullAlert"));
		accountSelf_newPwd.focus();
		return false;
	}
	else if(len(accountSelf_newPwd.value) < minPwdLen|| len(accountSelf_newPwd.value) > 32)//check length
	{
//		alert("密码最多输入32个字符，包括：字母 数字 . / - _");
		alert(_("accountSelf_newPwdIllegalAlert"));
		accountSelf_newPwd.value = accountSelf_newPwd.defaultValue;
		accountSelf_newPwd.focus();
		accountSelf_newPwd.select();
		return false;
	}
	else if(accountSelf_newPwd.value.indexOf(" ") >= 0)	/* no space */
	{
		alert(_("accountSelf_newPwdSpaceAlert"));
		accountSelf_newPwd.value = accountSelf_newPwd.defaultValue;
		accountSelf_newPwd.focus();
		accountSelf_newPwd.select();
		return false;
	}
	else
	{
		if(ispName == 28)//墨西哥TOTALPLAY
		{
			if(!checkTotalplayPwd(accountSelf_newPwd.value))	//pwd illegal
			{
				alert(_("accountSelf_newPwdIllegalAlert"));
				accountSelf_newPwd.value = accountSelf_newPwd.defaultValue;
				accountSelf_newPwd.focus();
				accountSelf_newPwd.select();
				return false;
			}
			
		}
		else
		{
			if(!checkManAdmPwd(accountSelf_newPwd.value))	//pwd illegal
			{
				alert(_("accountSelf_newPwdIllegalAlert"));
				accountSelf_newPwd.value = accountSelf_newPwd.defaultValue;
				accountSelf_newPwd.focus();
				accountSelf_newPwd.select();
				return false;
			}
		}
	}
	
	if (accountSelf_newPwd.value != accountSelf_newPwd2.value) {
//		alert("新密码与确认密码不一致!");
		alert(_("accountSelf_pwdMismatchedAlert"));
		accountSelf_newPwd2.value = accountSelf_newPwd2.defaultValue;
		accountSelf_newPwd2.focus();
		accountSelf_newPwd2.select();
		return false;
	}

	return true;
}

function CheckWanPwdValue()
{
	var wanNewPwdNode = getElement('accountSelf_newWanPwd');
	var wanNewPwd2Node = getElement('accountSelf_newWanPwd2');
	
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

function checkManAdmName(str)
{
	var reg = /^[\w]{1,32}$/;	//数字 英文字母 _ 
    if (!reg.test(str))
	{ 
     	return false; 
    }
	else
	{
		return true;
	}
}

function checkTotalplayPwd(str)
{
	var reg = /^[\w./-@#%]{1,32}$/;	//数字 英文字母 _ . / -@#%
    if (!reg.test(str))
	{ 
     	return false; 
    }
	else
	{
		return true;
	}
}
function initTranslation()  
{
    var e = document.getElementById("account_manage_title");
	e.innerHTML = _("account_manage_title");
	
    e = document.getElementById("accountSelf_userTitle");
	if(((ispName == 9) && (curUserType == 1)) || (ispName == 16))
		e.innerHTML = _("old_name_title");
	else		
		e.innerHTML = _("name_title");
	
    e = document.getElementById("accountSelf_oldPwdTitle");
	if(ispName == 22)	//泰国TRUE
		e.innerHTML = _("accountSelf_oldLanPwdTitle");
	else		
		e.innerHTML = _("accountSelf_oldPwdTitle");
	
    e = document.getElementById("accountSelf_newnameTitle");
	e.innerHTML = _("accountSelf_newnameTitle");
	
	e = document.getElementById("accountSelf_newPwdTitle");
	if(ispName == 22)	//泰国TRUE
		e.innerHTML = _("ac_lanPwd");
	else
		e.innerHTML = _("ac_pwd");
		
	e = document.getElementById("accountSelf_newPwd2Title");
	if(ispName == 22)	//泰国TRUE
		e.innerHTML = _("ac_lanPwd2");
	else
		e.innerHTML = _("ac_pwd2");
	
	e = document.getElementById("accountSelf_prompt");	
	if(ispName == 22)	//泰国TRUE
	{
		e.innerHTML = _("accountSelf_prompt") + _("accountSelf_prompt_true");
	}
	else
		e.innerHTML = _("accountSelf_prompt");
	
	e = document.getElementById("accountSelf_pwdTips");
	if(ispName == 6)	/* MALAY_TM要求密码18－32位 */
	{
		e.innerHTML = _("accountSelf_pwdTips_MALAY_TM");
	}
	else if(ispName == 16)	/* 越南要求密码6－32位 */
	{
		e.innerHTML = _("accountSelf_pwdTips_6");
	}
	else
	{
		e.innerHTML = _("accountSelf_pwdTips");
	}
	
	e = document.getElementById("accountSelf_wanPwdTips");
	e.innerHTML = _("accountSelf_pwdTips");
	e = document.getElementById("accountSelf_wanPwdTips2");
	e.innerHTML = _("accountSelf_pwdTips_TL_TRUE");
	
    e = document.getElementById("accountSelf_Apply");
	e.value = _("btnApply1");
    e = document.getElementById("accountSelf_Cancel");
	e.value = _("cancelValue");
	
    e = document.getElementById("accountSelf_Apply2");
	e.value = _("btnApply1");
    e = document.getElementById("accountSelf_Cancel2");
	e.value = _("cancelValue");
	
	if(ispName == 22)	//泰国TRUE普通用户
	{
		e = document.getElementById("accountSelf_oldWanPwdTitle");
		e.innerHTML = _("accountSelf_oldWanPwdTitle");
		e = document.getElementById("accountSelf_newWanPwdTitle");
		e.innerHTML = _("accountSelf_newWanPwdTitle");
		e = document.getElementById("accountSelf_newWanPwd2Title");
		e.innerHTML = _("accountSelf_newWanPwd2Title");
	}
}

function initValue()
{
	initTranslation();

	if(ispName == 8) /*pldt*/
	{
		if(defaultpassword == 1)
		{
			alert("Initial login on this account requires password change. Please enter new password.");
		}
	}
	/* 用户名可改:罗马尼亚普通用户或越南 */
	if(((ispName == 9) && (curUserType == 1)) || (ispName == 16))
	{
		setDisplay("new_username_tr", "");
	}
	else if(ispName == 22)	/* 泰国TRUE两级用户均LAN/WAN密码不同 */	
	{
		setDisplay("tb_wanpwd", "");
		setDisplay("tb_submit2", "");
	}
	/* delete by 吴小娟, 20160310, 原因: 自动填充登录用户名到accountSelf_user输入框。需求来源:朱崇银 */
//	document.getElementById("accountSelf_user").value = "";
	getElement("accountSelf_oldPwd").value = "";
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
              <td id="accountSelf_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<!-- ================= Own Account Adm Settings ================= -->
<form method="post" name="Adm" action="/goform/setAccountSelfPwd">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="account_manage_title" colspan="2">Account Management</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="accountSelf_userTitle">Username</td>
        <td class="tabal_right"><input type="text" name="accountSelf_user" disabled='disabled' size="16" maxlength="32" value="<% getCfgGeneral(1, 'login_user'); %>">
          <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_oldPwdTitle">Old Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_oldPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr id="new_username_tr" style="display: none">
        <td class="tabal_left" id="accountSelf_newnameTitle">New Username</td>
        <td class="tabal_right"><input type="text" name="accountSelf_newname" size="16" maxlength="32">
          <span class="gray">&nbsp(If the username is left empty, only the password will be changed. )</span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwdTitle">New Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd" size="16" maxlength="32">
          <strong style="color:#FF0033">*</strong><span id="accountSelf_pwdTips" class="gray"></span> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="accountSelf_newPwd2Title">Password Confirm</td>
        <td class="tabal_right"><input type="password" name="accountSelf_newPwd2" size="16" maxlength="32">
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
<form method="post" name="Adm2" action="/goform/set_accountself_wan_pwd">
  <table id='tb_wanpwd' class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr id='tr_oldWanPwd'>
        <td class="tabal_left" width="25%" id="accountSelf_oldWanPwdTitle">Old WAN Password</td>
        <td class="tabal_right"><input type="password" name="accountSelf_oldWanPwd" size="16" maxlength="32">
        </td>
      </tr>
      <tr id='tr_newWanPwd'>
        <td class="tabal_left" id="accountSelf_newWanPwdTitle">New WAN Password</td>
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
  <table id="tb_submit2" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%" style="display: none">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="accountSelf_Apply2" class="submit" onClick="return CheckWanPwdValue();">
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
