<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Voip_basic</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipBasicSync = '<% voipBasicSync(); %>';
var device_type = '<% getCfgGeneral(1, "device_type");%>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num");%>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
var http_request = getRequest();

function voipCfgHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var voipWanRDONLY = http_request.responseText;
			if(voipWanRDONLY == "1")
			{
				getElement("voip_userName").disabled = 1;
				getElement("voip_pwd").disabled = 1;
				getElement("voip_telNum").disabled = 1;
				getElement("voip_userName_2").disabled = 1;
				getElement("voip_pwd_2").disabled = 1;
				getElement("voip_telNum_2").disabled = 1;
				getElement("voip_registrarServer").disabled = 1;
				getElement("voip_registrarServerPort").disabled = 1;
				getElement("voip_proxyServer").disabled = 1;
				getElement("voip_proxyServerPort").disabled = 1;				
				getElement("voip_outbound_ip").disabled = 1;
				getElement("voip_outbound_port").disabled = 1;

				//modify by wuxj, 20161103, descrip:配置灰显时按钮显示cancel,点击后端口重新注册(from 钱凯)
				setDisplay("basic_apply", "none");
				setDisplay("basic_reconnect", "");					
			}
			else
			{
				setDisplay("basic_apply", "");
			}
		 }  
		else													// if request status is different then 200  
		{ 
			var span_info = document.getElementById("span_info");
			setDisplay("span_info", "");
			span_info.innerHTML = 'Error: ['+http_request.status+'] '+http_request.statusText;  			
		 }
	}
}

function LoadFrame()
{
	initTranslation();
	
	var voip_ipmode = '<% getCfgGeneral(1, "voip_ipmode");%>';
	if(device_type == 0)	/*SFU 设备*/
	{
		var voip_ipModel = document.getElementById("ipModel");	
		for(var i = 0; i < voip_ipModel.length; i++)
		{
			if(voip_ipModel.options[i].value == voip_ipmode)
			{
				voip_ipModel.options[i].selected = true;
				break;
			}
		}
	
		setDisplay("VoipIPModel", "");
		connectionTypeSwitch();
		
		//add by wuxj, 20150825, X_CMCC_SICHUAN SFU cvlan svlan readonly
		if(ispNameCode == 202)	//X_CMCC_SICHUAN
		{
			getElement("vlanId").disabled = true;
			getElement("valn_priority").disabled = true;
			getElement("svlanId").disabled = true;
			getElement("svaln_priority").disabled = true;
		}
	}
	else /*HGU设备ip获取方式从wan页面配合*/
	{
		/* add by 吴小娟, 20181120, 原因:外发代理配置变更为HGU通用需求.需求来源:朱崇银 */
		setDisplay("tr_sip_outbound", "");
		setDisplay("tr_sip_secOutbound", "");
		
		setDisplay("VoipIPModel", "none");
		setDisplay("static", "none");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "none");
	}

	if(voip_port_num == 2)
	{
		setDisplay("div_voipport_2", "");
	}
	else
	{
		setDisplay("div_voipport_2", "none");
	}
	
	if(ispNameCode == 15)	//PH X_GLOBE
	{
		setDisplay("tr_region", "");
	}
	
	if((ispNameCode == 15) && (curUserType == 1)) /*globe版本普通用户*/
	{
		setDisplay("s_reg_server_tr", "none");
		setDisplay("f_proxy_server_tr", "none");
		setDisplay("s_proxy_server_tr", "none");
		setDisplay("tr_sip_outbound", "none");
		setDisplay("tr_sip_secOutbound", "none");

		setDisplay("VoipIPModel", "none");
		setDisplay("static", "none");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "none");

		setDisplay("basic_cancel", "none");

		var content = "voip_status_diagnosis";
		content = content + "&x-csrftoken=" + getCsrftoken();
		
		if (!http_request) {
			alert("Giving up :( \nCannot create an XMLHTTP instance!");
			return false;
		}
		
		http_request.onreadystatechange = voipCfgHandler;
		http_request.open('POST', "/goform/voip_status_diagnosis", true);
		http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		http_request.send(content);
	}
}

function initTranslation()
{
	var e = document.getElementById("voipbasic_prompt");
	e.innerHTML = _("voipbasic_prompt");

	e = document.getElementById("basic_title");
	e.innerHTML = _("basic_title");
	e = document.getElementById("username_title");
	e.innerHTML = _("username_title");
	e = document.getElementById("password_title");
	e.innerHTML = _("password_title");
	e = document.getElementById("phoneno_title");
	e.innerHTML = _("phoneno_title");

	e = document.getElementById("username2_title");
	e.innerHTML = _("username2_title");
	e = document.getElementById("password2_title");
	e.innerHTML = _("password2_title");
	e = document.getElementById("phoneno2_title");
	e.innerHTML = _("phoneno2_title");

	e = document.getElementById("usernamelong_tip");
	e.innerHTML = _("usernamelong_tip");
	e = document.getElementById("passwordlong_tip");
	e.innerHTML = _("passwordlong_tip");
	e = document.getElementById("usernamelong2_tip");
	e.innerHTML = _("usernamelong_tip");
	e = document.getElementById("passwordlong2_tip");
	e.innerHTML = _("passwordlong_tip");	

	e = document.getElementById("proxip1_title");
	e.innerHTML = _("proxip1_title");
	e = document.getElementById("proxip2_title");
	e.innerHTML = _("proxip2_title");
	e = document.getElementById("proxport1_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("proxport2_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("regip1_title");
	e.innerHTML = _("regip1_title");
	e = document.getElementById("regport1_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("regport2_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("regip2_title");
	e.innerHTML = _("regip2_title");
	
	e = document.getElementById("outbound_ip_title");
	e.innerHTML = _("outbound_ip_title");
	e = document.getElementById("outbound_port_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("outbound_ip_tips");
	e.innerHTML = _("address_tip");
	e = document.getElementById("secOutbound_ip_title");
	e.innerHTML = _("secOutbound_ip_title");
	e = document.getElementById("secOutbound_port_title");
	e.innerHTML = _("port_title");
	e = document.getElementById("secOutbound_ip_tips");
	e.innerHTML = _("address_tip");
	
	e = document.getElementById("address1_tip");
	e.innerHTML = _("address_tip");
	e = document.getElementById("address2_tip");
	e.innerHTML = _("address_tip");
	e = document.getElementById("address3_tip");
	e.innerHTML = _("address_tip");
	e = document.getElementById("address4_tip");
	e.innerHTML = _("address_tip");

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
	e = document.getElementById("protocol_title");
	e.innerHTML = _("protocol_title");
	e = document.getElementById("f_dns_title");
	e.innerHTML = _("f_dns_title");
	e = document.getElementById("s_dns_title");
	e.innerHTML = _("s_dns_title");
	e = document.getElementById("cvlan_p_title");
	e.innerHTML = _("cvlan_p_title");
	e = document.getElementById("svlan_p_title");
	e.innerHTML = _("svlan_p_title");

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
	
	e = document.getElementById("basic_apply");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel");
	e.value = _("voip_cancel");

}

function connectionTypeSwitch()
{
	var IpMode =  document.getElementById("ipModel");
	if (IpMode.options.selectedIndex == 0) 
	{
		setDisplay("static", "");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "none");
	}
	else if (IpMode.options.selectedIndex == 2) 
	{
		setDisplay("static", "none");
		setDisplay("pppoe", "");
		setDisplay("dhcp", "none");
	}
	else 
	{
		setDisplay("static", "none");
		setDisplay("pppoe", "none");
		setDisplay("dhcp", "");
	}

}

function CheckForm()
{
	var voip_userNameNode = document.getElementById("voip_userName");	
	if(!CheckNotNull(voip_userNameNode.value))
	{
		alert(_("nullAlert") + _("username_title"));
		voip_userNameNode.value = voip_userNameNode.defaultValue;
		voip_userNameNode.focus();
		return false;
	}
	if(!checkVoipNamePwd(voip_userNameNode.value))
	{
		alert(_("username_title") + _("illegalAlert"));
		voip_userNameNode.value = voip_userNameNode.defaultValue;
		voip_userNameNode.focus();
		return false;
	}

	var voip_pwdNode = document.getElementById("voip_pwd");
//	voip_pwdNode.value = trim(voip_pwdNode.value);	
	if(!CheckNotNull(voip_pwdNode.value))
	{
		alert(_("nullAlert") + _("password_title"));
		voip_pwdNode.value = voip_pwdNode.defaultValue;
		voip_pwdNode.focus();
		return false;
	}
	else if(voip_pwdNode.value != "<% getCfgGeneral(1, 'voip_pwd_encode'); %>")		//modify by wuxj, 20160301, for pwd encode
	{
		if(!checkVoipNamePwd(voip_pwdNode.value))
		{
			alert(_("password_title") + _("illegalAlert"));
			voip_pwdNode.value = voip_pwdNode.defaultValue;
			voip_pwdNode.focus();
			return false;
		}
	}

	var voip_telNumNode = document.getElementById("voip_telNum");
	if(!CheckNotNull(voip_telNumNode.value))
	{
		alert(_("nullAlert") + _("phoneno_title"));
		voip_telNumNode.value = voip_telNumNode.defaultValue;
		voip_telNumNode.focus();
		return false;
	}
	if(!checkVoipTelNum(voip_telNumNode.value))
	{
		alert(_("phoneno_title") + _("illegalAlert"));
		voip_telNumNode.value = voip_telNumNode.defaultValue;
		voip_telNumNode.focus();
		return false;
	}

	if(voip_port_num == 2)
	{
		var voip_userName_2 = document.getElementById("voip_userName_2");
//		voip_userName_2.value = trim(voip_userName_2.value);
		if(CheckNotNull(voip_userName_2.value))
		{
			if(!checkVoipNamePwd(voip_userName_2.value))//it should be legal when not null
			{
				alert(_("username_title") + _("illegalAlert"));
				voip_userName_2.value = voip_userName_2.defaultValue;
				voip_userName_2.focus();
				return false;
			}
			if(ispNameCode == 15)	//GLOBE要求两用户名不得相同
			{
				if(voip_userName_2.value == voip_userNameNode.value)
				{
					alert(_("usernameRepeatAlert"));
					voip_userName_2.value = voip_userName_2.defaultValue;
					voip_userName_2.focus();
					return false;
				}
			}
		}

		var voip_pwd_2 = document.getElementById("voip_pwd_2");
//		voip_pwd_2.value = trim(voip_pwd_2.value);
		if(voip_pwd_2.value != "<% getCfgGeneral(1, 'voip_pwd_port2_encode'); %>")//modify by wuxj, 20160301, for pwd encode
		{
			if(CheckNotNull(voip_pwd_2.value) && !checkVoipNamePwd(voip_pwd_2.value))
			{//it should be legal when not null
				alert(_("password_title") + _("illegalAlert"));
				voip_pwd_2.value = voip_pwd_2.defaultValue;
				voip_pwd_2.focus();
				return false;
			}
		}

		var voip_telNum_2 = document.getElementById("voip_telNum_2");
//		voip_telNum_2.value = trim(voip_telNum_2.value);
		if(CheckNotNull(voip_telNum_2.value))
		{
			if(!checkVoipTelNum(voip_telNum_2.value))
			{//it should be legal when not null
				alert(_("phone number is illegal."));
				voip_telNum_2.value = voip_telNum_2.defaultValue;
				voip_telNum_2.focus();
				return false;
			}
			if(ispNameCode == 15)	//GLOBE要求两号码不得相同
			{
				if(voip_telNum_2.value == voip_telNumNode.value)
				{
					alert(_("telNumRepeatAlert"));
					voip_telNum_2.value = voip_telNum_2.defaultValue;
					voip_telNum_2.focus();
					return false;
				}
			}
		}

	}	
	var voip_proxyServerNode = document.getElementById("voip_proxyServer");
	if(!CheckNotNull(voip_proxyServerNode.value))
	{
		//alert("主代理服务器地址不能为空!");
		alert(_("Please input first proxy server address."));
		voip_proxyServerNode.value = voip_proxyServerNode.defaultValue;
		voip_proxyServerNode.focus();
		return false;
	}
	else if(!checkVoipServer(voip_proxyServerNode.value))
	{
		/*alert("主代理服务器地址非法!");
		voip_proxyServerNode.value = voip_proxyServerNode.defaultValue;
		voip_proxyServerNode.focus();
		return false;*/
	}
	var voip_proxyServerPortNode = document.getElementById("voip_proxyServerPort");
	if(!CheckNotNull(voip_proxyServerPortNode.value))
	{
		//alert("主代理服务器端口不能为空!");
		alert(_("Please input first proxy server port."));
		voip_proxyServerPortNode.value = voip_proxyServerPortNode.defaultValue;
		voip_proxyServerPortNode.focus();
		return false;
	}
	else if(!checkVoipServerPort(voip_proxyServerPortNode.value))
	{
		//alert("主代理服务器端口非法!");
		alert(_("First proxy server port is illegal."));
		voip_proxyServerPortNode.value = voip_proxyServerPortNode.defaultValue;
		voip_proxyServerPortNode.focus();
		return false;
	}
	if(!((ispNameCode == 15) && (curUserType == 1))) /*非globe版本普通用户*/
	{
		var voip_secProxyServerNode = document.getElementById("voip_secProxyServer");
		if(!checkVoipServer(voip_secProxyServerNode.value))
		{
			/*alert("备代理服务器地址非法!");
			voip_secProxyServerNode.value = voip_secProxyServerNode.defaultValue;
			voip_secProxyServerNode.focus();
			return false;*/
		}
		
		var voip_secProxyServerPortNode = document.getElementById("voip_secProxyServerPort");
		if(!checkVoipServerPort(voip_secProxyServerPortNode.value))
		{
			//alert("备代理服务器端口非法!");
			alert(_("Second proxy server port is illegal."));
			voip_secProxyServerPortNode.value = voip_secProxyServerPortNode.defaultValue;
			voip_secProxyServerPortNode.focus();
			return false;
		}
	}
		
	var voip_regServerNode = document.getElementById("voip_registrarServer");
	if(!CheckNotNull(voip_regServerNode.value))
	{
		//alert("主注册服务器地址不能为空!");
		alert(_("Please input first Register server address."));
		voip_regServerNode.value = voip_regServerNode.defaultValue;
		voip_regServerNode.focus();
		return false;
	}
	else if(!checkVoipServer(voip_regServerNode.value))
	{
		/*alert("主注册服务器地址非法!");
		voip_regServerNode.value = voip_regServerNode.defaultValue;
		voip_regServerNode.focus();
		return false;*/
	}
	
	var voip_regServerPortNode = document.getElementById("voip_registrarServerPort");
	if(!CheckNotNull(voip_regServerPortNode.value))
	{
		//alert("主注册服务器端口不能为空!");
		alert(_("Please input first Register server port."));
		voip_regServerPortNode.value = voip_regServerPortNode.defaultValue;
		voip_regServerPortNode.focus();
		return false;
	}
	else if(!checkVoipServerPort(voip_regServerPortNode.value))
	{
		//alert("主注册服务器端口非法!");
		alert(_("First Register server port is illegal."));
		voip_regServerPortNode.value = voip_regServerPortNode.defaultValue;
		voip_regServerPortNode.focus();
		return false;
	}
	
	if(!((ispNameCode == 15) && (curUserType == 1))) /*非globe版本普通用户*/
	{
		var voip_secRegServerNode = document.getElementById("voip_secRegistrarServer");
		if(!checkVoipServer(voip_secRegServerNode.value))
		{
			/*alert("备注册服务器地址非法!");
			voip_secRegServerNode.value = voip_secRegServerNode.defaultValue;
			voip_secRegServerNode.focus();
			return false;*/
		}
		
		var voip_secRegServerPortNode = document.getElementById("voip_secRegistrarServerPort");
		if(!checkVoipServerPort(voip_secRegServerPortNode.value))
		{
			//alert("备注册服务器端口非法!");
			alert(_("Second Register server port is illegal."));
			voip_secRegServerPortNode.value = voip_secRegServerPortNode.defaultValue;
			voip_secRegServerPortNode.focus();
			return false;
		}
	}
//	if(ispNameCode == 5 || ispNameCode == 15)	//X_AIS/GLOBE
	if(device_type != 0)	/* HGU设备*/
	{		
		var voip_outbound_ipNode = document.getElementById("voip_outbound_ip");
		if(!checkVoipServer(voip_outbound_ipNode.value))
		{
		/*
			alert(_("outboundProxyIPIllegalAlert"));
			voip_outbound_ipNode.value = voip_outbound_ipNode.defaultValue;
			voip_outbound_ipNode.focus();
			return false;	*/
		}
		
		if(!((ispNameCode == 15) && (curUserType == 1))) /*非globe版本普通用户*/
		{
			var voip_outbound_portNode = document.getElementById("voip_outbound_port");
			if(!checkVoipServerPort(voip_outbound_portNode.value))
			{
				alert(_("outboundProxyPortIllegalAlert"));
				voip_outbound_portNode.value = voip_outbound_portNode.defaultValue;
				voip_outbound_portNode.focus();
				return false;
			}
			var voip_secOutbound_portNode = document.getElementById("voip_secOutbound_port");
			if(!checkVoipServerPort(voip_secOutbound_portNode.value))
			{
				alert(_("secOutboundProxyPortIllegalAlert"));
				voip_secOutbound_portNode.value = voip_secOutbound_portNode.defaultValue;
				voip_secOutbound_portNode.focus();
				return false;
			}
		}
	}

	if(device_type == 0)	/*SFU 设备*/
	{
		//add by wuxj, 20150825, X_CMCC_SICHUAN SFU cvlan svlan readonly
		if(ispNameCode != 202)	//非X_CMCC_SICHUAN
		{
			/*vlan id*/	
			var vlan_idnode = document.getElementById("vlanId");
			var svlan_idnode = document.getElementById("svlanId");
			if(!CheckNotNull(vlan_idnode.value))
			{
				alert(_("Please input VLAN."));
				vlan_idnode.value = vlan_idnode.defaultValue;
				vlan_idnode.focus();
				return false;
			}
			else if(!VIDLegal(vlan_idnode.value))
			{
				alert(_("VLAN is illegal."));
				vlan_idnode.value = vlan_idnode.defaultValue;
				vlan_idnode.focus();
				return false;
			}

			if(svlan_idnode.value != "")
			{
				if(!VIDLegal(svlan_idnode.value))
				{
					alert(_("VLAN is illegal."));
					svlan_idnode.value = svlan_idnode.defaultValue;
					svlan_idnode.focus();
					return false;
				}
			}

			/*vlan priority*/	
			var prioritynode = document.getElementById("valn_priority");
			var sprioritynode = document.getElementById("svaln_priority");
			if(!CheckNotNull(prioritynode.value))
			{
				alert(_("Please input priority."));
				prioritynode.value = prioritynode.defaultValue;
				prioritynode.focus();
				return false;
			}
			else if(!checkvalnpriority(prioritynode.value))
			{
				alert(_("Priority is illegal."));
				prioritynode.value = prioritynode.defaultValue;
				prioritynode.focus();
				return false;
			}
			if(sprioritynode.value != "")
			{
				if(!checkvalnpriority(sprioritynode.value))
				{
					alert(_("Priority is illegal."));
					sprioritynode.value = sprioritynode.defaultValue;
					sprioritynode.focus();
					return false;
				}
			}
		}
			
		var ipModelNode = document.getElementById("ipModel");
		var staticIpNode = document.getElementById("staticIp");
		var staticNetmaskNode = document.getElementById("staticNetmask");
		var staticGatewayNode = document.getElementById("staticGateway");
		var pppoeUserNode = document.getElementById("pppoeUser");
		var pppoePassNode = document.getElementById("pppoePass");

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
		else if ((ipModelNode.options.selectedIndex == 2))
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

function checkVoipNamePwd(str)
{
	var reg = /^[\w+.@-]{1,64}$/;	//数字 英文字母 _+.@-
	if (!reg.test(str))
	{ 
		return false; 
	}
	else
	{
		return true;
	}
}

function checkVoipPwd(str)
{
	var reg = /^[\*]{1,64}$/;	//数字 英文字母 _
	if (!reg.test(str))
	{ 
		return false; 
	}
	else
	{
		return true;
	}
}

function checkVoipTelNum(str)
{
	var reg = /^[\w+]{1,64}$/;	//数字字母_+
	if (!reg.test(str))
	{ 
		return false; 
	}
	else
	{
		return true;
	}
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
	if(str != "")				//数字 [1024, 65535]
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			str = parseInt(str);
			if(1024 <= str  && str <= 65535)//modify by wuxj 20151105, 修改为与网管需求相同
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
	if(str != "")				//数字 [0, 7]
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
	if(str != "")				//数字 [0, 4095]
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
<form method="post" name="voip_basic_form" action="/goform/voipBasic" onSubmit="return CheckForm()">
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
        <td id="protocol_title" class="tabal_left" width="28%">VoIP Protocol</td>
        <td class="tabal_right" colspan="3">SIP</td>
      </tr>
      <tr id="tr_region" style="display:none">
        <td class="tabal_left" width="28%">Region</td>
        <td class="tabal_right" colspan="3">Philippines</td>
      </tr>
      <tr>
        <td id="username_title" class="tabal_left">VoIP Username(port1)</td>
        <td class="tabal_right" colspan="3"><input name="voip_userName" id="voip_userName" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_userName"); %>">
          <strong style="color:#FF0033">*</strong> <span id="usernamelong_tip" class="gray">(Username length should be 1-64.)</span></td>
      </tr>
      <tr>
        <td id="password_title" class="tabal_left">VoIP Password(port1)</td>
        <td class="tabal_right" colspan="3"><input name="voip_pwd" id="voip_pwd" size="15" maxlength="64" type="password" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)" value="<% getCfgGeneral(1, 'voip_pwd_encode'); %>">
          <strong style="color:#FF0033">*</strong><span id="passwordlong_tip" class="gray">(Password length should be 1-64.)</span></td>
      </tr>
      <tr>
        <td id="phoneno_title" class="tabal_left">Telephone Number(port1)</td>
        <td class="tabal_right" colspan="3"><input name="voip_telNum" id="voip_telNum" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_telNum"); %>">
          <strong style="color:#FF0033">*</strong><span id="telNum_tip" class="gray"></span></td>
      </tr>
    <table id="div_voipport_2" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
      <tr class="tabal_left">
        <td id="username2_title" class="tabal_left" width="28%">VoIP Username(port2)</td>
        <td class="tabal_right" colspan="3"><input name="voip_userName_2" id="voip_userName_2" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_userName_port2"); %>">
          <span id="usernamelong2_tip" class="gray">(Username length should be 1-64.)</span></td>
      </tr>
      <tr>
        <td id="password2_title" class="tabal_left">VoIP Password(port2)</td>
        <td class="tabal_right" colspan="3"><input name="voip_pwd_2" id="voip_pwd_2" size="15" maxlength="64" type="password" onfocus="clearInputValue(this.id)" value="<% getCfgGeneral(1, 'voip_pwd_port2_encode'); %>">
          <span id="passwordlong2_tip" class="gray">(Password length should be 1-64.)</span></td>
      </tr>
      <tr>
        <td id="phoneno2_title" class="tabal_left">Telephone Number(port2)</td>
        <td class="tabal_right" colspan="3"><input name="voip_telNum_2" id="voip_telNum_2" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_telNum_port2"); %>">
          <span id="telNum2_tip" class="gray"></span></td>
      </tr>
      </tbody>
    </table>
    <table  class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>

    <tr id="f_reg_server_tr" class="tabal_left">
      <td id="regip1_title" class="tabal_left" width="28%">First Register Server</td>
      <td class="tabal_right"><input name="voip_registrarServer" id="voip_registrarServer" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_registrarServer"); %>">
        <strong style="color:#FF0033">*</strong><span id="address3_tip" class="gray">(IP or Domain)</span></td>
      <td id="regport1_title" class="tabal_left">Port</td>
      <td class="tabal_right"><input name="voip_registrarServerPort" id="voip_registrarServerPort" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_registrarServerPort"); %>">
        <strong style="color:#FF0033">*</strong><span class="gray">(1024-65535)</span></td>
    </tr>
  
  
    <tr id="s_reg_server_tr" class="tabal_left">
      <td id="regip2_title" class="tabal_left" width="28%">Second Register Server</td>
      <td class="tabal_right"><input name="voip_secRegistrarServer" id="voip_secRegistrarServer" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_secRegistrarServer"); %>">
        <span id="address4_tip" class="gray">(IP or Domain)</span></td>
      <td id="regport2_title" class="tabal_left">Port</td>
      <td class="tabal_right"><input name="voip_secRegistrarServerPort" id="voip_secRegistrarServerPort" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_secRegistrarServerPort"); %>">
        <span class="gray">(1024-65535)</span></td>
    </tr>
    <tr id="f_proxy_server_tr">
      <td id="proxip1_title" class="tabal_left" width="28%">First Proxy Server</td>
      <td class="tabal_right" ><input name="voip_proxyServer" id="voip_proxyServer" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_proxyServer"); %>">
        <strong style="color:#FF0033">*</strong><span id="address1_tip" class="gray">(IP or Domain)</span></td>
      <td id="proxport1_title" class="tabal_left" width="5%">Port</td>
      <td class="tabal_right"><input name="voip_proxyServerPort" id="voip_proxyServerPort" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_proxyServerPort"); %>">
        <strong style="color:#FF0033">*</strong><span class="gray">(1024-65535)</span></td>
    </tr>

    <tr id="s_proxy_server_tr">
      <td id="proxip2_title" class="tabal_left" width="28%">Second Proxy Server</td>
      <td class="tabal_right"><input name="voip_secProxyServer" id="voip_secProxyServer" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_secProxyServer"); %>">
        <span id="address2_tip" class="gray">(IP or Domain)</span></td>
      <td id="proxport2_title" class="tabal_left">Port</td>
      <td class="tabal_right"><input name="voip_secProxyServerPort" id="voip_secProxyServerPort" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_secProxyServerPort"); %>">
        <span class="gray">(1024-65535)</span></td>
    </tr>

      <tr id="tr_sip_outbound" style="display: none">
        <td id="outbound_ip_title" class="tabal_left" width="28%">Outbound Proxy Server</td>
        <td class="tabal_right"><input name="voip_outbound_ip" id="voip_outbound_ip" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, 'voip_outbound_ip'); %>">
          <span id="outbound_ip_tips" class="gray">(IP or Domain)</span></td>
        <td id="outbound_port_title" class="tabal_left">Port</td>
        <td class="tabal_right"><input name="voip_outbound_port" id="voip_outbound_port" size="15" maxlength="5" type="text" value="<% getCfgGeneral(1, 'voip_outbound_port'); %>">
          <span class="gray">(1024-65535)</span></td>
      </tr>
      <tr id="tr_sip_secOutbound" style="display: none">
        <td id="secOutbound_ip_title" class="tabal_left" width="28%">Second Outbound Proxy Server</td>
        <td class="tabal_right"><input name="voip_secOutbound_ip" id="voip_secOutbound_ip" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, 'voip_secOutbound_ip'); %>">
          <span id="secOutbound_ip_tips" class="gray">(IP or Domain)</span></td>
        <td id="secOutbound_port_title" class="tabal_left">Port</td>
        <td class="tabal_right"><input name="voip_secOutbound_port" id="voip_secOutbound_port" size="15" maxlength="5" type="text" value="<% getCfgGeneral(1, 'voip_secOutbound_port'); %>">
          <span class="gray">(1024-65535)</span></td>
      </tr>
    </tbody>
    
  </table>
  <table id="VoipIPModel" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td id="f_dns_title" class="tabal_left" width="28%">First DNS Address</td>
        <td class="tabal_right"><input name="voip_dns1" id="voip_dns1" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_dns1"); %>">
        </td>
      </tr>
      <tr>
        <td id="s_dns_title" class="tabal_left" width="28%%">Second DNS Address</td>
        <td class="tabal_right"><input name="voip_dns2" id="voip_dns2" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "voip_dns2"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="28%">CVLAN ID</td>
        <td class="tabal_right"><input name="vlanId" id="vlanId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "vlanid"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1-4095)</span></td>
        </td>
      </tr>
      <tr>
        <td id="cvlan_p_title" class="tabal_left" width="28%">CVLAN Priority</td>
        <td class="tabal_right"><input name="valn_priority" id="valn_priority" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "vlan_priority"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0-7)</span></td>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="28%">SVLAN ID</td>
        <td class="tabal_right"><input name="svlanId" id="svlanId" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "svlanid"); %>">
          <span class="gray">(1-4095)</span></td>
        </td>
      </tr>
      <tr>
        <td id="svlan_p_title" class="tabal_left" width="28%">SVLAN Priority</td>
        <td class="tabal_right"><input name="svaln_priority" id="svaln_priority" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "svlan_priority"); %>">
          <span class="gray">(0-7)</span></td>
        </td>
      </tr>
      <tr class="tabal_left">
        <td width="28%" class="tabal_left" id="wConnectionType">IP Mode</td>
        <td><select name="ipModel" id="ipModel" size="1" style="width:200px;" onChange="connectionTypeSwitch();">
            <option value="0">STATIC</option>
            <option value="1">DHCP</option>
            <option value="2">PPPoE</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id="static" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wStaticMode">STATIC Mode</td>
      </tr>
      <tr>
        <td class="tabal_left" width="28%" id="wStaticIp">IP</td>
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
        <td class="tabal_left" width="28%" id="wDhcpCon_ip_title">IP</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_ip"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_mask_tr">
        <td class="tabal_left" id="wDhcpCon_mask_title">Netmask</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wDhcpCon_mask"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_gateway_tr">
        <td class="tabal_left" id="wDhcpCon_gateway_title">Gateway</td>
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
        <td class="tabal_left" width="28%" id="wPppoeUser">Username</td>
        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=32 style="width:320px;" value="<% getCfgGeneral(1, "pppoe_username"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips">(You can input 1-32 characters)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="wPppoePassword">Password</td>
        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=32 style="width:320px;" value="<% getCfgGeneral(1, "pppoe_password"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips">(You can input 1-32 characters)</span></td>
      </tr>
      <tr id="wDhcpCon_ip_tr">
        <td class="tabal_left" id="wpppCon_ip_title">IP</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_ip" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_ip"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_mask_tr">
        <td class="tabal_left" id="wpppCon_mask_title">Netmask</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_mask" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_mask"); %>">
        </td>
      </tr>
      <tr id="wDhcpCon_gateway_tr">
        <td class="tabal_left" id="wpppCon_gateway_title">Gateway</td>
        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway" readonly="readonly" style="width:320px;" value="<% getCfgGeneral(1, "wpppCon_gateway"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="28%"></td>
        <td class="tabal_submit" align="left"><input class="submit" id="basic_apply" type="submit">
          <input class="submit" id="basic_cancel" onclick="window.location.reload();" type="reset">
          <input class="submit" id="basic_reconnect" value="Cancel" type="button" onclick="document.location = '/goform/voip_reconnect'" style="display: none;">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<span id="span_info" style="display: none; color:#FF0000"></span>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
