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
<title>DDNS</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ddns", lang);

var ddnsSync = '<% ddnsSync(); %>';
var wanNameSync = '<% wanNameSync(); %>';	
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("ddns_prompt");
	e.innerHTML = _("ddns_prompt");

	e = document.getElementById("ddns_enable");
	e.innerHTML = _("Enable");
	e = document.getElementById("ddns_disable");
	e.innerHTML = _("Disable");
	
	e = document.getElementById("ddns_usernameTitle");
	e.innerHTML = _("ddns_username");
	e = document.getElementById("ddns_passwordTitle");
	e.innerHTML = _("ddns_password");
	e = document.getElementById("ddns_domainTitle");
	e.innerHTML = _("ddns_domain");
	e = document.getElementById("ddns_hostTitle");
	e.innerHTML = _("ddns_hostTitle");
	e = document.getElementById("ddns_providerTitle");
	e.innerHTML = _("ddns_providerTitle");
	e = document.getElementById("ddns_interfaceTitle");
	e.innerHTML = _("ddns_interface");
	e = document.getElementById("ddns_usernameTips");
	e.innerHTML = _("ddns_usernameTips");
	e = document.getElementById("ddns_passwordTips");
	e.innerHTML = _("ddns_passwordTips");
	
	e = document.getElementById("ddns_hostTips");
	e.innerHTML = _("ddns_hostTips");
	e = document.getElementById("ddns_serverTitle");
	e.innerHTML = _("ddns_server");
	e = document.getElementById("ddns_protocolTitle");
	e.innerHTML = _("ddns_protocolTitle");
	e = document.getElementById("Server_url_title");
	e.innerHTML = _("Server_url_title");
	
	e = document.getElementById("ddns_apply");
	e.value = _("ddns_apply");
	e = document.getElementById("ddns_cancel");
	e.value = _("ddns_cancel");
	e = document.getElementById("ddnscfg_remove");
	e.value = _("ddnscfg_remove");

}

function ddnsRemoveConfirm()
{
	document.location = "/goform/ddnsDele" + "?csrftoken=" + getCsrftoken();
}

function initValue()
{
	initTranslation();

	if(ispNameCode == 16)	//越南HGU
	{
		setDisplay("tr_ddnsEnable", "");
		var ddns_enable = '<% getCfgZero(1, "ddns_enable"); %>';
		var ddnsEnableNode = getElement("ddnsEnable");
		showRadioNodeByValue(ddnsEnableNode, ddns_enable);
		onClickSwitch(ddns_enable);
	}

	var ddns_interface = '<% getCfgZero(1, "ddns_interface"); %>';
	var ddnsinternode  = document.getElementById("ddns_interface");
	var ddnsprovidernode  = document.getElementById("ddns_provider");
	var ddns_protocolnode = document.getElementById("ddns_protocol");
	var i = 0;
	
	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");
	
	var pf_ruleSum = '<% getCfgGeneral(1, "wan_size"); %>';
	for(i = 0; i < pf_ruleSum; i++ )
	{
		if(wannameArray[i].search("INTERNET") >= 0)
		{
			ddnsinternode.options[ddnsinternode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if((ispNameCode == 5) && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			ddnsinternode.options[ddnsinternode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	for(var i = 0; i < ddnsinternode.length; i++)
	{
		if(ddnsinternode.options[i].value == ddns_interface)
		{
			ddnsinternode.options[i].selected = true;
			break;
		}
	}

	var ddnsproviderid  = '<% getCfgZero(1, "ddns_provider"); %>';
	var ddns_protocolid  = '<% getCfgZero(1, "ddns_protocol"); %>';
	for(var i = 0; i< ddnsprovidernode.length; i++)
	{
		if(ddnsprovidernode.options[i].value == ddnsproviderid )
		{
			ddnsprovidernode.options[i].selected = true;
			break;
		}
	}

	for(var i = 0; i < ddns_protocolnode.length; i++)
	{
		if(ddns_protocolnode.options[i].value == ddns_protocolid )
		{
			ddns_protocolnode.options[i].selected = true;
			break;
		}
	}

	ProviderTypeSwitch();

}


function checkddns_password(str)
{
	if (str.length > 0) 
	{
		var reg = /^[\S]{1,32}$/;	
		if (!reg.test(str))
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

function checkddns_host(str)
{
	if (str.length > 0) 
	{
		//var reg = /^[\S]{1,32}$/;
		var reg = /^[A-Za-z0-9.]{1,64}$/;
		if (!reg.test(str))
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

function checkddnsusername(str)
{
	if (str.length > 0) 
	{
		var re=/^[a-z0-9]{1,32}$/;	
		if (!re.test(str))
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

function CheckValue()
{	
	var ddns_password = document.getElementById("ddns_password");
	var ddns_domain = document.getElementById("ddns_domain");
	var ddns_username = document.getElementById("ddns_username");
	var ddns_interfaceNode = document.getElementById("ddns_interface");
	var ddns_provider = document.getElementById("ddns_provider");
	
	var ddns_hostnode = document.getElementById("ddns_host");
	var ddns_servernode = document.getElementById("ddns_server");
	var ddns_protocolnode = document.getElementById("ddns_protocol");
	var Server_urlnode = document.getElementById("Server_url");

	if (!CheckNotNull(ddns_username.value)) 
	{					
		alert(_("Please enter username!"));
		ddns_username.value = ddns_username.defaultValue;
		ddns_username.focus();
		return false;
	}
	
	if (!CheckNotNull(ddns_password.value)) 
	{					
		alert(_("Please enter password!"));
		ddns_password.value = ddns_password.defaultValue;
		ddns_password.focus();
		return false;
	}

	if (!CheckNotNull(ddns_hostnode.value)) 
	{					
		alert(_("Please enter host domain!"));
		ddns_hostnode.value = ddns_hostnode.defaultValue;
		ddns_hostnode.focus();
		return false;
	}
	/* add by 吴小娟, 20141210, 原因:增加接入网口非空判断 */
	if (!CheckNotNull(ddns_interfaceNode.value)) 
	{			
		alert(_("ddns_interfaceNUllAlert"));
		ddns_interfaceNode.value = ddns_interfaceNode.defaultValue;
		ddns_interfaceNode.focus();
		return false;
	}
/*
	if(!checkddnsusername(ddns_username.value))
	{
		alert(_("username is illegal!"));
		ddns_username.value = ddns_username.defaultValue;
		ddns_username.focus();
		return false;
  }
*/
	if(ddns_password.value != "<% getCfgGeneral(1, 'ddns_password_encode'); %>")		//modify by wuxj, 20160317, for pwd encode
	{
		if(!checkddns_password(ddns_password.value))
		{
			alert(_("Password is illegal!"));
			ddns_password.value = ddns_password.defaultValue;
			ddns_password.focus();
			return false;
		}
	}
/*
	if(!checkddns_host(ddns_host.value))
	{
		alert(_("Host Domain Name is illegal!"));
		ddns_host.value = ddns_host.defaultValue;
		ddns_host.focus();
		return false;
	}*/

	if(ddns_provider.options.selectedIndex  == 3)
	{
		if (!CheckNotNull(ddns_domain.value)) 
		{					
			alert(_("Please enter domain!"));
			ddns_domain.value = ddns_domain.defaultValue;
			ddns_domain.focus();
			return false;
		}
		if (!CheckNotNull(ddns_servernode.value)) 
		{					
			alert(_("Please enter serveraddr!"));
			ddns_servernode.value = ddns_servernode.defaultValue;
			ddns_servernode.focus();
			return false;
		}
		if(ddns_protocolnode.options.selectedIndex  == 0)
		{
			if (!CheckNotNull(Server_urlnode.value)) 
			{					
				alert(_("Please enter url!"));
				Server_urlnode.value = Server_urlnode.defaultValue;
				Server_urlnode.focus();
				return false;
			}
		}
	}
	
	return true;
}

function ProviderTypeSwitch()
{
	var ddns_provider = document.getElementById("ddns_provider");
	if(ddns_provider.options.selectedIndex == 3)
	{
		setDisplay("ddns_other_table", "");
		ProtocolTypeSwitch();
	}
	else
	{
		setDisplay("ddns_other_table", "none");
		setDisplay("ddns_url_table", "none");
	}
}

function ProtocolTypeSwitch()
{
	var ddns_protocol = document.getElementById("ddns_protocol");
	if(ddns_protocol.options.selectedIndex == 0)
	{
		setDisplay("ddns_url_table", "");
	}
	else
	{
		setDisplay("ddns_url_table", "none");
	}
}
function onClickSwitch(switchValue)
{
	if(switchValue == 0)	//disable
	{
		getElement("ddns_username").disabled = 1;
		getElement("ddns_password").disabled = 1;
		getElement("ddns_host").disabled = 1;
		getElement("ddns_domain").disabled = 1;
		getElement("ddns_protocol").disabled = 1;
		getElement("ddns_server").disabled = 1;
		getElement("Server_url").disabled = 1;
		getElement("ddns_interface").disabled = 1;
		getElement("ddns_provider").disabled = 1;
	}
	else
	{
		getElement("ddns_username").disabled = 0;
		getElement("ddns_password").disabled = 0;
		getElement("ddns_host").disabled = 0;
		getElement("ddns_domain").disabled = 0;
		getElement("ddns_protocol").disabled = 0;
		getElement("ddns_server").disabled = 0;
		getElement("Server_url").disabled = 0;
		getElement("ddns_interface").disabled = 0;
		getElement("ddns_provider").disabled = 0;
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="ddns_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="tabal_head">DDNS</td>
    </tr>
  </tbody>
</table>
<form method="post" name="ddns_form" action="/goform/ddnsCfg" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_ddnsEnable" style="display: none">
        <td class="tabal_left" id="ddnsEnable_title" align="left" width="25%">DDNS</td>
        <td class="tabal_right" colspan="6" align="left"><input checked="checked" value="1" name="ddnsEnable" onclick="onClickSwitch(this.value)" type="radio">
          <span id="ddns_enable">Enable</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="ddnsEnable" onclick="onClickSwitch(this.value)" type="radio">
          <span id="ddns_disable">Disable</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ddns_usernameTitle">Username</td>
        <td class="tabal_right"><input name="ddns_username" id="ddns_username" size="15" maxlength="32" type="text" autocomplete="off" value="<% getCfgGeneral(1, "ddns_username"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="ddns_usernameTips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="ddns_passwordTitle">Password</td>
        <td class="tabal_right"><input name="ddns_password" id="ddns_password" size="15" maxlength="32" type="password" autocomplete="off" value="<% getCfgGeneral(1, "ddns_password_encode"); %>" onFocus="clearInputValue(this.id)" onBlur="resetInputValue(this.id)">
          <strong style="color:#FF0033">*</strong><span class="gray" id="ddns_passwordTips"></span></td>
      </tr>
      <!--<tr>
        <td class="tabal_left" width="25%" id="ddns_hostTitle">主机域名:</td>
        <td class="tabal_right">
        	<select name="ddns_host" id="ddns_host">
				<option value="0">.3322.org</option>
	          	<option value="1">.2288.org</option>
			  	<option value="2">.6600.org</option>
			  	<option value="3">.7700.org</option>
			  	<option value="4">.8800.org</option>
			  	<option value="5">.8866.org</option>
			  	<option value="6">.9966.org</option>
        	</select></td>
        </td>
      </tr>

       <tr id="TrNetMode">
        <td class="tabal_left" width="25%" id="basicNetMode">Network Mode</td>
        <td class="tabal_right"><select name="wirelessmode" id="wirelessmode" size="1" value=4>
            <option value=0>802.11 b</option>
            <option value=1>802.11 g</option>
            <option value=2>802.11 b/g</option>
            <option value=3>802.11 n</option>
            <option value=4>802.11 b/g/n</option>
          </select></td>
      -->
      <tr>
        <td class="tabal_left" id="ddns_hostTitle">Host</td>
        <td class="tabal_right"><input name="ddns_host" id="ddns_host" size="32" maxlength="64" type="text" value="<% getCfgGeneral(1, "ddns_host"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="ddns_hostTips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" id="ddns_interfaceTitle">WAN Interface</td>
        <td class="tabal_right"><select id="ddns_interface" name="ddns_interface" size="1" style="width:35%">
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="ddns_providerTitle">DDNS Provider</td>
        <td class="tabal_right"><select id="ddns_provider" name="ddns_provider" size="1" style="width:35%" onChange="ProviderTypeSwitch();">
            <option value="0" selected="selected">www.3322.org </option>
            <option value="1">www.dyndns.org</option>
            <option value="2">www.no-ip.com</option>
            <option value="3">Other</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id="ddns_other_table" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="ddns_domainTitle">Domain</td>
        <td class="tabal_right"><input name="ddns_domain" id="ddns_domain" size="32" maxlength="64" type="text" value="<% getCfgGeneral(1, "ddns_domain"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(eg. dyndns.co.za)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ddns_serverTitle">Server Address</td>
        <td class="tabal_right"><input name="ddns_server" id="ddns_server" size="32" maxlength="255" type="text" value="<% getCfgGeneral(1, "ddns_server"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(eg. www.dyndns.co.za)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ddns_protocolTitle">Protocol</td>
        <td class="tabal_right"><select id="ddns_protocol" name="ddns_protocol" size="1" style="width:35%" onChange="ProtocolTypeSwitch();">
            <option value="2"selected="selected">GNUDip.http</option>
            <option value="1">GNUDip.tcp</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id="ddns_url_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr style="">
        <td width="25%" class="tabal_left" id="Server_url_title">Server URL</td>
        <td class="tabal_right" width="75%"><input name="Server_url" id="Server_url" size="32"  maxlength="255" style="width: 150px;" type="text" value="<% getCfgGeneral(1, "Server_url"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(eg. /cgi-bin/gdipupdt.cgi)</span></td>
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
        <td class="tabal_submit" align="left"><input class="submit" id="ddnscfg_remove" value="Remove Configuration" type="button" onClick="ddnsRemoveConfirm()">
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
