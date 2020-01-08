<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>UPnP</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("upnp", lang);

//get init value from driver
var upnpBasicSync = '<% setUPNPEnableSync(); %>';
var wan_name_flag = 0; /*由于wan连接的配置更新的时候，实际的操作时先删除wan连接，再新建wan连接，但是upnp的配置是不能删除的。
wan name变化的时候，由于我们配置文件的wan name已经和web页面可选的wan name不一致，
可以让web不显示wan name并且将状态修改为关闭状态。*/

var multiRouteWanFlag = '<% getCfgGeneral(1, "WEB_MULTI_ROUTE_WAN"); %>';

function initTranslation()
{
	var e = document.getElementById("upnp_prompt");
	e.innerHTML = _("upnp_prompt");

	e = document.getElementById("upnp_enable");
	e.innerHTML = _("upnp_enable");
	e = document.getElementById("upnp_disable");
	e.innerHTML = _("upnp_disable");

	e = document.getElementById("upnpEnableApply");
	e.value = _("upnpEnableApply");
	e = document.getElementById("upnpEnableCancel");
	e.value = _("upnpEnableCancel");
	e = document.getElementById("upnpcfg_remove");
	e.value = _("upnpcfg_remove");
    e = document.getElementById("upnp_wan_title");
	e.innerHTML = _("upnp_wan_title");
    
}

function UpnpRemoveConfirm()
{
	document.location = "/goform/upnpDele" + "?csrftoken=" + getCsrftoken();
}

function initValue()
{
    initTranslation();
    var upnpEnable = document.getElementsByName("upnpEnable");	
    for(var i = 0;i<upnpEnable.length;i++)
    {
        if(upnpEnable[i].value == '<% getCfgGeneral(1, "upnpEnable"); %>')
        {
            upnpEnable[i].checked = true;
            break;
        }
    }

    var wanNameSync = '<% wanNameSync(); %>';
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
	
    var upnp_wan = document.getElementById("upnp_wan");
    var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
    for( i = 0; i < wan_size; i++ )
    {
        if((wannameArray[i].search("NET_R") ) > 0)/* internet route wan*/
        {
            upnp_wan.options[upnp_wan.length] = new Option(wannameTextArray[i], wannameArray[i]);
        }
    }

    var upnp_wan_name = '<% getCfgGeneral(1, "upnp_wan"); %>';
    for(i = 0; i < upnp_wan.length;i++)
    {
        if (upnp_wan.options[i].value == upnp_wan_name)
        {
            upnp_wan.options[i].selected = true;
            wan_name_flag = 1;
            break;
        }
        else
        {
             wan_name_flag = 0;
        }
    }
    
    if (multiRouteWanFlag == '1')	//modify by wuxj, 20180330,修改为多路由WAN宏控
    {
        upnp_switch();
        
        if(wan_name_flag == 0)
        {
            upnpEnable[1].checked = true;
        }
        
        setDisplay("upnp_band_wan", "");
    }
    if(ispNameCode == 28)	//墨西哥TOTALPLAY
    {
        setDisplay("tb_upnpInfo", "");
    }
}

function upnp_switch()
{
    var upnpEnable = document.getElementsByName("upnpEnable");	
    if(upnpEnable[0].checked == true )
    {
        document.getElementById("upnp_wan").disabled = 0;
    }
    if(upnpEnable[1].checked == true )
    {
        document.getElementById("upnp_wan").disabled = 1;
    }  
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="upnp_enable_form" action="/goform/setUPNPEnable">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="upnp_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
      <tr>
        <td class="tabal_left" id="upnpEnable_title" align="left" width="18%">UPnP</td>
        <td class="tabal_right" colspan="6" align="left" width="82%"><input checked="checked" value="enable" name="upnpEnable" type="radio" onClick = "upnp_switch();">
          <font id="upnp_enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="upnpEnable" type="radio" onClick = "upnp_switch();">
          <font id="upnp_disable"></font></td>
      </tr>
      <tr id="upnp_band_wan" style="display: none">
        <td class="tabal_left"  id="upnp_wan_title"> WAN Name</td>
        <td class="tabal_right" ><select id="upnp_wan" name="upnp_wan" size="1" style="width:40%" >
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="upnpEnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="upnpEnableCancel" onClick="window.location.reload();">
        </td>
        </td>
        <td class="tabal_submit" align="left"><input class="submit" id="upnpcfg_remove" value="Remove configuration" type="button" onClick="UpnpRemoveConfirm()">
        </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_upnpInfo" style="display: none" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_title">
        <td width="4%" align="center" id="Id">No.</td>
        <td width="21%" align="center" id="IP">IP Address</td>
        <td width="15%" align="center" id="The_external_Port">External Port</td>
        <td width="15%" align="center" id="The_internal_Port">Internal Port</td>
        <td width="10%" align="center" id="Protocol">Protocol</td>
        <td width="25%" align="center" id="Description">Description</td>
        <td width="10%" align="center" id="Status">Status</td>
      </tr>
      <% upnpInfoSync(); %>
    </tbody>
  </table>   
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
