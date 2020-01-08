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

var setWirelessstateSync = '<% setWirelessstateSyncEx(); %>';
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
		case 5:
		 	wfmode = "802.11 a";
            break;
		case 6:
		 	wfmode = "802.11 an";
            break;
		case 7:
		 	wfmode = "802.11 ac";
            break;
	    default:
			break;
	}
	 return wfmode;
			
}

function ChannelName(channelvalue)
{
    var channelmoden;
	if(parseInt(channelvalue) == 0)
	{
		channelmoden = _("AutoSelect");
	}
	else
	{
		channelmoden = _("channel") + " " + parseInt(channelvalue);	
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
        <td class="tabal_right"name="ssidName1" id="ssidName1" size=20 ><% getCfgGeneral(1, "ssidName1"); %></td>
        <td class="tabal_right"name="ssidName1_enable" id="ssidName1_enable" size=20 ></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="basicSSID2_title">SSID2 Name</td>
        <td class="tabal_right"name="ssidName2" id="ssidName2" size=20 ><% getCfgGeneral(1, "ssidName2"); %></td>
        <td class="tabal_right"name="ssidName2_enable" id="ssidName2_enable" size=20 ></td>
      </tr>
      <tr id="tr_ssid3">
        <td class="tabal_left" width="25%" id="basicSSID3_title">SSID3 Name</td>
        <td class="tabal_right"name="ssidName3" id="ssidName3" size=20 ><% getCfgGeneral(1, "ssidName3"); %></td>
        <td class="tabal_right"name="ssidName3_enable" id="ssidName3_enable" size=20 ></td>
      </tr>
      <tr id="tr_ssid4">
        <td class="tabal_left" width="25%" id="basicSSID4_title">SSID4 Name</td>
        <td class="tabal_right"name="ssidName4" id="ssidName4" size=20 ><% getCfgGeneral(1, "ssidName4"); %></td>
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
