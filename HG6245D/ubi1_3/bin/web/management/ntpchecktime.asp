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
<title>NCP Check Time</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ntpchecktime", lang);

var ntpCheckTimeSync = '<% ntpCheckTimeSync(); %>';
var wanNameSync = '<% wanNameSync(); %>';

function initTranslation()
{
	var e = document.getElementById("checktime_prompt");
	e.innerHTML = _("checktime_prompt");
	
	e = document.getElementById("ntpchecktime_title");
	e.innerHTML = _("ntpchecktime_title");
	e = document.getElementById("checkboxTips");
	e.innerHTML = _("checkboxTips");
	e = document.getElementById("secondsTips");
	e.innerHTML = _("secondsTips");
	e = document.getElementById("firstNTPServer_Title");
	e.innerHTML = _("firstNTPServer_Title");
	e = document.getElementById("secondNTPServer_Title");
	e.innerHTML = _("secondNTPServer_Title");
	e = document.getElementById("thirdNTPServer_Title");
	e.innerHTML = _("thirdNTPServer_Title");
	e = document.getElementById("fourthNTPServer_Title");
	e.innerHTML = _("fourthNTPServer_Title");
	e = document.getElementById("fifthNTPServer_Title");
	e.innerHTML = _("fifthNTPServer_Title");
	e = document.getElementById("timeZoneTitle");
	e.innerHTML = _("timeZoneTitle");
	e = document.getElementById("GMTm12title");
	e.innerHTML = _("GMTm12title");
	e = document.getElementById("GMTm11title");
	e.innerHTML = _("GMTm11title");
	e = document.getElementById("GMTm10title");
	e.innerHTML = _("GMTm10title");
	e = document.getElementById("GMTm9title");
	e.innerHTML = _("GMTm9title");
	e = document.getElementById("GMTm8title");
	e.innerHTML = _("GMTm8title");
	e = document.getElementById("GMTm7title");
	e.innerHTML = _("GMTm7title");
	e = document.getElementById("GMTm6title");
	e.innerHTML = _("GMTm6title");
	e = document.getElementById("GMTm5title");
	e.innerHTML = _("GMTm5title");
	e = document.getElementById("GMTm4title");
	e.innerHTML = _("GMTm4title");
	e = document.getElementById("GMTm3title");
	e.innerHTML = _("GMTm3title");
	e = document.getElementById("GMTm2title");
	e.innerHTML = _("GMTm2title");
	e = document.getElementById("GMTm1title");
	e.innerHTML = _("GMTm1title");
	e = document.getElementById("GMT0title");
	e.innerHTML = _("GMT0title");
	e = document.getElementById("GMT1title");
	e.innerHTML = _("GMT1title");
	e = document.getElementById("GMT2title");
	e.innerHTML = _("GMT2title");
	e = document.getElementById("GMT3title");
	e.innerHTML = _("GMT3title");
	e = document.getElementById("GMT4title");
	e.innerHTML = _("GMT4title");
	e = document.getElementById("GMT5title");
	e.innerHTML = _("GMT5title");
	e = document.getElementById("GMT6title");
	e.innerHTML = _("GMT6title");
	e = document.getElementById("GMT7title");
	e.innerHTML = _("GMT7title");
	e = document.getElementById("GMT8title");
	e.innerHTML = _("GMT8title");
	e = document.getElementById("GMT9title");
	e.innerHTML = _("GMT9title");
	e = document.getElementById("GMT10title");
	e.innerHTML = _("GMT10title");
	e = document.getElementById("GMT11title");
	e.innerHTML = _("GMT11title");
	e = document.getElementById("GMT12title");
	e.innerHTML = _("GMT12title");
	
	e = document.getElementById("ntpCurTime_Title");
	e.innerHTML = _("ntpCurTime_Title"); 
	e = document.getElementById("ntpWanChannelTitle");
	e.innerHTML = _("ntpWanChannelTitle"); 
	
	e = document.getElementById("ntpsave_apply");
	e.value = _("ntpsave_apply");


}

function getValueByWanname(wanname)
{
	if(wanname.search("OTHER") >= 0)	// OTHER
	{
		return 100;
	}
	else if(wanname.search("TR069_VOIP_INTERNET") >= 0)	// TR069_VOIP_INTERNET
	{
		return 17;
	}
	else if(wanname.search("TR069_VOIP") >= 0)	// TR069_VOIP
	{
		return 16;
	}
	else if(wanname.search("MULTICAST_IPTV") >= 0)	// MULTICAST_IPTV
	{
		return 10;
	}
	else if(wanname.search("UNICAST_IPTV") >= 0)	// UNICAST_IPTV
	{
		return 9;
	}
	else if(wanname.search("RADIUS_INTERNET") >= 0)	// RADIUS_INTERNET
	{
		return 8;
	}
	else if(wanname.search("RADIUS") >= 0)	// RADIUS
	{
		return 7;
	}
	else if(wanname.search("IPTV") >= 0)	// IPTV
	{
		return 6;
	}
	else if(wanname.search("VOIP_INTERNET") >= 0)	// VOIP_INTERNET
	{
		return 5;
	}
	else if(wanname.search("VOIP") >= 0)	// VOIP
	{
		return 4;
	}
	else if(wanname.search("MULTICAST") >= 0)	// MULTICAST
	{
		return 3;
	}
	else if(wanname.search("TR069_INTERNET") >= 0)	// TR069_INTERNET
	{
		return 2;
	}
	else if(wanname.search("INTERNET") >= 0)	// INTERNET
	{
		return 1;
	}
	else if(wanname.search("TR069") >= 0)	// TR069
	{
		return 0;
	}
	
}

function initValue()
{
	initTranslation();
	var autoChecknode = getElement("autoCheck");
	var timezonenode  = getElement("timeZone");

	var ntpWanChannel = getElement("ntpWanChannel");

	var checkbox1 = '<% getCfgGeneral(1, "autoCheck"); %>';
	var timeZone = '<% getCfgGeneral(1, "timeZone"); %>';
	var timeZoneMinute = '<% getCfgGeneral(1, "timeZoneMinute"); %>';
	
	if(ispNameCode == 5)	//HGU X_AIS
	{
		setDisplay("tr_server3", "");
	}
	else if(ispNameCode == 17 || ispNameCode == 18)	//哥伦比亚telebucaramanga/Metrotel
	{
		setDisplay("tr_server3", "");
		setDisplay("tr_server4", "");
	}
	else if(ispNameCode == 16)	//越南HGU
	{
		setDisplay("tr_server3", "");
		setDisplay("tr_server4", "");
		setDisplay("tr_server5", "");
	}
//	else if(ispNameCode == 4)   //TAILAND_3BB 不需要显示WAN连接绑定
//	{
//		setDisplay("tr_bindwan", "none");
//	}
	else if(ispNameCode == 27)   //伊朗
	{
		timezonenode.options[timezonenode.length] = new Option("(GMT+03:30)Iran", "3.5");
		setDisplay('tr_daylightsavingstime_s', '');
		setDisplay('tr_daylightsavingstime_e', '');
	}
	
    if(checkbox1 == 1 )
	{
		autoChecknode.checked = true;
	}
	else
	{
		autoChecknode.checked = false;
	}
	
	if(timeZoneMinute == '30')
	{
		timeZone = parseInt(timeZone) + '.5';
	}
	for(var i = 0; i< timezonenode.length; i++)
	{
		if(timezonenode.options[i].value == timeZone )
		{
			timezonenode.options[i].selected = true;
			break;
		}
	}

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
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';	
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R") >= 0)	// 路由
		{
			ntpWanChannel.options[ntpWanChannel.length] = new Option(wannameTextArray[i], getValueByWanname(wannameArray[i]));
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			ntpWanChannel.options[ntpWanChannel.length] = new Option(wannameTextArray[i], 2);
		}
	}
	
	for(var i = 0; i < ntpWanChannel.length; i++)
	{
		if(ntpWanChannel.options[i].value == '<% getCfgGeneral(1, "ntpWanChannel"); %>' )
		{
			ntpWanChannel.options[i].selected = true;
			break;
		}
	}
	
	/*
	var firstNTPnode  = document.getElementById("firstNTPServer");
	var secondNTPnode  = document.getElementById("secondNTPServer");
	for(var i = 0; i< firstNTPnode.length; i++)
	{
		if(firstNTPnode.options[i].value == '<% getCfgGeneral(1, "firstNTPServer"); %>' )
		{
			firstNTPnode.options[i].selected = true;
			break;
		}
	}
	for(var i = 0; i< secondNTPnode.length; i++)
	{
		if(secondNTPnode.options[i].value == '<% getCfgGeneral(1, "secondNTPServer"); %>' )
		{
			secondNTPnode.options[i].selected = true;
			break;
		}
	}*/
	/*if(firstNTPnode.value == 1)
	{
		document.getElementById("firstNTPText").disabled = 1;
	}
	if(secondNTPnode.value == 1)
	{
		document.getElementById("secondNTPText").disabled = 1;
	}*/

}

function NTP1Switch(index)
{
	if(index == 1)
	{
    	getElement("firstNTPText").disabled = 1;
		getElement("firstNTPText").value = "";
	}
	else
	{
		getElement("firstNTPText").disabled = 0;
	}

}
function NTP2Switch(index)
{
	if(index == 1)
	{
    	getElement("secondNTPText").disabled = 1;
		getElement("secondNTPText").value = "";
	}
	else
	{
		getElement("secondNTPText").disabled = 0;
	}
}

function CheckSwitch()
{
	var autoCheck = getElement("autoCheck");
	
	if(autoCheck == 0)
	{
		getElement("autoCheckPeriod").disabled = 1;
	}
	else
	{
		getElement("autoCheckPeriod").disabled = 0;
	}
}

function CheckValue()
{	
    var fisrt_text = getElement("firstNTPText");
	var second_text = getElement("secondNTPText");
	var CheckPeriod = getElement("autoCheckPeriod");
	//var firstNTPnode  = document.getElementById("firstNTPServer");
	//var secondNTPnode  = document.getElementById("secondNTPServer");
	var checkbox1 = '<% getCfgGeneral(1, "autoCheck"); %>';
	
	if (!CheckNotNull(fisrt_text.value)) 
	{					
		//alert(_("请输入第一NTP校时服务器!"));
		alert(_("ntp_nofirstserveralert"));
		fisrt_text.value = fisrt_text.defaultValue;
		fisrt_text.focus();
		return false;
	}

	if (!CheckNotNull(second_text.value))
	{					
		//alert(_("请输入第二NTP校时服务器!"));
		alert(_("ntp_nosecondserveralert"));
		second_text.value = second_text.defaultValue;
		second_text.focus();
		return false;
	}
	if ((!CheckNotNull(CheckPeriod.value)) && (checkbox1 == 1)) 
	{					
		//alert(_("请输入自动校准周期!"));
		alert(_("ntp_noperiodalert"));
		CheckPeriod.value = CheckPeriod.defaultValue;
		CheckPeriod.focus();
		return false;
	}
	if ((!checktime(CheckPeriod.value)) && (checkbox1 == 1)) 
	{					
		//alert(_("请输入合法自动校准周期!"));
		alert(_("ntp_illegalperiodalert"));
		CheckPeriod.value = CheckPeriod.defaultValue;
		CheckPeriod.focus();
		return false;
	}
	if(ispNameCode == '27')//伊朗IRAN_NET
	{
		if(!checkYearLegal(getElement("start_y")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMonthLegal(getElement("start_m")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkDateLegal(getElement("start_d"), getElement("start_m").value))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkHourLegal(getElement("start_h")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMinLegal(getElement("start_min")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMinLegal(getElement("start_s")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkYearLegal(getElement("end_y")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMonthLegal(getElement("end_m")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkDateLegal(getElement("end_d"), getElement("end_m").value))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkHourLegal(getElement("end_h")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMinLegal(getElement("end_min")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		if(!checkMinLegal(getElement("end_s")))
		{
			alert(_("daylightsavingstimeIllegalAlert"));
			return false;
		}
		
		if(getElement('start_y').value < getElement('end_y').value)
		{
			return true;
		}
		else if(getElement('start_y').value > getElement('end_y').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_y').value = getElement('end_y').defaultValue;
			getElement('end_y').focus();
			return false;
		}
		
		if(getElement('start_m').value < getElement('end_m').value)
		{
			return true;
		}
		else if(getElement('start_m').value > getElement('end_m').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_m').value = getElement('end_m').defaultValue;
			getElement('end_m').focus();
			return false;
		}
		
		if(getElement('start_d').value < getElement('end_d').value)
		{
			return true;
		}
		else if(getElement('start_d').value > getElement('end_d').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_d').value = getElement('end_d').defaultValue;
			getElement('end_d').focus();
			return false;
		}
		
		if(getElement('start_h').value < getElement('end_h').value)
		{
			return true;
		}
		else if(getElement('start_h').value > getElement('end_h').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_h').value = getElement('end_h').defaultValue;
			getElement('end_h').focus();
			return false;
		}
		
		if(getElement('start_min').value < getElement('end_min').value)
		{
			return true;
		}
		else if(getElement('start_min').value > getElement('end_min').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_min').value = getElement('end_min').defaultValue;
			getElement('end_min').focus();
			return false;
		}
		
		if(getElement('start_s').value < getElement('end_s').value)
		{
			return true;
		}
		else if(getElement('start_s').value > getElement('end_s').value)
		{
			alert(_("daylightsavingstimeIllegalAlert"));			
			getElement('end_s').value = getElement('end_s').defaultValue;
			getElement('end_s').focus();
			return false;
		}
	}
	return true;
}

function checktime(str)
{
		if (str.length > 0) 
	{
		var re=/^[0-9]{1,5}$/;	
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

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="checktime_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="checktime_form" action="/goform/setntpCheckTime" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_head" id="ntpchecktime_title" >NTP Check Time</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_right" width="25%" ><input type="checkbox" name="autoCheck" id="autoCheck" checked="CheckSwitch();" value="1">
          <span class="tabal_right" id="checkboxTips">Enable NTP Check Time</span></td>
        <td class="tabal_right" width="75%"><input type="text" name="autoCheckPeriod" id="autoCheckPeriod" maxlength="5" size="5" value="<% getCfgGeneral(1, 'autoCheckPeriod'); %>">
          <span id="secondsTips">seconds (1-99999)</span></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_right" width="25%" id="firstNTPServer_Title">First NTP Server</td>
        <td class="tabal_right" width="75%" colspan="2"><input name="firstNTPText" size="25" maxlength="64" type="text" value="<% getCfgGeneral(1, 'firstNTPText'); %>"></td>
      </tr>
      <tr>
        <td class="tabal_right" width="25%" id="secondNTPServer_Title">Sencond NTP Server</td>
        <td class="tabal_right" width="75%" colspan="2"><input name="secondNTPText" size="25" maxlength="64" type="text" value="<% getCfgGeneral(1, 'secondNTPText'); %>"></td>
      </tr>
      <tr id="tr_server3" style="display: none">
        <td class="tabal_right" width="25%" id="thirdNTPServer_Title">Third NTP Server</td>
        <td class="tabal_right" width="75%" colspan="2"><input name="thirdNTPText" size="25" maxlength="64" type="text" value="<% getCfgGeneral(1, 'thirdNTPText'); %>"></td>
      </tr>
      <tr id="tr_server4" style="display: none">
        <td class="tabal_right" width="25%" id="fourthNTPServer_Title">Fourth NTP Server</td>
        <td class="tabal_right" width="75%" colspan="2"><input name="fourthNTPText" size="25" maxlength="64" type="text" value="<% getCfgGeneral(1, 'fourthNTPText'); %>"></td>
      </tr>
      <tr id="tr_server5" style="display: none">
        <td class="tabal_right" width="25%" id="fifthNTPServer_Title">Fifth NTP Server</td>
        <td class="tabal_right" width="75%" colspan="2"><input name="fifthNTPText" size="25" maxlength="64" type="text" value="<% getCfgGeneral(1, 'fifthNTPText'); %>"></td>
      </tr>
      <tr>
        <td class="tabal_right" id="timeZoneTitle">Time Zone</td>
        <td class="tabal_right" colspan="2"><select id="timeZone" name="timeZone" size="1" style="width:60%" >
            <option value="-12" id="GMTm12title">GMT-12 </option>
            <option value="-11" id="GMTm11title">GMT-11 </option>
            <option value="-10" id="GMTm10title">GMT-10 </option>
            <option value="-9" id="GMTm9title">GMT-9 </option>
            <option value="-8" id="GMTm8title">GMT-8 </option>
            <option value="-7" id="GMTm7title">GMT-7 </option>
            <option value="-6" id="GMTm6title">GMT-6 </option>
            <option value="-5" id="GMTm5title">GMT-5 </option>
            <option value="-4" id="GMTm4title">GMT-4 </option>
            <option value="-3" id="GMTm3title">GMT-3</option>
            <option value="-2" id="GMTm2title">GMT-2 </option>
            <option value="-1" id="GMTm1title">GMT-1 </option>
            <option value="0" id="GMT0title">GMT </option>
            <option value="1" id="GMT1title">GMT+1 </option>
            <option value="2" id="GMT2title">GMT+2 </option>
            <option value="3" id="GMT3title">GMT+3 </option>
            <option value="4" id="GMT4title">GMT+4 </option>
            <option value="5" id="GMT5title">GMT+5 </option>
            <option value="6" id="GMT6title">GMT+6 </option>
            <option value="7" id="GMT7title">GMT+7 </option>
            <option value="8" id="GMT8title" selected="selected">GMT+8 </option>
            <option value="9" id="GMT9title">GMT+9</option>
            <option value="10" id="GMT10title">GMT+10 </option>
            <option value="11" id="GMT11title">GMT+11 </option>
            <option value="12" id="GMT12title">GMT+12 </option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_right" width="25%" id="ntpCurTime_Title">Current Time</td>
        <td class="tabal_right" width="75%" colspan="2"><% getCfgGeneral(1, "ntpCurTime"); %></td>
      </tr>
      <tr id="tr_bindwan">
        <td class="tabal_right" id="ntpWanChannelTitle">Binding WAN connections</td>
        <td class="tabal_right" colspan="2"><select id="ntpWanChannel" name="ntpWanChannel" size="1" style="width:60%" >
            <!--option value="0" selected="selected">INTERNET</option>
            <option value="1">VOIP</option>
            <option value="2">TR069</option>
            <option value="3">OTHER</option>
            <option value="4">TR069_INTERNET</option>
            <option value="5">VOIP_INTERNET</option>
            <option value="6">TR069_VOIP</option>
            <option value="7">TR069_VOIP_INTERNET</option-->
          </select>
        </td>
      </tr>
      <tr id="tr_daylightsavingstime_s" style="display: none">
        <td class="tabal_right" width="25%" id="daylightsavingstime_Title" rowspan="2">Daylight Savings Time<span class="gray" id="dstTips"><br/>
          (such as 2017-08-01T13:50:00)</span></td>
        <td class="tabal_right" width="10%">Start Time</td>
        <td class="tabal_right"><input name="start_y" size="1" maxlength="4" type="text" value="<% getCfgGeneral(1, 'start_y'); %>">
          -
          <input name="start_m" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'start_m'); %>">
          -
          <input name="start_d" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'start_d'); %>">
          T
          <input name="start_h" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'start_h'); %>">
          :
          <input name="start_min" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'start_min'); %>">
          :
          <input name="start_s" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'start_s'); %>">
        </td>
      </tr>
      <tr id="tr_daylightsavingstime_e" style="display: none">
        <td class="tabal_right">End Time</td>
        <td class="tabal_right"><input name="end_y" size="1" maxlength="4" type="text" value="<% getCfgGeneral(1, 'end_y'); %>">
          -
          <input name="end_m" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'end_m'); %>">
          -
          <input name="end_d" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'end_d'); %>">
          T
          <input name="end_h" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'end_h'); %>">
          :
          <input name="end_min" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'end_min'); %>">
          :
          <input name="end_s" size="1" maxlength="2" type="text" value="<% getCfgGeneral(1, 'end_s'); %>"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="Check Time" type="submit" id="ntpsave_apply">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<!--form method="post" name="checktime_form1" action="/goform/setntpCheckTime">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
  <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="cancel"  value="系统校时" id="ntp_cancel" type="submit">
        </td>
  </tr>
</tbody>
</table>
</form-->
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
