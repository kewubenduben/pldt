<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Lan State</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var setLanstateSync = '<% setLanstateSync(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("lanstate_prompt");
	e.innerHTML = _("lanstate_prompt");

	e = document.getElementById("lState");
	e.innerHTML = _("lState");
	e = document.getElementById("lanIp");
	e.innerHTML = _("lanIp");
	e = document.getElementById("lanNetmask");
	e.innerHTML = _("lanNetmask");
/*
	e = document.getElementById("Lan_PortTitle");
	e.innerHTML = _("Lan_PortTitle");
	e = document.getElementById("Servicetitle");
	e.innerHTML = _("Servicetitle");
	e = document.getElementById("Statustitle");
	e.innerHTML = _("Statustitle");
*/
	
	e = document.getElementById("v6State");
	e.innerHTML = _("v6State");
	e = document.getElementById("lanIpv6");
	e.innerHTML = _("lanIpv6");
}

function initValue()
{
	initTranslation();
	
	var idisplay_v6_flag = '<% getCfgGeneral(1, "idisplay_v6_flag"); %>';
	if(parseInt(idisplay_v6_flag) != 0)
	{
		setDisplay("ipv6_lan_state", "");
	}
	else
	{
		setDisplay("ipv6_lan_state", "none");
	}
	if(ispNameCode == 9)/*罗马尼亚版本*/
	{
		setDisplay("lanmac_tr", "");
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="lanstate" id="lanstate">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="lanstate_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="lState">LAN State</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="lanIp">IP Address</td>
        <td class="tabal_right"><% getCfgGeneral(1, "lanstate_ipaddr"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="lanNetmask">Subnet Mask</td>
        <td class="tabal_right"><% getCfgGeneral(1, "lanstate_netmask"); %></td>
      </tr>
       <tr id ="lanmac_tr" style="display: none">
        <td class="tabal_left" width="25%" id="lmac">LAN MAC</td>
        <td class="tabal_right"><% getCfgGeneral(1, "lanmac"); %></td>
      </tr>
    </tbody>
  </table>
  <!--table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" height="5" width="100%">
    <tbody>
      <tr class="tabal_title">
        <td width="10%" id="Lan_PortTitle">Lan Port</td>
        <td width="45%" id="Servicetitle">Service</td>
        <td width="45%" id="Statustitle">Status</td>
      </tr>
      <tr class="tabal_left">
        <td width="10%"  align="center">1</td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan1_service"); %></td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan1_state"); %></td>
      </tr>
      </tr>
      
      <tr class="tabal_left">
        <td width="10%"  align="center">2</td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan2_service"); %></td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan2_state"); %></td>
      </tr>
      <tr class="tabal_left">
        <td width="10%"  align="center">3</td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan3_service"); %></td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan3_state"); %></td>
      </tr>
      </tr>
      
      <tr class="tabal_left">
        <td width="10%"  align="center">4</td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan4_service"); %></td>
        <td width="45%"  align="center"><% getCfgGeneral(1, "lan4_state"); %></td>
      </tr>
    </tbody>
  </table-->
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table  id = "ipv6_lan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="v6State">IPv6 State</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="lanIpv6">IPv6 Address</td>
        <td class="tabal_right"><% getCfgGeneral(1, "lanstate_ipav6ddr"); %></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
