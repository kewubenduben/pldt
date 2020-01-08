<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>LAN Port Band</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var lan_portbandsync = '<% lan_portbandsync(); %>';

function initTranslation()
{
	var e = document.getElementById("lan_portband_prompt");
	e.innerHTML = _("lan_portband_prompt");

	e = document.getElementById("wan_FE_title");
	e.innerHTML = _("wan_FE_title");
	e = document.getElementById("wan_SSID_24g_title");
	e.innerHTML = _("wan_SSID_24g_title");
	e = document.getElementById("wan_SSID_5g_title");
	e.innerHTML = _("wan_SSID_5g_title");

	e = document.getElementById("lanband_apply");
	e.value = _("inet apply");
	e = document.getElementById("lanband_cancel");
	e.value = _("inet cancel");
}

function showLanBandFESSID()
{
	var checkedFEValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	var checkedSSIDValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	
	var feData = "<% getCfgGeneral(1, 'lanband_fe_port'); %>";
	var feArr = feData.split(",");
	var ssidData = "<% getCfgGeneral(1, 'lanband_ssid_port'); %>";
	var ssidArr = ssidData.split(",");
	
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	/*lan band นดัก*/
	for(var i = 0; i < 4; i++)
	{
		if(feArr[i] == checkedFEValue[i])
		{
			wanFEBoxNode[i].checked = true;			
		}
		else
		{
	        wanFEBoxNode[i].checked =  false;	
		}		
	}
	/*ssid band นดัก*/
	for(var i = 0; i < 8; i++)
	{
		if(ssidArr[i] == checkedSSIDValue[i])
		{
			wanSsidBoxNode[i].checked = true;			
		}
		else
		{
	        wanSsidBoxNode[i].checked =  false;	
		}
	}
}

function initValue()
{
	initTranslation();
	
	var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num");%>';
	if(parseInt(wifi_chip_num) > 1)
		setDisplay("tr_5gssidBind", "");
	else
		setDisplay("tr_5gssidBind", "none");
	showLanBandFESSID();

	var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
	var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>'; 
	var wifi_ssid_sum = '<% getCfgGeneral(1, "wifi_ssid_sum"); %>';
	
	document.getElementById("wan_feBox2").disabled = 1;
	document.getElementById("wan_feBox3").disabled = 1;
	document.getElementById("wan_feBox4").disabled = 1;
	if(parseInt(lan_port_num) >= 1)
	{
		document.getElementById("wan_feBox1").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 2)
	{
		document.getElementById("wan_feBox2").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 3)
	{
		document.getElementById("wan_feBox3").disabled = 0;
	}
	if(parseInt(lan_port_num) >= 4)
	{
		document.getElementById("wan_feBox4").disabled = 0;
	}
	
	var wanSsidBoxNode = getElement("wan_ssidBox");
	if(WifiFlag == 1)
	{
		for(var i = 0; i < wifi_ssid_sum; i++)
		{
			wanSsidBoxNode[i].disabled = 0;
		}
	}
	else
	{
		for(var i = 0; i < wifi_ssid_sum; i++)
		{
			wanSsidBoxNode[i].disabled = 1;
		}
	}
}

function CheckValue()
{
	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="lan_portband_form" action="/goform/set_lan_portband" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="lan_portband_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table id="port_bang" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_feBind">
        <td width="25%" class="tabal_left" id="wan_FE_title">LAN Binding</td>
        <td class="tabal_right" ><span>LAN 1</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox1" value="1">
          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox2" value="2">
          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox3" value="4">
          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox4" value="8">
        <td>
      </tr>
      <tr id="tr_ssidBind">
        <td width="25%" class="tabal_left" id="wan_SSID_24g_title">2.4G SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="wan_ssidBox" value="1">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="wan_ssidBox" value="2">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="wan_ssidBox" value="4">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="wan_ssidBox" value="8">
        </td>
      </tr>
      <tr id="tr_5gssidBind">
        <td width="25%" class="tabal_left" id="wan_SSID_5g_title">5G SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="wan_ssidBox" value="16">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="wan_ssidBox" value="32">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="wan_ssidBox" value="64">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="wan_ssidBox" value="128">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="lanband_apply">
          <input class="submit" type="reset" value="Cancel" id="lanband_cancel"onclick="window.location.reload();" >
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
