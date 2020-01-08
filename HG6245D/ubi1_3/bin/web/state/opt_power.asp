<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>光功率信息</title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
Butterlate.setTextDomain("state", lang);

var opt_powerSync = '<% opt_powerSync(); %>';

function initTranslation()
{
	var e = document.getElementById("optpower_prompt");
	e.innerHTML = _("optpower_prompt");

	e = document.getElementById("out_power_title");
	e.innerHTML = _("out_power_title");
	e = document.getElementById("in_power_title");
	e.innerHTML = _("in_power_title");
	e = document.getElementById("temp_title");
	e.innerHTML = _("temp_title");
	e = document.getElementById("voltage_title");
	e.innerHTML = _("voltage_title");
	e = document.getElementById("bais_title");
	e.innerHTML = _("bais_title");
		e = document.getElementById("powe_Inf");
	e.innerHTML = _("powe_Inf");
}

function initValue()
{
	initTranslation();

	if(ispName == 16)
	{
		var onu_outpower = '<% getCfgGeneral(1, "onu_outpower");%>';
		var onu_inpower = '<% getCfgGeneral(1, "onu_inpower");%>';
		if(onu_outpower == 'N/A')
		{
			document.getElementById("unit_span_dBm").style.display = "none";
		}
		if(onu_inpower == 'N/A')
		{
			document.getElementById("unit_span_dBm2").style.display = "none";
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="optpower_inf" id="optpower_inf">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="optpower_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
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
        <td colspan="2" id="powe_Inf">Optical Info</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="out_power_title">Transmitted Power</td>
        <td class="tabal_right"><% getCfgGeneral(1, "onu_outpower"); %>
          <span id="unit_span_dBm"> dBm</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="in_power_title">Received Power</td>
        <td class="tabal_right"><% getCfgGeneral(1, "onu_inpower"); %>
          <span id="unit_span_dBm2"> dBm</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="temp_title">Operating Temperature</td>
        <td class="tabal_right"><% getCfgGeneral(1, "onu_tempereture"); %>
          <span> ℃</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="voltage_title">Supply Voltage</td>
        <td class="tabal_right"><% getCfgGeneral(1, "onu_voltage"); %>
          <span> V</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="bais_title">Bais Current</td>
        <td class="tabal_right"><% getCfgGeneral(1, "onu_electric"); %>
          <span> mA</span></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>