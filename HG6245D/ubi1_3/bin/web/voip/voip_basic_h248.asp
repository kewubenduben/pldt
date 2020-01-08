<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Voip_basic_H248</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

/*  加入用户是否LOGIN的检查end*/
var voipBasicH248Sync = '<% voipBasicH248Sync(); %>';
var device_type = '<% getCfgGeneral(1, "device_type");%>';

function initTranslation()
{
	var e = document.getElementById("voipbasic_prompt");
	e.innerHTML = _("voipbasic_prompt");

	e = document.getElementById("protocol_title");
	e.innerHTML = _("protocol_title");
	e = document.getElementById("basic_title");
	e.innerHTML = _("basic_title");
	e = document.getElementById("mgc1_title");
	e.innerHTML = _("mgc1_title");
	e = document.getElementById("mgcport1_title");
	e.innerHTML = _("mgcport1_title");
	e = document.getElementById("mgc2_title");
	e.innerHTML = _("mgc2_title");
	e = document.getElementById("mgcport2_title");
	e.innerHTML = _("mgcport2_title");
	e = document.getElementById("mgport_title");
	e.innerHTML = _("mgport_title");
	
	e = document.getElementById("address1_tip");
	e.innerHTML = _("address_tip");
	e = document.getElementById("address2_tip");
	e.innerHTML = _("address_tip");
	e = document.getElementById("cvlan_p_title");
	e.innerHTML = _("cvlan_p_title");

	e = document.getElementById("svlan_p_title");
	e.innerHTML = _("svlan_p_title");
	e = document.getElementById("fristdns_title");
	e.innerHTML = _("fristdns_title");
	e = document.getElementById("secdns_title");
	e.innerHTML = _("secdns_title");
	e = document.getElementById("fill_title1");
	e.innerHTML = _("fill_title");
	e = document.getElementById("fill_title2");
	e.innerHTML = _("fill_title");
	e = document.getElementById("nofill_title1");
	e.innerHTML = _("nofill_title");
	e = document.getElementById("nofill_title2");
	e.innerHTML = _("nofill_title");
	
	e = document.getElementById("mg_title");
	e.innerHTML = _("mg_title");
	e = document.getElementById("mg_type_title");
	e.innerHTML = _("mg_type_title");

	e = document.getElementById("rtpendpointnamerule_title");
	e.innerHTML = _("rtpendpointnamerule_title");
	e = document.getElementById("rtpendpointstart_title");
	e.innerHTML = _("prefix_title");
	e = document.getElementById("rtpendpointnumleng_title");
	e.innerHTML = _("rtpendpointnumleng_title");
	e = document.getElementById("rtpendpointalign_title");
	e.innerHTML = _("rtpendpointalign_title");
	e = document.getElementById("rtpendpointnumval_title");
	e.innerHTML = _("rtpendpointnumval_title");

	e = document.getElementById("phy_endpointnamerule_title");
	e.innerHTML = _("phy_endpointnamerule_title");
	e = document.getElementById("phy_endpointstart_title");
	e.innerHTML = _("prefix_title");
	e = document.getElementById("phy_endpointnumleng_title");
	e.innerHTML = _("rtpendpointnumleng_title");
	e = document.getElementById("phy_endpointalign_title");
	e.innerHTML = _("rtpendpointalign_title");
	e = document.getElementById("phy_endpointnumval_title");
	e.innerHTML = _("rtpendpointnumval_title");	

	e = document.getElementById("wConnectionType");
	e.innerHTML = _("wConnectionType");
	e = document.getElementById("wStaticMode");
	e.innerHTML = _("wStaticMode");
	e = document.getElementById("wStaticNetmask");
	e.innerHTML = _("wNetmask");
	e = document.getElementById("wStaticGateway");
	e.innerHTML = _("wGateway");

	e = document.getElementById("wDhcpMode");
	e.innerHTML = _("wDhcpMode");
	e = document.getElementById("wDhcpCon_mask_title");
	e.innerHTML = _("wNetmask");
	e = document.getElementById("wDhcpCon_gateway_title");
	e.innerHTML = _("wGateway");

	e = document.getElementById("wpppoeMode");
	e.innerHTML = _("wpppoeMode");
	e = document.getElementById("wPppoeUser");
	e.innerHTML = _("wPppoeUser");
	e = document.getElementById("wPppoeCon_userTips");
	e.innerHTML = _("wPppoeCon_userTips");
	e = document.getElementById("wPppoePassword");
	e.innerHTML = _("wPppoePassword");
	e = document.getElementById("wPppoeCon_pwdTips");
	e.innerHTML = _("wPppoeCon_pwdTips");
	
	e = document.getElementById("wpppCon_mask_title");
	e.innerHTML = _("wNetmask");
	e = document.getElementById("wpppCon_gateway_title");
	e.innerHTML = _("wGateway");
	
	e = document.getElementById("voip_apply");
	e.value = _("voip_apply");
	e = document.getElementById("voip_cancel");
	e.value = _("voip_cancel");

}

function LoadFrame()
{
	initTranslation();

	clearZeroInputValue("voip_priMGCPort");
	clearZeroInputValue("voip_secMGCPort");

	var voip_mgRegModeData = '<% getCfgGeneral(1, "voip_mgRegMode");%>';
	var voip_mgRegModeNode = document.getElementById("voip_mgRegMode");	
	for(var i = 0; i < voip_mgRegModeNode.length; i++)
	{
		if(voip_mgRegModeNode.options[i].value == voip_mgRegModeData)
		{
			voip_mgRegModeNode.options[i].selected = true;
			break;
		}
	}
	MgRegModeSwitch();

	var voiprtpendpointalign = "<% getCfgGeneral(1, "voiprtpendpointalign"); %>";
	var voiprtpendpointalignNode = document.getElementById("voiprtpendpointalign");
	for(var i = 0; i< voiprtpendpointalignNode.length; i++)
	{	
		if(voiprtpendpointalignNode.options[i].value == voiprtpendpointalign)
		{
			voiprtpendpointalignNode.options[i].selected = true;
			break;
		}
	}

	var voipphy_endpointalign = "<% getCfgGeneral(1, "voipphy_endpointalign"); %>";
	var voipphy_endpointalignNode = document.getElementById("voipphy_endpointalign");
	for(var i = 0; i< voipphy_endpointalignNode.length; i++)
	{	
		if(voipphy_endpointalignNode.options[i].value == voipphy_endpointalign)
		{
			voipphy_endpointalignNode.options[i].selected = true;
			break;
		}
	}

	var voip_ipmode = '<% getCfgGeneral(1, "voip_ipmode");%>';
	if(device_type == 0)	/*SFU 设备*/
	{
		setDisplay("VoipIPModel", "");//仅SFU时需要配置
		
		var voip_ipModel = document.getElementById("ipModel");	
		for(var i = 0; i < voip_ipModel.length; i++)
		{
			if(voip_ipModel.options[i].value == voip_ipmode)
			{
				voip_ipModel.options[i].selected = true;
				break;
			}
		}	
		connectionTypeSwitch();
	}
	else /*HGU设备ip获取方式从wan页面配合*/
	{
		setDisplay("VoipIPModel", "none");
		setDisplay("static", "none");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "none");
	}
	
}

function MgRegModeSwitch()
{
	var mgRegModeNode =  document.getElementById("voip_mgRegMode");
	var voip_mgIdNode = getElement("voip_mgId");
	if (mgRegModeNode.options.selectedIndex == 0)	//IP
	{
		voip_mgIdNode.readOnly = true;
	}
	else 
	{		
		voip_mgIdNode.readOnly = false;
	}
}

function connectionTypeSwitch()
{
	var IpMode = document.getElementById("ipModel");
	if (IpMode.options.selectedIndex == 0) 
	{
		setDisplay("static", "");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "none");
	}
	else if(IpMode.options.selectedIndex == 1)
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
function CheckForm()
{	
	var field;
	
	var voip_priMGCNode = document.getElementById("voip_priMGC");
	if(!CheckNotNull(voip_priMGCNode.value))
	{
		//alert("主MGC地址不能为空!");
		alert(_("Please input first MGC address."));
		voip_priMGCNode.value = voip_priMGCNode.defaultValue;
		voip_priMGCNode.focus();
		return false;
	}
	else if(!checkVoipServer(voip_priMGCNode.value))
	{
		//alert("主MGC地址非法!");
		alert(_("First MGC adress is illegal."));
		voip_priMGCNode.value = voip_priMGCNode.defaultValue;
		voip_priMGCNode.focus();
		return false;
	}
	
	var voip_priMGCPortNode = document.getElementById("voip_priMGCPort");
	if(!CheckNotNull(voip_priMGCPortNode.value))
	{
		//alert("主MGC端口号不能为空!");
		alert(_("Please input first MGC port."));
		voip_priMGCPortNode.value = voip_priMGCPortNode.defaultValue;
		voip_priMGCPortNode.focus();
		return false;
	}
	else if(!checkVoipServerPort(voip_priMGCPortNode.value))
	{
		//alert("主MGC端口号非法!");
		alert(_("First MGC port illegal."));
		voip_priMGCPortNode.value = voip_priMGCPortNode.defaultValue;
		voip_priMGCPortNode.focus();
		return false;
	}
	
	var voip_secMGCNode = document.getElementById("voip_secMGC");
	if(!checkVoipServer(voip_secMGCNode.value))
	{
		//alert("备用MGC地址非法!");
		alert(_("Second MGC address illegal."));
		voip_secMGCNode.value = voip_secMGCNode.defaultValue;
		voip_secMGCNode.focus();
		return false;
	}
	
	var voip_secMGCPortNode = document.getElementById("voip_secMGCPort");
	if(!checkVoipServerPort(voip_secMGCPortNode.value))
	{
		//alert("备用MGC端口非法!");
		alert(_("Second MGC port illegal."));
		voip_secMGCPortNode.value = voip_secMGCPortNode.defaultValue;
		voip_secMGCPortNode.focus();
		return false;
	}
	
/*	var voip_physicalTermIdNode = document.getElementById("voip_physicalTermId");
	if(!CheckNotNull(voip_physicalTermIdNode.value))
	{
		alert("端点用户名不能为空!");
		voip_physicalTermIdNode.value = voip_physicalTermIdNode.defaultValue;
		voip_physicalTermIdNode.focus();
		return false;
	}*/

	/*MC本地端口*/	
	var voip_MGPortNode = document.getElementById("voip_MGPort");
	if(!CheckNotNull(voip_MGPortNode.value))
	{
		//alert("本地MG端口号不能为空!");
		alert(_("Please input MG port."));
		voip_MGPortNode.value = voip_MGPortNode.defaultValue;
		voip_MGPortNode.focus();
		return false;
	}
	else if(!checkVoipServerPort(voip_MGPortNode.value))
	{
		//alert("本地MG端口号非法!");
		alert(_("MG port is illegal."));
		voip_MGPortNode.value = voip_MGPortNode.defaultValue;
		voip_MGPortNode.focus();
		return false;
	}
	
	/* validate voiprtpendpointstart */
	field = document.getElementById("voiprtpendpointstart");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入RTP终结点命名规则前缀!");
		alert(_("alert_voiprtpendpointstart"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* validate voiprtpendpointnumleng */
	field = document.getElementById("voiprtpendpointnumleng");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入RTP终结点命名规则数字部分长度!");
		alert(_("alert_voiprtpendpointnumleng"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 5))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

	/* validate voiprtp_tid
	field = document.getElementById("voiprtp_tid");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					
		//alert("请输入RTP TID个数!");
		alert(_("alert_voiprtp_tid"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 65535))					
	{		
		field.value = field.defaultValue;
		field.focus();
		return false;
	} */
	
	/* validate voiprtpendpointnumval"); */
	field = document.getElementById("voiprtpendpointnumval");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入RTP终结点命名规则数字部分起始值!");
		alert(_("alert_voiprtpendpointnumval"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 0, 65534))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

		/* validate voiprtpendpointstart */
	field = document.getElementById("voipphy_endpointstart");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入物理终结点命名规则前缀!");
		alert(_("alert_voipphy_endpointstart"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* validate voiprtpendpointnumleng */
	field = document.getElementById("voipphy_endpointnumleng");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入物理终结点命名规则数字部分长度!");
		alert(_("alert_voipphy_endpointnumleng"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 5))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voiprtpendpointnumval"); */
	field = document.getElementById("voipphy_endpointnumval");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入物理终结点命名规则数字部分起始值!");
		alert(_("alert_voipphy_endpointnumval"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 0, 65534))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

	if(device_type == 0)	/*SFU 设备*/
	{
		var voip_mgRegModeNode = document.getElementById("voip_mgRegMode");
		var ipModelNode = document.getElementById("ipModel");
		var staticIpNode = document.getElementById("staticIp");
		var staticNetmaskNode = document.getElementById("staticNetmask");
		var staticGatewayNode = document.getElementById("staticGateway");
		//var rtp_staticIpNode = document.getElementById("rtp_staticIp");
		//var rtp_staticNetmaskNode = document.getElementById("rtp_staticNetmask");
		//var rtp_staticGatewayNode = document.getElementById("rtp_staticGateway");
		var pppoeUserNode = document.getElementById("pppoeUser");
		var pppoePassNode = document.getElementById("pppoePass");

		/*cvlan id*/	
		var vlan_idnode = document.getElementById("vlanId");
		if(!CheckNotNull(vlan_idnode.value))
		{
			//alert("valn 不能为空!");
			alert(_("Please input VLAN."));
			vlan_idnode.value = vlan_idnode.defaultValue;
			vlan_idnode.focus();
			return false;
		}
		else if(!VIDLegal(vlan_idnode.value))
		{
			//alert("valn 非法!");
			alert(_("VLAN is illegal."));
			vlan_idnode.value = vlan_idnode.defaultValue;
			vlan_idnode.focus();
			return false;
		}

		/*cvlan priority*/	
		var prioritynode = document.getElementById("valn_priority");
		if(!CheckNotNull(prioritynode.value))
		{
			//alert("valn 优先级不能为空!");
			alert(_("Please input priority."));
			prioritynode.value = prioritynode.defaultValue;
			prioritynode.focus();
			return false;
		}
		else if(!checkvalnpriority(prioritynode.value))
		{
			//alert("valn 优先级非法!");
			alert(_("Priority is illegal."));
			prioritynode.value = prioritynode.defaultValue;
			prioritynode.focus();
			return false;
		}
		/*svlan id*/	
		var svlan_idnode = document.getElementById("svlanId");
		if(!VIDLegal(svlan_idnode.value))
		{
			//alert("valn 非法!");
			alert(_("VLAN is illegal."));
			svlan_idnode.value = svlan_idnode.defaultValue;
			svlan_idnode.focus();
			return false;
		}

		/*svlan priority*/	
		var sprioritynode = document.getElementById("svaln_priority");
		if(!checkvalnpriority(sprioritynode.value))
		{
			//alert("valn 优先级非法!");
			alert(_("Priority is illegal."));
			sprioritynode.value = sprioritynode.defaultValue;
			sprioritynode.focus();
			return false;
		}
		

		if (ipModelNode.options.selectedIndex == 0)
		{
			if(!CheckNotNull(staticIpNode.value))
			{
				//alert("IP不能为空!");
				alert(_("Please input IP."));
				staticIpNode.value = staticIpNode.defaultValue;
				staticIpNode.focus();
				return false;
			}
			else
			{
				if(!validateIP(staticIpNode.value))
				{
					//alert("IP输入非法");
					alert(_("IP is illegal."));
					staticIpNode.value = staticIpNode.defaultValue;
					staticIpNode.focus();
					return false;
				}
			}

			if(!CheckNotNull(staticNetmaskNode.value))
			{
				//alert("子网掩码不能为空!");
				alert(_("Please input netmask."));
				staticNetmaskNode.value = staticNetmaskNode.defaultValue;
				staticNetmaskNode.focus();
				return false;
			}
			else
			{
				if(!validateMask(staticNetmaskNode.value))
				{
					alert(_("Netmask is illegal."));
					//alert("子网掩码输入非法。");
					staticNetmaskNode.value = staticNetmaskNode.defaultValue;
					staticNetmaskNode.focus();
					return false;
				}
			}

			if(!CheckNotNull(staticGatewayNode.value))
			{
				//alert("网关不能为空!");
				alert(_("Please input gateway."));
				staticGatewayNode.value = staticGatewayNode.defaultValue;
				staticGatewayNode.focus();
				return false;
			}
			else
			{
				if(!validateIP(staticGatewayNode.value))
				{
					//alert("网关输入非法");
					alert(_("Gateway is illegal."));
					staticGatewayNode.value = staticGatewayNode.defaultValue;
					staticGatewayNode.focus();
					return false;
				}
			}

		}
		else if(ipModelNode.options.selectedIndex == 2)
		{
			if(!CheckNotNull(pppoeUserNode.value))
			{
				//alert("PPPOE用户名不能为空!");
				alert(_("Please input PPPOE username."));
				pppoeUserNode.value = pppoeUserNode.defaultValue;
				pppoeUserNode.focus();
				return false;
			}
			if(!CheckNotNull(pppoePassNode.value))
			{
				//alert("PPPOE用户名不能为空!");
				alert(_("Please input PPPOE password."));
				pppoePassNode.value = pppoePassNode.defaultValue;
				pppoePassNode.focus();
				return false;
			}

		}
	}
		
	return true;
}

function checkVoipServer(str)
{
	if(str != "")				//IP地址或域名
	{
		if(!validateIP(str) && !validateURL(str))
		{
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}

function checkVoipServerPort(str)
{
	if(str != "")				//数字 [0, 65535]
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			if((1024 <= parseInt(str)) && (parseInt(str) <= 65535))
			{
				return true;
			}
			else
			{
				return false; 
			}
		}
	}
	return true;
}

function checkvalnpriority(str)
{
	if(str != "")				//数字 [0, 65535]
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			if((0 <= parseInt(str)) && (parseInt(str) <= 7))
			{
				return true;
			}
			else
			{
				return false; 
			}
		}
	}
	return true;
}

function VIDLegal(str)
{
	if(str != "")				//数字 [0, 65535]
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			if((1 <= parseInt(str)) && (parseInt(str) <= 4095))
			{
				return true;
			}
			else
			{
				return false; 
			}
		}
	}
	return true;
}

</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="voipbasic_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="voip_basic_form" action="/goform/voipBasicH248" onSubmit="return CheckForm()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td id="basic_title" class="tabal_head">VoIP Basic Param</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td id="protocol_title" class="tabal_left" width="25%">VoIP Protocol</td>
        <td class="tabal_right" width="75%">H.248</td>
      </tr>
      <tr>
        <td id="mgc1_title" class="tabal_left" width="25%">Primary MGC Address</td>
        <td class="tabal_right" width="75%"><input name="voip_priMGC" id="voip_priMGC" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_priMGC"); %>">
          <strong style="color:#FF0033">*</strong><span id="address1_tip" class="gray">((IP or Domain)</span></td>
      </tr>
      <tr>
        <td id="mgcport1_title" class="tabal_left" width="25%">Primary MGC Port</td>
        <td class="tabal_right"><input name="voip_priMGCPort" id="voip_priMGCPort" size="15" maxlength="5" type="text" value="<% getCfgGeneral(1, "voip_priMGCPort"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1024-65535)</span></td>
      </tr>
      <tr>
        <td id="mgc2_title" class="tabal_left" width="25%">Standby MGC Address</td>
        <td class="tabal_right"><input name="voip_secMGC" id="voip_secMGC" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_secMGC"); %>">
          <span id="address2_tip" class="gray">(IP or Domain)</span></td>
        </td>
      </tr>
      <tr>
        <td id="mgcport2_title"  class="tabal_left" width="25%">Standby MGC Port</td>
        <td class="tabal_right"><input name="voip_secMGCPort" id="voip_secMGCPort" size="15" maxlength="5" type="text" value="<% getCfgGeneral(1, "voip_secMGCPort"); %>">
          <span class="gray">(1024-65535)</span></td>
      </tr>
      <tr>
        <td id="mgport_title" class="tabal_left" width="25%">Local MG port</td>
        <td class="tabal_right"><input name="voip_MGPort" id="voip_MGPort" size="15" maxlength="5" type="text" value="<% getCfgGeneral(1, "MG_port"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1024-65535)</span></td>
      </tr>
      <!--tr>
	        <td class="tabal_left" width="25%">端点用户名:</td>
	        <td class="tabal_right"><input name="voip_physicalTermId" id="voip_physicalTermId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_physicalTermId"); %>">
	          <strong style="color:#FF0033">*</strong></td>
	        </td>
	        </tr-->
      <tr>
        <td id="mg_type_title" class="tabal_left" width="25%">MG Marking Mode</td>
        <td class="tabal_right"><select name="voip_mgRegMode" id="voip_mgRegMode" onchange="MgRegModeSwitch()">
            <option value="0">IP</option>
            <option value="1" selected="selected">Domain</option>
            <option value="2">Device</option>
          </select></td>
        </td>
      </tr>
      <tr>
        <td id="mg_title" class="tabal_left" width="25%">MG Marking</td>
        <td class="tabal_right"><input name="voip_mgId" id="voip_mgId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_mgId"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="rtpendpointnamerule_title" align="left" width="25%">RTP End Point Name</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"></td>
      <tr>
        <td class="tabal_left" id="rtpendpointstart_title" align="left" width="25%">Prefix</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voiprtpendpointstart" id="voiprtpendpointstart" size="30" maxlength="15" value="<% getCfgGeneral(1, "voiprtpendpointstart"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="rtpendpointnumleng_title" align="left" width="25%">Digital Part Length</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voiprtpendpointnumleng" id="voiprtpendpointnumleng" size="30" maxlength="1" value="<% getCfgGeneral(1, "voiprtpendpointnumleng"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1-5)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="rtpendpointalign_title" align="left" width="25%">Alignment Mode</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><select name="voiprtpendpointalign" id="voiprtpendpointalign" size="1" style="width:182px;">
            <option id="fill_title1" value="0">Fill</option>
            <option id="nofill_title1" value="1">Not Fill</option>
          </select>
          &nbsp; &nbsp; </td>
      </tr>
      <tr>
        <td class="tabal_left" id="rtpendpointnumval_title" align="left" width="25%">Digital Part Initial Value</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voiprtpendpointnumval" id="voiprtpendpointnumval" size="30" maxlength="5" value="<% getCfgGeneral(1, "voiprtpendpointnumval"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0-65534)</span></td>
      </tr>
      <!--tr>
        <td class="tabal_left" id="voiprtp_tid_title" align="left" width="25%">&nbsp; &nbsp;&nbsp; &nbsp;RTP TID个数:</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voiprtp_tid" id="voiprtp_tid" size="30" maxlength="5" value="<% getCfgGeneral(1, "voiprtp_tid"); %>">
          &nbsp; &nbsp; 设置范围: 1~65535 </td>
	  <tr-->
      <tr>
        <td class="tabal_left" id="phy_endpointnamerule_title" align="left" width="25%">Physics End Point Name</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"></td>
      <tr>
        <td class="tabal_left" id="phy_endpointstart_title" align="left" width="25%">Prefix</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voipphy_endpointstart" id="voipphy_endpointstart" size="30" maxlength="15" value="<% getCfgGeneral(1, "voipphy_endpointstart"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="phy_endpointnumleng_title" align="left" width="25%">Digital Part Length</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voipphy_endpointnumleng" id="voipphy_endpointnumleng" size="30" maxlength="1" value="<% getCfgGeneral(1, "voipphy_endpointnumleng"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1-5)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="phy_endpointalign_title" align="left" width="25%">Alignment Mode</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><select name="voipphy_endpointalign" id="voipphy_endpointalign" size="1" style="width:182px;">
            <option id="fill_title2" value="0">Fill</option>
            <option id="nofill_title2" value="1">Not Fill</option>
          </select>
          &nbsp; &nbsp; </td>
      </tr>
      <tr>
        <td class="tabal_left" id="phy_endpointnumval_title" align="left" width="25%">Digital Part Initial Value</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="voipphy_endpointnumval" id="voipphy_endpointnumval" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipphy_endpointnumval"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0-65534)</span></td>
      <tr>
    </tbody>
  </table>
  <table id="VoipIPModel" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%">CVLAN ID</td>
        <td class="tabal_right"><input name="vlanId" id="vlanId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "vlanid"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1-4095)</span></td>
        </td>
      </tr>
      <tr>
        <td id="cvlan_p_title" class="tabal_left" width="25%">CVLAN Priority</td>
        <td class="tabal_right"><input name="valn_priority" id="valn_priority" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "vlan_priority"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0-7)</span></td>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%">SVLAN ID</td>
        <td class="tabal_right"><input name="svlanId" id="svlanId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "svlanid"); %>">
          <span class="gray">(1-4095)</span></td>
        </td>
      </tr>
      <tr>
        <td id="svlan_p_title" class="tabal_left" width="25%">SVLAN Priority</td>
        <td class="tabal_right"><input name="svaln_priority" id="svaln_priority" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "svlan_priority"); %>">
          <span class="gray">(0-7)</span></td>
        </td>
      </tr>
      <tr>
        <td id="fristdns_title" class="tabal_left" width="25%">Primary DNS Address</td>
        <td class="tabal_right"><input name="voip_dns1" id="voip_dns1" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_dns1"); %>">
        </td>
      </tr>
      <tr>
        <td id="secdns_title" class="tabal_left" width="25%">Standby DNS Address</td>
        <td class="tabal_right"><input name="voip_dns2" id="voip_dns2" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_dns2"); %>">
        </td>
      </tr>
      <tr>
        <td width="25%" class="tabal_left" id="wConnectionType">IP Mode</td>
        <td class="tabal_right"><select name="ipModel" id="ipModel" size="1" style="width:200px;" onChange="connectionTypeSwitch();">
            <option value="0">STATIC</option>
            <option value="1" selected="selected">DHCP</option>
            <option value="2">PPPoE</option>
          </select>
        </td>
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
  <table id="static" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wStaticMode">STATIC Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wStaticIp">IP</td>
        <td class="tabal_right"><input name="staticIp" id="staticIp" maxlength=15 size=32 value="<% getCfgGeneral(1, "voip_ip"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticNetmask">Netmask</td>
        <td class="tabal_right"><input name="staticNetmask" id="staticNetmask" maxlength=15 size=32 value="<% getCfgGeneral(1, "voip_mask"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticGateway">Gateway</td>
        <td class="tabal_right"><input name="staticGateway" id="staticGateway" maxlength=15 size=32
	  		value="<% getCfgGeneral(1, "voip_gateway"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <!-- ================= DHCP Mode ================= -->
  <table id="dhcp" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wDhcpMode">DHCP Mode</td>
      </tr>
      <tr id="wDhcpCon_ip_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_ip_title">IP</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_ip"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_mask_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_mask_title">Netmask</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_mask"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_gateway_tr">
        <td class="tabal_left" width="25%" id="wDhcpCon_gateway_title">Gateway</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_gateway"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <!-- ================= PPPOE Mode ================= -->
  <table id="pppoe" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%"  style="display: none;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wpppoeMode">PPPoE Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoeUser">Username</td>
        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=32 style="width:320px;" value="<% getCfgGeneral(1, "pppoe_username"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips">(You can input 1-32 characters)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoePassword">Password</td>
        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=32 style="width:320px;" value="<% getCfgGeneral(1, "pppoe_password"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips">(You can input 1-32 characters)</span></td>
      </tr>
      <tr id="wDhcpCon_ip_tr">
        <td class="tabal_left" width="25%" id="wpppCon_ip_title">IP</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_ip"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_mask_tr">
        <td class="tabal_left" width="25%" id="wpppCon_mask_title">Netmask</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_mask"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_gateway_tr">
        <td class="tabal_left" width="25%" id="wpppCon_gateway_title">Gateway</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_gateway"); %>">
        </td>
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
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" id="voip_apply" type="submit">
          <input class="submit" id="voip_cancel" onclick="window.location.reload();" type="reset">
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
