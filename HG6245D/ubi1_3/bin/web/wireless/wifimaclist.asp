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
<title>WIFI MAC List</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);
var size = '<% wifiMacListSync(); %>';

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>
/*  加入用户是否LOGIN的检查end*/
function initTranslation()
{
	var e = document.getElementById("wifi_macListPrompt");
	e.innerHTML = _("wifi_macListPrompt");
	
	e = document.getElementById("wifi_macListHead");
	e.innerHTML = _("wifi_macListHead");
}

function initValue()
{
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	if(ispNameCode == '9')	// 罗马尼亚 
	{
		getElement('td_id').width = '3%';
		getElement('td_ssid').width = '18%';
		getElement('td_mac').width = '15%';
		getElement('td_ip').width = '15%';

		setDisplay('td_conn_time', "");
		setDisplay('td_tx', "");
		setDisplay('td_rx', "");
		setDisplay('td_signal', "");
	}
	
	initTranslation();

	if(parseInt(size) < 0)
	{
		getElement("wifi_getRstPrompt").innerHTML = _("wifi_getRstPrompt");
		setDisplay("wifi_getRstPrompt", "");
	}
	else if(parseInt(size) == 0)
	{
		setDisplay("wifi_getRstPrompt", "none");
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
<form method="post" name="wifiMacList" id="wifiMacList">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="wifi_macListPrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td colspan="5" id="wifi_macListHead">WIFI Clients List</td>
      </tr>
      <tr class="tabal_title">
        <td id="td_id" width="10%">ID</td>
        <td id="td_ssid" width="30%">SSID</td>
        <td id="td_mac" width="30%">MAC</td>
        <td id="td_ip" width="30%">IP ADD</td>
        <td id="td_conn_time" width="11%" style="display:none">Register Time (s)</td>
        <td id="td_tx" width="12%" style="display:none">TX Rate (Mbit/s)</td>
        <td id="td_rx" width="13%" style="display:none">RX Rate (Mbit/s)</td>
        <td id="td_signal" width="13%" style="display:none">Receive Signal (dBm)</td>
      </tr>
      <% getWifiMac_IPListParam(); %>
    </tbody>
  </table>
  <br>
  <strong style="color:#FF0033"><span id="wifi_getRstPrompt"></span></strong>
</form>
</td>
</tr>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>