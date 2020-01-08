<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>VPN Enable</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("vpn_enable", lang);

//get init value from driver
var vpnBasicSync = '<% setMonitorCollectorSync(); %>';

function initTranslation()
{
    var e;
	/*
	e = document.getElementById("monitor_prompt");
	e.innerHTML = _("monitor_prompt");
	e = document.getElementById("monitor_title");
	e.innerHTML = _("monitor_title");
	*/

	e = document.getElementById("monitor_enable");
	e.innerHTML = _("VPN_enable");
	e = document.getElementById("monitor_disable");
	e.innerHTML = _("VPN_disable");

	e = document.getElementById("monitorApply");
	e.value = _("VPN basic apply");
	e = document.getElementById("monitorCancel");
	e.value = _("VPN basic cancel");
}

function initValue()
{
	initTranslation();
	var MonitorCollector = document.getElementsByName("MonitorCollector");	
	for(var i = 0;i<MonitorCollector.length;i++)
	{
		if(MonitorCollector[i].value == '<% getCfgGeneral(1, "MonitorCollector"); %>')
		{
			MonitorCollector[i].checked = true;
			break;
		}
	}
	MonitorCollector[0].disabled = 1;
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_monitor_enable" action="/goform/setMonitorCollector">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="monitor_prompt"  class="title_01" style="padding-left: 10px;" width="100%">在本页面上，您可以配置预检预修使能。</td>
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
      <tr>
        <td class="tabal_left" id="monitor_title" align="left" width="25%">预检预修开关</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="MonitorCollector" type="radio">
          <font id="monitor_enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="MonitorCollector" type="radio">
          <font id="monitor_disable"></font></td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="monitorApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="monitorCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
