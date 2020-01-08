<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>DMZ</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>';

var VlanBandSync = '<% vlanband_sync(); %>';

function initTranslation()
{

}

function initValue()
{
	initTranslation();

	var portband_node = document.getElementById("portband");

	if(parseInt(lan_port_num) == 1)
	{
		portband_node.options[portband_node.length] = new Option("lan1", "0");
	}
	if(parseInt(lan_port_num) == 2)
	{
		portband_node.options[portband_node.length] = new Option("lan1", "0");
		portband_node.options[portband_node.length] = new Option("lan2", "1");
	}
	if(parseInt(lan_port_num) == 3)
	{
		portband_node.options[portband_node.length] = new Option("lan1", "0");
		portband_node.options[portband_node.length] = new Option("lan2", "1");
		portband_node.options[portband_node.length] = new Option("lan3", "2");
	}
	if(parseInt(lan_port_num) == 4)
	{
		portband_node.options[portband_node.length] = new Option("lan1", "0");
		portband_node.options[portband_node.length] = new Option("lan2", "1");
		portband_node.options[portband_node.length] = new Option("lan3", "2");
		portband_node.options[portband_node.length] = new Option("lan4", "3");
	}

	if(WifiFlag == 1)
	{
		portband_node.options[portband_node.length] = new Option("ssid1", "4");
		portband_node.options[portband_node.length] = new Option("ssid2", "5");
		portband_node.options[portband_node.length] = new Option("ssid3", "6");
		portband_node.options[portband_node.length] = new Option("ssid4", "7");
	}
	

	var portbandnode  = document.getElementById("portband");
	var lan_portid  = '<% getCfgZero(1, "lan_port"); %>';
	for(var i = 0; i< portbandnode.length; i++)
	{
		if(portbandnode.options[i].value == lan_portid )
		{
			portbandnode.options[i].selected = true;
			break;
		}
	}
	PortIDSwitch();

}

function PortmodeSwitch()
{
	if(document.getElementById("portmode").options.selectedIndex == 1)
    {
		setDisplay("vlanbang_table", "");
	}
	else
	{
		setDisplay("vlanbang_table", "none");
		
	}
}

function PortIDSwitch()
{
	var portid = document.getElementById("portband");
	var portmodenode = document.getElementById("portmode");
	var vlanvalue_node = document.getElementById("vlanbang_value")
	if(portid.value == 0)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "lan1_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "lan1_vlanband"); %>';
	}
	else if(portid.value == 1)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "lan2_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "lan2_vlanband"); %>';
	}
	else if(portid.value == 2)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "lan3_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "lan3_vlanband"); %>';
	}
	else if(portid.value == 3)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "lan4_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "lan4_vlanband"); %>';
	}
	else if(portid.value == 4)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "ssid1_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "ssid1_vlanband"); %>';
	}
	else if(portid.value == 5)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "ssid2_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "ssid2_vlanband"); %>';
	}
	else if(portid.value == 6)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "ssid3_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "ssid3_vlanband"); %>';
	}
	else if(portid.value == 7)
	{
		portmodenode.options.selectedIndex = '<% getCfgZero(1, "ssid4_portmode"); %>';
		vlanvalue_node.value = '<% getCfgZero(1, "ssid4_vlanband"); %>';
	}

	 PortmodeSwitch();
}

function CheckValue()
{	
	var portmodenode = document.getElementById("portmode");
	var vlanvalue_node = document.getElementById("vlanbang_value")

	if(portmodenode.options.selectedIndex == 1)
	{
		if (!CheckNotNull(vlanvalue_node.value)) 
		{
			alert(_("请输入绑定vlan。"));
			vlanvalue_node.value = vlanvalue_node.defaultValue;
			vlanvalue_node.focus();
			return false;
		}
	}

	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="dmz_form" action="/goform/VlanBandCfg" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="portband_prompt" class="title_01" style="padding-left: 10px;" width="100%">在本页面您可以配置VLAN绑定。</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td id="portband_title" class="tabal_left" width="25%">端口</td>
        <td class="tabal_right" width="75%"><select name="portband" id="portband" size="1" style="width:200px;"  onChange="PortIDSwitch();">
          </select>
        </td>
      </tr>
      <tr >
        <td id="wan_portmode_title" class="tabal_left" width="25%">端口模式</td>
        <td class="tabal_right" width="75%"><select name="portmode" id="portmode" size="1" style="width:200px;"  onChange="PortmodeSwitch();">
            <option value="0" id="port_bangtitle" selected="selected" >端口绑定</option>
            <option value="1" id="vlan_bangtitle"  >VLAN绑定</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table id="vlanbang_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr >
        <td width="25%" class="tabal_left" id="vlanbang_title">绑定VLAN</td>
        <td class="tabal_right" width="75%"><input name="vlanbang_value" id="vlanbang_value" size="15"  maxlength=40 style="width: 150px;" type="text" >
          <strong style="color:#FF0033">*</strong><span class="gray" >(eg. 100/101)</span></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="应用" type="submit" id="dmz_apply">
          <input class="submit" name="cancel" onClick="window.location.reload();" value="取消" id="dmz_cancel" type="reset">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
