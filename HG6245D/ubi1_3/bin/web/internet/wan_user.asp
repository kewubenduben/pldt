<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan.js"></script>
<title>WAN</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var GetWANsizeSync = '<% get_wan_usersync(); %>';

function ipModelSwitch()
{
	var ipModelNode =  document.getElementById("ipModel");
	
	if (ipModelNode.options.selectedIndex == 1)
	{
		setDisplay("static", "");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "none");

	}
	else if (ipModelNode.options.selectedIndex == 0)
	{
		setDisplay("static", "none");
		setDisplay("dhcp", "");
		setDisplay("pppoe", "none");
	}
	else
	{
		setDisplay("static", "none");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "");
	}

}

function initValue()
{
	var ipmode_node = getElement("ipModel");
	var wan_connectionmode =  document.getElementById("wan_connectionmode");
	var user_ipmode = '<% getCfgGeneral(1, "user_ipmode"); %>';
	var have_internet = '<% getCfgGeneral(1, "have_internet"); %>';
	var WANpppoestate = '<% getCfgGeneral(1, "user_pppoe_state"); %>';

	if(have_internet == 1)
	{
		wan_connectionmode.options[wan_connectionmode.length] = new Option("INTERNET", "1");
	}
	
	showSelectNodeByValue(ipmode_node,user_ipmode);
	ipModelSwitch();

	if(WANpppoestate == 1)
	{
		document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_connect");
	}
	else
	{
		document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_disconnect");
	}

	
	ipmode_node.disabled = 1;
}

function CheckValue()
{
	var ipmode_node = getElement("ipModel");

	if(document.getElementById("wan_connectionmode").length <= 0)
	{
		alert(_("noInternetWan_alert"));
		return false;
	}

	if(ipmode_node.value == '1') /*static*/
	{
		var staticIp_v =  document.getElementById("staticIp");
		var staticNetmask_v =  document.getElementById("staticNetmask");
		var staticGateway_v =  document.getElementById("staticGateway");
		var staticPriDns_v =  document.getElementById("staticPriDns");
		var staticSecDns_v =  document.getElementById("staticSecDns");
		
		if (!checkIpAddr(staticIp_v, false))
			return false;
		if (!checkIpAddr(staticNetmask_v, true))
			return false;
		if (staticGateway_v.value != "")
			if (!checkIpAddr(staticGateway_v, false))
				return false;
		if (staticPriDns_v.value != "")
			if (!checkIpAddr(staticPriDns_v, false))
				return false;
		if (staticSecDns_v.value != "")
			if (!checkIpAddr(staticSecDns_v, false))
				return false;
	}
	else if(ipmode_node.value == '2') /*pppoe*/
	{
		var pppoeUserNode = document.getElementById("pppoeUser");
		var pppoePassNode = document.getElementById("pppoePass");
	
		if (!CheckNotNull(pppoeUserNode.value)) 
		{					
			alert(_("wPppoeCon_userNullAlert"));
			pppoeUserNode.value = pppoeUserNode.defaultValue;
			pppoeUserNode.focus();
			return false;
		}
		
		if (!CheckNotNull(pppoePassNode.value)) 
		{					
			alert(_("wPppoeCon_pwdNullAlert"));
			pppoePassNode.value = pppoePassNode.defaultValue;
			pppoePassNode.focus();
			return false;
		}
		
	}
	
}

function checkIpAddr(field, ismask)
{
	/* modify begin by 吴小娟, 20110503, 原因: 子网掩码校验范围不正确，
	    本次修改将所有校验改为采用专用的JS校验文件checkValue.js*/
	if (!CheckNotNull(field.value)) {
		//alert("Error! IP address is empty.");
		alert(_("wan_IPempty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {		
		if(!validateMask(field.value))
		{
			//alert('subnet mask is illegal!');
			alert(_("wan_mask_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}		
	}
	else {
		if (!validateIP(field.value))
		{
			//alert('IP adress is illegal!');
			alert(_("wan_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
	/* modify end by 吴小娟, 20110503 */
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="ddns_form" action="/goform/wan_user_tr069cfg" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="ddns_prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can modify connection parameters.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr>
        <td></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td >WAN Configuration</td>
      </tr>
      <tr>
        <td id="wan_servicetypeTitle" class="tabal_left" width="25%">Service Type</td>
        <td class="tabal_right" ><select name="wan_connectionmode" id="wan_connectionmode" size="1" style="width:200px;" >
          </select></td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="wan_connectionTypeTitle">Connection Type</td>
        <td class="tabal_right"><select name="wan_connectionType" id="wan_connectionType" size="1" style="width:200px;">
            <option value="1" id="wConnType_route" selected="selected" >Route</option>
          </select>
        </td>
      </tr>
      <tr id="tr_vlan">
        <td id="wan_vid_title" class="tabal_left" width="25%">VLAN ID</td>
        <td class="tabal_right" width="75%"><input name="wan_vid" id="wan_vid" size="15" disabled="disabled" style="width: 200px;" type="text" value="<% getCfgGeneral(1, "user_vlanid"); %>">
          </td>
      </tr>
      <tr id="tr_priority">
        <td id="wan_priorityTitle" class="tabal_left" width="25%">Priority</td>
        <td class="tabal_right" width="75%"><input name="wan_priority" id="wan_priority" size="15" disabled="disabled" style="width: 200px;" type="text" value="<% getCfgGeneral(1, "user_vlanpri"); %>">
          </td>
      </tr>
      <tr style="">
        <td width="25%" class="tabal_left" id="wConnectionType">WAN IP Mode </td>
        <td class="tabal_right"><select name="ipModel" id="ipModel" size="1" style="width:200px;" onChange="ipModelSwitch();">
            <option value="0" id="wConnTypeDhcp" selected="selected">DHCP</option>
            <option value="1" id="wConnTypeStatic">Static</option>
            <option value="2" id="wConnTypePppoe">PPPoE</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id="static" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wStaticMode">Static Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wStaticIp">IP Address</td>
        <td class="tabal_right"><input name="staticIp" id="staticIp" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_ipaddr"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticNetmask">Subnet Mask</td>
        <td class="tabal_right"><input name="staticNetmask" id="staticNetmask" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_netmask"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticGateway">Default Gateway</td>
        <td class="tabal_right"><input name="staticGateway" id="staticGateway" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_gateway"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticPriDns">Primary DNS Server</td>
        <td class="tabal_right"><input name="staticPriDns" id="staticPriDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_primary_dns"); %>"></td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticSecDns">Secondary DNS Server</td>
        <td class="tabal_right"><input name="staticSecDns" id="staticSecDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_secondary_dns"); %>"></td>
      </tr>
    </tbody>
  </table>
  <table id="dhcp" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wDhcpMode">DHCP Mode</td>
      </tr>
      <!--add begin by 吴小娟, 20110601, 原因: 新增DHCP连接IP等-->
      <tr id="wDhcpCon_ip_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_ip_title">IP Address</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_ip"  disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_ipaddr"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_mask_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_mask_title">Subnet Mask</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_mask"  disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_netmask"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_gateway_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_gateway_title">Default Gateway</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway"  disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_gateway"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_priDNS_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_priDNS_title">Primary DNS Server</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_priDNS"  disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_primary_dns"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_secDNS_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_secDNS_title">Secondary DNS Server</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_secDNS"  disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_secondary_dns"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <!-- ================= PPPOE Mode ================= -->
  <table id="pppoe" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wPppoeMode">PPPoE Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoeUser">User Name</td>
        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=31 style="width:200px;" value="<% getCfgGeneral(1, "user_pppoe_username"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoePassword">Password</td>
        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=31 style="width:200px;" value="<% getCfgGeneral(1, "user_pppoe_passowrd"); %>" >
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoeCon_status_title">State</td>
        <td class="tabal_right" id="wPppoeCon_status">&nbsp;</td>
      </tr>
      <tr id="wPppoeCon_ip_tr">
        <td class="tabal_left" width="25%" id="wPppoeCon_ip_title">IP Address</td>
        <td class="tabal_right"><input type="text" id="wPppoeCon_ip" disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_ipaddr"); %>">
        </td>
      </tr>
      <tr id="wPppoeCon_mask_tr">
        <td class="tabal_left" width="25%" id="wPppoeCon_mask_title">Subnet Mask</td>
        <td class="tabal_right"><input type="text" id="wPppoeCon_mask" disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_netmask"); %>">
        </td>
      </tr>
      <tr id="wPppoeCon_gateway_tr">
        <td class="tabal_left" width="25%" id="wPppoeCon_gateway_title">Default Gateway</td>
        <td class="tabal_right"><input type="text" id="wPppoeCon_gateway" disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_gateway"); %>">
        </td>
      </tr>
      <tr id="wPppoeCon_priDNS_tr">
        <td class="tabal_left" width="25%" id="wPppoeCon_priDNS_title">Primary DNS Server</td>
        <td class="tabal_right"><input type="text" id="wPppoeCon_priDNS" disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_primary_dns"); %>">
        </td>
      </tr>
      <tr id="wPppoeCon_secDNS_tr">
        <td class="tabal_left" width="25%" id="wPppoeCon_secDNS_title">Secondary DNS Server</td>
        <td class="tabal_right"><input type="text" id="wPppoeCon_secDNS" disabled="disabled" style="width:200px;" value="<% getCfgGeneral(1, "wan_secondary_dns"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="Apply" type="submit" id="ddns_apply">
          <input class="submit" name="cancel" onClick="window.location.reload();" value="Cancel" id="ddns_cancel" type="reset">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
