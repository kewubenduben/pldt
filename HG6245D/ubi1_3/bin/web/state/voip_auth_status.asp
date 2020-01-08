<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>VoIP Status</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>';
var voipStatusSync = '<% voipStatusSync(); %>';
var voip_regStatus_1 = '<% getCfgGeneral(1, "voip_regStatus_1"); %>';
var voip_regStatus_2 = '<% getCfgGeneral(1, "voip_regStatus_2"); %>';

function initTranslation()
{
	var e = document.getElementById("voipstateprompt");
	e.innerHTML = _("voipstateprompt");
	e = document.getElementById("NOtitle");
	e.innerHTML = _("NOtitle");
	e = document.getElementById("statetitle");
	e.innerHTML = _("statetitle");
	e = document.getElementById("phoneNOtitle");
	e.innerHTML = _("phoneNOtitle");

	e = document.getElementById("voip_state");
	e.innerHTML = displayVoipStatus(voip_regStatus_1);
	e = document.getElementById("voip_state2");
	e.innerHTML = displayVoipStatus(voip_regStatus_2);
}

function displayVoipStatus(regStatus)
{
	switch(parseInt(regStatus))
	{
		case 0:
			return _("INACTIVE");
			break;
		case 1:
			return _("REGING");
			break;
		case 2:
			return _("IDLE");
			break;
		case 3:
			return _("OFF_HOOK");
			break;
		case 4:
			return _("DIALING");
			break;
		case 5:
			return _("RING");
			break;
		case 6:
			return _("RINGBACK");
			break;
		case 7:
			return _("CONNECTING");
			break;
		case 8:
			return _("CONNECTED");
			break;
		case 9:
			return _("ON_HOOK");
			break;
		case 10:
			return _("DISCONNECTING");
			break;
		case 11:
			return _("BUSY");
			break;
		case 12:
			return _("REG_FAIL");
			break;
		case 13:
			return _("LINE_FAIL");
			break;
		default :
			return "";
			break;		
	}
}

function LoadFrame()
{
	initTranslation();
	
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	if(ispNameCode == '15')	//GLOBE
	{
		getElement("statetitle").width = "20%";
		getElement("phoneNOtitle").width = "20%";
		setDisplay("codeTitle", "");
		setDisplay("reasonTitle", "");
		setDisplay("code1", "");
		setDisplay("reason1", "");
		setDisplay("code2", "");
		setDisplay("reason2", "");
	}
	if(voip_port_num == 2)
	{
		setDisplay("div_voipPort2", "");
	}
}
</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td style="padding-left: 10px;" class="title_01" id="voipstateprompt" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" height="5" width="100%">
  <tbody>
    <tr class="tabal_title">
      <td width="10%" id="NOtitle">Index</td>
      <td width="40%" id="statetitle">Port State</td>
      <td width="50%" id="phoneNOtitle">Telephone Number</td>
      <td width="20%" id="codeTitle" style="display: none">Result Code</td>
      <td width="30%" id="reasonTitle" style="display: none">Fail Reason</td>
    </tr>
    <tr class='tabal_01'>
      <td id="voip_NO" align="center">1</td>
      <td id="voip_state" align="center"></td>
      <td id="phone_number" align="center"><% getCfgGeneral(1, "voip_telNum_1"); %></td>
      <td id="code1" align="center" style="display: none"><% getCfgGeneral(1, "voip_code_1"); %></td>
      <td id="reason1" align="center" style="display: none"><% getCfgGeneral(1, "voip_reason_1"); %>
      </td>
    </tr>
    <tr class='tabal_01' id="div_voipPort2" style="display: none">
      <td id="voip_NO2" align="center">2</td>
      <td id="voip_state2" align="center"></td>
      <td id="phone_number2" align="center"><% getCfgGeneral(1, "voip_telNum_2"); %></td>
      <td id="code2" align="center" style="display: none"><% getCfgGeneral(1, "voip_code_2"); %></td>
      <td id="reason2" align="center" style="display: none"><% getCfgGeneral(1, "voip_reason_2"); %>
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>
