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
<title>DHCPv6 Port Service</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var dhcpv6_portbandsync = '<% dhcpv6_portbandsync(); %>';
var dhcpv6_fe_bind = '<% getCfgGeneral(1, "dhcpv6_fe_bind"); %>';
var dhcpv6_ssid_bind = '<% getCfgGeneral(1, "dhcpv6_ssid_bind"); %>';
var dhcpv6_fe_bindvalue = dhcpv6_fe_bind.split(",");
var dhcpv6_ssid_bindvalue = dhcpv6_ssid_bind.split(",");

var dhcpra_fe_bind = '<% getCfgGeneral(1, "dhcpra_fe_bind"); %>';
var dhcpra_ssid_bind = '<% getCfgGeneral(1, "dhcpra_ssid_bind"); %>';
var dhcpra_fe_bindvalue = dhcpra_fe_bind.split(",");
var dhcpra_ssid_bindvalue = dhcpra_ssid_bind.split(",");

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>'; 

function initTranslation()
{
	var e = document.getElementById("dhcpv6_portband_prompt");
	e.innerHTML = _("dhcpv6_portband_prompt");

	e = document.getElementById("DHCPv6_FE_title");
	e.innerHTML = _("DHCP_FE_title");
	e = document.getElementById("DHCPv6_SSID_title");
	e.innerHTML = _("DHCP_SSID_title");

	e = document.getElementById("DHCPra_FE_title");
	e.innerHTML = _("DHCP_FE_title");
	e = document.getElementById("DHCPra_SSID_title");
	e.innerHTML = _("DHCP_SSID_title");

	e = document.getElementById("dhcpband_apply");
	e.value = _("inet apply");
	e = document.getElementById("dhcpband_cancel");
	e.value = _("inet cancel");
}

function initValue()
{
	initTranslation();

	var dhcpv6FEBoxNode = getElement("dhcpv6_feBox");
	var dhcpv6SsidBoxNode = getElement("dhcpv6_ssidBox");
	
	if(dhcpv6_fe_bindvalue[0] == 1)
	{
		dhcpv6FEBoxNode[0].checked = true;			
	}
	else
	{
        dhcpv6FEBoxNode[0].checked =  false;	
	}

	if(dhcpv6_fe_bindvalue[1] == 2)
	{
		dhcpv6FEBoxNode[1].checked = true;			
	}
	else
	{
        dhcpv6FEBoxNode[1].checked =  false;	
	}

	if(dhcpv6_fe_bindvalue[2] == 4)
	{
		dhcpv6FEBoxNode[2].checked = true;			
	}
	else
	{
        dhcpv6FEBoxNode[2].checked =  false;	
	}

	if(dhcpv6_fe_bindvalue[3] == 8)
	{
		dhcpv6FEBoxNode[3].checked = true;			
	}
	else
	{
        dhcpv6FEBoxNode[3].checked =  false;	
	}

	if(dhcpv6_ssid_bindvalue[0] == 1)
	{
		dhcpv6SsidBoxNode[0].checked = true;			
	}
	else
	{
        dhcpv6SsidBoxNode[0].checked =  false;	
	}
	if(dhcpv6_ssid_bindvalue[1] == 2)
	{
		dhcpv6SsidBoxNode[1].checked = true;			
	}
	else
	{
        dhcpv6SsidBoxNode[1].checked =  false;	
	}
	if(dhcpv6_ssid_bindvalue[2] == 4)
	{
		dhcpv6SsidBoxNode[2].checked = true;			
	}
	else
	{
        dhcpv6SsidBoxNode[2].checked =  false;	
	}
	if(dhcpv6_ssid_bindvalue[3] == 8)
	{
		dhcpv6SsidBoxNode[3].checked = true;			
	}
	else
	{
        dhcpv6SsidBoxNode[3].checked =  false;	
	}


	var dhcpraFEBoxNode = getElement("dhcpra_feBox");
	var dhcpraSsidBoxNode = getElement("dhcpra_ssidBox");
	
	if(dhcpra_fe_bindvalue[0] == 1)
	{
		dhcpraFEBoxNode[0].checked = true;			
	}
	else
	{
        dhcpraFEBoxNode[0].checked =  false;	
	}

	if(dhcpra_fe_bindvalue[1] == 2)
	{
		dhcpraFEBoxNode[1].checked = true;			
	}
	else
	{
        dhcpraFEBoxNode[1].checked =  false;	
	}

	if(dhcpra_fe_bindvalue[2] == 4)
	{
		dhcpraFEBoxNode[2].checked = true;			
	}
	else
	{
        dhcpraFEBoxNode[2].checked =  false;	
	}

	if(dhcpra_fe_bindvalue[3] == 8)
	{
		dhcpraFEBoxNode[3].checked = true;			
	}
	else
	{
        dhcpraFEBoxNode[3].checked =  false;	
	}

	if(dhcpra_ssid_bindvalue[0] == 1)
	{
		dhcpraSsidBoxNode[0].checked = true;			
	}
	else
	{
        dhcpraSsidBoxNode[0].checked =  false;	
	}
	if(dhcpra_ssid_bindvalue[1] == 2)
	{
		dhcpraSsidBoxNode[1].checked = true;			
	}
	else
	{
        dhcpraSsidBoxNode[1].checked =  false;	
	}
	if(dhcpra_ssid_bindvalue[2] == 4)
	{
		dhcpraSsidBoxNode[2].checked = true;			
	}
	else
	{
        dhcpraSsidBoxNode[2].checked =  false;	
	}
	if(dhcpra_ssid_bindvalue[3] == 8)
	{
		dhcpraSsidBoxNode[3].checked = true;			
	}
	else
	{
        dhcpraSsidBoxNode[3].checked =  false;	
	}

	if(lan_port_num == 1)
	{
		document.getElementById("dhcpv6_feBox2").disabled = 1;
		document.getElementById("dhcpv6_feBox3").disabled = 1;
		document.getElementById("dhcpv6_feBox4").disabled = 1;

		document.getElementById("dhcpra_feBox2").disabled = 1;
		document.getElementById("dhcpra_feBox3").disabled = 1;
		document.getElementById("dhcpra_feBox4").disabled = 1;
	}
	else if(lan_port_num == 2)
	{
		document.getElementById("dhcpv6_feBox3").disabled = 1;
		document.getElementById("dhcpv6_feBox4").disabled = 1;

		document.getElementById("dhcpra_feBox3").disabled = 1;
		document.getElementById("dhcpra_feBox4").disabled = 1;
	}

	if(WifiFlag == 0)
	{
		document.getElementById("dhcpv6_ssidBox1").disabled = 1;
		document.getElementById("dhcpv6_ssidBox2").disabled = 1;
		document.getElementById("dhcpv6_ssidBox3").disabled = 1;
		document.getElementById("dhcpv6_ssidBox4").disabled = 1;

		document.getElementById("dhcpra_ssidBox1").disabled = 1;
		document.getElementById("dhcpra_ssidBox2").disabled = 1;
		document.getElementById("dhcpra_ssidBox3").disabled = 1;
		document.getElementById("dhcpra_ssidBox4").disabled = 1;
	}

}

function CheckValue()
{
	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="dhcp_portband_form" action="/goform/set_dhcpv6_portband" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="dhcpv6_portband_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td colspan="2" id="DHCPv6title">DHCPv6</td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="DHCPv6_FE_title">LAN Binding</td>
        <td class="tabal_right" ><span>LAN 1</span>
          <input type="checkbox" name="dhcpv6_feBox" id="dhcpv6_feBox1" value="1">
          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
          <input type="checkbox" name="dhcpv6_feBox" id="dhcpv6_feBox2" value="2">
          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
          <input type="checkbox" name="dhcpv6_feBox" id="dhcpv6_feBox3" value="4">
          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
          <input type="checkbox" name="dhcpv6_feBox" id="dhcpv6_feBox4" value="8">
        <td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="DHCPv6_SSID_title">SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="dhcpv6_ssidBox" id="dhcpv6_ssidBox1" value="1">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="dhcpv6_ssidBox" id="dhcpv6_ssidBox2" value="2">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="dhcpv6_ssidBox" id="dhcpv6_ssidBox3" value="4">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="dhcpv6_ssidBox" id="dhcpv6_ssidBox4" value="8">
        </td>
      </tr>
      <tr>
        <td height="10px"></td>
      </tr>
      <tr class="tabal_head">
        <td colspan="2" id="RAtitle">RA</td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="DHCPra_FE_title">LAN Binding</td>
        <td class="tabal_right" ><span>LAN 1</span>
          <input type="checkbox" name="dhcpra_feBox" id="dhcpra_feBox1" value="1">
          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
          <input type="checkbox" name="dhcpra_feBox" id="dhcpra_feBox2" value="2">
          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
          <input type="checkbox" name="dhcpra_feBox" id="dhcpra_feBox3" value="4">
          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
          <input type="checkbox" name="dhcpra_feBox" id="dhcpra_feBox4" value="8">
        <td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="DHCPra_SSID_title">SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="dhcpra_ssidBox" id="dhcpra_ssidBox1" value="1">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="dhcpra_ssidBox" id="dhcpra_ssidBox2" value="2">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="dhcpra_ssidBox" id="dhcpra_ssidBox3" value="4">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="dhcpra_ssidBox" id="dhcpra_ssidBox4" value="8">
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

