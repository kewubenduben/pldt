<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Remote Control</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("remote_control", lang);

//get init value from driver
var RemoteControlSync = '<% RemoteControlSync(); %>';
var HttpsEnableSync = '<% HttpsEnableSync(); %>';
var webPortSync = '<% webPortSync(); %>';

var https_enalbe_value = '<% getCfgGeneral(1, "https_enable"); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

function initTranslation()
{
	var e = document.getElementById("rcEnable_title");
	e.innerHTML = _("rcEnable_title");
    e = document.getElementById("recontrol_prompt");
	if(ispNameCode == '9')
		e.innerHTML = _("recontrol_prompt_romania");
	else
		e.innerHTML = _("recontrol_prompt");

	e = document.getElementById("rc_enable");
	e.innerHTML = _("rc_enable");
	e = document.getElementById("rc_disable");
	e.innerHTML = _("rc_disable");

	e = document.getElementById("recontrolApply");
	e.value = _("recontrolApply");
	e = document.getElementById("recontrolCancel");
	e.value = _("recontrolCancel");

	if(ispNameCode == '26')	//TIM
	{
		e = document.getElementById("webport_Prompt");
		e.innerHTML = _("webport_Prompt");
		e = document.getElementById("web_portTitle");
		e.innerHTML = _("web_portTitle");
		e = document.getElementById("web_portchangeTitle");
		e.innerHTML = _("web_portchangeTitle");
		e = document.getElementById("web_portchangeTips");
		e.innerHTML = _("web_portchangeTips");
		e = document.getElementById("webport_apply");
		e.value = _("recontrolApply");
		e = document.getElementById("webport_cancel");
		e.value = _("recontrolCancel");
	}
}
function initValue()
{
	initTranslation();
    var rcEnable = document.getElementsByName("recontrol_check");	
	for(var i = 0;i<rcEnable.length;i++)
	{
		if(rcEnable[i].value == '<% getCfgGeneral(1, "rcenable"); %>')
		{
			rcEnable[i].checked = true;
			break;
		}
	}

	if((ispNameCode == 9) && (curUserType == 1)) /*罗马尼亚版本普通用户*/
	{

		if(https_enalbe_value == 1)
		{
			document.getElementById("recontrol_check_enable").disabled = 0;
			document.getElementById("recontrol_check_disable").disabled = 0;
			document.getElementById("recontrolApply").disabled = 0;
		}
		else
		{
			document.getElementById("recontrol_check_enable").disabled = 1;
			document.getElementById("recontrol_check_disable").disabled = 1;
			document.getElementById("recontrolApply").disabled = 1;
		}
	}
	if(ispNameCode == '26')	//add by wuxj, 20171226, for TIM
	{
		setDisplay('tr_prompWebPort', '');
		setDisplay('tb_webport', '');
		setDisplay('tb_webport_submit', '');
	}
}
function ChangeConfirm()
{
	var portvalue = document.getElementById("web_port_change");
	if (portvalue.value == "")
	{
			alert(_("web_PortNullAlert"));
			portvalue.value = portvalue.defaultValue;
			portvalue.focus();
			return false;
	}
	else
	{
		if(!checkWebPortLegal(portvalue))
		{	
			alert(_("web_portIllegalAlert"));
			return false;
		}
	}
	
    alert(_("Change_confirm"));	
	return true;
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="recontrol_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
            <tr id="tr_prompWebPort" style="display: none">
              <td id="webport_Prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="rc_enableform" action="/goform/setRemoteControl">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="rcEnable_title" width="25%"></td>
        <td class="tabal_right"><input checked="checked" value="1" name="recontrol_check" id="recontrol_check_enable" type="radio">
          <font id="rc_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="recontrol_check" id="recontrol_check_disable" type="radio">
          <font id="rc_disable">Disable</font></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="recontrolApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="recontrolCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method="post" action="/goform/webPortCfg" onSubmit="return ChangeConfirm()">
  <table id='tb_webport' class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr>
        <td class="tabal_left" width="30%" id="web_portTitle">WEB valid communication port</td>
        <td class="tabal_right"><input name="web_port" readonly = "readonly" id="web_port" size="10" maxlength="5" type="text" value="<% getCfgGeneral(1, 'web_port_1'); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="35%" id="web_portchangeTitle">WEB communication port you modified</td>
        <td class="tabal_right" width="65%"><input name="web_port_change" id="web_port_change" size="10" maxlength="5" type="text" value="<% getCfgGeneral(1, 'web_port_change'); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="web_portchangeTips">(Please input 1024-65535 or 80)</span></td>
      </tr>
    </tbody>
  </table>
  <table id='tb_webport_submit' class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="webport_apply">
          &nbsp; &nbsp;
          <input class="submit" onClick="window.location.reload();" value="Cancel" id="webport_cancel" type="reset">
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
