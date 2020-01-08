<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>DHCP Port Service</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var dhcp_portbandsync = '<% dhcp_portbandsync(); %>';
var dhcp_fe_bind = '<% getCfgGeneral(1, "dhcp_fe_bind"); %>';
var dhcp_ssid_bind = '<% getCfgGeneral(1, "dhcp_ssid_bind"); %>';
var dhcp_fe_bindvalue = dhcp_fe_bind.split(",");
var dhcp_ssid_bindvalue = dhcp_ssid_bind.split(",");

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>'; 


function initTranslation()
{
	var e = document.getElementById("dhcp_portband_prompt");
	e.innerHTML = _("dhcp_portband_prompt");

	e = document.getElementById("DHCP_FE_title");
	e.innerHTML = _("DHCP_FE_title");
	e = document.getElementById("DHCP_SSID_title");
	e.innerHTML = _("DHCP_SSID_title");

	e = document.getElementById("dhcpband_apply");
	e.value = _("inet apply");
	e = document.getElementById("dhcpband_cancel");
	e.value = _("inet cancel");
}

function initValue()
{
	initTranslation();

	var dhcpFEBoxNode = getElement("dhcp_feBox");
	var dhcpSsidBoxNode = getElement("dhcp_ssidBox");
	
	if(dhcp_fe_bindvalue[0] == 1)
	{
		dhcpFEBoxNode[0].checked = true;			
	}
	else
	{
        dhcpFEBoxNode[0].checked =  false;	
	}

	if(dhcp_fe_bindvalue[1] == 2)
	{
		dhcpFEBoxNode[1].checked = true;			
	}
	else
	{
        dhcpFEBoxNode[1].checked =  false;	
	}

	if(dhcp_fe_bindvalue[2] == 4)
	{
		dhcpFEBoxNode[2].checked = true;			
	}
	else
	{
        dhcpFEBoxNode[2].checked =  false;	
	}

	if(dhcp_fe_bindvalue[3] == 8)
	{
		dhcpFEBoxNode[3].checked = true;			
	}
	else
	{
        dhcpFEBoxNode[3].checked =  false;	
	}

	if(dhcp_ssid_bindvalue[0] == 1)
	{
		dhcpSsidBoxNode[0].checked = true;			
	}
	else
	{
        dhcpSsidBoxNode[0].checked =  false;	
	}
	if(dhcp_ssid_bindvalue[1] == 2)
	{
		dhcpSsidBoxNode[1].checked = true;			
	}
	else
	{
        dhcpSsidBoxNode[1].checked =  false;	
	}
	if(dhcp_ssid_bindvalue[2] == 4)
	{
		dhcpSsidBoxNode[2].checked = true;			
	}
	else
	{
        dhcpSsidBoxNode[2].checked =  false;	
	}
	if(dhcp_ssid_bindvalue[3] == 8)
	{
		dhcpSsidBoxNode[3].checked = true;			
	}
	else
	{
        dhcpSsidBoxNode[3].checked =  false;	
	}

	if(lan_port_num == 1)
	{
		document.getElementById("dhcp_feBox2").disabled = 1;
		document.getElementById("dhcp_feBox3").disabled = 1;
		document.getElementById("dhcp_feBox4").disabled = 1;
	}
	else if(lan_port_num == 2)
	{
		document.getElementById("dhcp_feBox3").disabled = 1;
		document.getElementById("dhcp_feBox4").disabled = 1;
	}

	if(WifiFlag == 0)
	{
		document.getElementById("dhcp_ssidBox1").disabled = 1;
		document.getElementById("dhcp_ssidBox2").disabled = 1;
		document.getElementById("dhcp_ssidBox3").disabled = 1;
		document.getElementById("dhcp_ssidBox4").disabled = 1;
	}


}

function CheckValue()
{
	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="dhcp_portband_form" action="/goform/set_dhcp_portband" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="dhcp_portband_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
      <tr>
        <td width="25%" class="tabal_left" id="DHCP_FE_title">LAN Binding</td>
        <td class="tabal_right" ><span>LAN 1</span>
          <input type="checkbox" name="dhcp_feBox" id="dhcp_feBox1" value="1">
          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
          <input type="checkbox" name="dhcp_feBox" id="dhcp_feBox2" value="2">
          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
          <input type="checkbox" name="dhcp_feBox" id="dhcp_feBox3" value="4">
          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
          <input type="checkbox" name="dhcp_feBox" id="dhcp_feBox4" value="8">
        <td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="DHCP_SSID_title">SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="dhcp_ssidBox" id="dhcp_ssidBox1" value="1">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="dhcp_ssidBox" id="dhcp_ssidBox2" value="2">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="dhcp_ssidBox" id="dhcp_ssidBox3" value="4">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="dhcp_ssidBox" id="dhcp_ssidBox4" value="8">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="dhcpband_apply">
          <input class="submit" type="reset" value="Cancel" id="dhcpband_cancel"onclick="window.location.reload();" >
        </td>
      </tr>
    </tbody>
  </table>
   <input type="hidden" name="dhcp_hid" id="dhcp_hid" value="0">
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
