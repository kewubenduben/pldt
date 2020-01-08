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
<title>FTP Server</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ftp_server", lang);

var ftpServerSync = '<% ftpServerSync(); %>';

function initTranslation()
{
	var e = document.getElementById("ftpServer_Prompt");
	e.innerHTML = _("ftpServer_Prompt");
    e = document.getElementById("ftpServer_head");
	e.innerHTML = _("ftpServer_head");
	e = document.getElementById("ftpServer_enTitle");
	e.innerHTML = _("ftpServer_head");
	e = document.getElementById("ftpServer_enableTitle");
	e.innerHTML = _("ftpServer_enableTitle");
	e = document.getElementById("ftpServer_disableTitle");
	e.innerHTML = _("ftpServer_disableTitle");
	e = document.getElementById("ftpServer_userTitle");
	e.innerHTML = _("ftpServer_userTitle");
	e = document.getElementById("ftpServer_userTips");
	e.innerHTML = _("ftpServer_userTips");
	e = document.getElementById("ftpServer_pwdTitle");
	e.innerHTML = _("ftpServer_pwdTitle");
	e = document.getElementById("ftpServer_pwdTips");
	e.innerHTML = _("ftpServer_pwdTips");
	e = document.getElementById("ftpServer_apply");
	e.value = _("ftpServer_apply");
	e = document.getElementById("ftpServer_cancel");
	e.value = _("ftpServer_cancel");
}
function initValue()
{ 
	initTranslation();
	var ftpServerEnable = "<% getCfgGeneral(1, "ftpServer_enable"); %>";
	var ftpServerEnableNode = getElement("ftpServer_enable");
	for(var i = 0; i < ftpServerEnableNode.length; i++)
	{
		if(ftpServerEnableNode[i].value == ftpServerEnable)
		{
			ftpServerEnableNode[i].checked = true;
			break;
		}
	}
	onClickMethod(ftpServerEnable);	
}

function onClickMethod(chooseValue)
{   
	with(document.forms[0]){
		if(chooseValue == "1"){					/* 启动 */
			setDisplay("tr_ftpServerUser","");
			setDisplay("tr_ftpServerPwd","");
		}
		else if(chooseValue == "0"){				/* 关闭 */
			setDisplay("tr_ftpServerUser","none");
			setDisplay("tr_ftpServerPwd","none");
		}
	}	
}

function checkValue()
{	
	var enableNode = getElement("ftpServer_enable");
	if(enableNode[1].checked)	/* 关闭 */
	{
		return true;
	}
	
	var ftpServer_user = document.getElementById("ftpServer_user");
	var ftpServer_pwd = document.getElementById("ftpServer_pwd");
	
	if (!CheckNotNull(ftpServer_user.value)) 
	{
//		alert("请输入用户名!");
		alert(_("ftpServer_userNullAlert"));
		ftpServer_user.value = ftpServer_user.defaultValue;
		ftpServer_user.focus();
		return false;
	}
	else if(!checkFtpServerUsername(ftpServer_user.value)) 
	{
//		alert("（请输入1-32个字符, 包括数字、字母 和 '_'）!");
		alert(_("ftpServer_userIllegalAlert"));
		ftpServer_user.value = ftpServer_user.defaultValue;
		ftpServer_user.focus();
		return false;
	}
	if (!CheckNotNull(ftpServer_pwd.value)) 
	{
//		alert("请输入密码!");
		alert(_("ftpServer_passNullAlert"));
		ftpServer_pwd.value = ftpServer_pwd.defaultValue;
		ftpServer_pwd.focus();
		return false;
	}
	else if(!checkFtpServerPwd(ftpServer_pwd.value)) 
	{
//		alert("（请输入1-8个字符, 包括数字、字母 和 '_'）!");
		alert(_("ftpServer_passIllegalAlert"));
		ftpServer_pwd.value = ftpServer_pwd.defaultValue;
		ftpServer_pwd.focus();
		return false;
	}
	return true;
}

function checkFtpServerUsername(str)
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
function checkFtpServerPwd(str)
{
	var reg = /^[\w]{1,8}$/;	//数字 英文字母 _
	if (!reg.test(str))
	{ 
		return false; 
	}
	else
	{
		return true;
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="ftpServer_fm" id="ftpServer_fm" action="/goform/setFtpServer" onSubmit="return checkValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="ftpServer_Prompt" style="padding-left: 10px;" class="title_01" width="100%"> </td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="ftpServer_head">FTP Server</td>
    </tr>
    <tr>
      <td class="tabal_left" id="ftpServer_enTitle" align="left" width="25%">FTP Server</td>
      <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="ftpServer_enable" onclick="onClickMethod(this.value)" type="radio">
        <span id="ftpServer_enableTitle">enable</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <input value="0" name="ftpServer_enable" onclick="onClickMethod(this.value)" type="radio" checked="checked">
        <span id="ftpServer_disableTitle">disable</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong></td>
    </tr>
    <div id="div_ftpServer">
    <tr id="tr_ftpServerUser">
      <td class="tabal_left" width="20%" id="ftpServer_userTitle">Username</td>
      <td class="tabal_right"><input name="ftpServer_user" id="ftpServer_user" maxlength=32 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "ftpServer_user"); %>">
        <strong style="color:#FF0033">*</strong><span class="gray" id="ftpServer_userTips"></span></td>
    </tr>
    <tr id="tr_ftpServerPwd">
      <td class="tabal_left" width="20%" id="ftpServer_pwdTitle">Password</td>
      <td class="tabal_right"><input name="ftpServer_pwd" id="ftpServer_pwd" maxlength=8 style="width: 150px;" type="password" value="<% getCfgGeneral(1, "ftpServer_pwd"); %>">
        <span class="gray" id="ftpServer_pwdTips"></span></td>
    </tr>
    </div>
    <!--tr>
      <td class="tabal_left" width="20%" id="ftpServer_priTitle">权限</td>
      <td class="tabal_right"><select name="ftpServer_priority" id="ftpServer_priority" size="1" style="width:17%">
            <option value="0">只读</option>
            <option value="1">只写</option>
            <option value="2">读写</option>
          </select></td>
    </tr-->
	<!-- -->
  </tbody>
</table>
<table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="tabal_submit" width="25%"></td>
      <td class="tabal_submit"><input type="submit" value="Apply" id="ftpServer_apply" class="submit">
        <input type="reset" value="Cancel" id="ftpServer_cancel" class="submit" onClick="window.location.reload()">
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
