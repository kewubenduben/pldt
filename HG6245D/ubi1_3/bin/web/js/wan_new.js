/***********************************************************************************
wan_new.js
wuxj
2015.5.22
wan JS functions
***********************************************************************************/

/* modify by wuxj, 20160808, ԭ��:�Ż�ʵ�֣���չ֧��8��SSID  */
function showFESSID(wanIndex)
{
	var checkedFEValue = new Array(1, 2, 4, 8);//Ŀǰ���4��LAN
	var checkedSSIDValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);//8��SSID
	
	var curFEArr = feArray[parseInt(wanIndex)].split(",");
	var curSSIDArr = ssidArray[parseInt(wanIndex)].split(",");

	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	/*lan band ��ѡ*/
	for(var i = 0; i < lanSum; i++)
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
	/*ssid band ��ѡ*/
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
	
	/*�˿ڰ���ʱֻ��
	for(i = 0; i < 4; i++)
	{
		wanFEBoxNode[i].disabled = 1;
		wanSsidBoxNode[i].disabled = 1;	
	}*/

	if(ispName == '25' || ispMinorNameCode == '24')/* ��³����/NETLIFE */
	{
		var portfe_layerArr = portfe_layerData.split(",");	
		for(var j = 0; j < lanSum; j++)/*lan band ��ѡ*/
		{
			if(portfe_layerArr[j] != checkedFEValue[j])
			{
				wanFEBoxNode[j].disabled = 1;
			}
		}
	}
	
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

	//modify by wuxj, 20181205, ����֧��WEB_COMM_WAN_CFG
	if(WEB_COMM_WAN_CFG == 1)
	{
		getElement("AFTR_value").value = "";
		
		getElement("staticIp_ipv6").value = "";
		getElement("IPv6_Gateway").value = "";
		getElement("IPv6_Pri_DNS").value = "";
		getElement("IPv6_Sec_DNS").value = "";
		getElement("Prefix_Length").value = "";
		getElement("IPv6_prefix").value = "";
	}
	getElement("ipv6_enable").value = 0;
	
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
}

function showDate(wanIndex)
{
	var curWANaddress = addressArray[wanIndex];
	
	var curWANstaticIP = WanStaticIp[wanIndex];
	var curWANstaticMask = WanStaticMask[wanIndex];
	var curWANstaticGW = WanStaticGW[wanIndex];
	var curWANstaticDns1 = WanStaticDNS1[wanIndex];
	var curWANstaticDns2 = WanStaticDNS2[wanIndex];
	
	var curWANpppoemode = WanpppoeMode[wanIndex];
	
	curWANIndex = wanIndexArray[wanIndex];
	curWANmode = modeArray[wanIndex];
	curWANtype = typeArray[wanIndex];

	document.getElementById("wan_enable").value = wan_enable_arr[wanIndex];
	
	document.getElementById("vlan_enable").value = vlanEnableArray[wanIndex];
	
	document.getElementById("wan_connectionType").value = curWANtype;
	document.getElementById("wan_connectionmode").value = curWANmode;
	if(ispName == 5 && curWANmode == 2)	/* add by ��С��, 20170502, ԭ��:̩��AISҪ��TR069_INTERNET WAN�����޸�ҵ������ */
	{		
		document.getElementById("wan_connectionmode").disabled = 1;
	}
	
	document.getElementById("wan_vid").value = VIDArray[wanIndex];
	document.getElementById("wan_priority").value = PriorityArray[wanIndex];
	if(MTUArray[wanIndex] == 0)
	{
		document.getElementById("wan_mtu").value = "";
	}
	else
	{
		document.getElementById("wan_mtu").value = MTUArray[wanIndex];
	}


	document.getElementById("ipModel").value = curWANaddress;
	
	if(curWANaddress == 1) /* ��̬*/
	{
		document.getElementById("staticIp").value = space2null(html_decode(curWANstaticIP));
		document.getElementById("staticNetmask").value = space2null(html_decode(curWANstaticMask));
		document.getElementById("staticGateway").value = space2null(html_decode(curWANstaticGW));
		document.getElementById("staticPriDns").value = space2null(html_decode(curWANstaticDns1));
		document.getElementById("staticSecDns").value = space2null(html_decode(curWANstaticDns2));
	}
	else if(curWANaddress == 2)/*pppoe*/
	{
		document.getElementById("pppoeUser").value = WanpppoeName[wanIndex];
		document.getElementById("pppoePass").value = WanpppoePwd[wanIndex];
		document.getElementById("pppoeOPMode").value = curWANpppoemode;

		//modify by wuxj, 20181205, ����֧��WEB_WAN_CONN_TRIGGER
		//modify by wuxj, 20170622, �����Ƕ��ư汾������ʾ������timeout������
		//AIS ��϶�� �������� X_GLOBE Խ�� ̩��TRUE
		if((WEB_WAN_CONN_TRIGGER == '1')
			|| (ispName == 12) || (ispName == 5) || (ispName == 9)|| (ispName == 15) || (ispName == 16) || (ispName == 22))
		{
			document.getElementById("pppAuthType").value = pppAuthTypeArray[wanIndex];
			document.getElementById("pppConnTrigger").value = pppConnTriggerArray[wanIndex];//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
//			pppoeOPModeSwitch();
			document.getElementById("ppp_outtime").value = space2null(html_decode(pppOutTimeArray[wanIndex]));
		}
	
		if(WanpppoeState[wanIndex] == 1)
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_connect");
		}
		else
		{
			document.getElementById("wPppoeCon_status").innerHTML = _("wPppoe_disconnect");
		}

		if((curWANpppoemode == 0) || (curWANpppoemode == 1))
		{
			document.getElementById("pppoeRetryPeriod").value = WanpppoeInterval[wanIndex];
		}
		
		document.getElementById("wPppoeCon_ip").value = html_decode(curWANstaticIP);
		document.getElementById("wPppoeCon_mask").value = html_decode(curWANstaticMask);
		document.getElementById("wPppoeCon_gateway").value = html_decode(curWANstaticGW);
		document.getElementById("wPppoeCon_priDNS").value = html_decode(curWANstaticDns1);
		document.getElementById("wPppoeCon_secDNS").value = html_decode(curWANstaticDns2);
	}
	else  /*dhcp*/
	{
		document.getElementById("wDhcpCon_ip").value = html_decode(curWANstaticIP);
		document.getElementById("wDhcpCon_mask").value = html_decode(curWANstaticMask);
		document.getElementById("wDhcpCon_gateway").value = html_decode(curWANstaticGW);
		document.getElementById("wDhcpCon_priDNS").value = html_decode(curWANstaticDns1);
		document.getElementById("wDhcpCon_secDNS").value = html_decode(curWANstaticDns2);
		//var option43_tip = document.getElementsByName("option43_enable");
		//var option60_tip = document.getElementsByName("option60_enable");
		//document.getElementById("option60_value").value = option60_value_arr[wanIndex];
		
		/*	for(var i = 0;i<option43_tip.length;i++)
			{
				if(option43_tip[i].value == option43_arr[wanIndex])
				{
					option43_tip[i].checked = true;
					break;
				}
			}
			
			for(var i = 0;i<option60_tip.length;i++)
			{
				if(option60_tip[i].value == option60_arr[wanIndex])
				{
					option60_tip[i].checked = true;
					break;
				}
			}*/
	}
	WanIndexSwitch(curWANmode);

	/*ֻ��internet��� ��������ipv6*/
	if((curWANmode  == 1) || (curWANmode == 2) || (curWANmode  == 5)
		|| (curWANmode  == 8) ||(curWANmode  == 17))
	{
		var ipv6_enable_s  = document.getElementById("ipv6_enable");
		var dslite_enable_s  = document.getElementById("DS_Lite_enable");
		var aftr_mode_s  = document.getElementById("AFTR_enable");
		var AFTR_value_node = getElement("AFTR_value");
		
		var staticIp_ipv6_node = getElement("staticIp_ipv6");
		var IPv6_Gateway_node = getElement("IPv6_Gateway");
		var IPv6_Pri_DNS_node = getElement("IPv6_Pri_DNS");
		var IPv6_Sec_DNS_node = getElement("IPv6_Sec_DNS");
		var Prefix_Length_node = getElement("Prefix_Length");
		var IPv6_prefix_node = getElement("IPv6_prefix");
	
//		setDisplay("wan_ipv6enable", "");	
//		ipv6_enable_s.value = ipv6_state;
		if(ispName == 12)/*��϶��, IPV6��wan*/
		{
			showSelectNodeByValue(ipv6_enable_s, ipv6_enable_arr[wanIndex]);
			if(curWANaddress == 1) /* ��̬*/
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
		else if(WEB_COMM_WAN_CFG == 1)//modify by wuxj, 20181205, ����֧��WEB_COMM_WAN_CFG
		{
			ipv6_enable_s.value = space2null(html_decode(ipv6_state_arr[wanIndex]));
			dslite_enable_s.value = space2null(html_decode(dslite_enable_arr[wanIndex]));
			aftr_mode_s.value = space2null(html_decode(aftr_mode_arr[wanIndex]));
			AFTR_value_node.value = space2null(html_decode(aftr_value_arr[wanIndex]));
			
			staticIp_ipv6_node.value = space2null(html_decode(staticIp_ipv6_arr[wanIndex]));
			IPv6_Gateway_node.value = space2null(html_decode(IPv6_Gateway_arr[wanIndex]));
			IPv6_Pri_DNS_node.value = space2null(html_decode(IPv6_Pri_DNS_arr[wanIndex]));
			IPv6_Sec_DNS_node.value = space2null(html_decode(IPv6_Sec_DNS_arr[wanIndex]));
			Prefix_Length_node.value = space2null(html_decode(Prefix_Length_arr[wanIndex]));
			IPv6_prefix_node.value = space2null(html_decode(IPv6_prefix_arr[wanIndex]));
		}
		else
		{
			ipv6_enable_s.value = space2null(html_decode(ipv6_state));
			dslite_enable_s.value = space2null(html_decode(dslite_enable));
			aftr_mode_s.value = space2null(html_decode(aftr_mode));
			AFTR_value_node.value = space2null(html_decode(aftr_value));
			
			staticIp_ipv6_node.value = space2null(html_decode(staticIp_ipv6));
			IPv6_Gateway_node.value = space2null(html_decode(IPv6_Gateway));
			IPv6_Pri_DNS_node.value = space2null(html_decode(IPv6_Pri_DNS));
			IPv6_Sec_DNS_node.value = space2null(html_decode(IPv6_Sec_DNS));
			Prefix_Length_node.value = space2null(html_decode(Prefix_Length));
			IPv6_prefix_node.value = space2null(html_decode(IPv6_prefix));
		}
	}
	else
	{
		setDisplay("wan_ipv6enable", "none");
		setDisplay("static_ipv6", "none");
		setDisplay("dhcp_ipv6", "none");
		setDisplay("pppoe_ipv6", "none");
	}

	ConnectTypeSwitch(curWANtype);
	
	//����ConnectTypeSwitch���ж�nat_enable��dns_enable��Ĭ�ϸ�ֵ���������������ض���ֵ�������
	document.getElementById("nat_enable").value = NatArray[wanIndex];
	document.getElementById("dns_enable").value = RelayArray[wanIndex];

	if(curWANmode == 0)  /*���յ���tr069  wan ���������޸�*/
	{
		//setDisplay("apply_table", "none");
	}
	else
	{
		setDisplay("apply_table", "");
	}

	//���·����ģʽ
/*	var route_brige_value = '<% getCfgGeneral(1, "route_brige_en"); %>';
	var route_brige_enable = getElement("route_brige_enable");

	if(route_brige_arr[wanIndex] == 1)
	{
		route_brige_enable.checked = true;			
	}
	else
	{
        route_brige_enable.checked =  false;	
	}*/

	/*�Ž�IPV6_V4ģʽ*/
	var wan_ipv6enable_node = document.getElementById("ipv6_enable");
	//	wan_ipv6enable_node.value = ipv6_v4_brige_value;
	showSelectNodeByValue(wan_ipv6enable_node, ipv6_v4_brige_value);
	
	document.getElementById("vlan_mode").value = vlanModeArray[wanIndex];
	vlanModeSwitch(vlanModeArray[wanIndex]);	
}

function ipv6_enableSwitch()
{
    var ipModelNode = document.getElementById("ipModel");
	var wan_ipv6enable = document.getElementById("ipv6_enable");

	if ((wan_ipv6enable.value == 3) )//v4 v6
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
		
		setDisplay("dsline_ipv6_table", "none");
		setDisplay("AFTR_ipv6_table", "none");
		setDisplay("AFTR_value_table", "none");
		
	}
	else if ((wan_ipv6enable.value == 2) )//v6
	{
		//modify by wuxj, 20160815, ԭ��:�޸�Ϊ���ݹ��ܺ���ʾ
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
	
	if (ipModelNode.options.selectedIndex == 1)//static
	{
		getElement('span_mtu').innerHTML = _("mtu_1500");	//modify by wuxj, 20170515, from�
		setDisplay("static", "");
	}
	else if (ipModelNode.options.selectedIndex == 0)//dhcp
	{
		getElement('span_mtu').innerHTML = _("mtu_1500");//modify by wuxj, 20170515, from�
		setDisplay("dhcp", "");

		if(ispName == 12)/*��϶��*/
		{
			Prefix_dhcp_node.options.selectedIndex = current_prefix_v6_dhcp;
		}
		else if(WEB_COMM_WAN_CFG == 1)//modify by wuxj, 20181205, ����֧��WEB_COMM_WAN_CFG
			Prefix_dhcp_node.options.selectedIndex = v6_addr_mode_arr[currentline];
		else
		{
			Prefix_dhcp_node.options.selectedIndex = prefix_v6_dhcp;
		}
		
	}
	else if (ipModelNode.options.selectedIndex == 2)//pppoe
	{
		//modify by wuxj, 20181205, ����֧��WEB_WAN_CONN_TRIGGER
		//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
		//AIS ��϶�� �������� X_GLOBE Խ��
		if((WEB_WAN_CONN_TRIGGER == '1') 
			|| (ispName == 12) || (ispName == 5) || (ispName == 9)|| (ispName == 15) || (ispName == 16))
		{
			if((wan_conmode.value == 0) || (wan_conmode.value == 4) || (wan_conmode.value == 16)) /*TR069, VOIP*/
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
		getElement('span_mtu').innerHTML = _("mtu_1492");//modify by wuxj, 20170515, from�
		setDisplay("pppoe", "");

		if(ispName == 12)/*��϶��*/
		{
			Prefix_pppoe_node.options.selectedIndex = current_prefix_v6_pppoe;
		}
		else if(WEB_COMM_WAN_CFG == 1)//modify by wuxj, 20181205, ����֧��WEB_COMM_WAN_CFG
			Prefix_pppoe_node.options.selectedIndex = v6_addr_mode_arr[currentline];		
		else
		{
			Prefix_pppoe_node.options.selectedIndex = prefix_v6_pppoe;
		}
		
	}
	ipv6_enableSwitch();//·��WAN����IP����ģʽ�����ʾ����	
}

function pppoeOPModeSwitch()
{
	var PppoeMode =  document.getElementById("pppConnTrigger");
	var wan_conmode = document.getElementById("wan_connectionmode");

	if((wan_conmode.value != 0) && (wan_conmode.value != 4) && (wan_conmode.value != 16)) /*TR069, VOIP*/
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
	document.location = "/goform/ppp_manual_connect?fw_curIndex=" + fw_curIndex.value
		+ "&ppphiddenButton=" + ppphiddenButton_node.value
		+ "&csrftoken=" + getCsrftoken();
}

//route/bridge
function ConnectTypeSwitch(chooseConnType)
{
	var ipv6_enable_s  = document.getElementById("ipv6_enable");
	var wan_conmode = document.getElementById("wan_connectionmode");

	/* modify by wuxj, 20170926, ip modeֻ��·��internet���ʱ��Ч */
	//·��internet���
	if((chooseConnType == 1)
	 && ((wan_conmode.value == 1) || (wan_conmode.value == 2) 
		|| (wan_conmode.value == 5) || (wan_conmode.value == 17) || (wan_conmode.value == 8)))
	{
		setDisplay("wan_ipv6enable", "");
//		ipv6_enableSwitch();
		setDisplay("tb_nat_dns", "");
		showSelectNodeByValue(getElement('nat_enable'), 1);
		showSelectNodeByValue(getElement('dns_enable'), 1);
		
		if(ispName == 15)	//X_GLOBE
			setDisplay("tr_natType", "");
	}
	else
	{
		showSelectNodeByValue(ipv6_enable_s, 1);//v4--��������ʾ��V6����ر�
		setDisplay("wan_ipv6enable", "none");
		setDisplay("tb_nat_dns", "none");
	}
	
	if (chooseConnType == 1) 	/* route */
	{
		setDisplay("tb_wanIPModel", "");//dhcp/static/pppoe	
		ipModelSwitch();

		//internet���
		if((wan_conmode.value == 1) || (wan_conmode.value == 2)
			|| (wan_conmode.value == 5) || (wan_conmode.value == 17)
			|| (wan_conmode.value == 8) )	//RADIUS_INTERNET
		{
			//add by wuxj, 20170522, tr181 internet route don't need port band
			if(WEB_DATAMODEL_181 == '1')
			{
				setDisplay("port_bang", "none");
			}
		}
	}
	else /*bridge*/
	{
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
		
		//internet���
		if((wan_conmode.value == 1) || (wan_conmode.value == 2)
			|| (wan_conmode.value == 5) || (wan_conmode.value == 17)
			|| (wan_conmode.value == 8) )	//RADIUS_INTERNET
		{
			//add by wuxj, 20170522, tr181 internet route don't need port band
			if(WEB_DATAMODEL_181 == '1')
			{
				setDisplay("port_bang", "");
			}
		}
	}
}
//Service Type: 0:TR069 1:INTERNET 2:TR069_INTERNET 3:Other 4:VOIP 5:VOIP_INTERNET 
//16:TR069_VOIP 17: TR069_VOIP_INTERNET
function WanIndexSwitch(chooseWanValue)
{	
	var select_WANtype = document.getElementById("wan_connectionType");

	Tr069Wan_style(chooseWanValue);
	
	//modify by wuxj, 20180227, ���а汾���޸�ΪTR069���WAN�����޸�Ϊ��TR069�������
	/*add begin by �����ã�20170313,ԭ��:GLOBE tr069_internet WAN�������óɲ���TR069 wan����*/
//	if( ispName == 15 )//GLOBE
	if( currentline != 'new' )//modify
	{
		//0:TR069 2:TR069_INTERNET 16:TR069_VOIP 17:TR069_INTERNET_VOIP
		if(curWANmode == 0 ||curWANmode == 2
			||curWANmode == 16 ||curWANmode == 17)
		{
			if(chooseWanValue != 0 &&  chooseWanValue != 2
				&&  chooseWanValue != 16 &&  chooseWanValue != 17)
			{
				//alert("Please make sure that there is one tr069 wan!");
				alert(_("tr069_wan_alert"));
				showSelectNodeByValue(getElement('wan_connectionmode'),curWANmode);
				return;
			}
		}
	}
	/*add end by �����ã�20170313*/

	//0:TR069 1:INTERNET 2:TR069_INTERNET 3:Other 4:VOIP 5:VOIP_INTERNET
	//16:TR069_VOIP 17: TR069_VOIP_INTERNET 7:RADIUS 8:RADIUS_INTERNET
	if ((chooseWanValue == 0) ||	(chooseWanValue == 1) 
		|| (chooseWanValue == 2) || (chooseWanValue == 4) || (chooseWanValue == 5)
		|| (chooseWanValue == 8)	//RADIUS_INTERNET
		|| (chooseWanValue == 16) || (chooseWanValue == 17))
	{
		//1:INTERNET���
		if(chooseWanValue == 1 || (chooseWanValue == 2)
			|| (chooseWanValue == 5) || (chooseWanValue == 17)
			|| (chooseWanValue == 8))	
		{
			//add by wuxj, 20170522, tr181 internet route don't need port band
			if(WEB_DATAMODEL_181 == '1' && select_WANtype.options.selectedIndex == 1)
			{
				setDisplay("port_bang", "none");
			}
			else
			{
				setDisplay("port_bang", "");
			}
				
			document.getElementById("wan_connectionType").disabled = 0;

			if(chooseWanValue == 1)//INTERNET
			{
				if(parseInt(brige_wan_only) == 1)	/*01A9Gֻ֧��internet �Ž�wan*/
				{
					document.getElementById("wan_connectionType").options.selectedIndex = 0;//bridge
					document.getElementById("wan_connectionType").disabled = 1;
				}
			}
/*
		    if(select_WANtype.options.selectedIndex == 1)
		    {
				var ipv6_enable_s  = document.getElementById("ipv6_enable");
				showSelectNodeByValue(ipv6_enable_s, 1);//v4
				setDisplay("wan_ipv6enable", "");
				ipv6_enableSwitch();
		    }
*/
		}
		//TR069 VOIP��� 
		if(chooseWanValue == 0 || (chooseWanValue == 4) 
			|| (chooseWanValue == 2) || (chooseWanValue == 5) 
			|| (chooseWanValue == 16) || (chooseWanValue == 17) ) 
		{				
				//var ipv6_enable_s  = document.getElementById("ipv6_enable");
				//ipv6_enable_s.options.selectedIndex = 1;
				document.getElementById("wan_connectionType").disabled = 1;
				document.getElementById("wan_connectionType").value = 1;
				
				if(chooseWanValue == 0 || (chooseWanValue == 4) || (chooseWanValue == 16))//tr069��voip��tr069_voip
				{
					setDisplay("port_bang", "none");
					setDisplay("static_ipv6", "none");
					setDisplay("dhcp_ipv6", "none");
					setDisplay("pppoe_ipv6", "none");
					setDisplay("wan_ipv6enable", "none");
					setDisplay("dsline_ipv6_table", "none");
					setDisplay("AFTR_ipv6_table", "none");
					setDisplay("AFTR_value_table", "none");
				}
	
//				Tr069Wan_style(chooseWanValue);
				
		}

	}
	else if(chooseWanValue == 3)	/* muticastֻ���Ž� */
	{
		document.getElementById("wan_connectionType").options.selectedIndex = 0;
		document.getElementById("wan_connectionType").disabled = 1;
		setDisplay("port_bang", "");
	}
	else if(chooseWanValue == 6)  /* IPTV ͬinternet */
	{
		//delete by wuxj, 20180611, �޸�ΪIPTV������·��,connectionType����(from ����ԭ)
		//modify by wuxj, 20180309, �޸�ΪIPTVֻ��·��(from ����)
//		document.getElementById("wan_connectionType").options.selectedIndex = 1;//route
//		ConnectTypeSwitch(1);
		document.getElementById("wan_connectionType").disabled = 0;
		ConnectTypeSwitch(getElement("wan_connectionType").value);
		
		setDisplay("port_bang", "");
	}
	else
	{	
		document.getElementById("wan_connectionType").disabled = 0;
		setDisplay("tb_wanIPModel", "");
		setDisplay("port_bang", "");
	}

	ConnectTypeSwitch(select_WANtype.options.selectedIndex);
}

function Tr069Wan_style(chooseWanValue)
{
	if(chooseWanValue == 0)//tr069
	{
		//modify by wuxj, 20180227, ����TR069���Ϳ��޸�ΪTR069�������
//		document.getElementById("wan_connectionmode").disabled = 1;
		
		/* ������ͨ,�㶫��ͨ,�Ĵ��ƶ����������ƶ�/Խ��HGU�汾TR069 WAN���������� */
		if((ispMinorNameCode == 303) || (ispMinorNameCode == 305) || (ispMinorNameCode == 202)
			|| (ispMinorNameCode == 203) || (ispName == 16))
		{
			document.getElementById("wan_enable").disabled = 1;	
			document.getElementById("wan_vid").disabled = 1;
			document.getElementById("wan_priority").disabled = 1;
			document.getElementById("ipModel").disabled = 1;
			document.getElementById("wan_mtu").disabled = 1;
			
			setDisplay("apply_table", "none");

			if(ispName == 16)//Խ��
			{
				document.getElementById("wan_connectionmode").disabled = 1;
			}
		}
		else if(ispName == 9)//��������Ҫ��TR069���������Ϳ���
		{
			document.getElementById("wan_connectionmode").disabled = 0;
			setDisplay("apply_table", "");	
		}
	}
	else
	{
		document.getElementById("wan_enable").disabled = 0;
		if(ispName == 5 && chooseWanValue == 2)	/* add by ��С��, 20170502, ԭ��:̩��AISҪ��TR069_INTERNET WAN�����޸�ҵ������ */
		{
			document.getElementById("wan_connectionmode").disabled = 1;
		}
		else
		{
			document.getElementById("wan_connectionmode").disabled = 0;
		}
		
		document.getElementById("wan_vid").disabled = 0;
		document.getElementById("wan_priority").disabled = 0;
		document.getElementById("nat_enable").disabled = 0;
		document.getElementById("dns_enable").disabled = 0;
		document.getElementById("wan_mtu").disabled = 0;
		document.getElementById("ipModel").disabled = 0;
		
		setDisplay("apply_table", "");
	}
}

function DsliteSwitch()
{
    if(document.getElementById("DS_Lite_enable").options.selectedIndex == 1)//enable
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
	e = document.getElementById("wan_SSID_24g_title");
	e.innerHTML = _("wan_SSID_24g_title");
	e = document.getElementById("wan_SSID_5g_title");
	e.innerHTML = _("wan_SSID_5g_title");
	
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
//	e = document.getElementById("wPppoeOnDemand");
//	e.innerHTML = _("wan protocol opmode ondemand");

/*	e = document.getElementById("wPppoepasv");
	e.innerHTML = _("wPppoepasv");	
	e = document.getElementById("wPppoeManual");
	e.innerHTML = _("wan protocol opmode manual");	*/
	
	/* add begin by ��С��, 20110601, ԭ��: ����DHCP����IP��DNS��*/
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
	//e = document.getElementById("Option60value_title");
	//e.innerHTML = _("Option60value_title");
	
	/* add end by ��С��, 20110601 */

	/* add begin by ��С��, 20110510, ԭ��: ����PPPOE����״̬��IP��DNS��*/
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
	e = document.getElementById("wPppoeCon_retryPeriod_title");
	e.innerHTML = _("wPppoeCon_retryPeriod_title");
	e = document.getElementById("wPppoeAuthTypeTitle");
	e.innerHTML = _("wPppoeAuthTypeTitle");
	e = document.getElementById("wPppoeConnTriggerTitle");
	e.innerHTML = _("wPppoeConnTriggerTitle");
	e = document.getElementById("wppp_outtimeTitle");
	e.innerHTML = _("wppp_outtimeTitle");
		
	e = document.getElementById("wPppoeCon_userTips");
	e.innerHTML = _("wPppoeCon_userTips");
	e = document.getElementById("wPppoeCon_pwdTips");
	e.innerHTML = _("wPppoeCon_pwdTips");
	e = document.getElementById("wPppoeCon_retryPeriod_tips");
	e.innerHTML = _("wPppoeCon_retryPeriod_tips");
    e = document.getElementById("manual_connect");
	e.value = _("manual_connect");
    e = document.getElementById("manual_disconnect");
	e.value = _("manual_disconnect");
		
	/* add end by ��С��, 20110510 */

	/* add begin by ����, 20130220, ԭ��:ipv6��ز��� */
	e = document.getElementById("wStaticIpv6");
	e.innerHTML = _("wStaticIpv6");
	e = document.getElementById("Prefix_Length_title");
	e.innerHTML = _("Prefix_Length_title");
	e = document.getElementById("wStaticGateway_ipv6");
	e.innerHTML = _("wStaticGateway_ipv6");
	e = document.getElementById("wStaticSecDns_ipv6");
	e.innerHTML = _("wStaticSecDns_ipv6");
	e = document.getElementById("wStaticPriDns_ipv6");
	e.innerHTML = _("wStaticPriDns_ipv6");
    e = document.getElementById("Address/Prefix_title");
	e.innerHTML = _("Address/Prefix_title");
	e = document.getElementById("Address/Prefix_title1");
	e.innerHTML = _("Address/Prefix_title");
	e = document.getElementById("wV6_Address/Prefix_static");
	e.innerHTML = _("wV6_Address/Prefix_static");
	e = document.getElementById("wV6_prefixMode_static");
	e.innerHTML = _("wV6_prefixMode_static");
	e = document.getElementById("Prefix_title");
	e.innerHTML = _("Prefix_title");
	e = document.getElementById("Prefix_title_dhcp");
	e.innerHTML = _("Prefix_title");
	e = document.getElementById("Prefix_title_pppoe");
	e.innerHTML = _("Prefix_title");
	e = document.getElementById("prefix_length_prompt");
	e.innerHTML = _("prefix_length_prompt");
	
	e = document.getElementById("Address/Prefix_title_pppoe");
	e.innerHTML = _("Address/Prefix_title_pppoe");
	/* add end by ����, 20130220 */
	
	e = document.getElementById("dslite_disable");
	e.innerHTML = _("wan_disabletitle");
	e = document.getElementById("dslite_enable");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("AFTR_enable_title");
	e.innerHTML = _("wan_enabletitle");
	e = document.getElementById("AFTR_disable_title");
	e.innerHTML = _("wan_disabletitle");
	e = document.getElementById("AFTRType1");
	e.innerHTML = _("AFTRType1");
	e = document.getElementById("Prefix_mode");
	e.innerHTML = _("Prefix_mode");
	e = document.getElementById("Prefix_value_title");
	e.innerHTML = _("Prefix_value_title");
	
	e = document.getElementById("wV6_prefixMode_pppoe");
	e.innerHTML = _("Prefix_mode");
	
	e = document.getElementById("wApply");
	e.value = _("inet apply");
	e = document.getElementById("wCancel");
	e.value = _("inet cancel");
}

function LoadFrame()
{ 
	initTranslation();
	
	if(parseInt(G10_LAN_FLAG) == 1)
	{
		lanSum = parseInt(lan_port_num) + parseInt(lan_port_num_10g);
		setDisplay("wan_10GEBox_title", "");
		setDisplay("wan_10GEBox", "");
	}
	else
	{
		lanSum = parseInt(lan_port_num);
		setDisplay("wan_10GEBox_title", "none");
		setDisplay("wan_10GEBox", "none");
	}
	document.getElementById("wan_feBox2").disabled = 1;
	document.getElementById("wan_feBox3").disabled = 1;
	document.getElementById("wan_feBox4").disabled = 1;
	if(parseInt(lanSum) >= 1)
	{
		document.getElementById("wan_feBox1").disabled = 0;
	}
	if(parseInt(lanSum) >= 2)
	{
		document.getElementById("wan_feBox2").disabled = 0;
	}
	if(parseInt(lanSum) >= 3)
	{
		document.getElementById("wan_feBox3").disabled = 0;
	}
	if(parseInt(lanSum) >= 4)
	{
		document.getElementById("wan_feBox4").disabled = 0;
	}
	if(parseInt(lanSum) >= 5)
	{
		document.getElementById("wan_10GEBox").disabled = 0;
	}
	
	if(parseInt(WifiFlag) == 1)
	{
		setDisplay("tr_ssidBind", "");
		if(parseInt(wifi_chip_num) > 1)
			setDisplay("tr_5gssidBind", "");
		else
			setDisplay("tr_5gssidBind", "none");
	}
	else
	{
		setDisplay("tr_ssidBind", "none");
		setDisplay("tr_5gssidBind", "none");
	}
	
	if(ispName == 9)//add by wuxj, 20160809, ��������ɾ��IPV6��ջ
	{
		getElement("ipv6_enable").options.remove(1);//v6
	}

	if((ispName == 12) || (ispName == 13))/* ��϶��HGU /ӡ�����HGU�汾*/
	{
		Have_RADIUS = 1;
	}

	var wan_connectionmodeNode = document.getElementById("wan_connectionmode");
	if(Have_RADIUS == 1)
	{
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("RADIUS", "7");
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("RADIUS_INTERNET", "8");
	}
	if(ispName == 28)/* ī����TOTALPLAYHGU */
	{
		wan_connectionmodeNode.options[wan_connectionmodeNode.length] = new Option("IPTV", "6");
	}
	if(ispName == 26)/* ����TIM */
	{
		setDisplay("tr_dnsrelay", "none");
	}
	
	if(wan_size == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("fw_ruletable").rows[0];

		if(parseInt(wan_line) == 1)
		{
			selectLine("record_1");
		}
		else if (parseInt(wan_line) == 0)
		{
			selectLine("record_0");
		}
		else if(parseInt(wan_line) == 2)
		{
		    selectLine("record_2");
		}
		else if(parseInt(wan_line) == 3)
		{
		    selectLine("record_3");
		}
		else
		{
			wan_line = 0;
			selectLine("record_0");
		}

		if(parseInt(wan_line) >= wan_size)
		{
			wan_line = 0;
			selectLine("record_0");
		}

		setDisplay("ConfigForm1", "");
	}

	if(ispName == 5 || ispName == 15)	//HGU X_AIS X_GLOBE
	{
		setDisplay("tr_vlan_enable", ""); 
		setDisplay("tr_pppAuthType", "");
		setDisplay("tr_pppConnTrigger", ""); 

		//delete by wuxj, 20180604, �޸�Ϊ�����豸��֧��V6��ջ
/*		var ipv6_l3_flag = '<% getCfgGeneral(1, "ipv6_l3_flag");%>';
		if(ipv6_l3_flag == '0')
		{
			getElement("ipv6_enable").options.remove(1);//v6
		}
*/		
	}
	//modify by wuxj, 20181205, ����֧��WEB_WAN_CONN_TRIGGER
	//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
	/*��϶��, AIS,�������� X_GLOBE Խ�� */
	if((WEB_WAN_CONN_TRIGGER == '1')
		|| (ispName == 12) || (ispName == 5) || (ispName == 9)|| (ispName == 15) || (ispName == 16))
	{
		setDisplay("tr_pppAuthType", ""); 
		setDisplay("tr_pppConnTrigger", "");
	}
	//add by wuxj, 20160829,PH X_GLOBE HGU customized
	if(pppoeUserExtend_flag == '1')	//PH X_GLOBE customized
	{
		getElement("pppoeUser").maxLength = "63";
		getElement("pppoePass").maxLength = "63";
		getElement("wPppoeCon_userTips").innerHTML = _("wPppoeCon_userTips_63");
		getElement("wPppoeCon_pwdTips").innerHTML = _("wPppoeCon_pwdTips_63");
	}

	if(brige_wan_only == 1) /*01A9G */
	{
		getElement("wan_connectionmode").options.remove(5);
		getElement("wan_connectionmode").options.remove(4);
		getElement("wan_connectionmode").options.remove(2);
		getElement("ipv6_enable").options.remove(2);//v6v4
		getElement("ipv6_enable").options.remove(1);//v6
	}
	if(vlan_all_trans_mark == 1)	//vlanȫ͸������
	{
		setDisplay("tr_vlan_mode", "");
		vlanModeSwitch();
	}

//	showDate(wan_line);//delete by wuxj, 20170502, selectLine�ѵ���showDate���˴������ٵ��ã�����Ḳ������ĳЩ��ʾ����
	if(wan_size == 0)
	{	
		setDisplay("static", "none");
		setDisplay("dhcp", "none");
		setDisplay("pppoe", "none");
	}
									          
	//if(document.getElementById("wan_connectionmode").options.selectedIndex != 0)		
	//{
//		ipModelSwitch();
//	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];
	
	/*modify begin by�����ã�20161215����϶���������ֻ������4��wan*/
	if(ispName == 12)/* ��϶��HGU */
	{
		if(rowLen > 5)
		{		
	//   		alert("���ֻ�ܴ���4������!");
	 		alert(_("pf_most4RulesAlert"));
			return;
		}
	}
	else
	{
		if(rowLen - 2 >= 8)
		{
	 		alert(_("pf_mostRulesAlert"));
			return;
		}
	}
	/*modify end by�����ã�20161215*/

	if (lastRow.id == 'record_new')		//�½�
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//ԭ���û�
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

function selectLine(id)
{
	var objTR = getElement(id);
	var wan_mode = document.getElementById("wan_connectionmode");

	initWANDetailInfo();
	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if(temp == 'new')		//�½�
		{
			document.getElementById("wan_enable").value = 1;
			document.getElementById("vlan_enable").value = 1;
			wan_mode.options.selectedIndex = 1;
			document.getElementById("nat_enable").options.selectedIndex = 0;
			document.getElementById("dns_enable").options.selectedIndex = 0;
			WanIndexSwitch(1);
			document.getElementById("wan_vid").focus();

			if(vlan_all_trans_mark == 1)	//vlanȫ͸������
			{
				document.getElementById("vlan_mode").value = 1;//tag
				vlanModeSwitch(1);
			}
			
			setDisplay("apply_table", "");
		}
        else if (temp == 'no')	//ԭ���û�
        {
        }
		else
		{
//			splitDate();
			showFESSID(temp);
			showDate(temp);
//			Tr069Wan_style(wan_mode.options.selectedIndex);	
		}
		
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;

		//��־��ǰ�༭�����id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);
		
	}	 
}

function clickRemove(tabTitle)
{
	if(wan_size  == 0)
	{			
//   		alert("��ǰû�й��򣬲���ɾ��!");
 		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pf_removeFlag');
    var noChooseFlag = true;
//	var value = checkNodes.getValue();		//�ж��Ƿ�ȫѡ�ˣ����ȫѡ�ˣ�����ipFilterDeleteAll
//	console.info("value.length = " + value.length);
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
//		alert('����ѡ��һ������');
		alert(_("pf_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("��ȷ��ɾ����ѡ����?") == false)
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;

	load_waiting();
	getElement("fw_ruleForm").submit();
	
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
		//modify by wuxj, 20171011, �޸�Ϊ��ȷ�ķ�ΧУ��
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

function checkIpAddr(field, ismask)
{
	/* modify begin by ��С��, 20110503, ԭ��: ��������У�鷶Χ����ȷ��
	    �����޸Ľ�����У���Ϊ����ר�õ�JSУ���ļ�checkValue.js*/
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
	/* modify end by ��С��, 20110503 */
}

/*У��wan���͵��ظ���*/
function checkWan(k)
{
	var wan_vid = document.getElementById("wan_vid");
	var wan_mode = document.getElementById("wan_connectionmode");
	var vlan_mode = document.getElementById("vlan_mode");
	var connect_type = document.getElementById("wan_connectionType");
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	var checkVidFlag = true;
	var checkPortBindFlag = true;

	//delete by wuxj, 20180920, ���������޸�Ϊ��ҪУ��VLAN
//	if((ispName == 5) || (ispName == 9) || (ispName == 28))//AIS/��������/ī����TOTALPLAY vid����һ��
	if((ispName == 5) || (ispName == 28))//AIS/ī����TOTALPLAY vid����һ��
	{
		checkVidFlag = false;
	}
	
	if(checkVidFlag == true)
	{
		if(wan_vid.value == VIDArray[k])/*vid ����һ��*/
		{
			alert(_("this VID have exist!"));
			return false;
		}
	}
	
	//internet��ؼ��鲥 IPTV
	if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 3)
		|| (wan_mode.value == 5) || (wan_mode.value == 17) 
		|| (wan_mode.value == 8) || (wan_mode.value == 6))
	{		
		//add by wuxj, 20170522, tr181 internet route don't need port band
		if(WEB_DATAMODEL_181 == '1' && connect_type.options.selectedIndex == 1)
		{
			checkPortBindFlag = false;
		}
		if(vlan_mode.options.selectedIndex == 1)/*VLAN ͸��ģʽ��һ���˿ڿ��������ҵ��*/
		{
			checkPortBindFlag = false;
		}		
		if(singlePortMultiRouteWanFlag == '1')	//֧�ֵ��˿ڰ��·��WAN
		{
			if( ((wan_mode.value == 1) || (wan_mode.value == 2)
				|| (wan_mode.value == 5) || (wan_mode.value == 17) || (wan_mode.value == 8)) 
				&& (connect_type.value == 1) )	/*��ǰwanΪROUTE INTERNET���*/
			{
				checkPortBindFlag = false;
			}
		}
		if(ispName == '28')//ī����TOTALPLAY
		{
/*			//����IPTV��INTERNETͬ��������(R/B)ʱ��ͬһ�˿�
			if(((modeArray[k] == 1) || (modeArray[k] == 2) || (modeArray[k] == 3)
				|| (modeArray[k] == 5) || (modeArray[k] == 17) 
				|| (modeArray[k] == 8) || (modeArray[k] == 6)) 
				&& (connect_type.options.selectedIndex == typeArray[k]))*/
			{
				checkPortBindFlag = false;
			}
		}
		if(checkPortBindFlag == true)
		{
			if(!checkPortBind(wanFEBoxNode, feArray[k].split(","), lanSum))
			{
				alert(_("wan_portBindedAlert"));
				return false;
			}
			if(!checkPortBind(wanSsidBoxNode, ssidArray[k].split(","), wifi_ssid_sum))
			{
				alert(_("wan_portBindedAlert"));
				return false;
			}
		}
	}
	
	if(wan_mode.value == 0) /*��ǰwanΪTR069*/
	{
		if(modeArray[k] == 0)  /*�ǵ�ǰwan�д���TR069 */
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2) /*�ǵ�ǰwan�д���INTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17)/*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
	}
	if((wan_mode.value == 1) && (connect_type.value == 1)) /*��ǰwanΪINTERNET-ROUTE*/
	{
		//��϶���汾�������ö���·��wan�������汾������
		if(ispName != 12 && (multiRouteWanFlag != '1'))
		{
			if(modeArray[k] == 5)/*�ǵ�ǰwan�д���INTERNET_VOIP*/
			{
				alert(_("INTERNET_VOIP_wan_RepeatAlert"));
				return false;
			}
			if(modeArray[k] == 2)/*�ǵ�ǰwan�д���INTERNET_TR069*/
			{
				alert(_("INTERNET_TR069_wan_RepeatAlert"));
				return false;
			}
			if(modeArray[k] == 17)/*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
			{
				alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
				return false;
			}
						
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*�ǵ�ǰwan�д���INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 2) /*��ǰwanΪINTERNET_TR069*/
	{
		if(modeArray[k] == 0) 		/*�ǵ�ǰwan�д���TR069*/
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2)		/*�ǵ�ǰwan�д���NTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17)/*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
		if(ispName != 12 && (multiRouteWanFlag != '1')) //��϶���汾�������ö���·��wan�������汾������
		{
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*�ǵ�ǰwan�д���INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 4) /*��ǰwanΪVOIP*/
	{
		if(modeArray[k] == 4) /*�ǵ�ǰwan�д���VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*�ǵ�ǰwan�д���NTERNET_VOIP */
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17) /*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
	}
	if(wan_mode.value == 5) /*��ǰwanΪINTERNET_VOIP*/
	{
		if(modeArray[k] == 4)/*�ǵ�ǰwan�д���VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*�ǵ�ǰwan�д���INTERNET_VOIP*/
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17) /*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
		if(ispName != 12 && (multiRouteWanFlag != '1')) //��϶���汾�������ö���·��wan�������汾������
		{
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*�ǵ�ǰwan�д���INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 16) /*��ǰwanΪTR069_VOIP*/
	{
		if(modeArray[k] == 0)  /*�ǵ�ǰwan�д���TR069 */
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2) /*�ǵ�ǰwan�д���INTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17) /*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 4)/*�ǵ�ǰwan�д���VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*�ǵ�ǰwan�д���INTERNET_VOIP*/
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
	}
	if(wan_mode.value == 17) /*��ǰwanΪTR069_VOIP_INTERNET*/
	{
		if(modeArray[k] == 0)  /*�ǵ�ǰwan�д���TR069 */
		{
			alert(_("TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 2) /*�ǵ�ǰwan�д���INTERNET_TR069*/
		{
			alert(_("INTERNET_TR069_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 4)/*�ǵ�ǰwan�д���VOIP*/
		{
			alert(_("VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 5)/*�ǵ�ǰwan�д���INTERNET_VOIP*/
		{
			alert(_("INTERNET_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 16) /*�ǵ�ǰwan�д���TR069_VOIP*/
		{
			alert(_("TR069_VOIP_wan_RepeatAlert"));
			return false;
		}
		if(modeArray[k] == 17) /*�ǵ�ǰwan�д���TR069_VOIP_INTERNET*/
		{
			alert(_("TR069_VOIP_INTERNET_wan_RepeatAlert"));
			return false;
		}
		if(ispName != 12 && (multiRouteWanFlag != '1')) //��϶���汾�������ö���·��wan�������汾������
		{
			if((modeArray[k] == 1) && (typeArray[k] == 1))/*�ǵ�ǰwan�д���INTERNET - ROUTE */
			{
				alert(_("INTERNET_R_wan_RepeatAlert"));
				return false;
			}
		}
	}
	if(wan_mode.value == 6) /*��ǰwanΪIPTV*/
	{
		if(modeArray[k] == 6)  /*�ǵ�ǰwanΪIPTV */
		{
			alert(_("IPTV_wan_RepeatAlert"));
			return false;
		}
	}
	
	return true;
}

function checkWanRepeat(temp)
{
	var k = 0;
	
	if(wan_size > 0)
	{
		for(k = 0; k < wan_size; k++)
	    {
			if(temp != 'new') /*�޸�wan*/
			{
				if(temp != k) /*temp Ϊ��ǰ�޸�wan���кţ������Լ����бȽ�*/
				{
					if(!checkWan(k))
					{
						return false;
					}
				}
			}
			else /*����wan*/
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
function checkWanRouteBridgeSum(temp, newConnectionType)
{
	var i = 0;
	var routeSum = 0;
	var bridgeSum = 0;
	for(i = 0; i < wan_size; i++)
	{
		if(typeArray[i] == 0)	//bridge
		{
			bridgeSum++;
		}
		else
		{
			routeSum++;
		}
	}
	if((temp == 'new') || (typeArray[temp] != newConnectionType))
	{
		if(newConnectionType == 0 && bridgeSum >= 4)	//bridge
		{
			alert(_("pf_most4BridgeWanAlert"));
			return false;
		}
		else if(newConnectionType == 1 && routeSum >= 4)
		{
			alert(_("pf_most4RouteWanAlert"));
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
	var wan_connectionTypeNode  = document.getElementById("wan_connectionType");
	var ipModelNode =  document.getElementById("ipModel");
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
	var Ipv6_Sec_DNS_node =  document.getElementById("IPv6_Sec_DNS");
	var IPv6_prefix_node =  document.getElementById("IPv6_prefix");

	var mut_value = document.getElementById("wan_mtu");
	var wan_enableNode = getElement("wan_enable");

	var checkWanRepeatFlag = true;
	
	if(!checkWanRouteBridgeSum(currentline, wan_connectionTypeNode.value))
	{
		wan_connectionTypeNode.value = 0;
		wan_connectionTypeNode.focus();
		return false;
	}

	if((checkWanRepeatFlag == true) && !checkWanRepeat(currentline))
	{
		return false;
	}
	if(getElement("vlan_mode").value != 3)	//��ȫ͸��
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

	//route internet���У��MTU
	if(wan_connectionTypeNode.options.selectedIndex == 1 
		&& (wan_mode.value == 1 || wan_mode.value == 2 || wan_mode.value == 5
		|| wan_mode.value == 17 || wan_mode.value == 8))
	{
		if(mut_value.value != "")  
		{
			if(!MTULegal(mut_value, ipModelNode.value))
			{
				return false;
			}
		}
	}

	/* ·��internet��� v6 */
	if( ((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 5)
		|| (wan_mode.value == 8) || (wan_mode.value == 17))
		&& (wan_connectionTypeNode.options.selectedIndex == 1) ) //route
	{
		if((v4_v6_mode.value == 2)	//v6	
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
	
   if ((ipModelNode.value == 1) && (wan_connectionTypeNode.value == 1)) /*static */
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
				if(!fw_checkv6Len(Ipv6_len_node))
				{
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

				/*add begin by�����ã�20161219��ԭ��:��϶���汾����IPV6 ip/gateway/dns/iprefixУ��*/
				if(ispName == 12) 
				{
					if(!checkIpv6(staticIp_v6_node.value))
					{
						alert(_("ipv6_IllegalAlert"));
						staticIp_v6_node.value = staticIp_v6_node.defaultValue;
						staticIp_v6_node.focus();
						return false;
					}
					if(!checkIpv6Prefix(IPv6_prefix_node.value))
					{
						alert(_("ipv6prefix_IllegalAlert"));
						IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
						IPv6_prefix_node.focus();	
						return false;
					}
					if(!checkIpv6GatewayDNS(Ipv6_Gateway_node.value))
					{
						alert(_("ipv6GW_IllegalAlert"));
						Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
						Ipv6_Gateway_node.focus();	
						return false;
					}
					if(!checkIpv6GatewayDNS(Ipv6_Pri_DNS_node.value))
					{
						alert(_("ipv6dns_IllegalAlert"));
						Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
						Ipv6_Pri_DNS_node.focus();	
						return false;
					}
					if(CheckNotNull(Ipv6_Sec_DNS_node.value))/*����DNS�ǿ�У��Ϸ���*/
					{
						if(!checkIpv6GatewayDNS(Ipv6_Sec_DNS_node.value))
						{
							alert(_("ipv6dns_IllegalAlert"));
							Ipv6_Sec_DNS_node.value = Ipv6_Sec_DNS_node.defaultValue;
							Ipv6_Sec_DNS_node.focus();	
							return false;
						}
					}
					
					/*ǰ׺IPv6_prefix_node��"/"֮ǰ�Ĳ��֣�������ipv6 ip/gateway/dns��ͬ*/
					var ipv6_info = IPv6_prefix_node.value.split("/");
					var ipaddr = ipv6_info[0];
					if(staticIp_v6_node.value == ipaddr ||Ipv6_Gateway_node.value == ipaddr
						||Ipv6_Pri_DNS_node.value == ipaddr ||Ipv6_Sec_DNS_node.value == ipaddr)
					{
						alert(_("ipv6prefix_same_IllegalAlert"));
						IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
						IPv6_prefix_node.focus();	
						return false;
					}
					
					/*����DNS������ͬ*/
					if(Ipv6_Pri_DNS_node.value == Ipv6_Sec_DNS_node.value)
					{
						alert(_("ipv6dns_same_IllegalAlert"));
						Ipv6_Sec_DNS_node.value = Ipv6_Sec_DNS_node.defaultValue;
						Ipv6_Sec_DNS_node.focus();	
						return false;
					}				
				}				
				/*add end by������,20161219*/
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
				if(!fw_checkv6Len(Ipv6_len_node))
				{
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
				
				/*add begin by�����ã�20161219��ԭ��:��϶���汾����IPV6 ip/gateway/dns/iprefixУ��*/
				if(ispName == 12)
				{
					if(!checkIpv6(staticIp_v6_node.value))
					{
						alert(_("ipv6_IllegalAlert"));
						staticIp_v6_node.value = staticIp_v6_node.defaultValue;
						staticIp_v6_node.focus();	
						return false;
					}
					if(!checkIpv6Prefix(IPv6_prefix_node.value))
					{
						alert(_("ipv6prefix_IllegalAlert"));
						IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
						IPv6_prefix_node.focus();	
						return false;
					}
					if(!checkIpv6GatewayDNS(Ipv6_Gateway_node.value))
					{
						alert(_("ipv6GW_IllegalAlert"));
						Ipv6_Gateway_node.value = Ipv6_Gateway_node.defaultValue;
						Ipv6_Gateway_node.focus();	
						return false;
					}
					if(!checkIpv6GatewayDNS(Ipv6_Pri_DNS_node.value))
					{
						alert(_("ipv6dns_IllegalAlert"));
						Ipv6_Pri_DNS_node.value = Ipv6_Pri_DNS_node.defaultValue;
						Ipv6_Pri_DNS_node.focus();	
						return false;
					}
					if(CheckNotNull(Ipv6_Sec_DNS_node.value))/*����DNS�ǿ�У��Ϸ���*/
					{
						if(!checkIpv6GatewayDNS(Ipv6_Sec_DNS_node.value))
						{
							alert(_("ipv6dns_IllegalAlert"));
							Ipv6_Sec_DNS_node.value = Ipv6_Sec_DNS_node.defaultValue;
							Ipv6_Sec_DNS_node.focus();	
							return false;
						}
					}

					/*ǰ׺IPv6_prefix_node��"/"֮ǰ�Ĳ��֣�������ipv6 ip/gateway/dns��ͬ*/
					var ipv6_info = IPv6_prefix_node.value.split("/");
					var ipaddr = ipv6_info[0];
					if(staticIp_v6_node.value == ipaddr ||Ipv6_Gateway_node.value == ipaddr
						||Ipv6_Pri_DNS_node.value == ipaddr ||Ipv6_Sec_DNS_node.value == ipaddr)
					{
						alert(_("ipv6prefix_same_IllegalAlert"));
						IPv6_prefix_node.value = IPv6_prefix_node.defaultValue;
						IPv6_prefix_node.focus();	
						return false;
					}
					
					/*����DNS������ͬ*/
					if(Ipv6_Pri_DNS_node.value == Ipv6_Sec_DNS_node.value)
					{
						alert(_("ipv6dns_same_IllegalAlert"));
						Ipv6_Sec_DNS_node.value = Ipv6_Sec_DNS_node.defaultValue;
						Ipv6_Sec_DNS_node.focus();	
						return false;
					}				
				}
				/*add end by������,20161219*/
			}
		}
   }
   else if ((ipModelNode.value == 2) && (wan_connectionTypeNode.value == 1))/*PPPOE*/
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
		//modify by wuxj, 20181205, ����֧��WEB_WAN_CONN_TRIGGER
		//add by wuxj, 20160809, ROMANIA add pppAuthType etc.
		/*��϶��, AIS,�������� X_GLOBE Խ�� */
		if((WEB_WAN_CONN_TRIGGER == '1')
			|| (ispName == 12) || (ispName == 5) || (ispName == 9) || (ispName == 15) || (ispName == 16))
		{
			var pppConnTrigger = document.getElementById("pppConnTrigger");
			var ppp_outtime = document.getElementById("ppp_outtime");
			
			if((wan_mode.value != 0) && (wan_mode.value != 4) && (wan_mode.value != 16)) /*TR069, VOIP*/
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
		/* delete by ��С��, 20150225, ԭ��:pppoeRetryPeriod�޸�Ϊֻ��������У�� */
/*
		if ((pppoeOPModeNode.options.selectedIndex == 0) || (pppoeOPModeNode.options.selectedIndex == 1))//Keep Alive
		{
			if (pppoeRetryPeriod.value == "")
			{
				alert(_("wPppoeCon_noretryperiod"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}

			else if(!(/^[\d]{1,5}$/.test(pppoeRetryPeriod.value)))	//1-5λ����
			{
				alert(_("wPppoeCon_retryPeriodIllegalAlert"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}

			if(pppoeRetryPeriod.value < 10)
			{
				alert(_("wPppoeCon_retryPeriodIllegalAlert"));
				pppoeRetryPeriod.focus();
				pppoeRetryPeriod.select();
				return false;
			}
		}
*/		
	}

	if(voip_port_num == 0)
	{
		//voip���
		if((wan_mode.value == 5) || (wan_mode.value == 4) || (wan_mode.value == 16) || (wan_mode.value == 17))
		{
			alert(_("voip_wan_alert"));
			return false;
		}
   }
	//delete by wuxj, 20170502, TR069�ظ���У������checkWan��ʵ�֣�����У��δ�����޸�����
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
	
   	if((wan_mode.value == 1) || (wan_mode.value == 2) || (wan_mode.value == 5)  
		|| (wan_mode.value == 8)	//RADIUS_INTERNET
		|| (wan_mode.value == 17)
		|| (wan_mode.value == 3))	//multicast
   	{	//INTERNET��ؼ�Other
   			
		//add by wuxj, 20170522, tr181 internet route don't need port band
		if(!(WEB_DATAMODEL_181 == '1' && wan_connectionTypeNode.options.selectedIndex == 1))
		{
			var portBindNum = getPortBindNum(wanFEBoxNode, wanSsidBoxNode, wifi_ssid_sum);
			if(portBindNum == 0)
			{
				alert("Please bind port!");
				return false;
			}
		}
   	}
	if(ispName == '25' || ispMinorNameCode == '24')/* ��³����/NETLIFE */	//���ڶ˿�ģʽ���ú����ɶ˿ڱ�ȥʹ�ܣ����´������ں�̨��ȡ�˿ڰ󶨵�����
	{
		for(var j = 0; j < lan_port_num; j++)
		{
			wanFEBoxNode[j].disabled = 0;
		}
	}
		
	load_waiting();
	return true;
}

function fw_checkv6Len(dom)
{
	var exp = /^\d+$/;
	var prefix_max_len;
	if(ispName == 12) /*modify by�����ã�20170113����϶���汾ǰ׺����1-128,�����汾:1-64,������Դ:����*/
	{
		prefix_max_len = 128;
	}
	else/*�����汾*/
	{
		prefix_max_len = 64;
	}
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= prefix_max_len)
		{
			return true;
		}
		else
		{
			if(ispName == 12) /*��϶��*/
			{
				alert(_("v6len_128_IllegalAlert"));
			}
			else/*�����汾*/
			{
				alert(_("v6len_IllegalAlert"));
			}
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		if(ispName == 12) /*��϶���汾*/
		{
			alert(_("v6len_128_IllegalAlert"));
		}
		else/*�����汾*/
		{
			alert(_("v6len_IllegalAlert"));
		}
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

