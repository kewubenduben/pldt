/***********************************************************************************
wan_romania.js
wuxj
2017.2.7
wan_romania JS functions
***********************************************************************************/

var curWANmode;
var curWANtype;

function MTUpppoeLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1280 <= dom.value && dom.value <= 1492)
		{
			return true;
		}
		else
		{
			alert(_("mtupppoe_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("mtupppoe_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkIpAddr(field, ismask)
{
	if (!CheckNotNull(field.value)) {
		alert(_("wan_IPempty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {		
		if(!validateMask(field.value))
		{
			alert(_("wan_mask_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}		
	}
	else {
		if (!validateIP(field.value))
		{
			alert(_("wan_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
}

function splitDate()
{
    var wan_num = wan_size;
	switch(parseInt(wan_num))
	{
		case 5:
			Wanindex4Array = wanIndex[4];
			modeWan4Array = modeArray[4];
			typeWan4Array = typeArray[4];
			addressWan4Array = addressArray[4];
			Wan4StaticIp = WanStaticIp[4];
			Wan4StaticMask = WanStaticMask[4];
			Wan4StaticGW = WanStaticGW[4];
			Wan4StaticDNS1 = WanStaticDNS1[4];
			Wan4StaticDNS2 = WanStaticDNS2[4];
		case 4:
			Wanindex3Array = wanIndex[3];
			modeWan3Array = modeArray[3];
			typeWan3Array = typeArray[3];
			addressWan3Array = addressArray[3];
			Wan3StaticIp = WanStaticIp[3];
			Wan3StaticMask = WanStaticMask[3];
			Wan3StaticGW = WanStaticGW[3];
			Wan3StaticDNS1 = WanStaticDNS1[3];
			Wan3StaticDNS2 = WanStaticDNS2[3];
        case 3:
			Wanindex2Array = wanIndex[2];
			modeWan2Array = modeArray[2];
			typeWan2Array = typeArray[2];
			addressWan2Array = addressArray[2];
			Wan2StaticIp = WanStaticIp[2];
			Wan2StaticMask = WanStaticMask[2];
			Wan2StaticGW = WanStaticGW[2];
			Wan2StaticDNS1 = WanStaticDNS1[2];
			Wan2StaticDNS2 = WanStaticDNS2[2];
       case 2:
			Wanindex1Array = wanIndex[1];
			modeWan1Array = modeArray[1];
			typeWan1Array = typeArray[1];
			addressWan1Array = addressArray[1];
			Wan1StaticIp = WanStaticIp[1];
			Wan1StaticMask = WanStaticMask[1];
			Wan1StaticGW = WanStaticGW[1];
			Wan1StaticDNS1 = WanStaticDNS1[1];
			Wan1StaticDNS2 = WanStaticDNS2[1];
        case 1:
			Wanindex0Array = wanIndex[0];
			modeWan0Array = modeArray[0];
			typeWan0Array = typeArray[0];
			addressWan0Array = addressArray[0];
			Wan0StaticIp = WanStaticIp[0];
			Wan0StaticMask = WanStaticMask[0];
			Wan0StaticGW = WanStaticGW[0];
			Wan0StaticDNS1 = WanStaticDNS1[0];
			Wan0StaticDNS2 = WanStaticDNS2[0];
			break;
		default:
			break;
}
}

/* modify by wuxj, 20160808, 原因:优化实现，扩展支持8个SSID  */
function showFESSID(wanIndex)
{
	var checkedFEValue = new Array(1, 2, 4, 8);//目前最多4个LAN
	var checkedSSIDValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);//8个SSID
	
	var curFEArr = feArray[parseInt(wanIndex)].split(",");
	var curSSIDArr = ssidArray[parseInt(wanIndex)].split(",");
			
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	/*lan band 勾选*/
	for(var i = 0; i < 4; i++)
	{
		if(curFEArr[i] == checkedFEValue[i])
		{
			wanFEBoxNode[i].checked = true;			
		}
		else
		{
	        wanFEBoxNode[i].checked =  false;	
		}		
	}
	/*ssid band 勾选*/
	for(var i = 0; i < wifi_ssid_sum; i++)
	{
		if(curSSIDArr[i] == checkedSSIDValue[i])
		{
			wanSsidBoxNode[i].checked = true;			
		}
		else
		{
	        wanSsidBoxNode[i].checked =  false;	
		}
	}	
}

function Tr069Wan_style(chooseWanValue)
{
	if(chooseWanValue == 0)//tr069
	{
		document.getElementById("wan_connectionmode").disabled = 1;
			
		/*越南HGU版本TR069 WAN不允许配置 */
		if(ispName == 16)
		{
			document.getElementById("wan_enable").disabled = 1;	
			document.getElementById("wan_vid").disabled = 1;
			document.getElementById("wan_priority").disabled = 1;
			document.getElementById("ipModel").disabled = 1;
			document.getElementById("wan_mtu").disabled = 1;
			
			setDisplay("apply_table", "none");	
		}
		if(ispName == 9)//罗马尼亚要求TR069的连接类型可配
		{
			document.getElementById("wan_connectionmode").disabled = 0;
			setDisplay("apply_table", "");	
		}
	}
	else
	{
		document.getElementById("wan_enable").disabled = 0;
		document.getElementById("wan_connectionmode").disabled = 0;
		document.getElementById("wan_vid").disabled = 0;
		document.getElementById("nat_enable").disabled = 0;
		document.getElementById("wan_priority").disabled = 0;
		document.getElementById("wan_mtu").disabled = 0;
		document.getElementById("dns_enable").disabled = 0;
		document.getElementById("ipModel").disabled = 0;
		setDisplay("apply_table", "");	
	}
}

function AFTRSwitch()
{
	if(document.getElementById("AFTR_enable").options.selectedIndex == 1)
    {
		setDisplay("AFTR_value_table", "");
	}
	else
	{
		setDisplay("AFTR_value_table", "none");		
	}
}

function DsliteSwitch()
{
	if(document.getElementById("DS_Lite_enable").options.selectedIndex == 1)
    {
		setDisplay("AFTR_ipv6_table", "");
		AFTRSwitch();
	}
	else
	{
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
	}
}

function vlanModeSwitch(curVlanMode)
{
	if(curVlanMode == 3)	//all trans
    {
		setDisplay("tr_vlan", "none");
		setDisplay("tr_priority", "none");
	}
	else
	{
		setDisplay("tr_vlan", "");
		setDisplay("tr_priority", "");		
	}
}

function ipv6_enableSwitch()
{
    var ipModelNode =  document.getElementById("ipModel");
	var wan_ipv6enable = document.getElementById("ipv6_enable");
	var wan_conmode = document.getElementById("wan_connectionmode");
	var wan_connectionTypeNode = getElement("wan_connectionType");

	if(wan_connectionTypeNode.value == 1)//route
	{
		if ((wan_ipv6enable.value == 3) )//v4 v6
		{
			//internet相关
			if((wan_conmode.value == 1) || (wan_conmode.value == 2) || (wan_conmode.value == 5))
			{
				if(ipModelNode.options.selectedIndex == 1)//STATIC
				{
					setDisplay("static_ipv6", "");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("static_ipv4_table", "");
					setDisplay("dhcp_ipv4_table", "none");
					setDisplay("pppoe_ipv4_table", "none");
					setDisplay("static", "");
					setDisplay("dhcp", "none");
					setDisplay("pppoe", "none");
				}
				else if(ipModelNode.options.selectedIndex == 0)//DHCP
				{
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("static_ipv4_table", "none");
					setDisplay("dhcp_ipv4_table", "");
					setDisplay("pppoe_ipv4_table", "none");
					setDisplay("static", "none");
					setDisplay("dhcp", "");
					setDisplay("pppoe", "none");
				}
				else if(ipModelNode.options.selectedIndex == 2)//PPPOE
				{
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "");
					setDisplay("static_ipv4_table", "none");
					setDisplay("dhcp_ipv4_table", "none");
					setDisplay("pppoe_ipv4_table", "");
					setDisplay("static", "none");
					setDisplay("dhcp", "none");
					setDisplay("pppoe", "");
				}
			}
			else
			{
				setDisplay("static_ipv6", "none");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("pppoe_ipv6", "none");
			}
			setDisplay("dsline_ipv6_table", "none");
			setDisplay("AFTR_ipv6_table", "none");
			setDisplay("AFTR_value_table", "none");
			
		}
		else if ((wan_ipv6enable.value == 2) )//v6
		{
			//internet相关
			if((wan_conmode.value == 1) || (wan_conmode.value == 2) || (wan_conmode.value == 5))
			{
				//modify by wuxj, 20160815, 原因:修改为根据功能宏显示
				if(WEB_DSLITE == '1')
				{
					setDisplay("dsline_ipv6_table", "");
					DsliteSwitch();
				}
				if(ipModelNode.options.selectedIndex == 1)//STATIC
				{
					setDisplay("static_ipv6", "");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("static", "");
					setDisplay("dhcp", "none");
					setDisplay("pppoe", "none");
				}
				else if(ipModelNode.options.selectedIndex == 0)//DHCP
				{
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("static", "none");
					setDisplay("dhcp", "");
					setDisplay("pppoe", "none");
				}
				else if(ipModelNode.options.selectedIndex == 2)//PPPOE
				{
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "");
					setDisplay("static", "none");
					setDisplay("dhcp", "none");
					setDisplay("pppoe", "");
					
				}
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "none");
			}
			else
			{
				if(ipModelNode.options.selectedIndex == 1)//STATIC
				{
					setDisplay("static", "");
					setDisplay("dhcp", "none");
					setDisplay("pppoe", "none");
					setDisplay("static_ipv4_table", "");
					setDisplay("dhcp_ipv4_table", "none");
					setDisplay("pppoe_ipv4_table", "none");
				}
				else if(ipModelNode.options.selectedIndex == 0)//DHCP
				{
					setDisplay("static", "none");
					setDisplay("dhcp", "");
					setDisplay("pppoe", "none");
					setDisplay("static_ipv4_table", "none");
					setDisplay("dhcp_ipv4_table", "");
					setDisplay("pppoe_ipv4_table", "none");
				}
				else if(ipModelNode.options.selectedIndex == 2)//PPPOE
				{
					setDisplay("static", "none");
					setDisplay("pppoe", "");
					setDisplay("dhcp", "none");
					setDisplay("static_ipv4_table", "none");
					setDisplay("dhcp_ipv4_table", "none");
					setDisplay("pppoe_ipv4_table", "");
					
				}
				setDisplay("static_ipv6", "none");
				setDisplay("dhcp_ipv6", "none");
				setDisplay("pppoe_ipv6", "none");
				setDisplay("dsline_ipv6_table", "none");
				setDisplay("AFTR_ipv6_table", "none");
				setDisplay("AFTR_value_table", "none");
			}

		}
		else	//v4
		{
			if(ipModelNode.options.selectedIndex == 1)//STATIC
			{
				setDisplay("static", "");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "none");
				setDisplay("static_ipv4_table", "");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "none");
			}
			else if(ipModelNode.options.selectedIndex == 0)//DHCP
			{
				setDisplay("static", "none");
				setDisplay("dhcp", "");
				setDisplay("pppoe", "none");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "");
				setDisplay("pppoe_ipv4_table", "none");
			}
			else if(ipModelNode.options.selectedIndex == 2)//PPPOE
			{
				setDisplay("static", "none");
				setDisplay("dhcp", "none");
				setDisplay("pppoe", "");
				setDisplay("static_ipv4_table", "none");
				setDisplay("dhcp_ipv4_table", "none");
				setDisplay("pppoe_ipv4_table", "");
				
			}
			setDisplay("static_ipv6", "none");
			setDisplay("dhcp_ipv6", "none");
			setDisplay("pppoe_ipv6", "none");
			setDisplay("dsline_ipv6_table", "none");
			setDisplay("AFTR_ipv6_table", "none");
			setDisplay("AFTR_value_table", "none");
		}//v4
		
	}//route
}

function pppoeOPModeSwitch()
{
	var PppoeMode =  document.getElementById("pppConnTrigger");
	var wan_conmode = document.getElementById("wan_connectionmode");

	if((wan_conmode.value != 0) && (wan_conmode.value != 4)) /*TR069, VOIP*/
	{
		if(PppoeMode.options.selectedIndex == 0) //OnDemand
		{
			setDisplay("tr_ppp_outtime", "");
			setDisplay("tr_manual_connect", "none");
		}
		else if(PppoeMode.options.selectedIndex == 2) //Manual
		{
			setDisplay("tr_ppp_outtime", "none");	
			setDisplay("tr_manual_connect", "");
		}
		else											//AlwaysOn
		{
			setDisplay("tr_ppp_outtime", "none");	
			setDisplay("tr_manual_connect", "none");
		}
	}
	
}

function ipModelSwitch()
{
	var ipModelNode =  document.getElementById("ipModel");
	var Prefix_dhcp_node =  document.getElementById("Address/Prefix_dhcp");
	var Prefix_pppoe_node =  document.getElementById("Address/Prefix_pppoe");
	var wan_conmode = document.getElementById("wan_connectionmode");
	
	setDisplay("static", "none");
	setDisplay("dhcp", "none");
	setDisplay("pppoe", "none");
	setDisplay("static_ipv4_table", "none");
	setDisplay("dhcp_ipv4_table", "none");
	setDisplay("pppoe_ipv4_table", "none");
	
	if (ipModelNode.options.selectedIndex == 1)
	{
		getElement('span_mtu').innerHTML = _("mtu_1500");//modify by wuxj, 20170515, from杨寒
		setDisplay("static", "");
		setDisplay("static_ipv4_table", "");
	}
	else if (ipModelNode.options.selectedIndex == 0)
	{
		getElement('span_mtu').innerHTML = _("mtu_1500");//modify by wuxj, 20170515, from杨寒
		setDisplay("dhcp", "");
		setDisplay("dhcp_ipv4_table", "");
		
		Prefix_dhcp_node.options.selectedIndex = prefix_v6_dhcp;		
	}
	else if (ipModelNode.options.selectedIndex == 2)//pppoe
	{
		//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
		//AIS 厄瓜多尔 罗马尼亚 X_GLOBE 越南
		if((ispName == 12) || (ispName == 5) || (ispName == 9) || (ispName == 15) || (ispName == 16))
		{
			if((wan_conmode.value == 0) || (wan_conmode.value == 4)) /*TR069, VOIP*/
			{ 
				setDisplay("tr_pppAuthType", "none");
				setDisplay("tr_pppConnTrigger", "none");
				setDisplay("tr_manual_connect", "none");
				setDisplay("tr_ppp_outtime", "none");
			}
			else
			{
				setDisplay("tr_pppAuthType", "");
				setDisplay("tr_pppConnTrigger", "");
				pppoeOPModeSwitch();
			}
		}
		getElement('span_mtu').innerHTML = _("mtu_1492");//modify by wuxj, 20170515, from杨寒
		setDisplay("pppoe", "");
		setDisplay("pppoe_ipv4_table", "");

		if(ispName == 12)/*厄瓜多尔*/
		{
			Prefix_pppoe_node.options.selectedIndex = current_prefix_v6_pppoe;
		}
		else
		{
			Prefix_pppoe_node.options.selectedIndex = prefix_v6_pppoe;
		}
		
	}	
	ipv6_enableSwitch();
}

function pppoemanual_connect(rs)
{
	var ppphiddenButton_node =  document.getElementById("ppphiddenButton");
	var fw_curIndex = document.getElementById("fw_curIndex");
	if (rs == 1) 
	{
		ppphiddenButton_node.value = 1;
	}
	else 
	{
		ppphiddenButton_node.value = 0;
	}
	document.location = "/goform/ppp_manual_connect" + "?csrftoken=" + getCsrftoken()
		+ "&fw_curIndex=" + fw_curIndex.value
		+ "&ppphiddenButton=" + ppphiddenButton_node.value;
}

//route/bridge
function ConnectTypeSwitch(chooseConnType)
{
	var ipv6_enable_s  = document.getElementById("ipv6_enable");
	var wan_conmode = document.getElementById("wan_connectionmode");
	
	/* modify by wuxj, 20170926, ip mode只在路由internet相关时有效 */
	//路由internet相关
	if((chooseConnType == 1)
		&& ((wan_conmode.value == 1) || (wan_conmode.value == 2) 
		|| (wan_conmode.value == 5)))
	{
		setDisplay("wan_ipv6enable", "");
		ipv6_enableSwitch();
		setDisplay("tb_nat_dns", "");
	}
	else
	{
		setDisplay("wan_ipv6enable", "none");
		ipv6_enableSwitch()
		setDisplay("tb_nat_dns", "none");
	}
	
	if (chooseConnType == 1) 	/* route */
	{
		setDisplay("tb_wanIPModel", "");
		ipModelSwitch();

		/*TR069、VOIP、TR069_VOIP不显示 nat dns*/
		if((wan_conmode.value != 0) && (wan_conmode.value != 4)	&& (wan_conmode.value != 16))
		{
			setDisplay("tb_nat_dns", "");
		}
	}
	else /*bridge*/
	{
		setDisplay("tb_nat_dns", "none");
		setDisplay("tb_wanIPModel", "none");	
		setDisplay("static_ipv4_table", "none");
		setDisplay("pppoe_ipv4_table", "none");
		setDisplay("dhcp_ipv4_table", "none");
		setDisplay("pppoe", "none");
		setDisplay("static", "none");
		setDisplay("dhcp", "none");

		showSelectNodeByValue(ipv6_enable_s, 1);//v4
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
		setDisplay("dsline_ipv6_table", "none");
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
	}
}

//Service Type: 0:TR069 1:INTERNET 2:TR069_INTERNET 3:Other 4:VOIP 5:VOIP_INTERNET
function WanIndexSwitch(chooseWanIndex, curLineID)
{	
	var select_WANtype = document.getElementById("wan_connectionType");

	if ((chooseWanIndex == 0) ||	(chooseWanIndex == 1) 
		|| (chooseWanIndex == 2) || (chooseWanIndex == 4) || (chooseWanIndex == 5) || (chooseWanIndex == 16))
	{
		//TR069 VOIP相关
		if(chooseWanIndex == 0 || (chooseWanIndex == 4) 
			|| (chooseWanIndex == 2) || (chooseWanIndex == 5) || (chooseWanIndex == 16) ) 
		{				
				setDisplay("port_bang", "");
				document.getElementById("wan_connectionType").disabled = 1;
				document.getElementById("wan_connectionType").value = 1;
				
				if(chooseWanIndex == 0 || (chooseWanIndex == 4) || (chooseWanIndex == 16))//tr069、voip、tr069_voip
				{
					setDisplay("port_bang", "none");
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("wan_ipv6enable", "none");
					setDisplay("dsline_ipv6_table", "none");
					setDisplay("AFTR_ipv6_table", "none");
					setDisplay("AFTR_value_table", "none");
					setDisplay("tb_nat_dns", "none");				
				}
				Tr069Wan_style(chooseWanIndex);
				ConnectTypeSwitch(1);//route

				if(ispName == 16 && currentline == 'new')//VIETTEL HGU
				{
					if(chooseWanIndex == 0)//tr069
					{
						document.getElementById("wan_vid").value = "2501";
						document.getElementById("wan_priority").value = "7";	
					}
					if(chooseWanIndex == 4)//VOIP
					{
						document.getElementById("wan_vid").value = "335";
						document.getElementById("wan_priority").value = "5";
					}
				}
		}
		else	//1:INTERNET
		{		
			document.getElementById("wan_connectionType").disabled = 0;
			setDisplay("port_bang", "");
			ConnectTypeSwitch(select_WANtype.options.selectedIndex);
			if(ispName == 16 && currentline == 'new')//VIETTEL HGU
			{
				document.getElementById("wan_vid").value = "35";
				document.getElementById("wan_priority").value = "0";	
			}
		}

		if((chooseWanIndex == 1) || (chooseWanIndex == 2) || (chooseWanIndex == 5))//internet相关
		{
			if(chooseWanIndex == 1)
			{
				if(parseInt(brige_wan_only) == 1)	
				{
					document.getElementById("wan_connectionType").disabled = 0;
					document.getElementById("wan_connectionType").options.selectedIndex = 0;
					ConnectTypeSwitch(0);//bridge
					document.getElementById("wan_connectionType").disabled = 1;
				}
			}
			
		    if(select_WANtype.options.selectedIndex == 1)
		    {
				var ipv6_enable_s  = document.getElementById("ipv6_enable");
				showSelectNodeByValue(ipv6_enable_s, 1);//v4
				setDisplay("wan_ipv6enable", "");
				ipv6_enableSwitch();
		    }
		}

	}
	else if((chooseWanIndex == 3) || (chooseWanIndex == 10))	/* muticast只能桥接 */
	{
		ConnectTypeSwitch(0);//bridge,muticast_IPTV
		document.getElementById("wan_connectionType").options.selectedIndex = 0;
		document.getElementById("wan_connectionType").disabled = 1;
		setDisplay("port_bang", "");
		if(ispName == 16 && currentline == 'new')//越南viettel
		{
			if(chooseWanIndex == 3)//mutiscreen
			{
				document.getElementById("wan_vid").value = "2502";
				document.getElementById("wan_priority").value = "3";
			}
			else//muticast_IPTV
			{
				document.getElementById("wan_vid").value = "36";
				document.getElementById("wan_priority").value = "3";
			}	
		}
	}
	else	/*other*/
	{	
		document.getElementById("wan_connectionType").disabled = 0;
		setDisplay("tb_wanIPModel", "");
		setDisplay("port_bang", "");
//		ipModelSwitch(0);
	}
}

function clickRemove(tabTitle)
{
	if(wan_size  == 0)
	{			
 		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pf_removeFlag');
    var noChooseFlag = true;
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				noChooseFlag = false;
				break;
			}
		}
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
		alert(_("pf_noChooseAlert"));
		return ;
	}
	        
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;
		
	load_waiting();
	getElement("fw_ruleForm").submit();
	
}

function initTranslation()
{
	var e = document.getElementById("wan_prompt");
	e.innerHTML = _("wan_prompt");
	e = document.getElementById("wan_add");
	e.value = _("wan_add");
	e = document.getElementById("wan_delete");
	e.value = _("wan_delete");

	e = document.getElementById("WANListHead");
	e.innerHTML = _("WANListHead");

	e = document.getElementById("WAN_nameTitle");
	e.innerHTML = _("WAN_nameTitle");
	e = document.getElementById("WAN_VIDtitle");
	e.innerHTML = _("WAN_VIDtitle");
	e = document.getElementById("WAN_ipmode");
	e.innerHTML = _("WAN_ipmode");

	e = document.getElementById("wan_servicetypeTitle");
	e.innerHTML = _("wan_servicetypeTitle");
	e = document.getElementById("wConnType_bridge");
	e.innerHTML = _("wConnType_bridge");
	e = document.getElementById("wConnType_route");
	e.innerHTML = _("wConnType_route");

	e = document.getElementById("vlan_modeTitle");
	e.innerHTML = _("vlan_modeTitle");
	e = document.getElementById("vlan_vlan_trans_tip");
	e.innerHTML = _("vlan_vlan_trans_tip");
	e = document.getElementById("vlan_all_trans_tip");
	e.innerHTML = _("vlan_all_trans_tip");
	
	e = document.getElementById("nat_enabletitle");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("nat_disabletitle");
	e.innerHTML = _("wan_disabletitle");
	e = document.getElementById("dns_enabletitle");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("dns_disabletitle");
	e.innerHTML = _("wan_disabletitle")
	e = document.getElementById("wan_enable_tip");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("wan_disable_tip");
	e.innerHTML = _("wan_disabletitle");
	e = document.getElementById("wan_enableTitle");
	e.innerHTML = _("WAN Enable");
	
	e = document.getElementById("vlan_enableTitle");
	e.innerHTML = _("VLAN Enable")
	e = document.getElementById("vlan_enable_tip");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("vlan_disable_tip");
	e.innerHTML = _("wan_disabletitle");
		
	e = document.getElementById("wan_connectionTypeTitle");
	e.innerHTML = _("wan_connectionTypeTitle");
	e = document.getElementById("wan_priorityTitle");
	e.innerHTML = _("wan_priorityTitle");
	e = document.getElementById("nat_typetitle");
	e.innerHTML = _("nat_typetitle");
	e = document.getElementById("lan_dns_relay");
	e.innerHTML = _("lan_dns_relay");
	e = document.getElementById("wan_FE_title");
	e.innerHTML = _("wan_FE_title");
	e = document.getElementById("wan_SSID_title");
	e.innerHTML = _("wan_SSID_title");

	e = document.getElementById("wConnectionType");
	e.innerHTML = _("wan connection type");
	e = document.getElementById("wConnTypeStatic");
	e.innerHTML = _("wan connection type static");
	e = document.getElementById("wConnTypeDhcp");
	e.innerHTML = _("wan connection type dhcp");
	e = document.getElementById("wConnTypePppoe");
	e.innerHTML = _("wan connection type pppoe");

	e = document.getElementById("wStaticMode");
	e.innerHTML = _("wan static mode");
	e = document.getElementById("wStaticIp");
	e.innerHTML = _("inet ip");
	e = document.getElementById("wStaticNetmask");
	e.innerHTML = _("inet netmask");
	e = document.getElementById("wStaticGateway");
	e.innerHTML = _("inet gateway");
	e = document.getElementById("wStaticPriDns");
	e.innerHTML = _("inet pri dns");
	e = document.getElementById("wStaticSecDns");
	e.innerHTML = _("inet sec dns");

	e = document.getElementById("wDhcpMode");
	e.innerHTML = _("wan dhcp mode");
	e = document.getElementById("wIP_mode_title");
	e.innerHTML = _("wIP_mode_title");

	e = document.getElementById("wPppoeMode");
	e.innerHTML = _("wan pppoe mode");
	e = document.getElementById("wPppoeUser");
	e.innerHTML = _("inet user");
	e = document.getElementById("wPppoePassword");
	e.innerHTML = _("inet password");
	e = document.getElementById("wPppoeOPMode");
	e.innerHTML = _("wan protocol opmode");
	e = document.getElementById("wPppoeKeepAlive");
	e.innerHTML = _("wan protocol opmode keepalive");

	e = document.getElementById("wDhcpCon_ip_title");
	e.innerHTML = _("wDhcpCon_ip_title");
	e = document.getElementById("wDhcpCon_mask_title");
	e.innerHTML = _("wDhcpCon_mask_title");
	e = document.getElementById("wDhcpCon_gateway_title");
	e.innerHTML = _("wDhcpCon_gateway_title");
	e = document.getElementById("wDhcpCon_priDNS_title");
	e.innerHTML = _("wDhcpCon_priDNS_title");
	e = document.getElementById("wDhcpCon_secDNS_title");
	e.innerHTML = _("wDhcpCon_secDNS_title");
	
	e = document.getElementById("wPppoeCon_status_title");
	e.innerHTML = _("wPppoeCon_status_title");
	e = document.getElementById("wPppoeCon_ip_title");
	e.innerHTML = _("wPppoeCon_ip_title");
	e = document.getElementById("wPppoeCon_mask_title");
	e.innerHTML = _("wPppoeCon_mask_title");
	e = document.getElementById("wPppoeCon_gateway_title");
	e.innerHTML = _("wPppoeCon_gateway_title");
	e = document.getElementById("wPppoeCon_priDNS_title");
	e.innerHTML = _("wPppoeCon_priDNS_title");
	e = document.getElementById("wPppoeCon_secDNS_title");
	e.innerHTML = _("wPppoeCon_secDNS_title");
	
}

function selectLine(id)
{
	var objTR = getElement(id);
	var wan_mode = document.getElementById("wan_connectionmode");

	initWANDetailInfo();
	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if (temp == 'new')		//新建
		{
			document.getElementById("wan_enable").value = 1;
			document.getElementById("vlan_enable").value = 1;
				
			if(ispName == 16)//越南HGU 由于wan_connectionmode下拉列表在变化，所以新增时清除下拉列表里TR069
			{
				var wanConModeNode = getElement("wan_connectionmode");
				for(var i = 0; i < wanConModeNode.length; i++)
				{
					if(wanConModeNode.options[i].value == "0")//tr069
					{
						wanConModeNode.options.remove(wanConModeNode.options[i].index);
					}
				}
			}
//			Tr069Wan_style(1);//internet
			showSelectNodeByValue(wan_mode, 1);
			document.getElementById("nat_enable").options.selectedIndex = 0;
			document.getElementById("dns_enable").options.selectedIndex = 0;
			WanIndexSwitch(1, currentline);
			document.getElementById("wan_vid").focus();

			if(vlan_all_trans_mark == 1)	//vlan全透传功能
			{
				document.getElementById("vlan_mode").value = 1;//tag
				vlanModeSwitch(1);
			}
			
			setDisplay("apply_table", "");
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			splitDate();
			showFESSID(temp);
			showDate(temp);		
//			Tr069Wan_style(curWANmode);
		}			
		
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;
		
		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);
		
	}	 
}

function LoadFrame()
{
	initTranslation();
	if(ispName == 9)//add by wuxj, 20160809, 罗马尼亚删除IPV6单栈
	{
		getElement("ipv6_enable").options.remove(1);//v6
	}
	
	var wan_connectionmodeNode = document.getElementById("wan_connectionmode");
	if(Have_RADIUS == 1)
	{
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("RADIUS", "7");
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("RADIUS_INTERNET", "8");
	}
	//add by wuxj, 20160531, for ROMANIA, add TR069_VOIP
	if(ispName == 9)//罗马尼亚要求可配TR069_VOIP的WAN
	{
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("TR069_VOIP", "16");
	}
	if(ispName == 16)//越南HGU
	{
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("IPTV", "10");
		wan_connectionmodeNode.options[3].text="Multiscreen";//原other

		wan_connectionmodeNode.options.remove(5);//voip_internet
		wan_connectionmodeNode.options.remove(2);//tr069_internet
		wan_connectionmodeNode.options.remove(0);//tr069
		
		//add by wuxj, 20170405, delete operationMode & retryPeriod
		setDisplay("tr_operationMode", "none");
		setDisplay("tr_retryPeriod", "none");
	}
	if(wan_size == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("fw_ruletable").rows[0];

		if(wan_line == "" || parseInt(wan_line) >= wan_size)
		{
			wan_line = 0;
			selectLine("record_0");
		}
		else
		{
			selectLine("record_" + wan_line);
		}
	
		setDisplay("ConfigForm1", "");
	}

	if(ispName == 5 || ispName == 15)	//HGU X_AIS X_GLOBE
	{
		setDisplay("tr_vlan_enable", ""); 
		setDisplay("tr_pppAuthType", "");
		setDisplay("tr_pppConnTrigger", ""); 
//delete by wuxj, 20180604, 修改为所有设备均支持V6单栈
/*
		if(ipv6_l3_flag == '0')
		{
			getElement("ipv6_enable").options.remove(1);//v6
		}
*/
	}
	//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
	/*厄瓜多尔 罗马尼亚 越南 */
	if((ispName == 12) || (ispName == 9) || (ispName == 16))
	{
		setDisplay("tr_pppAuthType", ""); 
		setDisplay("tr_pppConnTrigger", "");
	}
	if(vlan_all_trans_mark == 1)	//vlan全透传功能
	{
		setDisplay("tr_vlan_mode", "");
		vlanModeSwitch();
	}

	if(wan_size == 0)
	{	
		setDisplay("static", "none");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "none");
	}

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
	
	if(WifiFlag == 1)
	{
		document.getElementById("wan_ssidBox1").disabled = 0;
		document.getElementById("wan_ssidBox2").disabled = 0;
		document.getElementById("wan_ssidBox3").disabled = 0;
		document.getElementById("wan_ssidBox4").disabled = 0;
	}
	else
	{
		document.getElementById("wan_ssidBox1").disabled = 1;
		document.getElementById("wan_ssidBox2").disabled = 1;
		document.getElementById("wan_ssidBox3").disabled = 1;
		document.getElementById("wan_ssidBox4").disabled = 1;
	}								         
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 6)
	{		
//   		alert("最多只能创建5条规则!");
 		alert(_("pf_mostRulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay("ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_new");
	
}

function VIDLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 4094)
		{
			return true;
		}
		else
		{
			alert(_("VID_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("VID_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}
function PriorityLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 7)
		{
			return true;
		}
		else
		{
			alert(_("priority_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("priority_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function MTULegal(dom, connectionTypeValue)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		//modify by wuxj, 20171011, 修改为正确的范围校验
		if(connectionTypeValue == 2)	//pppoe
		{
			if(!checkNumberLegal(dom, 1280, 1492))
			{
				alert(_("mtupppoe_IllegalAlert"));
				return false;
			}
		}
		else								//dhcp static
		{
			if(!checkNumberLegal(dom, 1280, 1500))
			{
				alert(_("mtudhcpstatic_IllegalAlert"));
				return false;
			}			
		}
	}
	else
	{	
		alert(_("mtu_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function initWANDetailInfo()
{
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	document.getElementById("wan_vid").value = "";
	document.getElementById("wan_priority").value = "";	
	document.getElementById("wan_mtu").value = "";
	document.getElementById("wan_enable").value = 1;
	document.getElementById("vlan_enable").value = 1;
	document.getElementById("ipModel").value = 0;
	
	document.getElementById("staticIp").value = "";
	document.getElementById("staticNetmask").value = "";
	document.getElementById("staticGateway").value = "";
	document.getElementById("staticPriDns").value = "";
	document.getElementById("staticSecDns").value = "";
	
	document.getElementById("pppoeUser").value = "";
	document.getElementById("pppoePass").value = "";	
	document.getElementById("wPppoeCon_ip").value = "";
	document.getElementById("wPppoeCon_mask").value = "";
	document.getElementById("wPppoeCon_gateway").value = "";
	document.getElementById("wPppoeCon_priDNS").value = "";
	document.getElementById("wPppoeCon_secDNS").value = "";
	
	document.getElementById("wDhcpCon_ip").value = "";
	document.getElementById("wDhcpCon_mask").value = "";
	document.getElementById("wDhcpCon_gateway").value = "";
	document.getElementById("wDhcpCon_priDNS").value = "";
	document.getElementById("wDhcpCon_secDNS").value = "";
	
	for(var i = 0; i < wifi_ssid_sum; i++)
	{
		wanSsidBoxNode[i].checked =  false;
	}
	wanFEBoxNode[0].checked =  false;
	wanFEBoxNode[1].checked =  false;
	wanFEBoxNode[2].checked =  false;
	wanFEBoxNode[3].checked =  false;
	
	document.getElementById("wan_enable").disabled = 0;	
	document.getElementById("wan_connectionmode").disabled = 0;
	document.getElementById("wan_connectionType").disabled = 0;	
	document.getElementById("wan_vid").disabled = 0;
	document.getElementById("wan_priority").disabled = 0;
	document.getElementById("ipModel").disabled = 0;
	document.getElementById("wan_mtu").disabled = 0;

	document.getElementById("wan_connectionmode").options.selectedIndex = 0;
	document.getElementById("nat_enable").options.selectedIndex = 0;
	document.getElementById("dns_enable").options.selectedIndex = 0;
	
	if(ispName == 16)//越南
	{
		getElement("pppAuthType").options[3].selected = true;	//default: Auto
		getElement("pppConnTrigger").options[1].selected = true;	//default: AlwaysOn
	}
}

function showDate(wanIndex)
{
	var curWAN_mtu;
	var curWANaddress;
	var curWANstaticIP;
	var curWANstaticMask;
	var curWANstaticGW;
	var curWANstaticDns1;
	var curWANstaticDns2;
	var curWANpppoemode;
	var curWANpppoeinterval;
	var curWANpppoestate;
	var curoption60_value;
	var curoption60;
	var curoption43;
	var curroute_brige;
	
	switch(parseInt(wanIndex))
	{
		case 0:
			curWANIndex = Wanindex0Array
			curWANmode = modeWan0Array;
			curWANtype = typeWan0Array;
			curWANaddress = addressWan0Array;	
			curWANstaticIP = Wan0StaticIp;
			curWANstaticMask = Wan0StaticMask;
			curWANstaticGW = Wan0StaticGW;
			curWANstaticDns1 = Wan0StaticDNS1;
			curWANstaticDns2 = Wan0StaticDNS2;
			break;
		case 1:
			curWANIndex = Wanindex1Array
			curWANmode = modeWan1Array;
			curWANtype = typeWan1Array;
			curWANaddress = addressWan1Array;	
			curWANstaticIP = Wan1StaticIp;
			curWANstaticMask = Wan1StaticMask;
			curWANstaticGW = Wan1StaticGW;
			curWANstaticDns1 = Wan1StaticDNS1;
			curWANstaticDns2 = Wan1StaticDNS2;
			break;
		case 2:
			curWANIndex = Wanindex2Array
			curWANmode = modeWan2Array;
			curWANtype = typeWan2Array;
			curWANaddress = addressWan2Array;
			curWANstaticIP = Wan2StaticIp;
			curWANstaticMask = Wan2StaticMask;
			curWANstaticGW = Wan2StaticGW;
			curWANstaticDns1 = Wan2StaticDNS1;
			curWANstaticDns2 = Wan2StaticDNS2;
			break;
		case 3 :
			curWANIndex = Wanindex3Array
			curWANmode = modeWan3Array;
			curWANtype = typeWan3Array;
			curWANaddress = addressWan3Array;
			curWANstaticIP = Wan3StaticIp;
			curWANstaticMask = Wan3StaticMask;
			curWANstaticGW = Wan3StaticGW;
			curWANstaticDns1 = Wan3StaticDNS1;
			curWANstaticDns2 = Wan3StaticDNS2;
			break;
		case 4 :
			curWANIndex = Wanindex4Array
			curWANmode = modeWan4Array;
			curWANtype = typeWan4Array;
			curWANaddress = addressWan4Array;
			curWANstaticIP = Wan4StaticIp;
			curWANstaticMask = Wan4StaticMask;
			curWANstaticGW = Wan4StaticGW;
			curWANstaticDns1 = Wan4StaticDNS1;
			curWANstaticDns2 = Wan4StaticDNS2;
			break;
		default:
			break;	
	}

	if(ispName == 16)//VIETTEL HGU
	{
		var wanConModeNode = getElement("wan_connectionmode");
		if(curWANmode != 0)	//非tr069
		{			
			for(var i = 0; i < wanConModeNode.length; i++)
			{
				if(wanConModeNode.options[i].value == "0")//tr069
				{
					wanConModeNode.options.remove(wanConModeNode.options[i].index);//delete tr069
				}
			}
		}
		else
		{
			wanConModeNode.options[wanConModeNode.length] = new Option("TR069", "0");
		}
	}
	
	curWANpppoemode = WanpppoeMode[wanIndex];
	curWANpppoeinterval = WanpppoeInterval[wanIndex];
	curWANpppoestate = WanpppoeState[wanIndex];
	curoption43 = option43_arr[wanIndex];
	curoption60 = option60_arr[wanIndex];
	curoption60_value = option60_value_arr[wanIndex];
	curroute_brige = route_brige_arr[wanIndex];
	
	document.getElementById("wan_enable").value = wan_enable_arr[wanIndex];	
	document.getElementById("vlan_enable").value = vlanEnableArray[wanIndex];	
	document.getElementById("wan_connectionType").value = curWANtype;
	document.getElementById("wan_connectionmode").value = curWANmode;
	document.getElementById("wan_vid").value = VIDArray[wanIndex];
	document.getElementById("wan_priority").value = PriorityArray[wanIndex];
	document.getElementById("nat_enable").value = NatArray[wanIndex];
	document.getElementById("dns_enable").value = RelayArray[wanIndex];
	document.getElementById("ipModel").value = curWANaddress;

	curWAN_mtu = MTUArray[wanIndex];
	if(curWAN_mtu == 0)
	{
		document.getElementById("wan_mtu").value = "";
	}
	else
	{
		document.getElementById("wan_mtu").value = curWAN_mtu;
	}
	
	if(curWANaddress == 1) /* 静态*/
	{
		document.getElementById("staticIp").value = curWANstaticIP;
		document.getElementById("staticNetmask").value = curWANstaticMask;
		document.getElementById("staticGateway").value = curWANstaticGW;
		document.getElementById("staticPriDns").value = curWANstaticDns1;
		document.getElementById("staticSecDns").value = curWANstaticDns2;
	}
	else if(curWANaddress == 2)/*pppoe*/
	{
		document.getElementById("pppoeUser").value = html_decode(WanpppoeName[wanIndex]);
		document.getElementById("pppoePass").value = html_decode(WanpppoePwd[wanIndex]);
		document.getElementById("pppoeOPMode").value = curWANpppoemode;
		
		document.getElementById("pppAuthType").value = pppAuthTypeArray[wanIndex];
		document.getElementById("pppConnTrigger").value = pppConnTriggerArray[wanIndex];
//		pppoeOPModeSwitch();
		document.getElementById("ppp_outtime").value = pppOutTimeArray[wanIndex];
	
		if(curWANpppoestate == 1)
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_connect");
		}
		else
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_disconnect");
		}

		if((curWANpppoemode == 0) || (curWANpppoemode == 1))
		{
			document.getElementById("pppoeRetryPeriod").value = curWANpppoeinterval;
		}
		
		document.getElementById("wPppoeCon_ip").value = curWANstaticIP;
		document.getElementById("wPppoeCon_mask").value = curWANstaticMask;
		document.getElementById("wPppoeCon_gateway").value = curWANstaticGW;
		document.getElementById("wPppoeCon_priDNS").value = curWANstaticDns1;
		document.getElementById("wPppoeCon_secDNS").value = curWANstaticDns2;
	}
	else  /*dhcp*/
	{
		document.getElementById("wDhcpCon_ip").value = curWANstaticIP;
		document.getElementById("wDhcpCon_mask").value = curWANstaticMask;
		document.getElementById("wDhcpCon_gateway").value = curWANstaticGW;
		document.getElementById("wDhcpCon_priDNS").value = curWANstaticDns1;
		document.getElementById("wDhcpCon_secDNS").value = curWANstaticDns2;
	}
	
	WanIndexSwitch(curWANmode, currentline);
//	ConnectTypeSwitch(curWANtype);

	if ((curWANmode  == 0) || (curWANmode == 3) || (curWANmode  == 4) 
		||(curWANmode  == 2) ||(curWANmode  == 5) ||(curWANmode  == 16)||(curWANmode  == 10))
	{
		document.getElementById("wan_connectionType").disabled = 1;
		
		setDisplay("tb_nat_dns", "");
		if(ispName == 15)	//X_GLOBE
			setDisplay("tr_natType", "");
		
		if((curWANmode  == 0) || (curWANmode == 3) || (curWANmode  == 4) ||(curWANmode  == 16) ||(curWANmode  == 10))
		{
			setDisplay("wan_ipv6enable", "none");
			ipv6_enableSwitch()
		}
		else
		{	
			setDisplay("wan_ipv6enable", "");
			ipv6_enableSwitch()
		}
		setDisplay("tb_wanIPModel", "");	
//		ipModelSwitch();
		if(curWANmode  == 3 ||(curWANmode  == 10)) /*组播为桥接模式*/
		{
			setDisplay("tb_nat_dns", "none");
			setDisplay("tb_wanIPModel", "none");	   
			setDisplay("pppoe", "none");
			setDisplay("dhcp", "none");
			setDisplay("static", "none");
		}
	}
	else		//1:internet
	{
		if(parseInt(brige_wan_only) == 1)	/*01A9G只支持internet 桥接wan*/
		{
			document.getElementById("wan_connectionType").disabled = 1;
		}
		else
		{
			document.getElementById("wan_connectionType").disabled = 0;
		}
		
		setDisplay("tb_nat_dns", "");
		if(ispName == 15)	//X_GLOBE
			setDisplay("tr_natType", "");
	
		setDisplay("wan_ipv6enable", "");
		ipv6_enableSwitch()
	
		setDisplay("tb_wanIPModel", "");	
//		ipModelSwitch();
		
	}

	/*只有internet相关 可以配置ipv6*/
	if((curWANmode  == 1) || (curWANmode == 2) || (curWANmode  == 5))
	{
		var ipv6_enable_s  = document.getElementById("ipv6_enable");
		var dslite_enable_s  = document.getElementById("DS_Lite_enable");
		var aftr_mode_s  = document.getElementById("AFTR_enable");
		
		setDisplay("wan_ipv6enable", "");	
//		ipv6_enable_s.value = ipv6_state;
		if(ispName == 12)/*厄瓜多尔, IPV6多wan*/
		{
			showSelectNodeByValue(ipv6_enable_s, ipv6_enable_arr[wanIndex]);
			if(curWANaddress == 1) /* 静态*/
			{
				document.getElementById("staticIp_ipv6").value = ip6addr_arr[wanIndex];
				document.getElementById("Prefix_Length").value = ipv6_prelength_arr[wanIndex];
				document.getElementById("IPv6_Gateway").value = ipv6_gateway_arr[wanIndex];
				document.getElementById("IPv6_Pri_DNS").value = ipv6_pridns_arr[wanIndex];
				document.getElementById("IPv6_Sec_DNS").value = ipv6_secdns_arr[wanIndex];
				document.getElementById("IPv6_prefix").value = ipv6_prefix_arr[wanIndex];
			}
			current_prefix_v6_dhcp = prefix_v6_dhcp_arr[wanIndex]
			current_prefix_v6_pppoe = prefix_v6_pppoe_arr[wanIndex]
		}
		else
		{
			showSelectNodeByValue(ipv6_enable_s, ipv6_state);
		}

//		dslite_enable_s.value = dslite_enable;
		showSelectNodeByValue(dslite_enable_s, dslite_enable);

//		aftr_mode_s.value = aftr_mode;
		showSelectNodeByValue(aftr_mode_s, aftr_mode);
		
		ipv6_enableSwitch();
	}
	else
	{
		setDisplay("wan_ipv6enable", "none");
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
	}

	ConnectTypeSwitch(curWANtype);

	if(curWANmode == 0)  /*江苏电信tr069  wan 参数不能修改*/
	{
		//setDisplay("apply_table", "none");
	}
	else
	{
		setDisplay("apply_table", "");
	}

	/*桥接IPV6_V4模式*/
	var wan_ipv6enable_node = document.getElementById("ipv6_enable");
	showSelectNodeByValue(wan_ipv6enable_node, tr069_v6_v4_mode);
	
	document.getElementById("vlan_mode").value = vlanModeArray[wanIndex];
	vlanModeSwitch(vlanModeArray[wanIndex]);	
}

function checkWanRepeat(temp)
{
	var k = 0;
	
	if(wan_size > 0)
	{
		for(k = 0; k < wan_size; k++)
	    {
			if(temp != 'new') /*修改wan*/
			{
				if(temp != k) /*temp 为当前修改wan的行号，不和自己进行比较*/
				{
					if(!checkWan(k))
					{
						return false;
					}
				}
			}
			else /*新增wan*/
			{	
				if(!checkWan(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}

/*校验wan类型的重复性*/
function checkWan(k)
{
	var wan_vid = document.getElementById("wan_vid");
	var wan_mode = document.getElementById("wan_connectionmode");
	var vlan_mode = document.getElementById("vlan_mode");
	var connect_type = document.getElementById("wan_connectionType");
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");

	if((ispName != 5) && (ispName != 9))//AIS 、罗马尼亚 vid可以一样
	{
		if(wan_vid.value == VIDArray[k])/*vid 不能一样*/
		{
			alert(_("this VID have exist!"));
			return false;						
		}
	}
	/*add by gxy,20170112,原因:越南HGU版本Multicast、IPTV不能同时存在*/
	if(ispName == 16)//越南HGU
	{
		if(wan_mode.value == 10) /*当前wan为IPTV*/
		{
			if(modeArray[k] == 3)  /*非当前wan中存在Multicast */
			{
				alert(_("IPTV_Multicast_RepeatAlert"));
				return false;
			}
		}
		if(wan_mode.value == 3) /*当前wan为Multicast*/
		{
			if(modeArray[k] == 10)  /*非当前wan中存在IPTV*/
			{
				alert(_("Multicast_IPTV_RepeatAlert"));
				return false;
			}
		}
		
	}
	if(vlan_mode.options.selectedIndex != 1)/*VLAN 透传模式，一个端口可以配多条业务*/
	{
		//internet相关及组播
		//add by gxy,20170112,原因:新增IPTV绑定端口校验
		if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 3) || (wan_mode.value == 5)|| (wan_mode.value == 10))
		{
			if(!checkPortBind(wanFEBoxNode, feArray[k].split(","),lan_port_num))
			{
				alert(_("wan_portBindedAlert"));
				return false;
			}
			if(!checkPortBind(wanSsidBoxNode, ssidArray[k].split(","),wifi_ssid_sum))
			{
				alert(_("wan_portBindedAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 0) /*当前wan为TR069*/
	{
		if(modeArray[k] == 0)  /*非当前wan中存在TR069 */
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2) /*非当前wan中存在INTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*非当前wan中存在TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
	}
	if((wan_mode.value == 1) && (connect_type.value == 1)) /*当前wan为INTERNET-ROUTE*/
	{
		if(ispName != 12) //厄瓜多尔版本可以配置多条路由wan，其他版本不允许
		{
			if(modeArray[k] == 5)/*非当前wan中存在INTERNET_VOIP*/
			{
				alert(_("INTERNET_VOIP_wan_RepeatAlert"));
				return false;
			}
			if(modeArray[k] == 2)/*非当前wan中存在INTERNET_TR069*/
			{
				alert(_("INTERNET_TR069_wan_RepeatAlert"));
				return false;
			}
						
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*非当前wan中存在INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 2) /*当前wan为INTERNET_TR069*/
	{
		if(modeArray[k] == 0) 		/*非当前wan中存在TR069*/
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2)		/*非当前wan中存在NTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*非当前wan中存在TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(ispName != 12) //厄瓜多尔版本可以配置多条路由wan，其他版本不允许
		{
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*非当前wan中存在INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 4) /*当前wan为VOIP*/
	{
		if(modeArray[k] == 4) /*非当前wan中存在VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*非当前wan中存在NTERNET_VOIP */
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*非当前wan中存在TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
	}
	if(wan_mode.value == 5) /*当前wan为INTERNET_VOIP*/
	{
		if(modeArray[k] == 4)/*非当前wan中存在VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*非当前wan中存在INTERNET_VOIP*/
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*非当前wan中存在TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(ispName != 12) //厄瓜多尔版本可以配置多条路由wan，其他版本不允许
		{
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*非当前wan中存在INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 16) /*当前wan为TR069_VOIP*/
	{
		if(modeArray[k] == 0)  /*非当前wan中存在TR069 */
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2) /*非当前wan中存在INTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*非当前wan中存在TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 4)/*非当前wan中存在VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*非当前wan中存在INTERNET_VOIP*/
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
	}
	
	return true;
}

function checkValue()
{
	var vlan_id = getElement("wan_vid");
	var vprioriry = getElement("wan_priority");
	var wan_mode = document.getElementById("wan_connectionmode");
	var wan_type  = document.getElementById("wan_connectionType");
	var connectionType =  document.getElementById("ipModel");
	var staticIp_v =  document.getElementById("staticIp");
	var staticNetmask_v =  document.getElementById("staticNetmask");
	var staticGateway_v =  document.getElementById("staticGateway");
	var staticPriDns_v =  document.getElementById("staticPriDns");
	var staticSecDns_v =  document.getElementById("staticSecDns");
	var pppoeUserNode = document.getElementById("pppoeUser");
	var pppoePassNode = document.getElementById("pppoePass");
	var pppoeOPModeNode = document.getElementById("pppoeOPMode");
	var pppoeRetryPeriod = document.getElementById("pppoeRetryPeriod");
	var pppoeOPMode = document.getElementById("pppoeOPMode");
	var v4_v6_mode = document.getElementById("ipv6_enable");

	var DS_Lite_mode = document.getElementById("DS_Lite_enable");
	var AFTR_mode = document.getElementById("AFTR_enable");
	var AFTR_value_node = document.getElementById("AFTR_value");
	var staticIp_v6_node =  document.getElementById("staticIp_ipv6");
	var Ipv6_len_node =  document.getElementById("Prefix_Length");
	var Ipv6_Gateway_node =  document.getElementById("IPv6_Gateway");
	var Ipv6_Pri_DNS_node =  document.getElementById("IPv6_Pri_DNS");
	var IPv6_prefix_node =  document.getElementById("IPv6_prefix");

	var mut_value = document.getElementById("wan_mtu");

	if(!checkWanRepeat(currentline))
	{
		return false;
	}
	if(getElement("vlan_mode").value != 3)	//非全透传
	{
		if(!VIDLegal(vlan_id))
		{
			return false;
		}
		if(!PriorityLegal(vprioriry))
		{
			return false;
		}
	}

	if(wan_type.options.selectedIndex == 1)
	{
		if(mut_value.value != "")  
		{
			if(!MTULegal(mut_value, connectionType.value))
			{
				return false;
			}
		}
	}
	//v6
				/*internet, internet_tr069, internet_voip*/
	if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 5))
	{
		if((v4_v6_mode.value == 2)  && (wan_type.options.selectedIndex == 1) 
			&& (DS_Lite_mode.options.selectedIndex == 1) && (AFTR_mode.options.selectedIndex == 1))
		{	
			if (!CheckNotNull(AFTR_value_node.value)) 
			{
				alert(_("ipv6AFTRAlert"));
				AFTR_value_node.value = AFTR_value_node.defaultValue;
				AFTR_value_node.focus();
				return false;
			}
		}
	}
	
   if ((connectionType.value == 1) && (wan_type.value == 1)) /*static */
   {
   		if((v4_v6_mode.value == 3))	//v4&v6
   		{
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

			/*internet, internet_tr069, internet_voip*/
			if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 5))
			{
				if (!CheckNotNull(staticIp_v6_node.value)) 
				{					
					alert(_("ipv6Alert"));
					staticIp_v6_node.value = staticIp_v6_node.defaultValue;
					staticIp_v6_node.focus();
					return false;
				}
				if(!checkV6PrefixLength(64, Ipv6_len_node.value))
				{
					alert(_("v6len_IllegalAlert"));
					Ipv6_len_node.value = Ipv6_len_node.defaultValue;
					Ipv6_len_node.focus();
					return false;
				}
				if (!CheckNotNull(Ipv6_Gateway_node.value)) 
				{					
					alert(_("ipv6GWAlert"));
					Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
					Ipv6_Gateway_node.focus();
					return false;
				}
				if (!CheckNotNull(Ipv6_Pri_DNS_node.value)) 
				{					
					alert(_("ipv6dnsAlert"));
					Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
					Ipv6_Pri_DNS_node.focus();
					return false;
				}
				if (!CheckNotNull(IPv6_prefix_node.value)) 
				{					
					alert(_("ipv6prefixAlert"));
					IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
					IPv6_prefix_node.focus();
					return false;
				}
			}
   		}
		else if( (v4_v6_mode.value == 1))	//v4
		{
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
		else if((v4_v6_mode.value == 2))	//v6
		{
			/*internet, internet_tr069, internet_voip*/
			if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 5))
			{
				if (!CheckNotNull(staticIp_v6_node.value)) 
				{					
					alert(_("ipv6Alert"));
					staticIp_v6_node.value = staticIp_v6_node.defaultValue;
					staticIp_v6_node.focus();
					return false;
				}
				if(!checkV6PrefixLength(64, Ipv6_len_node.value))
				{
					alert(_("v6len_IllegalAlert"));
					Ipv6_len_node.value = Ipv6_len_node.defaultValue;
					Ipv6_len_node.focus();
					return false;
				}
				if (!CheckNotNull(Ipv6_Gateway_node.value)) 
				{					
					alert(_("ipv6GWAlert"));
					Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
					Ipv6_Gateway_node.focus();
					return false;
				}
				if (!CheckNotNull(Ipv6_Pri_DNS_node.value)) 
				{					
					alert(_("ipv6dnsAlert"));
					Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
					Ipv6_Pri_DNS_node.focus();
					return false;
				}
				if (!CheckNotNull(IPv6_prefix_node.value)) 
				{					
					alert(_("ipv6prefixAlert"));
					IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
					IPv6_prefix_node.focus();
					return false;
				}
			}

		}
   }

   else if ((connectionType.value == 2) && (wan_type.value == 1))/*PPPOE*/
   { 
	   	
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
		/*厄瓜多尔, AIS,罗马尼亚 X_GLOBE 越南 */
		if((ispName == 12) || (ispName == 5) || (ispName == 9) || (ispName == 15) || (ispName == 16))
		{
			var pppConnTrigger = document.getElementById("pppConnTrigger");
			var ppp_outtime = document.getElementById("ppp_outtime");
			var wan_conmode = document.getElementById("wan_connectionmode");
			
			if((wan_conmode.value != 0) && (wan_conmode.value != 4)) /*TR069, VOIP*/
			{
				if(pppConnTrigger.options.selectedIndex == 0)
				{
					if(!checkNumberLegal(ppp_outtime, 30, 60000))					/* validate whether legal */
					{		
						ppp_outtime.value = ppp_outtime.defaultValue;
						ppp_outtime.focus();
						alert(_("PPPoe OutTime value illegal!"));
						return false;
					}
				}
			}
		}		
	}

   if(voip_port_num == 0)
   {
		if((wan_mode.value == 5) || (wan_mode.value == 4))
		{
			alert(_("voip_wan_alert"));
			return false;
		}

   }
   //delete by wuxj, 20170502, TR069重复性校验已在checkWan中实现，以下校验未考虑修改流程
   /*
   if((modeWan0Array == 0) || (modeWan1Array == 0) || (modeWan2Array == 0) || (modeWan3Array == 0))
   {
		if(wan_mode.value == 2)
		{
			alert(_("tr069Wan_exist_alert"));
			return false;
		}
   }*/

	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
   	if((wan_mode.value == 1) || (wan_mode.value == 2) 
		|| (wan_mode.value == 5) || (wan_mode.value == 3) || (wan_mode.value == 10))
   	{	//INTERNET相关及Other
			if((wanFEBoxNode[0].checked == false) && (wanFEBoxNode[1].checked == false) 
				&& (wanFEBoxNode[2].checked == false) && (wanFEBoxNode[3].checked == false)
				&& (wanSsidBoxNode[0].checked == false) && (wanSsidBoxNode[1].checked == false) 
				&& (wanSsidBoxNode[2].checked == false) && (wanSsidBoxNode[3].checked == false))
			{
				alert(_("port_band_alert"));
				return false;
			}
   	}

	load_waiting();
	return true;
}

