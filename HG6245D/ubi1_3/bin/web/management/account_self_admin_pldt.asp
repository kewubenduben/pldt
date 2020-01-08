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
<script type="text/javascript" src="/js/wireless.js"></script>
<title>Account Self Management</title>
<script language="JavaScript" type="text/javascript">

/*  asp ҳ���м����û��Ƿ�LOGIN�ļ��begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  �����û��Ƿ�LOGIN�ļ��end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
var token = <%  get_random_str(); %>
Butterlate.setTextDomain("account", lang);

var ssid1Name = '<% get_ssid1_param_sync( ); %>';

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
var defaultpassword = '<% getCfgGeneral(1, "defaultpassword"); %>';
var security_mode = '<% getCfgGeneral(1, "security_mode"); %>';
var security_mode_5g_ssid1 = '<% getCfgGeneral(1, "AuthMode"); %>';
var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num");%>';

var wifi_flag = '<% getCfgGeneral(1, "WifiFlag"); %>';

function checkWifiParam()
{
	/*SSID1����������*/
	var ssid1_pwd = document.getElementById("ssid1_pwd");
	var ssid1_pwd2 = document.getElementById("ssid1_pwd2");
	var ssid1_name = document.getElementById("ssid1_name");

	if (!CheckNotNull(ssid1_name.value)) {
		alert(_("Please enter SSID Name!"));
		ssid1_name.focus();
		return false;
	}
	if(checkSpecialChar(";", ssid1_name.value))
	{
		alert(_("you can not input ") + "';'!");
		ssid1_name.value = ssid1_name.defaultValue;
		ssid1_name.focus();
		return false;
	}

	if (!CheckNotNull(ssid1_pwd.value)) {
		alert(_("no_pwd"));
		ssid1_pwd.focus();
		return false;
	}
	if(checkSpecialChar(";", ssid1_pwd.value))
	{
		alert(_("you can not input ") + "';'!");
		ssid1_pwd.value = ssid1_pwd.defaultValue;
		ssid1_pwd.focus();
		return false;
	}
	if (ssid1_pwd2.value != ssid1_pwd.value) {
		alert(_("accountSelf_pwdMismatchedAlert"));
		getElement("ssid1_pwd2").focus();
		getElement("ssid1_pwd2").select();
		return false;
	}

	if (security_mode == "OPEN" || security_mode == "SHARED" || security_mode == "WEPAUTO")
	{
		var keylength = document.Adm.ssid1_pwd.value.length;

		if(keylength != 5 && keylength != 13) 
		{
			alert(_("Please input 5 or 13 characters ") );
			ssid1_pwd.focus();
			return false;
		}
		if(checkInjection(document.Adm.ssid1_pwd.value)== false)
		{
			alert(_(" contains invalid characters."));
			ssid1_pwd.focus();
			return false;
		}
	}
	else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK")
	{
		var keyvalue = document.Adm.ssid1_pwd.value;

		if (keyvalue.length < 8)
		{
			alert(_("secure wpapsk key length"));
			ssid1_pwd.focus();
			return false;
		}

		if(checkInjection(keyvalue) == false)
		{
			alert(_("contains invalid characters."));
			ssid1_pwd.focus();
			return false;
		}
	}

	if(wifi_chip_num == '2')
	{
		var ssid1_pwd_5g = document.getElementById("ssid1_pwd_5g");
		var ssid1_pwd2_5g = document.getElementById("ssid1_pwd2_5g");
		var ssid1_name_5g = document.getElementById("ssid1_name_5g");

		if (!CheckNotNull(ssid1_name_5g.value)) {
			alert(_("Please enter SSID Name!"));
			ssid1_name_5g.focus();
			return false;
		}
		if(checkSpecialChar(";", ssid1_name_5g.value))
		{
			alert(_("you can not input ") + "';'!");
			ssid1_name_5g.value = ssid1_name_5g.defaultValue;
			ssid1_name_5g.focus();
			return false;
		}

		if (!CheckNotNull(ssid1_pwd_5g.value)) {
			alert(_("no_pwd"));
			ssid1_pwd_5g.focus();
			return false;
		}
		if(checkSpecialChar(";", ssid1_pwd_5g.value))
		{
			alert(_("you can not input ") + "';'!");
			ssid1_pwd_5g.value = ssid1_pwd_5g.defaultValue;
			ssid1_pwd_5g.focus();
			return false;
		}
		if (ssid1_pwd2_5g.value != ssid1_pwd_5g.value) {
			alert(_("accountSelf_pwdMismatchedAlert"));
			getElement("ssid1_pwd2_5g").focus();
			getElement("ssid1_pwd2_5g").select();
			return false;
		}
		if (security_mode_5g_ssid1 == "OPEN" || security_mode_5g_ssid1 == "SHARED" || security_mode_5g_ssid1 == "WEPAUTO")
		{
			var keylength = document.Adm.ssid1_pwd_5g.value.length;

			if(keylength != 5 && keylength != 13) 
			{
				alert(_("Please input 5 or 13 characters ") );
				ssid1_pwd_5g.focus();
				return false;
			}
			if(checkInjection(document.Adm.ssid1_pwd_5g.value)== false)
			{
				alert(_(" contains invalid characters."));
				ssid1_pwd_5g.focus();
				return false;
			}
		}
		else if (security_mode_5g_ssid1 == "WPAPSK" || security_mode_5g_ssid1 == "WPA2PSK" || security_mode_5g_ssid1 == "WPAPSKWPA2PSK")
		{
			var keyvalue = document.Adm.ssid1_pwd_5g.value;

			if (keyvalue.length < 8)
			{
				alert(_("secure wpapsk key length"));
				ssid1_pwd_5g.focus();
				return false;
			}

			if(checkInjection(keyvalue) == false)
			{
				alert(_("contains invalid characters."));
				ssid1_pwd_5g.focus();
				return false;
			}
		}
	}
	
}

function CheckValue()
{
	var accountSelf_user = document.getElementById("accountSelf_user").value;
	var accountSelf_oldPwd = document.getElementById("accountSelf_oldPwd").value;
	var accountSelf_newPwd = document.getElementById("accountSelf_newPwd").value;
	var accountSelf_newPwd2 = document.getElementById("accountSelf_newPwd2").value;
	var minPwdLen;
	if(ispName == 6)	/* MALAY_TMҪ������18��32λ */
	{
		minPwdLen = 18;
	}
	else if(ispName == 16)	/* Խ��Ҫ������6��32λ */
	{
		minPwdLen = 6;
	}
	else
	{
		minPwdLen = 8;
	}

	if (!CheckNotNull(accountSelf_user)) {
//		alert("�û�������Ϊ��!");
		alert(_("accountSelf_userNullAlert"));
		getElement("accountSelf_user").focus();
		return false;
	}
	
	if (!CheckNotNull(accountSelf_oldPwd)) {
//		alert("ԭ���벻��Ϊ��!");
		alert(_("accountSelf_oldPwdNullAlert"));
		getElement("accountSelf_oldPwd").focus();
		return false;
	}
	
	if (!CheckNotNull(accountSelf_newPwd)) {
//		alert("�����벻��Ϊ��!");
		alert(_("accountSelf_newPwdNullAlert"));
		getElement("accountSelf_newPwd").focus();
		return false;
	}
	else if(len(accountSelf_newPwd) < minPwdLen|| len(accountSelf_newPwd) > 32)
	{
//		alert("�����������32���ַ�����������ĸ ���� . / - _");
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
    
    if(accountSelf_oldPwd == accountSelf_newPwd) 
	{
		alert(_("accountSelf_pwdMatchedOldPwdAlert"));
		getElement("accountSelf_newPwd").focus();
		getElement("accountSelf_newPwd").select();
		return false;
	}
	
	if (accountSelf_newPwd != accountSelf_newPwd2) {
//		alert("��������ȷ�����벻һ��!");
		alert(_("accountSelf_pwdMismatchedAlert"));
		getElement("accountSelf_newPwd2").focus();
		getElement("accountSelf_newPwd2").select();
		return false;
	}

	if(wifi_flag == 1)
		if(checkWifiParam() == false)
			return false;
	
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
	if(ispName == 6)	/* MALAY_TMҪ������18��32λ */
	{
		e.innerHTML = _("accountSelf_pwdTips_MALAY_TM");
	}
	else if(ispName == 16)	/* Խ��Ҫ������6��32λ */
	{
		e.innerHTML = _("accountSelf_pwdTips_6");
	}
	else
	{
		e.innerHTML = _("accountSelf_pwdTips");
	}
	e = document.getElementById("ssid1_name_title");
	e.innerHTML = _("ssid1_name_title");
	e = document.getElementById("ssid1_name_title_5g");
	e.innerHTML = _("ssid1_name_title");
	e = document.getElementById("ssid1_pwd_title");
	e.innerHTML = _("ssid1_pwd_title");
	e = document.getElementById("ssid1_pwd_title_5g");
	e.innerHTML = _("ssid1_pwd_title");
	e = document.getElementById("ssid1_pwd2_title");
	e.innerHTML = _("ssid1_pwd2_title");
	e = document.getElementById("ssid1_pwd2_title_5g");
	e.innerHTML = _("ssid1_pwd2_title");
	e= document.getElementById("ssidNameTips");
	e.innerHTML = _("ssidNameTips");
	e= document.getElementById("ssidNameTips_5g");
	e.innerHTML = _("ssidNameTips");
	e = document.getElementById("accountSelf_Apply");
	e.value = _("btnApply1");
	e = document.getElementById("accountSelf_Cancel");
	e.value = _("cancelValue");
}

function initValue()
{
	initTranslation();	
	
	/* delete by ��С��, 20160310, ԭ��: �Զ�����¼�û�����accountSelf_user�����������Դ:����� */
//	document.getElementById("accountSelf_user").value = "";
	document.getElementById("accountSelf_oldPwd").value = "";
	document.getElementById("accountSelf_newPwd").value = "";
	document.getElementById("accountSelf_newPwd2").value = "";

    if (security_mode == "OPEN" || security_mode == "SHARED" || security_mode == "WEPAUTO")
    {
        document.getElementById("password_tips").innerHTML = _("wep_pwd_tips");
    }
    else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK")
    {
        document.getElementById("password_tips").innerHTML = _("wpa_pwd_tips");
    }

	/*add begin by�����ã�20170221��ԭ��:��ʼ��¼ʱ������˫Ƶ�豸5G wifi ssid1����*/
	if(wifi_chip_num == '2')
	{
		setDisplay("tb_5g_ssid", "");
		if (security_mode_5g_ssid1 == "OPEN" || security_mode_5g_ssid1 == "SHARED" || security_mode_5g_ssid1 == "WEPAUTO")
		{
			document.getElementById("password_tips_5g").innerHTML = _("wep_pwd_tips");
		}
		else if (security_mode_5g_ssid1 == "WPAPSK" || security_mode_5g_ssid1 == "WPA2PSK" || security_mode_5g_ssid1 == "WPAPSKWPA2PSK")
		{
			document.getElementById("password_tips_5g").innerHTML = _("wpa_pwd_tips");
		}
	}	
	/*add end by�����ã�20170221*/
	
	/* modify by wuxj, 20170904, ԭ��: ά���˺��״ε�¼����ǿ���޸�����.������Դ:Ǯ�� */
	if(ispName == 8) /* pldt */
	{
		if(curUserType == '2')	//ά���˺Ų����SSID����
		{
			wifi_flag = 0;
		}		
	}
	/* add by wuxj, 20181022, ԭ��: ̩��TRUE��ͨ�û��״ε�¼��ǿ���޸�����.������Դ:Ǯ�� */
	else if(ispName == 22) /* ̩��TRUE */
	{
		wifi_flag = 0;		//�����SSID����
	}
	if(wifi_flag == 0)
	{
		setDisplay("tb_2g_ssid", "none");
		setDisplay("tb_5g_ssid", "none");
	}	
	if(defaultpassword == 1)
	{
		if(wifi_flag == 0)
			alert("Initial login on this account you must modify account password!");
		else
			alert("Initial login on this account you must modify account password, SSID name and authentication password!");
	}
	
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
<form method="post" name="Adm" action="/goform/set_pldt_account_self_param">
  <table id="tb_account" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="account_manage_title" colspan="2">Account Management</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="accountSelf_userTitle">Username</td>
        <td class="tabal_right"><input type="text" name="accountSelf_user" id="accountSelf_user" readonly = "true" size="16" maxlength="32" value="<% getCfgGeneral(1, 'login_user'); %>">
        </td>
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
  <table id="tb_2g_ssid" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="ssid1_title" colspan="2">2.4G SSID1</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ssid1_name_title">SSID Name</td>
        <td class="tabal_right"><input type="text" name="ssid1_name" id="ssid1_name" size="32" maxlength="32">
          <strong style="color:#FF0033">*</strong><span class="gray" id="ssidNameTips">(1-32 Characters)</span> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="ssid1_pwd_title">Password</td>
        <td class="tabal_right"><input type="password" name="ssid1_pwd" id="ssid1_pwd" size="16" maxlength="64">
          <strong style="color:#FF0033">*</strong><span class="gray" id="password_tips" ></span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="ssid1_pwd2_title">Password Confirm</td>
        <td class="tabal_right"><input type="password" name="ssid1_pwd2" id="ssid1_pwd2" size="16" maxlength="64">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_5g_ssid" class="tabal_bg" style="display: none;" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td id="ssid1_title_5g" colspan="2">5G SSID1</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="ssid1_name_title_5g">SSID Name</td>
      <td class="tabal_right"><input type="text" name="ssid1_name_5g" id="ssid1_name_5g" size="32" maxlength="32">
        <strong style="color:#FF0033">*</strong><span class="gray" id="ssidNameTips_5g">(1-32 Characters)</span> </td>
    </tr>
    <tr>
      <td class="tabal_left" id="ssid1_pwd_title_5g">Password</td>
      <td class="tabal_right"><input type="password" name="ssid1_pwd_5g" id="ssid1_pwd_5g" size="16" maxlength="64">
        <strong style="color:#FF0033">*</strong><span class="gray" id="password_tips_5g" ></span></td>
    </tr>
    <tr>
      <td class="tabal_left" id="ssid1_pwd2_title_5g">Password Confirm</td>
      <td class="tabal_right"><input type="password" name="ssid1_pwd2_5g" id="ssid1_pwd2_5g" size="16" maxlength="64">
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
