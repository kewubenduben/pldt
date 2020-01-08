<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>

<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
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
    var e = document.getElementById("ipv6_dhcp_prompt");
    e.innerHTML = _("ipv6_dhcp_prompt");    
    e = document.getElementById("ipv6_addr_title");
    e.innerHTML = _("ipv6_addr_title");
    e = document.getElementById("ipv6_static_addr_tips");
    e.innerHTML = _("ipv6_static_addr_tips");   
    e = document.getElementById("ipv6_lan_title");
    e.innerHTML = _("ipv6_lan_title");
    e = document.getElementById("Enable_dhcpv6_title");
    e.innerHTML = _("Enable_dhcpv6_title");        
    e = document.getElementById("v6dhcpstart_title");
    e.innerHTML = _("v6dhcpstart_title");
    e = document.getElementById("v6dhcpend_title");
    e.innerHTML = _("v6dhcpend_title");
    e = document.getElementById("Managed_Flag_title");
    e.innerHTML = _("Managed_Flag_title");
    e = document.getElementById("other_Flag_title");
    e.innerHTML = _("other_Flag_title");
    e = document.getElementById("ipv6_static_addr_title");
    e.innerHTML = _("ipv6_static_addr_title");  
	e = document.getElementById("max_Interval_title");
	e.innerHTML = _("max_Interval_title");
	e = document.getElementById("min_Interval_title");
	e.innerHTML = _("min_Interval_title");
	e = document.getElementById("max_Interval_tips");
	e.innerHTML = _("max_Interval_tips");
	e = document.getElementById("min_Interval_tips");
	e.innerHTML = _("min_Interval_tips");
    e = document.getElementById("dhcpv6_apply");
    e.value = _("inet apply");
    e = document.getElementById("dhcpv6_cancel");
    e.value = _("inet cancel");
}


function initValue()
{
        initTranslation();
        
	var enable_dhcp6s = '<% getCfgGeneral(1, "enable_dhcp6s"); %>';
	var enable_dhcp6s_id = document.getElementById("Enable_dhcpv6");
        var managed_flag = '<% getCfgGeneral(1, "managed_flag"); %>';
    	var Managed_Flag_id = document.getElementById("Managed_Flag");
    	var other_flag = '<% getCfgGeneral(1, "other_flag"); %>';
    	var other_Flag_id = document.getElementById("Other_Flag");
       
    
	if(enable_dhcp6s == 1 )
	{
            enable_dhcp6s_id.checked = true;
            setDisplay("tr_dhcpv6_startip", "");
            setDisplay("tr_dhcpv6_endip", "");
	}
	else
	{
            enable_dhcp6s_id.checked = false;
            setDisplay("tr_dhcpv6_startip", "none");
            setDisplay("tr_dhcpv6_endip", "none");
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

}
function CheckValue()
{
    var ipv6_static_addr = document.getElementById("ipv6_static_addr");
    if (!CheckNotNull(ipv6_static_addr.value)) 
    {					
    	alert(_("v6_static_addr"));
    	ipv6_static_addr.value = ipv6_static_addr.defaultValue;
    	ipv6_static_addr.focus();
    	return false;
    }

       var v6dhcpstart = document.getElementById("v6dhcpstart");
    if (!CheckNotNull(v6dhcpstart.value)) 
    {					
    	alert(_("v6_dhcp_start"));
    	v6dhcpstart.value = v6dhcpstart.defaultValue;
    	v6dhcpstart.focus();
    	return false;
    }

    var v6dhcpend = document.getElementById("v6dhcpend");
    if (!CheckNotNull(v6dhcpend.value)) 
    {					
    	alert(_("v6_dhcp_end"));
    	v6dhcpend.value = v6dhcpend.defaultValue;
    	v6dhcpend.focus();
    	return false;
    }
	
	var ra_interval_max = document.getElementById("max_Interval");
	var ra_interval_min = document.getElementById("min_Interval");

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
    
    return true;
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

function dhcpv6_ip_switch()
{
     var Enable_dhcpv6 = document.getElementById("Enable_dhcpv6");
     
    if(Enable_dhcpv6.checked == true)
    {
        setDisplay("tr_dhcpv6_startip", "");
        setDisplay("tr_dhcpv6_endip", "");
    }
    else
    {
        setDisplay("tr_dhcpv6_startip", "none");
        setDisplay("tr_dhcpv6_endip", "none");
    }

}
</script>

</head>

<body class="mainbody" onLoad="initValue()">

    <form method="post" name="lanCfg" id="lanCfg" action="/goform/setIPv6DhcpCfg" onSubmit="return CheckValue()">

	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tbody>
	      <tr>
	        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
	            <tbody>
	              <tr>
	                <td id="ipv6_dhcp_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
                    <td colspan="2" id="ipv6_addr_title">IPv6 Address</td>
                   </tr>
                <tr>
                    <td class="tabal_left" width="25%" id="ipv6_static_addr_title">IPv6 Static Address</td>
                    <td class="tabal_right"><input name="ipv6_static_addr" id="ipv6_static_addr" maxlength = 43 value="<% getCfgGeneral(1, "ipv6_static_addr"); %>" >
                    <span id="ipv6_static_addr_tips" name="ipv6_static_addr_tips"></span></td>
                 </tr>
		<tr>
			<td height="5px"></td>
		</tr>
	            <tr class="tabal_head">
                    <td colspan="2" id="ipv6_lan_title"> &nbsp IPv6 LAN Address Set</td>
                   </tr>
	            <tr>
                    <td class="tabal_left" width="25%" id="Enable_dhcpv6_title">Enable DHCPv6 Service</td>
                    <td class="tabal_right"><input type="checkbox" name="Enable_dhcpv6" id="Enable_dhcpv6" value="1" onClick="dhcpv6_ip_switch();"></td>
                    </tr>
	  
	            <tr id = "tr_dhcpv6_startip" style="display:none">
                    <td class="tabal_left" width="25%" id="v6dhcpstart_title">Start Interface ID</td>
                    <td class="tabal_right"><input name="v6dhcpstart" id="v6dhcpstart" maxlength=19 value="<% getCfgGeneral(1, "v6dhcpstart"); %>" ></td>
                </tr>
				
	            <tr id = "tr_dhcpv6_endip" style="display:none">
                    <td class="tabal_left" width="25%" id="v6dhcpend_title">End Interface ID</td>
                    <td class="tabal_right"><input name="v6dhcpend" id="v6dhcpend" maxlength=19 value="<% getCfgGeneral(1, "v6dhcpend"); %>" ></td>
                </tr>
	
                <tr>
                   <td class="tabal_left" width="25%" id="Managed_Flag_title">Managed Flag</td>
                   <td class="tabal_right"><input type="checkbox" name="Managed_Flag" id="Managed_Flag" value="1"/></td>
                </tr>
	  
                <tr>
                    <td class="tabal_left" width="25%" id="other_Flag_title">Other Config Flag </td>
                    <td class="tabal_right"><input type="checkbox" name="Other_Flag" id="Other_Flag" value="1"/></td>
                </tr>
                <tr>
			        <td class="tabal_left" width="25%" id="max_Interval_title">Max RA Interval</td>
			        <td class="tabal_right"><input name="max_Interval" id="max_Interval" maxlength=4 value="<% getCfgGeneral(1, "max_Interval"); %>" >
			          <span id="max_Interval_tips" name="max_Interval_tips">Seconds (4-1800)</span></td>
			      </tr>
			      <tr>
			        <td class="tabal_left" width="25%" id="min_Interval_title">Min RA Interval</td>
			        <td class="tabal_right"><input name="min_Interval" id="min_Interval" maxlength=4 value="<% getCfgGeneral(1, "min_Interval"); %>" >
			          <span id="min_Interval_tips" name="max_Interval_tips">Seconds (3-1350)</span></td>
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

