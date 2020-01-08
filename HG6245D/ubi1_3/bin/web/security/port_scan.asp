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
<title>Prevent Port Scanning</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

//get init value from driver
var PortScanSync = '<% PortScanSync(); %>';

function initTranslation()
{
	var e = document.getElementById("pro_PortScan_prompt");
	e.innerHTML = _("pro_PortScan_prompt");
    e = document.getElementById("pro_PortScan_title");
	e.innerHTML = _("pro_PortScan_title");

	e = document.getElementById("pps_enable");
	e.innerHTML = _("pps_enable");
	e = document.getElementById("pps_disable");
	e.innerHTML = _("pps_disable");

	e = document.getElementById("pps_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("pps_cancel");
	e.value = _("firewall_cancel");	
	
}

function initValue()
{
	initTranslation();
	var Pro_PortScanning = document.getElementsByName("Pro_PortScanningEnable");	
	for(var i = 0;i<Pro_PortScanning.length;i++)
	{
		if(Pro_PortScanning[i].value == '<% getCfgGeneral(1, "Pro_PortScanningEnable"); %>')
		{
			Pro_PortScanning[i].checked = true;
			break;
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post name="pro_PortScan_basic" action="/goform/setPortScanEnable">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="pro_PortScan_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="pro_PortScan_title" align="left" width="25%">Anti Port Scan</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="Pro_PortScanningEnable" type="radio">
          <font id="pps_enable">Enable</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="Pro_PortScanningEnable" type="radio">
          <font id="pps_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>

  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="pps_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="pps_cancel" onClick="window.location.reload()">
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
