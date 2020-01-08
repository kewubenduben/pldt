<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>DEBUG LOG</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("log", lang);

//get init value from driver
function initTranslation()
{
	var e = document.getElementById("log_debugPrompt");
	e.innerHTML = _("log_debugPrompt");
	e = document.getElementById("log_debugListHead");
	e.innerHTML = _("log_debugListHead");
}

function initValue()
{
	initTranslation();
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="show_log">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="log_debugPrompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td id="log_debugListHead"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td><textarea rows="20" cols="116" readonly="readonly"><% debug_log_sync(); %>
</textarea></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
