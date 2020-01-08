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
<title>DHCP Service</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var dhcpServiceSync = '<% dhcpServiceSync(); %>';
var optionenbale = '<% getCfgGeneral(1, "option_60enable_s"); %>';
var option125enbale = '<% getCfgGeneral(1, "option_125enable"); %>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
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

function option60TypeSwitch()		
{

	if (document.dhcpCfg.option_60enable_s.options.selectedIndex == 0)
	{
		document.getElementById("option_start").style.visibility = "hidden";
		document.getElementById("option_start").style.display = "none";
		document.dhcpCfg.option60Start.disabled = true;
		document.getElementById("option_end").style.visibility = "hidden";
		document.getElementById("option_end").style.display = "none";
		document.dhcpCfg.option60End.disabled = true;
	}
	else
	{
		document.getElementById("option_start").style.visibility = "visible";
		document.getElementById("option_start").style.display = style_display_on();
		document.dhcpCfg.option60Start.disabled = false;
		document.getElementById("option_end").style.visibility = "visible";
		document.getElementById("option_end").style.display = style_display_on();
		document.dhcpCfg.option60End.disabled = false;
	}
}

function option125TypeSwitch()
{
	if (document.dhcpCfg.option_125enable_s.options.selectedIndex == 0)
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
	document.dhcpCfg.dhcpStart.disabled = true;
	document.getElementById("end").style.visibility = "hidden";
	document.getElementById("end").style.display = "none";
	document.dhcpCfg.dhcpEnd.disabled = true;
	document.getElementById("mask").style.visibility = "hidden";
	document.getElementById("mask").style.display = "none";
	document.dhcpCfg.dhcpMask.disabled = true;
	document.getElementById("pridns").style.visibility = "hidden";
	document.getElementById("pridns").style.display = "none";
	document.dhcpCfg.dhcpPriDns.disabled = true;
	document.getElementById("secdns").style.visibility = "hidden";
	document.getElementById("secdns").style.display = "none";
	document.dhcpCfg.dhcpSecDns.disabled = true;
	document.getElementById("gateway").style.visibility = "hidden";
	document.getElementById("gateway").style.display = "none";
	document.dhcpCfg.dhcpGateway.disabled = true;
	document.getElementById("option_60enable").style.visibility = "hidden";
	document.getElementById("option_60enable").style.display = "none";
	document.dhcpCfg.option_60enable_s.disabled = true;
	document.getElementById("option_start").style.visibility = "hidden";
	document.getElementById("option_start").style.display = "none";
	document.dhcpCfg.option60Start.disabled = true;
	document.getElementById("option_end").style.visibility = "hidden";
	document.getElementById("option_end").style.display = "none";
	document.dhcpCfg.option60End.disabled = true;

	document.getElementById("dhcp_time").style.visibility = "hidden";
	document.getElementById("dhcp_time").style.display = "none";

	setDisplay("option_125enable", "none");
	setDisplay("option125_text_id", "none");
	setDisplay("dhcp_agent_id", "none");

	/*setDisplay("div_dhcpServer", "none");*/
	if (document.dhcpCfg.dhcpType.options.selectedIndex == 1)
	{	
		document.getElementById("start").style.visibility = "visible";
		document.getElementById("start").style.display = style_display_on();
		document.dhcpCfg.dhcpStart.disabled = false;
		document.getElementById("end").style.visibility = "visible";
		document.getElementById("end").style.display = style_display_on();
		document.dhcpCfg.dhcpEnd.disabled = false;
		document.getElementById("mask").style.visibility = "visible";
		document.getElementById("mask").style.display = style_display_on();
		document.dhcpCfg.dhcpMask.disabled = false;
		document.getElementById("pridns").style.visibility = "visible";
		document.getElementById("pridns").style.display = style_display_on();
		document.dhcpCfg.dhcpPriDns.disabled = false;
		document.getElementById("secdns").style.visibility = "visible";
		document.getElementById("secdns").style.display = style_display_on();
		document.dhcpCfg.dhcpSecDns.disabled = false;
		document.getElementById("gateway").style.visibility = "visible";
		document.getElementById("gateway").style.display = style_display_on();
		document.dhcpCfg.dhcpGateway.disabled = false;

		document.getElementById("dhcp_time").style.visibility = "visible";
		document.getElementById("dhcp_time").style.display = style_display_on();		
		
		document.getElementById("option_60enable").style.visibility = "visible";
		document.getElementById("option_60enable").style.display = style_display_on();
		document.dhcpCfg.option_60enable_s.disabled = false;
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
	else if(document.dhcpCfg.dhcpType.options.selectedIndex == 2) /*dhcp relay*/
	{
		setDisplay("dhcp_agent_id", "");
	}
		
}

function initTranslation()
{
	var e = document.getElementById("dhcp_prompt");
	e.innerHTML = _("dhcp_prompt");
	
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
	
	e = document.getElementById("dhcp_apply");
	e.value = _("inet apply");
	e = document.getElementById("dhcp_cancel");
	e.value = _("inet cancel");	
}

function initValue()
{
	initTranslation();
	var dhcp = <% getCfgZero(1, "dhcpEnabled"); %>;
	var optionvalue = getElementByName("option_60enable_s");
	var option125value = getElementByName("option_125enable_s");
	var dhcp_node = document.getElementById("dhcpType");
	
	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
	
	if(ispNameCode == 15)/*globe*/
	{
		dhcp_node.options[dhcp_node.length] = new Option("DHCP Relay", "2");
	}
	
	document.dhcpCfg.dhcpType.options.selectedIndex = 1 * dhcp;
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
}

function checkIpAddr(field, ismask)
{
	/* modify begin by 吴小娟, 20110503, 原因: 子网掩码校验范围不正确，
	    本次修改将所有校验改为采用专用的JS校验文件checkValue.js*/
	if (!CheckNotNull(field.value)) 
	{
		//alert("Error! IP address is empty.");
		alert(_("dhcp_IP_empty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {		
		if(!validateMask(field.value))
		{
			//alert('subnet mask is illegal!');
			alert(_("dhcp_mask_illegal"));
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
			alert(_("dhcp_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
	/* modify end by 吴小娟, 20110503 */
}

function IpAddress2DecNum(address)
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
	if (document.dhcpCfg.dhcpType.options.selectedIndex == 1) 
	{
		if (!checkIpAddr(document.dhcpCfg.dhcpStart, false))
		{
			return false;
		}
		if (!checkIpAddr(document.dhcpCfg.dhcpEnd, false))
		{
			return false;
		}
		if (!checkIpAddr(document.dhcpCfg.dhcpMask, true))
		{
			return false;
		}		
		if (!checkIpAddr(document.dhcpCfg.dhcpPriDns, false))
		{
			return false;
		}

		if((IpAddress2DecNum(document.dhcpCfg.dhcpEnd.value) - IpAddress2DecNum(document.dhcpCfg.dhcpStart.value)) < 0 )
		{
			alert(_("pf_endIPTooSmallAlert"));
			return false;
		}
		
/* modify begin by 吴小娟, 20111208, 原因:该参数可以为空 */
		var secDnsNode = document.dhcpCfg.dhcpSecDns;
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

		if (!checkIpAddr(document.dhcpCfg.dhcpGateway, false))
		{
			return false;
		}

		if (document.dhcpCfg.option_60enable_s.options.selectedIndex == 1)
		{
			if (!checkIpAddr(document.dhcpCfg.option60Start, false))
			{
				return false;
			}
			if (!checkIpAddr(document.dhcpCfg.option60End, false))
			{
				return false;
			}
		}


			if ((document.dhcpCfg.dhcptime.value) != 0)
			{
				if (!checktime_hour(document.dhcpCfg.dhcptime))
				{
					return false;
				}
			}

			

			if ((document.dhcpCfg.dhcptime_m.value) != 0)
			{
				if (!checktime_min(document.dhcpCfg.dhcptime_m))
				{
					return false;
				}
			}

			if (((document.dhcpCfg.dhcptime.value ) == 0) &&
				((document.dhcpCfg.dhcptime_m.value) == 0))
			{
				alert(_("DHCP Lease Time is illegal."));
				return false;
				
			}

			if (parseInt(document.dhcpCfg.dhcptime_m.value) == 99*60)
			{
				if ((parseInt(document.dhcpCfg.dhcptime.value ) )> 0)
				{
					alert(_("DHCP Lease Time is illegal."));
					document.dhcpCfg.dhcptime.value = 0;
					return false;
				}

			}

			if (parseInt(document.dhcpCfg.dhcptime.value) == 99)
			{
				if ((parseInt(document.dhcpCfg.dhcptime_m.value )) > 0)
				{
					alert(_("DHCP Lease Time is illegal."));
					document.dhcpCfg.dhcptime_m.value = 0;
					return false;
				}

			}

			if(ispNameCode == 15)/*globe*/
			{
				var option125_valuenode = document.dhcpCfg.option125_text;
				if (document.dhcpCfg.option_125enable_s.options.selectedIndex == 1)
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
	else if (document.dhcpCfg.dhcpType.options.selectedIndex == 2) 
	{
		if (!checkIpAddr(document.dhcpCfg.dhcprelay_ip, false))
		{
			return false;
		}
	}

	if(ispNameCode == '16')/* VIETTEL */
	{
		alert(_("rebootAlert"));
	}
	return true;
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

var oldDhcpStartIP;
function recDhcpIP(id)
{
	oldDhcpStartIP = getElement(id).value;
}

/*
 * Try to modify dhcp server configurations:
 *   dhcp start/end ip address to the same as new lan ip address
 */
function modDhcpIP(id)
{
	var node = getElement(id);
	if(node.value != oldDhcpStartIP)
	{
		if(confirm(_("lan_modDhcpIPConfirm")) == false)
		{
			node.value = oldDhcpStartIP;
			return ;	
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="dhcpCfg" id="dhcpCfg" action="/goform/setDhcp" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="dhcp_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_submit"><input type="submit" value="Apply" id="dhcp_apply" class="submit" onClick="TimeoutReload(20)">
          <input type="reset" name="Cancel" value="Cancel" id="dhcp_cancel" class="submit" onClick="window.location.reload()">
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
