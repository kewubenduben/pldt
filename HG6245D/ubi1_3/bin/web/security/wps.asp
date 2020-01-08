<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta http-equiv="Refresh" content="20">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>WPS</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control();%>';
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wps", lang);

var wps_enable_sync = '<% wps_enable_sync(); %>';
var WPSconnectSync = '<% WPSconnectSync(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

var wps_enable_2g = '<% getCfgZero(1, "wps_enable_2g"); %>';
var wps_enable_5g = '<% getCfgZero(1, "wps_enable_5g"); %>';

function initTranslation()
{
	var e = document.getElementById("wps_prompt");
	e.innerHTML = _("wps_prompt");
	e = document.getElementById("WPS_enable_head");
	e.innerHTML = _("WPS_enable_head");
	e = document.getElementById("wps_enable_title");
	e.innerHTML = _("WPS_enable_head");
	e = document.getElementById("wps_enable_font");
	e.innerHTML = _("wps_enable_title");
	e = document.getElementById("wps_disable_font");
	e.innerHTML = _("wps_disable_title");
	e = document.getElementById("WPS_cfg_head");
	e.innerHTML = _("WPS_cfg_head");
	
    e = document.getElementById("wps_PINtitel");
	e.innerHTML = _("wps_PINtitel");
    e = document.getElementById("wps_statetitle");
	e.innerHTML = _("wps_statetitle");
	e = document.getElementById("wps_PINer");
	e.innerHTML = _("wps_PINer");
	e = document.getElementById("wps_buttontitel");
	e.innerHTML = _("wps_buttontitel");
	e = document.getElementById("wps_PINer1");
	e.innerHTML = _("wps_PINer");
	e = document.getElementById("wps_PIN1_prompt");
	e.innerHTML = _("wps_PIN1_prompt");
	e = document.getElementById("wps_bandSelec_head");
	e.innerHTML = _("wps_bandSelec_head");
	e = document.getElementById("wps_bandSelect_title");
	e.innerHTML = _("wps_bandSelec_head");
	
	e = document.getElementById("wps_apply");
	e.value = _("wps_apply");
	e = document.getElementById("wps_cancel");
	e.value = _("WPSCancel");
	e = document.getElementById("WPSconnect");
	e.value = _("WPSconnect");
	e = document.getElementById("WPSCancel");
	e.value = _("WPSCancel");
}

function checkwpspincode(str)
{
	if (str.length > 0) 
	{
		var re=/^[0-9]{8}$/;	
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
	var pin_code = document.getElementById("wps_PIN");
	var pin_style = document.getElementsByName("wps_style");
	var wps_mode_node = document.getElementById("wps_mode");
	var pin_code1 = document.getElementById("wps_PIN1");

	if((ispNameCode == 17) || (ispNameCode == 18))/*COLUMBIA_TELEBU与COLUMBIA_METRO*/
	{
		if(wps_mode_node.options.selectedIndex == 1)
		{
			if (!CheckNotNull(pin_code1.value)) 
			{					
				//alert(_("Please enter pin code!"));
				alert(_("wps_nopinalert"));
				pin_code1.value = pin_code1.defaultValue;
				pin_code1.focus();
				return false;
			}

			if(!checkwpspincode(pin_code1.value))
			{
				//alert(_("PIN code is illegal!"));
				alert(_("wps_pinillegal"));
				pin_code1.value = pin_code1.defaultValue;
				pin_code1.focus();
				return false;
		    }
		}
	}
	else
	{
		if(pin_style[0].checked == true)
		{
			if (!CheckNotNull(pin_code.value)) 
			{					
				//alert(_("Please enter pin code!"));
				alert(_("wps_nopinalert"));
				pin_code.value = pin_code.defaultValue;
				pin_code.focus();
				return false;
			}

			if(!checkwpspincode(pin_code.value))
			{
				//alert(_("PIN code is illegal!"));
				alert(_("wps_pinillegal"));
				pin_code.value = pin_code.defaultValue;
				pin_code.focus();
				return false;
		    }
		}	
	}
	load_waiting();
	return true;
}

function wpsModeSwitch()
{
	var wps_mode_node = document.getElementById("wps_mode");
	if(wps_mode_node.options.selectedIndex == 1)
	{
		setDisplay("tr_pincode", "");
	}
	else
	{
		setDisplay("tr_pincode", "none");
	}
}

function initValue()
{
	initTranslation();	
	var wpsstate = '<% getCfgZero(1, "wps_state"); %>';
	var wpsstate_input = document.getElementById("wps_state");
	
	var wps_enalbe_node = document.getElementsByName("wpsEnable");
	
	var wpsmode_node = document.getElementById("wps_mode");
	var wps_mode_value = '<% getCfgZero(1, "wps_mode"); %>';
	var wpsstate_input1 = document.getElementById("wps_state1");

	/*add begin by郭心悦，20170103，原因:应宋伟宁要求新增双频wps 2.4G/5G切换*/
	var FH_AUTO_WPS_SWITCH_FLAG = '<% getCfgGeneral(1, "FH_AUTO_WPS_SWITCH_FLAG");%>';
	if(FH_AUTO_WPS_SWITCH_FLAG == '1')
	{
		setDisplay("wps_bandSelec_table", "");
		var wps_wifi_band = '<% getCfgZero(1, "wifi_band"); %>';
		var wps_wifi_band_node = document.getElementsByName("wifi_band");
		showRadioNodeByValue(wps_wifi_band_node, wps_wifi_band);
		
		changeBand(wps_wifi_band);
	}
	else
	{
		showRadioNodeByValue(wps_enalbe_node, wps_enable_2g);
	}

	if((ispNameCode == 17) || (ispNameCode == 18))/*COLUMBIA_TELEBU与COLUMBIA_METRO*/
	{
		setDisplay("tb_wps_cfg1", "none");
		setDisplay("tb_wps_cfg2", "");
		showSelectNodeByValue(wpsmode_node, wps_mode_value);
		 wpsModeSwitch();

		 if (wpsstate == "WPS_START")
			wpsstate_input1.innerHTML = _("Connecting");
		else if (wpsstate == "WPS_TIMEOUT")
			wpsstate_input1.innerHTML = _("Time_Out");
		else if (wpsstate == "WPS_SUCCESS")
			wpsstate_input1.innerHTML = _("connection_Successful");
		else
			wpsstate_input1.innerHTML = _("connection_fail");	
	}
	else if(ispNameCode == 16 ) //viettel
	{
		setDisplay("div_wps_cfg", "none");
	}
	else
	{
	    if (wpsstate == "WPS_START")
			wpsstate_input.innerHTML = _("Connecting");
		else if (wpsstate == "WPS_TIMEOUT")
			wpsstate_input.innerHTML = _("Time_Out");
		else if (wpsstate == "WPS_SUCCESS")
			wpsstate_input.innerHTML = _("connection_Successful");
		else
			wpsstate_input.innerHTML = _("connection_fail");	
	}
}

function changeBand(curBand)
{
	var wps_enalbe_node = document.getElementsByName("wpsEnable");
	if(curBand == 0)//2.4g
	{
		showRadioNodeByValue(wps_enalbe_node, wps_enable_2g);
	}
	else
	{
		showRadioNodeByValue(wps_enalbe_node, wps_enable_5g);
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wps_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
  </tbody>
</table>
<form method= "post" name="wps_enable" action="/goform/set_wps_enable">
  <table id="wps_bandSelec_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wps_bandSelec_head">WPS Band Select</td>
      </tr>
      <tr>
        <td class="tabal_left" id="wps_bandSelect_title" align="left" width="25%">WPS Band Select</td>
        <td class="tabal_right" align="left" width="75%"><input checked="checked" value="0" name="wifi_band" type="radio" onclick="changeBand(this.value)">
          <font id="wps_band2.4g_font">2.4G</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="1" name="wifi_band" type="radio" onclick="changeBand(this.value)">
          <font id="wps_band5g_font">5G</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table id="wps_enable_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="5" id="WPS_enable_head">WPS Enable</td>
      </tr>
      <tr>
        <td class="tabal_left" id="wps_enable_title" align="left" width="25%">WPS Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="wpsEnable" type="radio">
          <font id="wps_enable_font">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="wpsEnable" type="radio">
          <font id="wps_disable_font">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table id="wps_enable_apply_table" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="wps_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="wps_cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<div id="div_wps_cfg">
  <form method="post" name="wps" action="/goform/setWPSconnect" onSubmit="return CheckValue();">
    <table  id="tb_wps_cfg1" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr class="tabal_head">
          <td colspan="5" id="WPS_cfg_head">WPS Configuration</td>
        </tr>
        <tr>
          <td class="tabal_left" width="25%" id="wps_statetitle">WPS State</td>
          <td class="tabal_right" id="wps_state"><% getCfgGeneral(1, "wps_state"); %></td>
        </tr>
        <tr>
          <td class="tabal_right" colspan="6" align="left" ><input checked="checked" value = "pin" name="wps_style" id="wps_style_p"  type="radio">
            <font id="wps_PINtitel">Please input PIN code</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
        </tr>
        <tr>
          <td class="tabal_left" width="6%" id="wps_PINer">PIN Code</td>
          <td class="tabal_right"><input name="wps_PIN" id="wps_PIN" size="15" maxlength="8" type="text"><span class="gray" id="wps_pinTips">&nbsp;&nbsp;(Please enter 8 digits)</span>
          </td>
        </tr>
        <tr>
          <td class="tabal_right" colspan="6" align="left" ><input value = "button" name="wps_style" id="wps_style_b" type="radio">
            <font id="wps_buttontitel">Please turn on the button of the equipment.</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
        </tr>
    </table>
    <table id="tb_wps_cfg2" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
      <tbody>
        <tr class="tabal_head">
          <td colspan="5" id="WPS_cfg_head1">WPS Configuration</td>
        </tr>
        <tr>
          <td class="tabal_left" width="25%" id="wps_statetitle1">WPS State</td>
          <td class="tabal_right" id="wps_state1"><% getCfgGeneral(1, "wps_state"); %></td>
        </tr>
        <tr>
          <td class="tabal_left" width="25%" id="wps_modetitle">WPS Mode</td>
          <td class="tabal_right"><select id="wps_mode" name="wps_mode" size="1" style="width:35%" onChange="wpsModeSwitch();">
              <option value="1" selected="selected">PBC</option>
              <option value="2">PIN Code</option>
            </select>
          </td>
        </tr>
        <tr id="tr_pincode">
          <td class="tabal_left" width="25%" id="wps_PINer1">PIN Code</td>
          <td class="tabal_right"><input name="wps_PIN1" id="wps_PIN1" size="15" maxlength="8" type="text" style="width:35%" value="<% getCfgGeneral(1, "wps_pincode"); %>">
            <span id="wps_PIN1_prompt" class="gray">(You can input number 0-9 (8 characters).)</span></td>
        </tr>
    </table>
    <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_submit" width="25%"></td>
          <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Connect" id="WPSconnect">
            &nbsp; &nbsp;
            <input class="submit" type="reset" value="Cancel" id="WPSCancel" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
