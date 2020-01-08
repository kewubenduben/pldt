<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>WifiPowerControl</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

Butterlate.setTextDomain("wireless", lang);

//get init value from driver
var wifiPowerCtrlSync = '<% wifiPowerCtrlSyncEx(); %>';
var WifiConNumSync = '<% WifiConNumSyncEx(); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("wifipower_prompt");
	e.innerHTML = _("wifipower_prompt");
	e = document.getElementById("wifi_power_title");
	e.innerHTML = _("wifi_power_title");
	e = document.getElementById("RecommendTips");
	if(ispNameCode == '4')			/* TAILAND_3BB_CODE */
	{
		e.innerHTML = _("Recommend_120Tips");//recommend 120%
	}
	else
	{
		e.innerHTML = _("RecommendTips");	//recommend 100%
	}
	
	e = document.getElementById("wifi_conNumTitle");
	e.innerHTML = _("wifi_conNumTitle");
	
	e = document.getElementById("wifiPower_apply");
	e.value = _("wifiPower_apply");
	e = document.getElementById("wifiPower_cancel");
	e.value = _("wifiPower_cancel");
	e = document.getElementById("wificonnum_apply");
	e.value = _("wifiPower_apply");
	e = document.getElementById("wificonnum_cancel");
	e.value = _("wifiPower_cancel");
	
}

function CheckValue(type)
{
	if(type == 'power')
	{
		load_waiting();
		return true;
	}
	
	var ssid1_num = document.getElementById("ssid1_num");
	var ssid2_num = document.getElementById("ssid2_num");
	var ssid3_num = document.getElementById("ssid3_num");
	var ssid4_num = document.getElementById("ssid4_num");

	if(!CheckNotNull(ssid1_num.value)) 
	{					
		alert(_("Please enter conection number!"));
		ssid1_num.value = ssid1_num.defaultValue;
		ssid1_num.focus();
		return false;
	}
	else if(!fw_checkNmbLegal(ssid1_num))
	{
		return false;
	}
	if (!CheckNotNull(ssid2_num.value)) 
	{					
		alert(_("Please enter conection number!"));
		ssid2_num.value = ssid2_num.defaultValue;
		ssid2_num.focus();
		return false;
	}
	else if(!fw_checkNmbLegal(ssid2_num))
	{
		return false;
	}
	if (!CheckNotNull(ssid3_num.value)) 
	{					
		alert(_("Please enter conection number!"));
		ssid3_num.value = ssid3_num.defaultValue;
		ssid3_num.focus();
		return false;
	}
	else if(!fw_checkNmbLegal(ssid3_num))
	{
		return false;
	}
	if (!CheckNotNull(ssid4_num.value)) 
	{					
		alert(_("Please enter conection number!"));
		ssid4_num.value = ssid4_num.defaultValue;
		ssid4_num.focus();
		return false;
	}
	else if(!fw_checkNmbLegal(ssid4_num))
	{
		return false;
	}

	load_waiting();
	return true;
}

function fw_checkNmbLegal(dom)
{
	var exp = /^\d+$/;
	dom.value = parseInt(dom.value);
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 32)
		{
			return true;
		}
		else
		{
			alert(_("pf_connetnumberIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("pf_connetnumberIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function initValue()
{
	initTranslation();
	
	var wifiPower = '<% getCfgGeneral(1, "wifiPower"); %>';
	var wifiPower_node  = document.getElementById("wifiPower");
	for(var i = 0; i< wifiPower_node.length; i++)
	{
		if(wifiPower_node.options[i].value == wifiPower )
		{
			wifiPower_node.options[i].selected = true;
			break;
		}
	}
	if(ispNameCode == '26')	//add by wuxj, 20180103, for TIM
	{
		wifiPower_node.options.remove(9);//200
		wifiPower_node.options.remove(8);//180
		wifiPower_node.options.remove(7);//160
		wifiPower_node.options.remove(6);//140
		wifiPower_node.options.remove(5);//120
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post name="wifi_power" action="/goform/setWifiPowerEx" onSubmit="return CheckValue('power')">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="wifipower_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="wifi_power_title" align="left" width="25%">WIFI Power Control</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><select name="wifiPower" id="wifiPower" size="1">
            <option value=20> 20% </option>
            <option value=40> 40% </option>
            <option value=60> 60% </option>
            <option value=80> 80% </option>
            <option value=100 selected="selected"> 100% </option>
            <option value=120> 120% </option>
            <option value=140> 140% </option>
            <option value=160> 160% </option>
            <option value=180> 180% </option>
            <option value=200> 200% </option>
          </select>
          &nbsp; &nbsp; &nbsp;<span class="gray" id="RecommendTips"></span> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="wifiPower_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="wifiPower_cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method=post name="wifi_power" action="/goform/setWifiConNumEx" onSubmit="return CheckValue('connum')">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table id="ssidstanum_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="wifi_conNumTitle">Number of WIFI Connections</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" >SSID1</td>
        <td class="tabal_right"><input name="ssid1_num" id="ssid1_num" size="32" maxlength="5" type="text" value="<% getCfgGeneral(1, "ssid1_num"); %>">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" >SSID2</td>
        <td class="tabal_right"><input name="ssid2_num" id="ssid2_num" size="32" maxlength="5" type="text" value="<% getCfgGeneral(1, "ssid2_num"); %>">
        </td>
      </tr>
      <tr id="tr_ssid3">
        <td class="tabal_left" width="25%" >SSID3</td>
        <td class="tabal_right"><input name="ssid3_num" id="ssid3_num" size="32" maxlength="5" type="text" value="<% getCfgGeneral(1, "ssid3_num"); %>">
        </td>
      </tr>
      <tr id="tr_ssid4">
        <td class="tabal_left" width="25%" >SSID4</td>
        <td class="tabal_right"><input name="ssid4_num" id="ssid4_num" size="32" maxlength="5" type="text" value="<% getCfgGeneral(1, "ssid4_num"); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="wificonnum_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="wificonnum_cancel" onClick="window.location.reload()">
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
