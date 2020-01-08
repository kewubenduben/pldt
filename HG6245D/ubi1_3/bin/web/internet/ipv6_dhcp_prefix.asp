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
    var e = document.getElementById("ipv6_prefix_prompt");
    e.innerHTML = _("ipv6_prefix_prompt"); 
    e = document.getElementById("ipv6_prefix_title");
    e.innerHTML = _("ipv6_prefix_title");
    e = document.getElementById("Prefix_Mode_title");
    e.innerHTML = _("Prefix_Mode_title");
    e = document.getElementById("prefix_net_title");
    e.innerHTML = _("v6_net_title");
    e = document.getElementById("prefix_static_title");
    e.innerHTML = _("v6_static_title");
    e = document.getElementById("Prefix_Set_title");
    e.innerHTML = _("Prefix_Set_title");
    e = document.getElementById("dhcpv6_apply");
    e.value = _("inet apply");
    e = document.getElementById("dhcpv6_cancel");
    e.value = _("inet cancel");
}
function initValue()
{
    var Prefix_Mode = '<% getCfgGeneral(1, "prefix_mode"); %>';
    var Prefix_Mode_id = document.getElementById("Prefix_Mode");

    for(var i = 0; i< Prefix_Mode_id.length; i++)
    {
    	if(Prefix_Mode_id.options[i].value == Prefix_Mode )
    	{
    		Prefix_Mode_id.options[i].selected = true;
    		break;
    	}
    }

    PrefixModeSwitch();
    initTranslation();
}
function CheckValue()
{
    var ra_Prefix_Set = document.getElementById("Prefix_Set");

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
    return true;
}


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

</script>

</head>

<body class="mainbody" onLoad="initValue()">

    <form method="post" name="lanCfg" id="lanCfg" action="/goform/setIPv6Prefix" onSubmit="return CheckValue()">

	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tbody>
	      <tr>
	        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
	            <tbody>
	              <tr>
	                <td id="ipv6_prefix_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
                    <td colspan="2" id="ipv6_prefix_title">&nbsp Prefix Mode Setting</td>
                </tr>
                
                <tr>
                    <td class="tabal_left" width="25%" id="Prefix_Mode_title">Prefix Mode</td>
                    <td class="tabal_right">
                        <select name="Prefix_Mode" id="Prefix_Mode" size="1" onChange="PrefixModeSwitch();">
                            <option value="0" id="prefix_net_title">Network Connection</option>
                            <option value="1" id="prefix_static_title">Static</option>
                        </select>
                    </td>
                </tr>
                
                <tr id="v6_prefixSet" style="display: none">
                    <td class="tabal_left" width="25%" id="Prefix_Set_title">Prefix Set</td>
                    <td class="tabal_right"><input name="Prefix_Set" id="Prefix_Set" maxlength=128 value="<% getCfgGeneral(1, "Prefix_Set"); %>"/></td>
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
