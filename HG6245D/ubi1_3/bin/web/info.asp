<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan_state.js"></script>
<title>Device State Information</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var size = '<% dhcpUserListSync(); %>';
var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';
var sncfgSync = '<% sncfgSync();%>';
var catvFlag = '<% getCfgGeneral(1, "CatvFlag"); %>'; 
var reg_state = '<% getCfgGeneral(1, "reg_state"); %>';
var ONT_state = '<% getCfgGeneral(1, "ONT_state"); %>';

var opt_powerSync = '<% opt_powerSync(); %>';

var previousTR = null;
var setWAN_IPV6InfoSync = '<% setWAN_IPV6InfoSync(); %>';
var setLanstateSync = '<% setLanstateSync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var get_wan_detail = '<% get_wan_detail(); %>';

var wan_num = '<% getCfgGeneral(1, "wan_num"); %>';
var wan_mac_buff = '<% getCfgGeneral(1, "wan_mac_buff"); %>';
var wan_gateway_buff = '<% getCfgGeneral(1, "wan_gateway_buff"); %>';
var uptime_buff = '<% getCfgGeneral(1, "uptime_buff"); %>';
var pppoe_state = '<% getCfgGeneral(1, "pppoe_state"); %>';

var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>';
var voipStatusSync = '<% voipStatusSync(); %>';
var voip_regStatus_1 = '<% getCfgGeneral(1, "voip_regStatus_1"); %>';
var voip_regStatus_2 = '<% getCfgGeneral(1, "voip_regStatus_2"); %>';


function initTranslation()
{
    var e = document.getElementById("DeInf");
	e.innerHTML = _("DeInf");
	e = document.getElementById("softver");
	e.innerHTML = _("softver");
	e = document.getElementById("hardver");
	e.innerHTML = _("hardver");
	e = document.getElementById("device_model");
	e.innerHTML = _("device_model");
	e = document.getElementById("device_descrip");
	e.innerHTML = _("device_descrip");
	e = document.getElementById("ONU_state");
	e.innerHTML = _("ONU_state");
	e = document.getElementById("ONU_reg_title");
	e.innerHTML = _("ONU_reg_title");
	e = document.getElementById("CPU_rate");
	e.innerHTML = _("CPU_rate");
	e = document.getElementById("mem_rate");
	e.innerHTML = _("mem_rate");
	e = document.getElementById("server_port");
	e.innerHTML = _("server_port");
	e = document.getElementById("rf_power_title");
	e.innerHTML = _("rf_power_title");
	e = document.getElementById("catv_revpower_title");
	e.innerHTML = _("catv_revpower_title");
	e = document.getElementById("catv_enable_title");
	e.innerHTML = _("catv_enable_title");

	e = document.getElementById("lState");
	e.innerHTML = _("lState");
	e = document.getElementById("lanIp");
	e.innerHTML = _("lanIp");
	e = document.getElementById("lanNetmask");
	e.innerHTML = _("lanNetmask");
	e = document.getElementById("v6State");
	e.innerHTML = _("v6State");
	e = document.getElementById("lanIpv6");
	e.innerHTML = _("lanIpv6");
	e = document.getElementById("out_power_title");
	e.innerHTML = _("out_power_title");
	e = document.getElementById("in_power_title");
	e.innerHTML = _("in_power_title");
	e = document.getElementById("temp_title");
	e.innerHTML = _("temp_title");
	e = document.getElementById("voltage_title");
	e.innerHTML = _("voltage_title");
	e = document.getElementById("bais_title");
	e.innerHTML = _("bais_title");
		e = document.getElementById("powe_Inf");
	e.innerHTML = _("powe_Inf");

	e = document.getElementById("NOtitle");
	e.innerHTML = _("NOtitle");
	e = document.getElementById("statetitle");
	e.innerHTML = _("statetitle");
	e = document.getElementById("phoneNOtitle");
	e.innerHTML = _("phoneNOtitle");

	e = document.getElementById("voip_state");
	e.innerHTML = displayVoipStatus(voip_regStatus_1);
	e = document.getElementById("voip_state2");
	e.innerHTML = displayVoipStatus(voip_regStatus_2);

	e = document.getElementById("dhcp_userListHead");
	e.innerHTML = _("dhcp_userListHead");
	
	e = document.getElementById("dhcp_macTitle");
	e.innerHTML = _("dhcp_macTitle");
	e = document.getElementById("dhcp_ipTitle");
	e.innerHTML = _("dhcp_ipTitle");
	e = document.getElementById("dhcp_hiredTimeTitle");
	e.innerHTML = _("dhcp_hiredTimeTitle");
	e = document.getElementById("dhcp_typeTitle");
	e.innerHTML = _("dhcp_typeTitle");


	e = document.getElementById("device_info_head");
	e.innerHTML = _("device_info_head");
	e = document.getElementById("lan_info_head");
	e.innerHTML = _("lan_info_head");
	e = document.getElementById("connected_clients_head");
	e.innerHTML = _("connected_clients_head");
	e = document.getElementById("ont_info_head");
	e.innerHTML = _("ont_info_head");
    	e = document.getElementById("voip_info_head");
	e.innerHTML = _("voip_info_head"); 
    	e = document.getElementById("wan_info_head");
	e.innerHTML = _("wan_info_head");
	
	e = document.getElementById("wanListHead");
	e.innerHTML = _("wanListHead");
	e = document.getElementById("wan_name");
	e.innerHTML = _("wan_name");
	e = document.getElementById("wan_state");
	e.innerHTML = _("wan_state");
	e = document.getElementById("wan_mode");
	e.innerHTML = _("wan_mode");
	e = document.getElementById("ip_mode");
	e.innerHTML = _("ip_mode");
	e = document.getElementById("wan_mask");
	e.innerHTML = _("wan_mask");
	e = document.getElementById("wan_vlan");
	e.innerHTML = _("wan_vlan");
	e = document.getElementById("wan_type");
	e.innerHTML = _("wan_type");
	e = document.getElementById("v6State");
	e.innerHTML = _("v6State");
	e = document.getElementById("wanIpv6");
	e.innerHTML = _("wanIpv6");
	e = document.getElementById("wanprefix");
	e.innerHTML = _("wanprefix");
	e = document.getElementById("gateway_v6");
	e.innerHTML = _("v6gateway");
	e = document.getElementById("wan_dns");
	e.innerHTML = _("wan_dns");
	e = document.getElementById("wan_dns2");
	e.innerHTML = _("wan_dns2");
	e = document.getElementById("backPage");
	e.innerHTML = _("setup");				
}
function displayVoipStatus(regStatus)
{
	switch(parseInt(regStatus))
	{
		case 0:
			return _("INACTIVE");
			break;
		case 1:
			return _("REGING");
			break;
		case 2:
			return _("IDLE");
			break;
		case 3:
			return _("OFF_HOOK");
			break;
		case 4:
			return _("DIALING");
			break;
		case 5:
			return _("RING");
			break;
		case 6:
			return _("RINGBACK");
			break;
		case 7:
			return _("CONNECTING");
			break;
		case 8:
			return _("CONNECTED");
			break;
		case 9:
			return _("ON_HOOK");
			break;
		case 10:
			return _("DISCONNECTING");
			break;
		case 11:
			return _("BUSY");
			break;
		case 12:
			return _("REG_FAIL");
			break;
		case 13:
			return _("LINE_FAIL");
			break;
		default :
			return "";
			break;		
	}
}
function initValue()
{
	initTranslation();
	var port_value = document.getElementById("server_port_value");
	var web_port = '<% getCfgGeneral(1, "web_port"); %>';
	var ONU_regstate = document.getElementById("ONU_regstate");
	var loid_state = '<% getCfgGeneral(1, "loid_state"); %>';
	
	port_value.innerHTML = web_port;
	
	if(catvFlag == 1)
	{
		setDisplay("catv_rf", "");
	}
	else
	{
		setDisplay("catv_rf", "none");
	}
	switch(parseInt(loid_state))
	{
		case 0:
		ONU_regstate.innerHTML = _("INIT");
		break;
		case 1:
		ONU_regstate.innerHTML = _("OK");
		break;
		case 2:
		ONU_regstate.innerHTML = _("LOID_ERR");
		break;
		case 3:
		ONU_regstate.innerHTML = _("LPWD_ERR");
		break;
		case 4:
		ONU_regstate.innerHTML = _("LOID_COLLISION");
		break;
		case 10:
		ONU_regstate.innerHTML = _("SN_COLLISION");
		break;
		case 11:
		ONU_regstate.innerHTML = _("NO_RESOURCE");
		break;
		case 12:
		ONU_regstate.innerHTML = _("TYPE_ERR");
		break;
		case 13:
		ONU_regstate.innerHTML = _("SN_ERR");
		break;
		case 14:
		ONU_regstate.innerHTML = _("PWD_ERR");
		break;
		case 15:
		ONU_regstate.innerHTML = _("PWD_COLLISION");
		break;
		default:
		ONU_regstate.innerHTML = _("INIT");
		break;
	}

	var catv_enable_value = '<% getCfgGeneral(1, "catv_enable"); %>';
	var catv_enable_node = document.getElementById("catv_enable");
	if(catv_enable_value == 1)
	{
		catv_enable_node.innerHTML = _("Enable");
	}
	else
	{
		catv_enable_node.innerHTML = _("Disable");
	}
    
    var ipv6_enable_s = '<% getCfgGeneral(1, "ipv6_enable"); %>';/* 0:ipv4; 1:双栈 ;2:ipv6 */
	
    if(ipv6_enable_s != 0)
	{
		setDisplay("ipv6_lan_state", "");
	}
	else
	{
		setDisplay("ipv6_lan_state", "none");
	}
	switch(parseInt(ipv6_enable_s))
	{
		case 0:
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "none");//无V6,不显示V6 WAN信息
			break;
		case 1:
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "");
			break;
		case 2:
			setDisplay("tb_wanstate", "none");	//无V4,不显示WAN状态表
			setDisplay("ipv6_wan_state", "");
			break;
		default:								//视为V4
			setDisplay("tb_wanstate", "");
			setDisplay("ipv6_wan_state", "none");
			break;
	}
        
    if(voip_port_num == 2)
    {
        setDisplay("div_voipPort2", "");
    }
	if(ispName == 15)	//GLOBE
		setDisplay("sysUpTime_tr", "");
	
	selectLine("record_0");
	if((wan_num > 0) && (ispName == 15)) /* GLOBE版本wan计数大于0*/
	{
		setDisplay("wan_state_table", "");
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table  border="0" cellpadding="0" cellspacing="1" width="97%">
  <tbody>
    <tr>
      <td  width="45%"><h2 id = "device_info_head"> Device Info</h2></td>
      <td align="right"><a id="backPage" href="./login.html"><font size="3">Setup</font></a></td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="DeInf">Device Information</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="softver">Software Version</td>
      <td class="tabal_right"><% getCfgGeneral(1, "software_version"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="hardver">Hardware Version</td>
      <td class="tabal_right"><% getCfgGeneral(1, "hardware_version"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="device_model">Device Type</td>
      <td class="tabal_right"><% getCfgGeneral(1, "DeviceType"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="device_descrip">Device Description</td>
      <td class="tabal_right"><% getCfgGeneral(1, "PonType"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="ONU_state">ONU State</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ONT_state"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="ONU_reg_title">ONU Regist State</td>
      <td class="tabal_right" id="ONU_regstate"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" >LOID</td>
      <td class="tabal_right" id="ONU_LOID"><% getCfgGeneral(1, "logic_sn"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="CPU_rate">CPU Usage</td>
      <td class="tabal_right"><% getCfgGeneral(1, "CPU_rate"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="mem_rate">Memory Usage</td>
      <td class="tabal_right"><% getCfgGeneral(1, "mem_rate"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="server_port">Web Server port</td>
      <td class="tabal_right" id="server_port_value"></td>
    </tr>
    <tr id= "sysUpTime_tr" style="display: none">
      <td class="tabal_left" width="25%" id="upTimeTitle">System UpTime</td>
      <td class="tabal_right" id="upTime"><% getCfgGeneral(1, "sysUpTimeDate"); %>
          d
          <% getCfgGeneral(1, "sysUpTimeHour"); %>
          h
          <% getCfgGeneral(1, "sysUpTimeMin"); %>
          m
          <% getCfgGeneral(1, "sysUpTimeSec"); %>
          s</td>
    </tr>
  </tbody>
</table>
<table id="catv_rf" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr >
      <td class="tabal_left" width="25%" id="catv_enable_title">CATV State</td>
      <td class="tabal_right" id="catv_enable" ></td>
    </tr>
    <tr >
      <td class="tabal_left" width="25%" id="catv_revpower_title">CATV Received Power</td>
      <td class="tabal_right" ><% getCfgGeneral(1, "catv_revpower"); %>
        dBm</td>
    </tr>
    <tr >
      <td class="tabal_left" width="25%" id="rf_power_title">CATV RF Power</td>
      <td class="tabal_right"  ><% getCfgGeneral(1, "rf_power"); %>
        dBmV</td>
    </tr>
  </tbody>
</table>
<h2  id = "lan_info_head"> LAN Info</h2>
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
<h2  id = "connected_clients_head"> Connected Clients</h2>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="dhcp_userListHead">DHCP Clients List</td>
    </tr>
    <tr class="tabal_title">
      <td width="5%">ID</td>
      <td width="21%"id="dhcp_hostnameTitle">Hostname</td>
      <td width="20%"id="dhcp_macTitle">MAC</td>
      <td width="20%"id="dhcp_ipTitle">IP</td>
      <td width="17%"id="dhcp_hiredTimeTitle">Hired Time</td>
      <td width="17%"id="dhcp_typeTitle">Type</td>
    </tr>
    <% getDhcpUserListParam(); %>
  </tbody>
</table>
<br>
<strong style="color:#FF0033"><span id="dhcp_getRstPrompt"></span></strong>
</form>
</td>
</tr>
</table>
<h2  id = "ont_info_head"> ONT Info</h2>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="powe_Inf">Optical Info</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="out_power_title">Transmitted Power</td>
      <td class="tabal_right"><% getCfgGeneral(1, "onu_outpower"); %>
        <span> dBm</span></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="in_power_title">Received Power</td>
      <td class="tabal_right"><% getCfgGeneral(1, "onu_inpower"); %>
        <span> dBm</span></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="temp_title">Operating Temperature</td>
      <td class="tabal_right"><% getCfgGeneral(1, "onu_tempereture"); %>
        <span> ℃</span></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="voltage_title">Supply Voltage</td>
      <td class="tabal_right"><% getCfgGeneral(1, "onu_voltage"); %>
        <span> V</span></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="bais_title">Bais Current</td>
      <td class="tabal_right"><% getCfgGeneral(1, "onu_electric"); %>
        <span> mA</span></td>
    </tr>
  </tbody>
</table>
<h2  id = "voip_info_head"> VoIP Info</h2>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" height="5" width="100%">
  <tbody>
    <tr class="tabal_title">
      <td width="10%" id="NOtitle">Index</td>
      <td width="20%" id="statetitle">Port State</td>
      <td width="20%" id="phoneNOtitle">Telephone Number</td>
      <td width="20%" id="codeTitle">Result Code</td>
      <td width="30%" id="reasonTitle">Fail Reason</td>
    </tr>
    <tr class='tabal_01'>
      <td id="voip_NO" align="center">1</td>
      <td id="voip_state" align="center"></td>
      <td id="phone_number" align="center"><% getCfgGeneral(1, "voip_telNum_1"); %></td>
      <td id="code1" align="center"><% getCfgGeneral(1, "voip_code_1"); %></td>
      <td id="reason1" align="center"><% getCfgGeneral(1, "voip_reason_1"); %>
      </td>
    </tr>
    <tr class='tabal_01' id="div_voipPort2" style="display: none">
      <td id="voip_NO2" align="center">2</td>
      <td id="voip_state2" align="center"></td>
      <td id="phone_number2" align="center"><% getCfgGeneral(1, "voip_telNum_2"); %></td>
      <td id="code2" align="center"><% getCfgGeneral(1, "voip_code_2"); %></td>
      <td id="reason2" align="center"><% getCfgGeneral(1, "voip_reason_2"); %>
      </td>
    </tr>
  </tbody>
</table>
<h2  id = "wan_info_head"> WAN </h2>
<table id="tb_wanstate" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="wanListHead">WAN State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="wan_name">Index</td>
      <td width="9%" align="center" id="wan_state">State</td>
      <td width="10%" align="center" id="wan_mode">Mode</td>
      <td width="9%" align="center" id="ip_mode">IP Type</td>
      <td width="14%" align="center" >IP</td>
      <td width="15%" align="center" id="wan_mask">Mask</td>
      <td width="14%" align="center" >DNS</td>
      <td width="7%" align="center" id="wan_vlan">VLAN/Priority</td>
      <td width="5%" align="center" id="wan_type">Connection Type</td>
    </tr>
    <% setWANInfoSync(); %>
  </tbody>
</table>
<table  border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="wan_state_table" class="tabal_bg" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" >More Information</td>
    </tr>
    <tr id="tr_ppp_state" style="display: none;">
      <td class="tabal_left" width="25%">PPPoE State</td>
      <td class="tabal_right" id="ppp_stateDetail"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">WAN Mac</td>
      <td class="tabal_right" id="wan_mac"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Connection Uptime</td>
      <td class="tabal_right" id="wan_uptime"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Gateway</td>
      <td class="tabal_right" id="wan_gateway"></td>
    </tr>
  </tbody>
</table>
<table  id="ipv6_wan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="v6State">IPv6 State</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanIpv6">IPv6 Address</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_ip"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanprefix">Prefix</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6Prefix"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="gateway_v6">Default Gateway</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_gateway"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns">Primary DNS Server</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_pridns"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns2">Secondary DNS Server</td>
      <td class="tabal_right"><% getCfgGeneral(1, "ipv6_secdns"); %></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<br>
<br>
</body>
</html>
