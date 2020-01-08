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
<title>VPN Enable</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("vpn_enable", lang);

//get init value from driver
var vpnBasicSync = '<% setVPNEnableSync(); %>';

function initTranslation()
{
	var e = document.getElementById("vpnEnable_title");
	e.innerHTML = _("VPNEnable_title");
    e = document.getElementById("vpn_prompt");
	e.innerHTML = _("VPN_prompt");

	e = document.getElementById("vpn_enable");
	e.innerHTML = _("VPN_enable");
	e = document.getElementById("vpn_disable");
	e.innerHTML = _("VPN_disable");

	e = document.getElementById("vpnEnableApply");
	e.value = _("VPN basic apply");
	e = document.getElementById("vpnEnableCancel");
	e.value = _("VPN basic cancel");
}

function initValue()
{
	initTranslation();
	var vpnEnable = document.getElementsByName("VPNEnable");	
	for(var i = 0;i<vpnEnable.length;i++)
	{
		if(vpnEnable[i].value == '<% getCfgGeneral(1, "VPNEnable"); %>')
		{
			vpnEnable[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">

<form method="post" name="fm_vpn_enable" action="/goform/setVPNEnable">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="vpn_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="vpnEnable_title" align="left" width="25%">VPN Pass-through</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="VPNEnable" type="radio">
          <font id="vpn_enable"></font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="VPNEnable" type="radio">
          <font id="vpn_disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong><span class="gray" id="vpn_portocol">( GRE )</span> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="vpnEnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="vpnEnableCancel" onClick="window.location.reload()">
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
