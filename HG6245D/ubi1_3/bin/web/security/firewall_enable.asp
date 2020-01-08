<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Firewall</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

//get init value from driver
var firewallEnableSync = '<% firewallEnableSync(); %>';

function initTranslation()
{
	var e = document.getElementById("firewallEnable_title");
	e.innerHTML = _("firewallEnable_title");
    e = document.getElementById("firewall_prompt");
	e.innerHTML = _("firewall_prompt");

	e = document.getElementById("firewall_enable");
	e.innerHTML = _("firewall_enable");
	e = document.getElementById("firewall_disable");
	e.innerHTML = _("firewall_disable");

	e = document.getElementById("fw_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("fw_cancel");
	e.value = _("firewall_cancel");	
	
}

function initValue()
{
	initTranslation();
	var firewallEnable = document.getElementsByName("FirewallEnable");	
	for(var i = 0;i<firewallEnable.length;i++)
	{
		if(firewallEnable[i].value == '<% getCfgGeneral(1, "FirewallEnable"); %>')
		{
			firewallEnable[i].checked = true;
			break;
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post name="fm_firewall_basic" action="/goform/setFirewallEnable">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="firewall_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="firewallEnable_title" align="left" width="25%">Firewall Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="FirewallEnable" type="radio">
          <font id="firewall_enable">Enable</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="FirewallEnable" type="radio">
          <font id="firewall_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>

  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="fw_apply" onclick="load_waiting()">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="fw_cancel" onClick="window.location.reload()">
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

