<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Fiberhome Debug Enable</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);
var token = <%  get_random_str(); %>;

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var telnetEnableSync = '<% telnetEnableSync(); %>';
var adminEnableSync = '<% adminEnableSync(); %>';
var omciDebugSync = '<% omciDebugSync(); %>';

function initTranslation()
{	
}

function initValue()
{
	initTranslation();
	var telnetEnableNode = document.getElementsByName("telnet_enable");
	var telnetEnable = '<% getCfgGeneral(1, "telnet_enable"); %>';
	showRadioNodeByValue(telnetEnableNode, telnetEnable);
	
	if(ispNameCode == '8' || ispNameCode == '5')	//pldt/ais
	{
		setDisplay("div_adminenable", '');
		var adminEnableNode = document.getElementsByName("admin_enable");
		var admin_enable = '<% getCfgGeneral(1, "admin_enable"); %>';
		showRadioNodeByValue(adminEnableNode, admin_enable);
	}
	
	var PON_TYPE = '<% getCfgGeneral(1, "FH_AUTO_PON_TYPE"); %>';
	if(PON_TYPE == 'GPON')
	{
		setDisplay("div_omciDebug", '');
		var omciDebugNode = document.getElementsByName("omci_debug");
		var omci_debug = '<% getCfgGeneral(1, "omci_debug"); %>';
		showRadioNodeByValue(omciDebugNode, omci_debug);
	}
	
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="telnet_enable_prompt"  class="title_01" style="padding-left: 10px;" width="100%">On this page, you can enable/disable factory debug switch.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
  </tbody>
</table>
<form method=post action="/goform/setTelnetEnable">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="telnet_title" align="left" width="25%">Telnet Switch</td>
        <td class="tabal_right" align="left"><input checked="checked" value="1" name="telnet_enable" type="radio">
          <font id="telnet_enable_title">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="telnet_enable" type="radio">
          <font id="telnet_disable_title">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="telnet_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="telnet_cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<div id='div_adminenable' style="display: none">
  <form method=post action="/goform/setAdminEnable">
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_left" id="admin_title" align="left" width="25%">Web Admin Switch</td>
          <td class="tabal_right" align="left"><input checked="checked" value="1" name="admin_enable" type="radio">
            <font id="admin_enable_title">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input value="0" name="admin_enable" type="radio">
            <font id="admin_disable_title">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
        </tr>
    </table>
    <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_submit" width="25%"></td>
          <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="telnet_apply">
            &nbsp; &nbsp;
            <input class="submit" type="reset" value="Cancel" id="telnet_cancel" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
<div id='div_omciDebug' style="display: none">
  <form method=post action="/goform/setOmciDebug">
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_left" id="omci_debug_title" align="left" width="25%">Omci Debug Switch</td>
          <td class="tabal_right" align="left"><input checked="checked" value="1" name="omci_debug" type="radio">
            <font id="omci_enable_title">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input value="0" name="omci_debug" type="radio">
            <font id="omci_disable_title">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
        </tr>
    </table>
    <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_submit" width="25%"></td>
          <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="omci_apply">
            &nbsp; &nbsp;
            <input class="submit" type="reset" value="Cancel" id="omci_cancel" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
