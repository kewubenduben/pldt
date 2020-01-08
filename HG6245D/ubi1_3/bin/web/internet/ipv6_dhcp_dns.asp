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
<title>DHCPv6</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);


var setDhcpv6Sync = '<% setDhcpv6Sync(); %>';

function initTranslation()
{
    var e = document.getElementById("ipv6_dns_prompt");
    e.innerHTML = _("ipv6_dns_prompt");
    e = document.getElementById("ipv6_dns_title");
    e.innerHTML = _("ipv6_dns_title");
    e = document.getElementById("dns_source_title");
    e.innerHTML = _("dns_source_title");
    e = document.getElementById("dns_source_net_title");
    e.innerHTML = _("v6_net_title");
    e = document.getElementById("dns_source_static_title");
    e.innerHTML = _("v6_static_title");
    e = document.getElementById("dns_source_agent_title");
    e.innerHTML = _("dns_source_agent_title");
    e = document.getElementById("first_dns_title");
    e.innerHTML = _("first_dns_title");
    e = document.getElementById("sec_dns_title");
    e.innerHTML = _("sec_dns_title");
    e = document.getElementById("dhcpv6_apply");
    e.value = _("inet apply");
    e = document.getElementById("dhcpv6_cancel");
    e.value = _("inet cancel");
}

function initValue()
{
	var v6dns_Mode = '<% getCfgGeneral(1, "dns_srouce"); %>';
	var v6dns_Mode_id = document.getElementById("dns_srouce");
    
    	for(var i = 0; i< v6dns_Mode_id.length; i++)
	{
		if(v6dns_Mode_id.options[i].value == v6dns_Mode )
		{
			v6dns_Mode_id.options[i].selected = true;
			break;
		}
	}
	dnsModeSwitch();
    	initTranslation();
}
function CheckValue()
{

var ra_Pridns_Set = document.getElementById("Pridns_Set");
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
return true;
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
</script>

</head>

<body class="mainbody" onLoad="initValue()">

    <form method="post" name="lanCfg" id="lanCfg" action="/goform/setIPv6DhcpDns" onSubmit="return CheckValue()">

	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tbody>
	      <tr>
	        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
	            <tbody>
	              <tr>
	                <td id="ipv6_dns_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
	              </tr>
	            </tbody>
	          </table></td>
	      </tr>
	      <tr>
	        <td height="5px"></td>
	      </tr>
	    </tbody>
	  </table>
	  
        <table id="ipv6_cfg_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>

                <tr class="tabal_head">
                    <td colspan="2" id="ipv6_dns_title">IPv6 DNS Proxy Setting</td>
                </tr>

                <tr>
                    <td class="tabal_left" width="25%" id="dns_source_title">DNS Source</td>
                        <td class="tabal_right">
                            <select name="dns_srouce" id="dns_srouce" size="1" onChange="dnsModeSwitch();">
                                <option value="0" id="dns_source_net_title">Network Connection</option>
                                <option value="1" id="dns_source_static_title">Static</option>
                                <option value="2" id="dns_source_agent_title">Agent</option>
                            </select>
                        </td>
                </tr>

                <tr id="v6_dnsServer1" style="display: none">
                    <td class="tabal_left" width="25%" id="first_dns_title">Primary DNS Server</td>
                    <td class="tabal_right"><input name="Pridns_Set" id="Pridns_Set" maxlength=128 value="<% getCfgGeneral(1, "Pridns_Set"); %>"/></td>
                </tr>
                <tr id="v6_dnsServer2" style="display: none">
                    <td class="tabal_left" width="25%" id="sec_dns_title">Secondary DNS Server</td>
                    <td class="tabal_right"><input name="secdns_Set" id="secdns_Set" maxlength=128 value="<% getCfgGeneral(1, "secdns_Set"); %>"/></td>
                </tr>
                
	        </tbody> 
        </table>
  
        <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dhcpv6_apply" id="dhcpv6_apply" class="submit">
                    <input type="reset" value="Cancel" name="dhcpv6_cancel" id="dhcpv6_cancel" class="submit" onClick="window.location.reload();">
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
