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
<title>PON INFO</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

function initTranslation()
{
	var e = document.getElementById("pon_countPrompt");
	e.innerHTML = _("pon_countPrompt");
	e = document.getElementById("pon_infoHead");
	e.innerHTML = _("pon_infoHead");
	
	e = document.getElementById("portTitle");
	e.innerHTML = _("lanport");
	e = document.getElementById("port_tbTitle");
	e.innerHTML = _("lanport_tb");
	e = document.getElementById("port_tpTitle");
	e.innerHTML = _("lanport_tp");
	e = document.getElementById("port_rbTitle");
	e.innerHTML = _("lanport_rb");
	e = document.getElementById("port_rpTitle");
	e.innerHTML = _("lanport_rp");
	e = document.getElementById("port_errorFramesTitle");
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
              <td id="pon_countPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td colspan="5" id="pon_infoHead">PON Information</td>
    </tr>
    <tr class="tabal_title">
      <td width="5%" align="center" id="portTitle">Port</td>
      <td width="19%" align="center" id="port_tbTitle">Transmit Bytes</td>
      <td width="19%" align="center" id="port_tpTitle">Transmit Packets</td>
      <td width="19%" align="center" id="port_rbTitle">Receive Bytes </td>
      <td width="19%" align="center" id="port_rpTitle">Receive Packets </td>
      <td width="19%" align="center" id="port_errorFramesTitle">Error Frames</td>
    </tr>
    <% pon_count_sync(); %>
  </tbody>
</table>
</body>
