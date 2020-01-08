<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<!--meta http-equiv="Refresh" content="20"-->
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>WIFI Neighboring AP Information</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);
var size = '<% wifi_ap_info_sync(); %>';

var  checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;

function initTranslation()
{
	var e = document.getElementById("wifi_apPrompt");
	e.innerHTML = _("wifi_apPrompt");
	
	e = document.getElementById("wifi_apHead");
	e.innerHTML = _("wifi_apHead");
}

function initValue()
{	
//	initTranslation();

	if(parseInt(size) < 0)
	{
		getElement("wifi_getRstPrompt").innerHTML = _("wifi_getRstPrompt");
		setDisplay("wifi_getRstPrompt", "");
	}
	else
	{
		getElement("wifi_getRstPrompt").innerHTML = "";
		setDisplay("wifi_getRstPrompt", "none");
	}
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
              <td id="wifi_apPrompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can query the neighboring AP information may disconnect all STA connections.</td>
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
      <td colspan="5" id="wifi_apHead">Neighboring AP Information</td>
    </tr>
    <tr class="tabal_title">
      <td width="10%">SSID Name</td>
      <td width="10%">MAC Address</td>
      <!--td width="9%">Network Type</td-->
      <td width="8%">Channel</td>
      <td width="10%">Signal Strength (dBm)</td>
      <td width="10%">Noise (dBm)</td>
      <td width="10%">DTIM Interval</td>
      <td width="10%">Beacon Period (ms)</td>
      <td width="10%">Authentication Mode</td>
      <td width="10%">Working Mode</td>
      <td width="10%">Max. Rate (Mbit/s)</td>
    </tr>
    <% get_wifi_ap_info(); %>
  </tbody>
</table>
<br>
<strong style="color:#FF0033"><span id="wifi_getRstPrompt"></span></strong>
</td>
</tr>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
