<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Routing Table Info</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("log", lang);

//get init value from driver
function initTranslation()
{
}

function initValue()
{
	initTranslation();
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="route_infoPrompt"  class="title_01" style="padding-left: 10px;" width="100%">On this page, you could query the routing table info.</td>
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
  <div style="float: right;">
    <input type="reset" value="Fresh" class="submit" onClick="window.location.reload()">
  </div>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td id="route_infoHead">Routing Table Info</td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td><textarea rows="20" cols="116" readonly="readonly"><% route_info_sync(); %>
</textarea></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
