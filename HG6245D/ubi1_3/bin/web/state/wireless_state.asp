<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Refresh" content="20">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Wireless State</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';
var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num");%>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

var setWirelessstateSync = '<% setWirelessstateSync(); %>';
var wifimode  = '<% getCfgZero(1, "WirelessMode"); %>';
var channelvalue  = '<% getCfgZero(1, "Channel"); %>';
var radiovalue = '<% getCfgGeneral(1, "RadioOff"); %>';
var ssid1_enable = '<% getCfgGeneral(1, "SSIDEnable1"); %>';
var ssid2_enable = '<% getCfgGeneral(1, "SSIDEnable2"); %>';
var ssid3_enable = '<% getCfgGeneral(1, "SSIDEnable3"); %>';
var ssid4_enable = '<% getCfgGeneral(1, "SSIDEnable4"); %>';

function SSID_EnableGet(ssid_enable)
{	
	var ssid_state;
	if(ssid_enable == "enable")
	{
		ssid_state = _("Enable")
	}
	else
	{
		ssid_state = _("Disable")
	}

	return ssid_state
}

function radiostatename(radiovalue)
{
	var radiostate;
	switch(parseInt(radiovalue))
	{
		case 0:
			radiostate = _("radio off");
			break;
		case 1:
			radiostate = _("radio on");
			break;
		default:
			break;
	}
		return radiostate;
}

function wirelessModename(wifimode)
{    
	var wfmode;
	switch(parseInt(wifimode))
	{
		case 0:
			wfmode = "802.11 b";
		    break;
		case 1:
			wfmode = "802.11 g";	
            break;
        case 2:
			wfmode = "802.11 b/g";
			break;
	    case 3:
		 	wfmode = "802.11 n";
            break;
		case 4:
		 	wfmode = "802.11 b/g/n";
            break;
	    default:					
			break;
	}
	 return wfmode;
			
}

function ChannelName(channelvalue)
{
    var channelmoden;
	switch(parseInt(channelvalue))
	{
		case 0:
			channelmoden = _("AutoSelect");
		    break;
		case 1:
			channelmoden = _("channel") + " 1";	
            break;
        case 2:
			channelmoden = _("channel") + " 2";
			break;
	    case 3:
		 	channelmoden = _("channel") + " 3";
            break;
		case 4:
			channelmoden = _("channel") + " 4";
		    break;
		case 5:
			channelmoden = _("channel") + " 5";
            break;
        case 6:
			channelmoden = _("channel") + " 6";
			break;
	    case 7:
			channelmoden = _("channel") + " 7";
            break;
		case 8:
			channelmoden = _("channel") + " 8";
		    break;
		case 9:
			channelmoden = _("channel") + " 9";
            break;
        case 10:
			channelmoden = _("channel") + " 10";
			break;
	    case 11:
			channelmoden = _("channel") + " 11";
            break;
		case 12:
			channelmoden = _("channel") + " 12";
		    break;
		case 13:
			channelmoden = _("channel") + " 13";
            break;
        case 14:
			channelmoden = _("channel") + " 14";
			break;
	    default:	
			channelmoden = _("channel") + " 15";
			break;
		}
	 return channelmoden;
			
}

function initTranslation()
{
	var e = document.getElementById("wireState");
	e.innerHTML = _("WirelessState");
	e = document.getElementById("wifistate_prompt");
	e.innerHTML = _("wifistate_prompt");
	e = document.getElementById("basicRadioButton");
	e.innerHTML = _("basicRadioButton");
	e = document.getElementById("basicNetMode");
	e.innerHTML = _("basicNetMode");
	e = document.getElementById("basicFreqA");
	e.innerHTML = _("basicFreqA");
	e = document.getElementById("basicSSID1_title");
	e.innerHTML = _("basicSSID1_title");
	e = document.getElementById("basicSSID2_title");
	e.innerHTML = _("basicSSID2_title");
	e = document.getElementById("basicSSID3_title");
	e.innerHTML = _("basicSSID3_title");
	e = document.getElementById("basicSSID4_title");
	e.innerHTML = _("basicSSID4_title");

	e = document.getElementById("wireStateStatic");
	e.innerHTML = _("wireStateStatic");
	e = document.getElementById("rpc_title");
	e.innerHTML = _("rpc_title");	
	e = document.getElementById("rbc_title");
	e.innerHTML = _("rbc_title");
	e = document.getElementById("rmc_title");
	e.innerHTML = _("rmc_title");
		e = document.getElementById("rdc_title");
	e.innerHTML = _("rdc_title");
	e = document.getElementById("rpc_title");
	e.innerHTML = _("rpc_title");	
	e = document.getElementById("rbc_title");
	e.innerHTML = _("rbc_title");
	e = document.getElementById("spc_title");
	e.innerHTML = _("spc_title");
		e = document.getElementById("sbc_title");
	e.innerHTML = _("sbc_title");
	e = document.getElementById("smc_title");
	e.innerHTML = _("smc_title");	
	e = document.getElementById("sdc_title");
	e.innerHTML = _("sdc_title");
	
    e = document.getElementById("wirelessmode");
	e.innerHTML = wirelessModename(wifimode);
	e = document.getElementById("sz11aChannel");
	e.innerHTML  = ChannelName(channelvalue);
	e = document.getElementById("radioButton");
	e.innerHTML  = radiostatename(radiovalue);

	e = document.getElementById("ssidName1_enable");
	e.innerHTML  = SSID_EnableGet(ssid1_enable);
	e = document.getElementById("ssidName2_enable");
	e.innerHTML  = SSID_EnableGet(ssid2_enable);
	e = document.getElementById("ssidName3_enable");
	e.innerHTML  = SSID_EnableGet(ssid3_enable);
	e = document.getElementById("ssidName4_enable");
	e.innerHTML  = SSID_EnableGet(ssid4_enable);

}

function initValue()
{
	initTranslation();
	
	if(ispMinorNameCode == 303)		/* X_CU_ANHUI */
	{
		setDisplay("tr_ssid3", "none");
		setDisplay("tr_ssid4", "none");
	}

	if((ispNameCode == 9 || ispNameCode == 22) && curUserType == 1)		/* 罗马尼亚/泰国TRUE普通用户 */
	{
		setDisplay("tr_ssid2", "none");
		setDisplay("tr_ssid3", "none");
		setDisplay("tr_ssid4", "none");
	}
    wirelessModename(wifimode);
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="lanstate" id="lanstate">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="wifistate_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td colspan="2" id="wireState">Wireless State</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="basicRadioButton">Radio On/Off</td>
        <td class="tabal_right" name="radioButton" id="radioButton"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="basicNetMode">Network Mode</td>
        <td class="tabal_right"name="wirelessmode" id="wirelessmode"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%"><font id="basicFreqA">Frequency (Channel)</font></td>
        <td class="tabal_right" id="sz11aChannel" name="sz11aChannel"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="basicSSID1_title">SSID1 Name</td>
        <td class="tabal_right"width="40%"name="ssidName1" id="ssidName1" size=20 ><% getCfgGeneral(1, "ssidName1"); %></td>
		<!--td class="tabal_right"width="20%"name="ssidName1_mac" id="ssidName1_mac" ><% getCfgGeneral(1, "ssidmac1"); %></td-->
        <td class="tabal_right"name="ssidName1_enable" id="ssidName1_enable" size=20 ></td>
      </tr>
      <tr id="tr_ssid2">
        <td class="tabal_left" width="25%" id="basicSSID2_title">SSID2 Name</td>
        <td class="tabal_right"width="40%"name="ssidName2" id="ssidName2" size=20 ><% getCfgGeneral(1, "ssidName2"); %></td>
		<!--td class="tabal_right"width="20%"name="ssidName2_mac" id="ssidName2_mac" ><% getCfgGeneral(1, "ssidmac2"); %></td-->
        <td class="tabal_right"name="ssidName2_enable" id="ssidName2_enable" size=20 ></td>
      </tr>
      <tr id="tr_ssid3">
        <td class="tabal_left" width="25%" id="basicSSID3_title">SSID3 Name</td>
        <td class="tabal_right"width="40%"name="ssidName3" id="ssidName3" size=20 ><% getCfgGeneral(1, "ssidName3"); %></td>
		<!--td class="tabal_right"width="20%"name="ssidName3_mac" id="ssidName3_mac" ><% getCfgGeneral(1, "ssidmac3"); %></td-->
        <td class="tabal_right"name="ssidName3_enable" id="ssidName3_enable" size=20 ></td>
      </tr>
      <tr id="tr_ssid4">
        <td class="tabal_left" width="25%" id="basicSSID4_title">SSID4 Name</td>
        <td class="tabal_right"width="40%"name="ssidName4" id="ssidName4" size=20 ><% getCfgGeneral(1, "ssidName4"); %></td>
		<!--td class="tabal_right"width="20%"name="ssidName4_mac" id="ssidName4_mac" ><% getCfgGeneral(1, "ssidmac4"); %></td-->
        <td class="tabal_right"name="ssidName4_enable" id="ssidName4_enable" size=20 ></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wireStateStatic">Wireless packets Count</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="rpc_title">Received Packets Count</td>
        <td class="tabal_right"name="stream_rpc" id="stream_rpc" size=20 ><% getCfgGeneral(1, "rpc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="rbc_title">Received Bytes Count</td>
        <td class="tabal_right"name="stream_rbc" id="stream_rbc" size=20 ><% getCfgGeneral(1, "rbc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="rmc_title">Error Received Packets Count</td>
        <td class="tabal_right"name="stream_rmc" id="stream_rmc" size=20 ><% getCfgGeneral(1, "rmc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="rdc_title">Loss Received Packets Count</td>
        <td class="tabal_right"name="stream_rdc" id="stream_rdc" size=20 ><% getCfgGeneral(1, "rdc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="spc_title">Sent Packets Count</td>
        <td class="tabal_right"name="stream_spc" id="stream_spc" size=20 ><% getCfgGeneral(1, "spc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="sbc_title">Sent Bytes Count</td>
        <td class="tabal_right"name="stream_sbc" id="stream_sbc" size=20 ><% getCfgGeneral(1, "sbc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="smc_title">Error Sent Packets Count</td>
        <td class="tabal_right"name="stream_smc" id="stream_smc" size=20 ><% getCfgGeneral(1, "smc"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="sdc_title">Loss Sent Packets Count</td>
        <td class="tabal_right"name="stream" id="stream" size=20 ><% getCfgGeneral(1, "sdc"); %></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</form>
</body>
</html>
