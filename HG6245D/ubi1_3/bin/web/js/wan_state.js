/***********************************************************************************
wan_state.js
wuxj
2017.12.8
wan state common js functions
***********************************************************************************/

//add by wuxj, 20181205, 增加支持WEB_COMM_WAN_CFG
function showIPV6info(wanIndex)
{
	/*三层 IP模式: IPv4 - 0, IPv6 - 2, IPv4&IPv6 - 1	*/
	var cur_ip_stack_mode = ip_stack_mode_arr[wanIndex];
	if(cur_ip_stack_mode == 0)
		setDisplay("ipv6_wan_state", "none");
	else
		setDisplay("ipv6_wan_state", "");

	getElement('td_ipv6_ip').innerHTML = space2null(html_decode(staticIp_ipv6_arr[wanIndex]));
	getElement('td_ipv6_gw').innerHTML = space2null(html_decode(IPv6_Gateway_arr[wanIndex]));
	getElement('td_ipv6_pridns').innerHTML = space2null(html_decode(IPv6_Pri_DNS_arr[wanIndex]));
	getElement('td_ipv6_secdns').innerHTML = space2null(html_decode(IPv6_Sec_DNS_arr[wanIndex]));
	getElement('td_ipv6_prefix').innerHTML = space2null(html_decode(IPv6_prefix_arr[wanIndex]));
}
function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];		
		
		var up_time = uptime_buff.split("|")[temp];
		
		/*modify by 陈鹏 20181022，原因:泰国TRUE要求增加PPPoE Uptime，时间格式为: 0 d 0 h 0 m 0 s ，需求来源:钱凯*/
		var up_time_day;
		var up_time_hour;
		var up_time_min;
		var up_time_sec;

		up_time_sec = parseInt((up_time % 3600) % 60);
		up_time_min = parseInt((up_time % 3600) / 60);
		if(ispName == 22)//泰国TRUE
		{		
			up_time_hour = parseInt((up_time / 3600) % 24);	
			up_time_day = parseInt(up_time / 3600 / 24);
		}
		else		//GLOBE
		{
			up_time_hour = parseInt(up_time/3600);
		}

		var up_time_day_text = up_time_day + " d ";		
		var up_time_hour_text = up_time_hour + " h ";
		var up_time_min_text = up_time_min + " m ";
		var up_time_sec_text = up_time_sec + " s ";	
		
		if(ispName == 22)//泰国TRUE
		{
			document.getElementById("wan_uptime").innerHTML = up_time_day_text + up_time_hour_text + up_time_min_text + up_time_sec_text;
		}
		else		//GLOBE
		{
			document.getElementById("wan_uptime").innerHTML = up_time_hour_text + up_time_min_text + up_time_sec_text;
		}

		/*modify end by 陈鹏 20181022*/
		document.getElementById("wan_mac").innerHTML = wan_mac_buff.split("|")[temp];
		document.getElementById("wan_gateway").innerHTML = wan_gateway_buff.split("|")[temp];

		var curIPMode = getElement("ip_mode_" + temp).innerHTML;
		var curPppCode = pppoe_state.split("|")[temp];
		if(ispName == 15)
		{
			if(curIPMode == 'PPPoE')
			{
				setDisplay("tr_ppp_state", "");
				getElement("ppp_stateDetail").innerHTML = getPppoeState(parseInt(curPppCode));
			}
			else
			{
				setDisplay("tr_ppp_state", "none");
			}
		}
		//add by wuxj, 20181205, 增加支持WEB_COMM_WAN_CFG
		if(WEB_COMM_WAN_CFG == 1)
			showIPV6info(temp);
		
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;
	}	 
}

function getPppoeState(code)
{
	switch(code)
	{
		case 0:
			return "OK";
			break;
		case 15:
		case 22:
		case 23:
			return "Request sent but no reply from server";
			break;
		case 11:
		case 19:
		case 21:
			return "Authenticaltion failed";
			break;
		default:
			return "Internet is down";
			break;
	}
}

function initTranslation()
{
	var e = document.getElementById("wan_statePrompt");
	e.innerHTML = _("wanstate_prompt");

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
	e = document.getElementById("v6State_title");
	e.innerHTML = _("v6State");
	e = document.getElementById("v6_address_title");    
	e.innerHTML = _("wanIpv6");
	e = document.getElementById("v6_state_title");
	e.innerHTML = _("wan_state");
	e = document.getElementById("v6_index_title");
	e.innerHTML = _("wan_name");
	e = document.getElementById("v6_IPMode_title");
	e.innerHTML = _("wan_mode");

	if(ispName == 12)/*厄瓜多尔 ipv6多wan*/
	{
//		var V6_wan_num = '<% getCfgGeneral(1, "v6_wan_num"); %>';
		for(var i = 0; i < V6_wan_num; i++)
		{
			e = document.getElementById("ipv6_prefixTitle_" + i);
			e.innerHTML = _("wanprefix");
			e = document.getElementById("ipv6_gatewayTitle_" + i);
			e.innerHTML = _("v6gateway");
			e = document.getElementById("ipv6_priDNSTitle_" + i);
			e.innerHTML = _("wan_dns");
		}
	}	
}

function initValue()
{
	initTranslation();
	selectLine("record_0");
/*	
	var ipv6_enable_s = '<% getCfgGeneral(1, "ipv6_enable"); %>';// 0:ipv4; 1:双栈 ;2:ipv6
	switch(parseInt(ipv6_enable_s))
	{
		case 0:
			setDisplay("tb_wanstate", "");
			break;
		case 1:
			setDisplay("tb_wanstate", "");
			break;
		case 2:
			setDisplay("tb_wanstate", "none");	//无V4,不显示WAN状态表
			break;
		default:								//视为V4
			setDisplay("tb_wanstate", "");
			break;
	}
*/
	//delete by wuxj, 20181225, 修改为支持多V6,根据各WAN实际的IP协议栈模式控制V6表显示(selectLine)
	//modify by wuxj, 20180621, 修改为通过idisplay_v6_flag控制V6表显示
/*	var idisplay_v6_flag = '<% getCfgGeneral(1, "idisplay_v6_flag"); %>';
	if(parseInt(idisplay_v6_flag) != 0)
	{
		setDisplay("ipv6_wan_state", "");
	}
	else
	{
		setDisplay("ipv6_wan_state", "none");
	}*/
	if((wan_num > 0) && (ispName == 9 || ispName == 15 || ispName == 22)) /*罗马尼亚版本/菲律宾GLOBE HGU/泰国TRUE，wan计数大于0*/
	{
		setDisplay("wan_state_table", "");
	}
	
	if(ispName == 12)/*厄瓜多尔 ipv6多wan*/
	{
		setDisplay("tb_wanstate", "");
		setDisplay("ipv6_mutiwan_state", "");
		setDisplay("ipv6_wan_state", "none");
	}
	//delete by 吴小娟, WEB_COMM_WAN_CFG时修改为有V6时才显示V6表。需求来源:王炎原
	/*
	var WEB_COMM_WAN_CFG = '<% getCfgGeneral(1, "WEB_COMM_WAN_CFG");%>';
	if(WEB_COMM_WAN_CFG == 1)
	{
		setDisplay("tb_wanstate", "");
		setDisplay("ipv6_wan_state", "");
	}
	*/
}

