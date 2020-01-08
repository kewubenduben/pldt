<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Local Area Network (LAN) Settings</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

//jianglei add for get init value from driver
var jl2 = '<% setLanSync(); %>';

var ispUserCode =  '<% getCfgGeneral(1, "ispUserCode"); %>';
var idisplay_v6_flag = '<% getCfgGeneral(1, "idisplay_v6_flag"); %>';

var dhcpServiceSync = '<% dhcpServiceSync(); %>';
var optionenbale = '<% getCfgGeneral(1, "option_60enable_s"); %>';
var option125enbale = '<% getCfgGeneral(1, "option_125enable"); %>';

/* delete begin by 吴小娟, 20110626, 原因: 删除未使用的方法、变量*/
/* modify begin by 吴小娟, 20110711, 原因: 增加语句末尾的分号*/
var secs;
var timerID = null;
var timerRunning = false;
function StartTheTimer(){
	if (secs==0){
		TimeoutReload(5);
		//window.location.reload();
		window.location.href=window.location.href;	//reload page
    }else{
        self.status = secs;
        secs = secs - 1;
        timerRunning = true;
        timerID = self.setTimeout("StartTheTimer()", 1000);
    }
}

function TimeoutReload(timeout)
{
	secs = timeout;
	if(timerRunning)
		clearTimeout(timerID);
	timerRunning = false;
	StartTheTimer();	
}
/* modify end by 吴小娟, 20110711 */

function PrefixModeSwitch()
{
	if (document.lanCfg.Prefix_Mode.options.selectedIndex == 1)
	{
		setDisplay("v6_prefixSet", "");
	}
	else
	{
		setDisplay("v6_prefixSet", "none");
	}
}

function dnsModeSwitch()
{
	if (document.lanCfg.dns_srouce.options.selectedIndex == 1)
	{
		setDisplay("v6_dnsServer1", "");
		setDisplay("v6_dnsServer2", "");
	}
	else
	{
		setDisplay("v6_dnsServer1", "none");
		setDisplay("v6_dnsServer2", "none");
	}
}

function option60TypeSwitch()		
{

	if (document.lanCfg.option_60enable_s.options.selectedIndex == 0)
	{
		document.getElementById("option_start").style.visibility = "hidden";
		document.getElementById("option_start").style.display = "none";
		document.lanCfg.option60Start.disabled = true;
		document.getElementById("option_end").style.visibility = "hidden";
		document.getElementById("option_end").style.display = "none";
		document.lanCfg.option60End.disabled = true;
	}
	else
	{
		document.getElementById("option_start").style.visibility = "visible";
		document.getElementById("option_start").style.display = style_display_on();
		document.lanCfg.option60Start.disabled = false;
		document.getElementById("option_end").style.visibility = "visible";
		document.getElementById("option_end").style.display = style_display_on();
		document.lanCfg.option60End.disabled = false;
	}
}

function option125TypeSwitch()
{
	if (document.lanCfg.option_125enable_s.options.selectedIndex == 0)
	{
		setDisplay("option125_text_id", "none");
	}
	else
	{
		setDisplay("option125_text_id", "");
	}

}

function dhcpTypeSwitch()
{
	document.getElementById("start").style.visibility = "hidden";
	document.getElementById("start").style.display = "none";
	document.lanCfg.dhcpStart.disabled = true;
	document.getElementById("end").style.visibility = "hidden";
	document.getElementById("end").style.display = "none";
	document.lanCfg.dhcpEnd.disabled = true;
	document.getElementById("mask").style.visibility = "hidden";
	document.getElementById("mask").style.display = "none";
	document.lanCfg.dhcpMask.disabled = true;
	document.getElementById("pridns").style.visibility = "hidden";
	document.getElementById("pridns").style.display = "none";
	document.lanCfg.dhcpPriDns.disabled = true;
	document.getElementById("secdns").style.visibility = "hidden";
	document.getElementById("secdns").style.display = "none";
	document.lanCfg.dhcpSecDns.disabled = true;
	document.getElementById("gateway").style.visibility = "hidden";
	document.getElementById("gateway").style.display = "none";
	document.lanCfg.dhcpGateway.disabled = true;
	document.getElementById("option_60enable").style.visibility = "hidden";
	document.getElementById("option_60enable").style.display = "none";
	document.lanCfg.option_60enable_s.disabled = true;
	document.getElementById("option_start").style.visibility = "hidden";
	document.getElementById("option_start").style.display = "none";
	document.lanCfg.option60Start.disabled = true;
	document.getElementById("option_end").style.visibility = "hidden";
	document.getElementById("option_end").style.display = "none";
	document.lanCfg.option60End.disabled = true;

	document.getElementById("dhcp_time").style.visibility = "hidden";
	document.getElementById("dhcp_time").style.display = "none";

	setDisplay("option_125enable", "none");
	setDisplay("option125_text_id", "none");
	setDisplay("dhcp_agent_id", "none");

	/*setDisplay("div_dhcpServer", "none");*/
	if (document.lanCfg.dhcpType.options.selectedIndex == 1)
	{	
		document.getElementById("start").style.visibility = "visible";
		document.getElementById("start").style.display = style_display_on();
		document.lanCfg.dhcpStart.disabled = false;
		document.getElementById("end").style.visibility = "visible";
		document.getElementById("end").style.display = style_display_on();
		document.lanCfg.dhcpEnd.disabled = false;
		document.getElementById("mask").style.visibility = "visible";
		document.getElementById("mask").style.display = style_display_on();
		document.lanCfg.dhcpMask.disabled = false;
		document.getElementById("pridns").style.visibility = "visible";
		document.getElementById("pridns").style.display = style_display_on();
		document.lanCfg.dhcpPriDns.disabled = false;
		document.getElementById("secdns").style.visibility = "visible";
		document.getElementById("secdns").style.display = style_display_on();
		document.lanCfg.dhcpSecDns.disabled = false;
		document.getElementById("gateway").style.visibility = "visible";
		document.getElementById("gateway").style.display = style_display_on();
		document.lanCfg.dhcpGateway.disabled = false;

		document.getElementById("dhcp_time").style.visibility = "visible";
		document.getElementById("dhcp_time").style.display = style_display_on();		
		
		document.getElementById("option_60enable").style.visibility = "visible";
		document.getElementById("option_60enable").style.display = style_display_on();
		document.lanCfg.option_60enable_s.disabled = false;
		option60TypeSwitch();
		if(ispNameCode == 15)/*globe*/
		{
			setDisplay("option_125enable", "");
			option125TypeSwitch();
		}
		if(ispNameCode == 9 && curUserType == 1)/*罗马尼亚普通用户*/
		{
			setDisplay("option_60enable", "");
			option60TypeSwitch();
		}
		
		/*setDisplay("div_dhcpServer", "");	*/	
	}
	else if(document.lanCfg.dhcpType.options.selectedIndex == 2) /*dhcp relay*/
	{
		setDisplay("dhcp_agent_id", "");
	}
		
}

function initTranslation()
{
	var e = document.getElementById("lan_prompt");
	e.innerHTML = _("lan_prompt");
	
	e = document.getElementById("lSetup");
	e.innerHTML = _("lan setup");
	e = document.getElementById("lHostname");
	e.innerHTML = _("inet hostname");
	e = document.getElementById("lIp");
	e.innerHTML = _("gateway_ip");
	e = document.getElementById("lNetmask");
	e.innerHTML = _("inet netmask");
	e = document.getElementById("ipv6_title");
	e.innerHTML = _("ipv6_title");
	e = document.getElementById("Managed_Flag_title");
	e.innerHTML = _("Managed_Flag_title");
	e = document.getElementById("other_Flag_title");
	e.innerHTML = _("other_Flag_title");
	e = document.getElementById("max_Interval_title");
	e.innerHTML = _("max_Interval_title");
	e = document.getElementById("min_Interval_title");
	e.innerHTML = _("min_Interval_title");
	e = document.getElementById("Prefix_Mode_title");
	e.innerHTML = _("Prefix_Mode_title");
	e = document.getElementById("enable_dhcp6s_title_title");
	e.innerHTML = _("enable_dhcp6s_title_title");

	e = document.getElementById("max_Interval_tips");
	e.innerHTML = _("max_Interval_tips");
	e = document.getElementById("min_Interval_tips");
	e.innerHTML = _("min_Interval_tips");
	e = document.getElementById("dns_source_title");
	e.innerHTML = _("dns_source_title");
	e = document.getElementById("dns_source_net_title");
	e.innerHTML = _("v6_net_title");
	e = document.getElementById("dns_source_static_title");
	e.innerHTML = _("v6_static_title");
	e = document.getElementById("dns_source_relay_title");
	e.innerHTML = _("v6_dns_relay_title");
	e = document.getElementById("prefix_net_title");
	e.innerHTML = _("v6_net_title");
	e = document.getElementById("prefix_static_title");
	e.innerHTML = _("v6_static_title");

		e = document.getElementById("first_dns_title");
	e.innerHTML = _("first_dns_title");
	e = document.getElementById("Prefix_Set_title");
	e.innerHTML = _("Prefix_Set_title");
		e = document.getElementById("sec_dns_title");
	e.innerHTML = _("sec_dns_title");
	e = document.getElementById("v6dhcpstart_title");
	e.innerHTML = _("v6dhcpstart_title");
		e = document.getElementById("v6dhcpend_title");
	e.innerHTML = _("v6dhcpend_title");
		e = document.getElementById("v6dhcpPreferTime_title");
	e.innerHTML = _("v6dhcpPreferTime_title");
		e = document.getElementById("v6dhcpValidTime_title");
	e.innerHTML = _("v6dhcpValidTime_title");
			e = document.getElementById("ipv6_static_addr_title");
	e.innerHTML = _("ipv6_static_addr_title");
				e = document.getElementById("ipv6_static_addr_tips");
	e.innerHTML = _("ipv6_static_addr_tips");
	
	e = document.getElementById("dhcp_serviceHead");
	e.innerHTML = _("dhcp_serviceHead");
	e = document.getElementById("dhcp_typeTitle");
	e.innerHTML = _("dhcp_typeTitle");
	if(ispNameCode == 9)
	{
		e = document.getElementById("dhcp_typeD");
		e.innerHTML = _("inet disable");
		e = document.getElementById("dhcp_typeS");
		e.innerHTML = _("inet enable");
	}
	else
	{
		e = document.getElementById("dhcp_typeD");
		e.innerHTML = _("inet disable");
		e = document.getElementById("dhcp_typeS");
		e.innerHTML = _("dhcp_typeS");
	}
	e = document.getElementById("dhcp_relayTitle");
	e.innerHTML = _("dhcp_relayTitle");
	e = document.getElementById("dhcp_startTitle");
	e.innerHTML = _("dhcp_startTitle");
	e = document.getElementById("dhcp_endTitle");
	e.innerHTML = _("dhcp_endTitle");
	e = document.getElementById("dhcp_netmaskTitle");
	e.innerHTML = _("dhcp_netmaskTitle");
	e = document.getElementById("dhcp_priDnsTitle");
	e.innerHTML = _("dhcp_priDnsTitle");
	e = document.getElementById("dhcp_secDnsTitle");
	e.innerHTML = _("dhcp_secDnsTitle");
	e = document.getElementById("dhcp_gatewayTitle");
	e.innerHTML = _("dhcp_gatewayTitle");
	e = document.getElementById("dhcp_timeTitle");
	e.innerHTML = _("dhcp_timeTitle");
	e = document.getElementById("dhcp_hourTitle");
	e.innerHTML = _("dhcp_hourTitle");
	e = document.getElementById("dhcp_minTitle");
	e.innerHTML = _("dhcp_minTitle");
	e = document.getElementById("dhcp_timeTips");
	e.innerHTML = _("dhcp_timeTips");
	e = document.getElementById("option125_textTitle");
	e.innerHTML = _("option125_textTitle");
	e = document.getElementById("option_60_typeD");
	e.innerHTML = _("inet disable");
	e = document.getElementById("option_60_typeS");
	e.innerHTML = _("dhcp_typeS");
	e = document.getElementById("option_125_typeD");
	e.innerHTML = _("inet disable");
	e = document.getElementById("option_125_typeS");
	e.innerHTML = _("inet enable");
	
	e = document.getElementById("option60_startTitle");
	e.innerHTML = _("option60_startTitle");
		e = document.getElementById("option60_endTitle");
	e.innerHTML = _("option60_endTitle");

	e = document.getElementById("lApply");
	e.value = _("inet apply");
	e = document.getElementById("lCancel");
	e.value = _("inet cancel");
	
}

function initValue()
{
	initTranslation();
	var opmode = <% getCfgZero(1, "OperationMode"); %>;

	var managed_flag = '<% getCfgGeneral(1, "managed_flag"); %>';
	var Managed_Flag_id = document.getElementById("Managed_Flag");
	var other_flag = '<% getCfgGeneral(1, "other_flag"); %>';
	var other_Flag_id = document.getElementById("other_Flag");
	var enable_dhcp6s = '<% getCfgGeneral(1, "enable_dhcp6s"); %>';
	var enable_dhcp6s_id = document.getElementById("enable_dhcp6s");
	var Prefix_Mode = '<% getCfgGeneral(1, "Prefix_Mode"); %>';
	var Prefix_Mode_id = document.getElementById("Prefix_Mode");
	var v6dns_Mode = '<% getCfgGeneral(1, "dns_srouce"); %>';
	var v6dns_Mode_id = document.getElementById("dns_srouce");

	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
	
    if(ispUserCode == "X_CT_CQYT")
    {
		setDisplay("ipv6_cfg_table", "none");
    }
    else
    {
    	if(idisplay_v6_flag == '' || parseInt(idisplay_v6_flag) == 0)
    	{
    		setDisplay("ipv6_cfg_table", "none");
    	}
    	else
    	{
    		setDisplay("ipv6_cfg_table", "");
    	}
    }

	if(ispNameCode == 9 && curUserType == 1) /*罗马尼亚版本普通用户*/
	{
		setDisplay("ipv6_cfg_table", "none");
	}        
	if(ispNameCode == '22')//THAILAND_TRUE
	{
		setDisplay('tr_v6dhcpPreferTime', '');
		setDisplay('tr_v6dhcpValidTime', '');
	}
	if(ispNameCode == '4' && DEV_TYPE == '01A9G')	//TH_3BB 01A9G
	{		
		setDisplay('tb_submit', 'none');
		getElement('lanIp').disabled = 1;
		getElement('lanNetmask').disabled = 1;
	}
	if(managed_flag == 1 )
	{
		Managed_Flag_id.checked = true;
	}
	else
	{
		Managed_Flag_id.checked = false;
	}

	if(other_flag == 1 )
	{
		other_Flag_id.checked = true;
	}
	else
	{
		other_Flag_id.checked = false;
	}

	if(enable_dhcp6s == 1 )
	{
		enable_dhcp6s_id.checked = true;
	}
	else
	{
		enable_dhcp6s_id.checked = false;
	}
	clickEnableDHCP6s();

	for(var i = 0; i< Prefix_Mode_id.length; i++)
	{
		if(Prefix_Mode_id.options[i].value == Prefix_Mode )
		{
			Prefix_Mode_id.options[i].selected = true;
			break;
		}
	}

	for(var i = 0; i< v6dns_Mode_id.length; i++)
	{
		if(v6dns_Mode_id.options[i].value == v6dns_Mode )
		{
			v6dns_Mode_id.options[i].selected = true;
			break;
		}
	}
	PrefixModeSwitch();
	dnsModeSwitch();

	if (opmode != "0") {
		document.getElementById("brGateway").style.visibility = "hidden";
		document.getElementById("brGateway").style.display = "none";
		document.getElementById("brPriDns").style.visibility = "hidden";
		document.getElementById("brPriDns").style.display = "none";
		document.getElementById("brSecDns").style.visibility = "hidden";
		document.getElementById("brSecDns").style.display = "none";
	}

	var dhcp = <% getCfgZero(1, "dhcpEnabled"); %>;
	var optionvalue = getElementByName("option_60enable_s");
	var option125value = getElementByName("option_125enable_s");
	var dhcp_node = document.getElementById("dhcpType");
	
	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
	
	if(ispNameCode == 15)/*globe*/
	{
		dhcp_node.options[dhcp_node.length] = new Option("DHCP Relay", "2");
	}
	
	document.lanCfg.dhcpType.options.selectedIndex = 1 * dhcp;
	optionvalue.options.selectedIndex = 1 * optionenbale;
	option125value.options.selectedIndex = 1 * option125enbale;

	/*jianglei 初始化时显示或隐藏DHCP配置数据*/
	dhcpTypeSwitch();
	
	if(ispNameCode == '4' && DEV_TYPE == '01A9G')	//TH_3BB 01A9G
	{		
		setDisplay('tb_submit', 'none');
		setDisplay('tr_dhcptype', 'none');
		setDisplay('dhcp_agent_id', 'none');
		setDisplay('pridns', 'none');
		setDisplay('secdns', 'none');
		setDisplay('option_60enable', 'none');
		
		getElement('dhcpStart').disabled = 1;
		getElement('dhcpEnd').disabled = 1;
		getElement('dhcpMask').disabled = 1;
		getElement('dhcpGateway').disabled = 1;
		getElement('dhcptime').disabled = 1;
		getElement('dhcptime_m').disabled = 1;
	}
	
	/*处理读写失败提示*/
 	dealLanFailedHandle();
}
/* delete end by 吴小娟, 20110626 */

function checkIpAddr(field, ismask)
{
	/* modify begin by 吴小娟, 20110503, 原因: 子网掩码校验范围不正确，
	    本次修改将所有校验改为采用专用的JS校验文件checkValue.js*/
	if (!CheckNotNull(field.value)) {
		//alert("Error! IP address is empty.");
		alert(_("lan_IP_empty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {		
		if(!validateMask(field.value))
		{
			//alert('subnet mask is illegal!');
			alert(_("lan_mask_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}		
	}
	else 
	{
		if (!validateIP(field.value))
		{
			//alert('IP adress is illegal!');
			alert(_("lan_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
	/* modify end by 吴小娟, 20110503 */
}

function checkInterval(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(4 <= dom.value && dom.value <= 1800)
		{
			return true;
		}
		else
		{
			alert(_("v6_RAIntervalIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("v6_RAIntervalIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkIntervalmin(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(3 <= dom.value && dom.value <= 1350)
		{
			return true;
		}
		else
		{
			alert(_("v6_RAIntervalIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("v6_RAIntervalIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkDHCPv6Lifetime(timeNode)
{
	if(timeNode.value == 'infinity')
		return true;
	else if(!checkNumberLegal(timeNode, 1, 4294967295))
	{
		alert(_("paramIllegalAlert"));
		return false;
	}

	return true;
}
function IpAddress2DecNum_aa(address)
{
    var addrParts = address.split('.');
    var num = 0;
    for (i = 0; i < 4; i++)
    {
        num += parseInt(addrParts[i]) * Math.pow(256, 3 - i);
    }
    return num;
}

function checkoption125_value(str)
{
	var reg = /^[A-Za-z0-9.]{1,128}$/;
	if (!reg.test(str))
	{ 
		return false; 
	}
	else
	{
		return true;
	}
	
	return true;
}
function CheckValue()
{
	var ra_interval_max = document.getElementById("max_Interval");
	var ra_interval_min = document.getElementById("min_Interval");
	
	if (document.lanCfg.hostname.value.indexOf(" ") >= 0)
	{
		alert(_("lan_no_space"));
		document.lanCfg.hostname.focus();
		document.lanCfg.hostname.select();
		return false;
	}
	if (!checkIpAddr(document.lanCfg.lanIp, false))
		return false;
	if (!checkIpAddr(document.lanCfg.lanNetmask, true))
		return false;
	if(parseInt(idisplay_v6_flag) == 1)	/* check v6 params */
	{
		if (!CheckNotNull(ra_interval_max.value)) 
		{
			alert(_("v6_RAIntervalNullAlert"));
			ra_interval_max.value = ra_interval_max.defaultValue;
			ra_interval_max.focus();
			return false;
		}
		if (!CheckNotNull(ra_interval_min.value)) 
		{					
			alert(_("v6_RAIntervalNullAlert"));
			ra_interval_min.value = ra_interval_min.defaultValue;
			ra_interval_min.focus();
			return false;
		}
		
		if(!checkInterval(ra_interval_max))
		{
			return false;
		}
		if(!checkIntervalmin(ra_interval_min))
		{
			return false;
		}
		//min最大为0.75*max
		if(ra_interval_max.value * 0.75 < ra_interval_min.value)
		{
			alert(_("v6_minRAIntervalIllegalAlert"));
			ra_interval_min.value = ra_interval_min.defaultValue;
			ra_interval_min.focus();
			return false;
		}
					
		var ra_Prefix_Set = document.getElementById("Prefix_Set");
		var ra_Pridns_Set = document.getElementById("Pridns_Set");

		if (document.lanCfg.Prefix_Mode.options.selectedIndex == 1)
		{
			if (!CheckNotNull(ra_Prefix_Set.value)) 
			{					
				alert(_("v6_prefixSetNullAlert"));
				ra_Prefix_Set.value = ra_Prefix_Set.defaultValue;
				ra_Prefix_Set.focus();
				return false;
			}
		}
		if (document.lanCfg.dns_srouce.options.selectedIndex == 1)
		{
			if (!CheckNotNull(ra_Pridns_Set.value)) 
			{					
				alert(_("v6_primaryDnsNullAlert"));
				ra_Pridns_Set.value = ra_Pridns_Set.defaultValue;
				ra_Pridns_Set.focus();
				return false;
			}
		}
	}
	if(ispNameCode == '22')	//THAILAND_TRUE
	{
		var enable_dhcp6sNode = getElement("enable_dhcp6s");
		if(enable_dhcp6sNode.checked == true)
		{
			var v6dhcpPreferTimeNode = getElement("v6dhcpPreferTime");
			if(!checkDHCPv6Lifetime(v6dhcpPreferTimeNode))
				return false;
			var v6dhcpValidTimeNode = getElement("v6dhcpValidTime");
			if(v6dhcpValidTimeNode.value != "")
				if(!checkDHCPv6Lifetime(v6dhcpValidTimeNode))
					return false;

			if(v6dhcpPreferTimeNode.value > v6dhcpValidTimeNode.value)
			{					
				alert(_("v6_validTimeIlligalAlert"));
				v6dhcpValidTimeNode.value = v6dhcpValidTimeNode.defaultValue;
				v6dhcpValidTimeNode.focus();
				return false;
			}
		}
	}
	
	if (document.lanCfg.dhcpType.options.selectedIndex == 1) 
	{
		if (!checkIpAddr(document.lanCfg.dhcpStart, false))
		{
			return false;
		}
		if (!checkIpAddr(document.lanCfg.dhcpEnd, false))
		{
			return false;
		}
		if (!checkIpAddr(document.lanCfg.dhcpMask, true))
		{
			return false;
		}		
		if (!checkIpAddr(document.lanCfg.dhcpPriDns, false))
		{
			return false;
		}

		if((IpAddress2DecNum(document.lanCfg.dhcpEnd.value) - IpAddress2DecNum(document.lanCfg.dhcpStart.value)) < 0 )
		{
			alert(_("pf_endIPTooSmallAlert"));
			return false;
		}
		
/* modify begin by 吴小娟, 20111208, 原因:该参数可以为空 */
		var secDnsNode = document.lanCfg.dhcpSecDns;
		if (CheckNotNull(secDnsNode.value))	//非空时检验IP
		{
			if (!validateIP(secDnsNode.value))
			{
				//alert('IP adress is illegal!');
				alert(_("dhcp_ip_illegal"));
				secDnsNode.value = secDnsNode.defaultValue;
				secDnsNode.focus();
				return false;
			}
		}
/* modify end by 吴小娟, 20111208 */

		if (!checkIpAddr(document.lanCfg.dhcpGateway, false))
		{
			return false;
		}

		if (document.lanCfg.option_60enable_s.options.selectedIndex == 1)
		{
			if (!checkIpAddr(document.lanCfg.option60Start, false))
			{
				return false;
			}
			if (!checkIpAddr(document.lanCfg.option60End, false))
			{
				return false;
			}
		}


		if ((document.lanCfg.dhcptime.value) != 0)
		{
			if (!checktime_hour(document.lanCfg.dhcptime))
			{
				return false;
			}
		}

		if ((document.lanCfg.dhcptime_m.value) != 0)
		{
			if (!checktime_min(document.lanCfg.dhcptime_m))
			{
				return false;
			}
		}

		if (((document.lanCfg.dhcptime.value ) == 0) &&
			((document.lanCfg.dhcptime_m.value) == 0))
		{
			alert(_("DHCP Lease Time is illegal."));
			return false;				
		}

		if (parseInt(document.lanCfg.dhcptime_m.value) == 99*60)
		{
			if ((parseInt(document.lanCfg.dhcptime.value ) )> 0)
			{
				alert(_("DHCP Lease Time is illegal."));
				document.lanCfg.dhcptime.value = 0;
				return false;
			}
		}

		if (parseInt(document.lanCfg.dhcptime.value) == 99)
		{
			if ((parseInt(document.lanCfg.dhcptime_m.value )) > 0)
			{
				alert(_("DHCP Lease Time is illegal."));
				document.lanCfg.dhcptime_m.value = 0;
				return false;
			}
		}

		if(ispNameCode == 15)/*globe*/
		{
			var option125_valuenode = document.lanCfg.option125_text;
			if (document.lanCfg.option_125enable_s.options.selectedIndex == 1)
			{
				if(!checkoption125_value(option125_valuenode.value))
				{
					alert(_("Option125 value is illegal!"));
					option125_valuenode.value = option125_valuenode.defaultValue;
					option125_valuenode.focus();
					return false;
				}
			}
		}
	}
	else if (document.lanCfg.dhcpType.options.selectedIndex == 2) 
	{
		if (!checkIpAddr(document.lanCfg.dhcprelay_ip, false))
		{
			return false;
		}
	}

//	if(ispNameCode == '16' || ispNameCode == '26')/* VIETTEL/巴西TIM */
	{
		alert(_("rebootAlert"));
	}
	return true;
}
function lan2_enable_switch()
{
	if (document.lanCfg.lan2enabled[1].checked == true)
	{
		document.lanCfg.lan2Ip.disabled = true;
		document.lanCfg.lan2Netmask.disabled = true;
	}
	else
	{
		document.lanCfg.lan2Ip.disabled = false;
		document.lanCfg.lan2Netmask.disabled = false;
	}
}

var oldIp;
function recIpCfg()
{
	oldIp = document.lanCfg.lanIp.value;
}

/*
 * Try to modify dhcp server configurations:
 *   dhcp start/end ip address to the same as new lan ip address
 */
function modLanCfg()
{
/* modify by 吴小娟, 20180619, 原因:局域网DHCP合回本页面，恢复LAN与地址池的自动匹配 */
/* modify by 吴小娟, 20150504, 原因: 修改LAN IP增加提示 */
/*	if(document.lanCfg.lanIp.value != oldIp)
	{
		if(confirm(_("lan_modIPConfirm")) == false)
		{
			document.lanCfg.lanIp.value = oldIp;
			return ;	
		}
	}
*/
/* delete begin by 吴小娟, 20111117, 原因:局域网DHCP独立，不再作此替换 */
///*
	var i, j;
	var mask = document.lanCfg.lanNetmask.value;
	var newNet = document.lanCfg.lanIp.value;

	//support simple subnet mask only
	if (mask == "255.255.255.0")
		mask = 3;
	else if (mask == "255.255.0.0")
		mask = 2;
	else if (mask == "255.0.0.0")
		mask = 1;
	else
		return;

	//get the old subnet
	for (i=0, j=0; i<oldIp.length; i++) {
		if (oldIp.charAt(i) == '.') {
			j++;
			if (j != mask)
				continue;
			oldIp = oldIp.substring(0, i);
			break;
		}
	}

	//get the new subnet
	for (i=0, j=0; i<newNet.length; i++) {
		if (newNet.charAt(i) == '.') {
			j++;
			if (j != mask)
				continue;
			newNet = newNet.substring(0, i);
			break;
		}
	}

	document.lanCfg.dhcpGateway.value = document.lanCfg.lanIp.value;
	document.lanCfg.dhcpStart.value = document.lanCfg.dhcpStart.value.replace(oldIp, newNet);
	document.lanCfg.dhcpEnd.value = document.lanCfg.dhcpEnd.value.replace(oldIp, newNet);
	document.lanCfg.dhcpPriDns.value = document.lanCfg.dhcpPriDns.value.replace(oldIp, newNet);
	if(CheckNotNull(document.lanCfg.dhcpSecDns.value))
	{
		document.lanCfg.dhcpSecDns.value = document.lanCfg.dhcpSecDns.value.replace(oldIp, newNet);
	}
	
//*/
/* delete end by 吴小娟, 20111117 */
}

 /*****************************************************************************
 * 函 数 名  : dealLanFailedHandle
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年5月26日
 * 函数功能  : 用于读写设备数据失败时结果提示
 * 输入参数  : 无
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function dealLanFailedHandle()
{
	var lanSetFailedID = '<% getCfgGeneral(1, "lanSetFailedID"); %>';
	if(lanSetFailedID != "" && lanSetFailedID !="dataFormatError")
	{
		/*获取处理失败的参数节点*/
		var dom = document.getElementById(lanSetFailedID);

		/*提示处理失败，获取焦点后显示正常*/
		setFailedDom(dom, 1);		/*1:写*/
	}
	else
	{
		var lanGetFailedIDs = '<% getCfgGeneral(1, "lanGetFailedIDs"); %>';
		if(lanGetFailedIDs != "")
		{
			var idArray = new Array();
			idArray = parseGetFailedIDs(lanGetFailedIDs);
			for(var i = 0; i<idArray.length; i++)
			{
				var dom = document.getElementById(idArray[i]);
				setFailedDom(dom, 0);		/*0:读*/
			}
		}
	}
}

function clickEnableDHCP6s()
{
	var enable_dhcp6sNode = getElement("enable_dhcp6s");
	if(enable_dhcp6sNode.checked == true)		//enable
	{
		getElement("v6dhcpstart").disabled = false;
		getElement("v6dhcpend").disabled = false;
		getElement("v6dhcpPreferTime").disabled = false;
		getElement("v6dhcpValidTime").disabled = false;
	}
	else										//disable
	{
		getElement("v6dhcpstart").disabled = true;
		getElement("v6dhcpend").disabled = true;
		getElement("v6dhcpPreferTime").disabled = true;
		getElement("v6dhcpValidTime").disabled = true;
	}
}

function checktime_hour(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 99)
		{
			return true;
		}
		else
		{
			alert(_("DHCP Lease Time is illegal."));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("DHCP Lease Time is illegal."));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checktime_min(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 99*60)
		{
			return true;
		}
		else
		{
			alert(_("DHCP Lease Time is illegal."));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("DHCP Lease Time is illegal."));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

var oldDhcpIP;
function recDhcpIP(id)
{
	oldDhcpIP = getElement(id).value;
}

/*
 * Try to modify dhcp server configurations:
 *   dhcp start/end ip address to the same as new lan ip address
 */
function modDhcpIP(id)
{
	var i, j;
	var mask = document.lanCfg.dhcpMask.value;
	var newNet = getElement(id).value;

	//support simple subnet mask only
	if (mask == "255.255.255.0")
		mask = 3;
	else if (mask == "255.255.0.0")
		mask = 2;
	else if (mask == "255.0.0.0")
		mask = 1;
	else
		return;

	//get the old subnet
	for (i=0, j=0; i<oldDhcpIP.length; i++) {
		if (oldDhcpIP.charAt(i) == '.') {
			j++;
			if (j != mask)
				continue;
			oldDhcpIP = oldDhcpIP.substring(0, i);
			break;
		}
	}

	//get the new subnet
	for (i=0, j=0; i<newNet.length; i++) {
		if (newNet.charAt(i) == '.') {
			j++;
			if (j != mask)
				continue;
			newNet = newNet.substring(0, i);
			break;
		}
	}

	if(id == 'dhcpStart')
	{
		document.lanCfg.dhcpGateway.value = document.lanCfg.dhcpGateway.value.replace(oldDhcpIP, newNet);
	}
	else if(id == 'dhcpGateway')
	{
		document.lanCfg.dhcpStart.value = document.lanCfg.dhcpStart.value.replace(oldDhcpIP, newNet);
	}
	document.lanCfg.dhcpEnd.value = document.lanCfg.dhcpEnd.value.replace(oldDhcpIP, newNet);
	document.lanCfg.dhcpPriDns.value = document.lanCfg.dhcpPriDns.value.replace(oldDhcpIP, newNet);
	if(CheckNotNull(document.lanCfg.dhcpSecDns.value))
	{
		document.lanCfg.dhcpSecDns.value = document.lanCfg.dhcpSecDns.value.replace(oldDhcpIP, newNet);
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="lanCfg" id="lanCfg" action="/goform/setLan" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="lan_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td colspan="2" id="lSetup">LAN Setup</td>
      </tr>
      <tr <% var hashost = getHostSupp();
      if (hashost != "1") write("style=\"visibility:hidden;display:none\""); %>>
        <td class="tabal_left" width="25%" id="lHostname">Hostname</td>
        <td class="tabal_right"><input name="hostname" maxlength=16
              value="<% getCfgGeneral(1, "HostName"); %>"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="lIp">IP Address</td>
        <td class="tabal_right"><input name="lanIp" id="lanIp" maxlength=15 value="<% getCfgGeneral(1, "lan_ipaddr"); %>" onFocus="recIpCfg()" onBlur="modLanCfg()"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="lNetmask">Subnet Mask</td>
        <td class="tabal_right"><input name="lanNetmask" id="lanNetmask" maxlength=15 value="<% getCfgGeneral(1, "lan_netmask"); %>"></td>
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
  <table id="ipv6_cfg_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="ipv6_title">IPv6 Config</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ipv6_static_addr_title"></td>
        <td class="tabal_right"><input name="ipv6_static_addr" id="ipv6_static_addr" maxlength = 43 value="<% getCfgGeneral(1, "ipv6_static_addr"); %>" >
          <span id="ipv6_static_addr_tips" name="ipv6_static_addr_tips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="Managed_Flag_title">Managed Flag</td>
        <td class="tabal_right"><input type="checkbox" name="Managed_Flag" id="Managed_Flag" value="1"/></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="other_Flag_title">Other Config Flag</td>
        <td class="tabal_right"><input type="checkbox" name="other_Flag" id="other_Flag" value="1"/></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="max_Interval_title">Max RA Interval</td>
        <td class="tabal_right"><input name="max_Interval" id="max_Interval" maxlength=4 value="<% getCfgGeneral(1, "max_Interval"); %>"/>
          <span id="max_Interval_tips" name="max_Interval_tips">Seconds (4-1800)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="min_Interval_title">Min RA Interval</td>
        <td class="tabal_right"><input name="min_Interval" id="min_Interval" maxlength=4 value="<% getCfgGeneral(1, "min_Interval"); %>"/>
          <span id="min_Interval_tips" name="max_Interval_tips">Seconds (3-1350)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="dns_source_title">DNS Source</td>
        <td class="tabal_right"><select name="dns_srouce" id="dns_srouce" size="1" onChange="dnsModeSwitch();">
            <option value="0" id="dns_source_net_title">Network Connection</option>
            <option value="1" id="dns_source_static_title">Static</option>
            <option value="2" id="dns_source_relay_title">Relay</option>
          </select>
        </td>
      </tr>
      <tr id="v6_dnsServer1" style="display: none">
        <td class="tabal_left" width="25%" id="first_dns_title">First DNS Server</td>
        <td class="tabal_right"><input name="Pridns_Set" id="Pridns_Set" maxlength=128 value="<% getCfgGeneral(1, "Pridns_Set"); %>"/></td>
      </tr>
      <tr id="v6_dnsServer2" style="display: none">
        <td class="tabal_left" width="25%" id="sec_dns_title">Second DNS Server</td>
        <td class="tabal_right"><input name="secdns_Set" id="secdns_Set" maxlength=128 value="<% getCfgGeneral(1, "secdns_Set"); %>"/></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="Prefix_Mode_title">Prefix Mode</td>
        <td class="tabal_right"><select name="Prefix_Mode" id="Prefix_Mode" size="1" onChange="PrefixModeSwitch();">
            <option value="0" id="prefix_net_title">Network Connection</option>
            <option value="1" id="prefix_static_title">Static</option>
          </select>
        </td>
      </tr>
      <tr id="v6_prefixSet" style="display: none">
        <td class="tabal_left" width="25%" id="Prefix_Set_title">Prefix Set</td>
        <td class="tabal_right"><input name="Prefix_Set" id="Prefix_Set" maxlength=128 value="<% getCfgGeneral(1, "Prefix_Set"); %>"/></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="enable_dhcp6s_title_title">Enable DHCP6S</td>
        <td class="tabal_right"><input type="checkbox" name="enable_dhcp6s" id="enable_dhcp6s" value="1" onClick="clickEnableDHCP6s();"/></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="v6dhcpstart_title">Start IPv6 Address</td>
        <td class="tabal_right"><input name="v6dhcpstart" id="v6dhcpstart" maxlength=19 value="<% getCfgGeneral(1, "v6dhcpstart"); %>" />
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="v6dhcpend_title">End IPv6 Address</td>
        <td class="tabal_right"><input name="v6dhcpend" id="v6dhcpend" maxlength=19 value="<% getCfgGeneral(1, "v6dhcpend"); %>" />
        </td>
      </tr>
      <tr id='tr_v6dhcpPreferTime' style="display: none">
        <td class="tabal_left" width="25%" id="v6dhcpPreferTime_title">DHCPv6 Preferred Lifetime</td>
        <td class="tabal_right"><input name="v6dhcpPreferTime" maxlength=10 value="<% getCfgGeneral(1, "v6dhcpPreferTime"); %>" />
          <strong style="color:#FF0033">*</strong><span id="v6dhcpPreferTime_tips">Seconds (1-4294967295, infinity)</span></td>
      </tr>
      <tr id='tr_v6dhcpValidTime' style="display: none">
        <td class="tabal_left" width="25%" id="v6dhcpValidTime_title">DHCPv6 Valid Lifetime</td>
        <td class="tabal_right"><input name="v6dhcpValidTime" maxlength=10 value="<% getCfgGeneral(1, "v6dhcpValidTime"); %>" />
          <strong style="color:#FF0033">*</strong><span id="v6dhcpValidTime_tips">Seconds (1-4294967295, infinity)</span></td>
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
        <td colspan="2" id="dhcp_serviceHead">DHCP Service</td>
      </tr>
      <tr id='tr_dhcptype'>
        <td class="tabal_left" width="25%" id="dhcp_typeTitle">Type</td>
        <td class="tabal_right"><select name="dhcpType" id="dhcpType" size="1" onChange="dhcpTypeSwitch();">
            <option value="0" id="dhcp_typeD">Disable</option>
            <option value="1" id="dhcp_typeS">Server</option>
          </select>
        </td>
      </tr>
      <tr id="dhcp_agent_id" style="display: none">
        <td class="tabal_left" width="25%" id="dhcp_relayTitle" align="right">Server IP</td>
        <td class="tabal_right"><input name="dhcprelay_ip" id="dhcprelay_ip" maxlength=15
             value="<% getCfgGeneral(1, "dhcprelay_ip"); %>"></td>
      </tr>
    <div id="div_dhcpServer">
      <tr id="start">
        <td class="tabal_left" width="25%" id="dhcp_startTitle" align="right">DHCP Start IP</td>
        <td class="tabal_right"><input name="dhcpStart" id="dhcpStart" maxlength=15
             value="<% getCfgGeneral(1, "dhcpStart"); %>" onFocus="recDhcpIP(this.id)" onBlur="modDhcpIP(this.id)"></td>
      </tr>
      <tr id="end">
        <td class="tabal_left" width="25%" id="dhcp_endTitle" align="right">DHCP End IP</td>
        <td class="tabal_right"><input name="dhcpEnd" id="dhcpEnd" maxlength=15
             value="<% getCfgGeneral(1, "dhcpEnd"); %>"></td>
      </tr>
      <tr id="mask">
        <td class="tabal_left" width="25%" id="dhcp_netmaskTitle" align="right">DHCP Subnet Mask</td>
        <td class="tabal_right"><input name="dhcpMask" id="dhcpMask" maxlength=15
             value="<% getCfgGeneral(1, "dhcpMask"); %>"></td>
      </tr>
      <tr id="pridns">
        <td class="tabal_left" width="25%" id="dhcp_priDnsTitle" align="right">DHCP Primary DNS</td>
        <td class="tabal_right"><input name="dhcpPriDns" id="dhcpPriDns" maxlength=15
             value="<% getCfgGeneral(1, "dhcpPriDns"); %>"></td>
      </tr>
      <tr id="secdns">
        <td class="tabal_left" width="25%" id="dhcp_secDnsTitle" align="right">DHCP Secondary DNS</td>
        <td class="tabal_right"><input name="dhcpSecDns" id="dhcpSecDns" maxlength=15
             value="<% getCfgGeneral(1, "dhcpSecDns"); %>"></td>
      </tr>
      <tr id="gateway">
        <td class="tabal_left" width="25%" id="dhcp_gatewayTitle" align="right">DHCP Default Gateway</td>
        <td class="tabal_right"><input name="dhcpGateway" id="dhcpGateway" maxlength=15
             value="<% getCfgGeneral(1, "dhcpGateway"); %>" onFocus="recDhcpIP(this.id)" onBlur="modDhcpIP(this.id)"></td>
      </tr>
      <tr id="dhcp_time">
        <td class="tabal_left" width="25%" id="dhcp_timeTitle" align="right">DHCP Lease Time</td>
        <td class="tabal_right"><input name="dhcptime" id="dhcptime" maxlength=15
             value="<% getCfgGeneral(1, "dhcptime_h"); %>">
          <span id="dhcp_hourTitle">Hour</span>
          <input name="dhcptime_m" id="dhcptime_m" maxlength=15
             value="<% getCfgGeneral(1, "dhcptime_m"); %>">
          <span id="dhcp_minTitle">Min</span> <span class="gray" id="dhcp_timeTips">( 1 min - 99 hours )</span></td>
        </td>
      </tr>
      <tr id ="option_60enable">
        <td class="tabal_left" width="25%" id="option_60enableTitle">Option60</td>
        <td class="tabal_right"><select name="option_60enable_s" id="option_60enable_s" size="1" onChange="option60TypeSwitch();">
            <option value="0" id="option_60_typeD">Disable</option>
            <option value="1" id="option_60_typeS">Server</option>
          </select>
        </td>
      </tr>
      <div>
        <tr id="option_start">
          <td class="tabal_left" width="25%" id="option60_startTitle" align="right">Option 60 Start IP</td>
          <td class="tabal_right"><input name="option60Start" id="option60Start" maxlength=15
             value="<% getCfgGeneral(1, "option60Start"); %>"></td>
        </tr>
        <tr id="option_end">
          <td class="tabal_left" width="25%" id="option60_endTitle" align="right">Option 60 End IP</td>
          <td class="tabal_right"><input name="option60End" id="option60End" maxlength=15
             value="<% getCfgGeneral(1, "option60End"); %>"></td>
        </tr>
      </div>
      <tr id ="option_125enable"  style="display: none">
        <td class="tabal_left" width="25%" id="option_125enableTitle">Option125</td>
        <td class="tabal_right"><select name="option_125enable_s" id="option_125enable_s" size="1" onChange="option125TypeSwitch();">
            <option value="0" id="option_125_typeD">Disable</option>
            <option value="1" id="option_125_typeS">Server</option>
          </select>
        </td>
      </tr>
      <tr id="option125_text_id"  style="display: none">
        <td class="tabal_left" width="25%" id="option125_textTitle" align="right">Option 125 Value</td>
        <td class="tabal_right"><input name="option125_text" id="option125_text" maxlength=128
	             value="<% getCfgGeneral(1, "option125text"); %>"></td>
      </tr>
    </div>
    </tbody>
    
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="lApply" class="submit" onClick="TimeoutReload(20)">
          <input type="reset" name="Cancel" value="Cancel" id="lCancel" class="submit" onClick="window.location.reload()">
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
