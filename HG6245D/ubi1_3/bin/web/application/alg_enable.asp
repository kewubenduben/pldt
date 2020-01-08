<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>ALG ENABLE</title>
<script language="JavaScript" type="text/javascript">
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var alg_enable_sync = '<% alg_enable_sync(); %>';

function initTranslation()
{
	var e = document.getElementById("alg_prompt");
	e.innerHTML = _("alg_prompt");

	e = document.getElementById("alg_head");
	e.innerHTML = _("alg_head");
	e = document.getElementById("enable");
	e.innerHTML = _("inet enable");
	e = document.getElementById("disable");
	e.innerHTML = _("inet disable");
	
	e = document.getElementById("apply");
	e.value = _("inet apply");
	e = document.getElementById("cancel");
	e.value = _("inet cancel");
}

function initValue()
{
	initTranslation();
	var sip_alg = document.getElementsByName("sip_alg");
	showRadioNodeByValue(sip_alg, '<% getCfgGeneral(1, "sip_alg"); %>');
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post action="/goform/set_alg_enable">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="alg_prompt" class="title_01" style="padding-left: 10px;" width="100%">You could configure ALG on this page. </td>
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
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="alg_head"></td>
      </tr>
      <tr>
        <td class="tabal_left" align="left" width="25%">SIP ALG</td>
        <td class="tabal_right" align="left" width="75%"><input checked="checked" value="1" name="sip_alg" type="radio">
          <font id="enable">enable</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="sip_alg" type="radio">
          <font id="disable">disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="cancel" onClick="window.location.reload()">
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