<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Refresh" content="60">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Voip Call History</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("callhistoryprompt");
	e.innerHTML = _("callhistoryprompt");
	var e = document.getElementById("voip_dateTitle");
	e.innerHTML = _("voip_dateTitle");
	var e = document.getElementById("voip_timeTitle");
	e.innerHTML = _("voip_timeTitle");
	var e = document.getElementById("voip_outnumberTitle");
	e.innerHTML = _("voip_outnumberTitle");
	var e = document.getElementById("voip_directionTitle");
	e.innerHTML = _("voip_directionTitle");
	var e = document.getElementById("voip_localnumberTitle");
	e.innerHTML = _("voip_localnumberTitle");
	var e = document.getElementById("voip_durationTitle");
	e.innerHTML = _("voip_durationTitle");
	var e = document.getElementById("voip_callhistoryHead");
	e.innerHTML = _("voip_callhistoryHead");
}

function LoadFrame()
{
	initTranslation();
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
              <td style="padding-left: 10px;" class="title_01" id="callhistoryprompt" width="100%"></td>
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
    <tr class="tabal_head">
      <td colspan="7" id="voip_callhistoryHead">VoIP Call History</td>
    </tr>
    <tr class="tabal_title">
      <td width="18%"id="voip_dateTitle">Date</td>
      <td width="16%"id="voip_timeTitle">Time</td>
      <td width="19%"id="voip_outnumberTitle">Out Number</td>
      <td width="12%"id="voip_directionTitle">Direction</td>
      <td width="19%"id="voip_localnumberTitle">Local Number</td>
      <td width="16%"id="voip_durationTitle">Duration</td>
    </tr>
    <% voip_call_history_sync(); %>
  </tbody>
</table>
</body>
</html>
