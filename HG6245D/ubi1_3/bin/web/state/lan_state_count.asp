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
	e = document.getElementById("lan_infor_title");
	e.innerHTML = _("lan_infor_title");
	e = document.getElementById("lanport");
	e.innerHTML = _("lanport");
	e = document.getElementById("lanport_mode");
	e.innerHTML = _("lanport_mode");
	e = document.getElementById("lanport_speed");
	e.innerHTML = _("lanport_speed");
	e = document.getElementById("lanport_link");
	e.innerHTML = _("lanport_link");
	e = document.getElementById("lanport_tb");
	e.innerHTML = _("lanport_tb");
	e = document.getElementById("lanport_tp");
	e.innerHTML = _("lanport_tp");
	e = document.getElementById("lanport_rb");
	e.innerHTML = _("lanport_rb");
	e = document.getElementById("lanport_rp");
	e.innerHTML = _("lanport_rp");
	e = document.getElementById("lanport_errorFrames");
	e.innerHTML = _("lanport_errorFrames");	
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
                <td colspan="5" id="lan_infor_title">LAN Information</td>
              </tr>
              <tr class="tabal_title">
                <td width="5%" align="center" id="lanport">Port</td>
                <td width="7%" align="center" id="lanport_mode">Mode</td>
                <td width="7%" align="center" id="lanport_speed">Speed</td>
                <td width="7%" align="center" id="lanport_link">Link</td>
                <td width="15%" align="center" id="lanport_tb">Transmit Bytes</td>
                <td width="15%" align="center" id="lanport_tp">Transmit Packets</td>
                <td width="15%" align="center" id="lanport_rb">Receive Bytes </td>
                <td width="15%" align="center" id="lanport_rp">Receive Packets </td>
                <td width="14%" align="center" id="lanport_errorFrames">Error Frames</td>
              </tr>
              <% LanCountSync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
