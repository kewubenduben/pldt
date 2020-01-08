<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>LAN STATE</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);


function initTranslation()
{
	var e = document.getElementById("lan_inforPrompt");
	e.innerHTML = _("lan_inforPrompt");
	e = document.getElementById("lan_port_status_title");
	e.innerHTML = _("lan_port_status_title");
	e = document.getElementById("lanport");
	e.innerHTML = _("lanport");
	e = document.getElementById("lanport_admin");
	e.innerHTML = _("lanport_admin");
	e = document.getElementById("lanport_status");
	e.innerHTML = _("lanport_status");
	e = document.getElementById("lanport_mode");
	e.innerHTML = _("lanport_mode");
	e = document.getElementById("lanport_speed");
	e.innerHTML = _("lanport_speed");
}

</script>
</head>
<body class="mainbody" onLoad="initTranslation()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="lan_inforPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="lan_port_status_title">LAN Port Status</td>
              </tr>
              <tr class="tabal_title">
                <td width="8%" align="center" id="lanport">Port</td>
                <td width="23%" align="center" id="lanport_admin">Admin</td>
                <td width="23%" align="center" id="lanport_status">Status</td>
                <td width="23%" align="center" id="lanport_mode">Mode</td>
                <td width="23%" align="center" id="lanport_speed">Speed</td>
              </tr>
              <% lan_port_status_sync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
