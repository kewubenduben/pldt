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
<title>LOG</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("log", lang);

//get init value from driver
function initTranslation()
{
	var e = getElement("logcfg_prompt");
	e.innerHTML = _("logcfg_prompt");
    e = getElement("log_title");
	e.innerHTML = _("log_title");
	e = getElement("logEnableTitle");
	e.innerHTML = _("logEnableTitle");
	e = getElement("logDisableTitle");
	e.innerHTML = _("logDisableTitle");
	
	e = getElement("logLevelTitle");
	e.innerHTML = _("logLevelTitle");
	
	e = getElement("log_apply");
	e.value = _("log_apply");
	e = getElement("log_cancel");
	e.value = _("log_cancel");
}

function initValue()
{
	initTranslation();

	var logLevel = '<% getCfgZero(1, "logLevel"); %>';
	var logLevelNode = getElement("logLevel");
	showSelectNodeByValue(logLevelNode, logLevel);
	
	var logEnable = '<% getCfgZero(1, "logEnable"); %>';
	var logEnableNode = getElement("logEnable");
	showRadioNodeByValue(logEnableNode, logEnable);
	onClickSwitch(logEnable);
}

function onClickSwitch(switchValue)
{
	if(switchValue == 0)	//disable
	{
		getElement("logLevel").disabled = 1;
	}
	else
	{
		getElement("logLevel").disabled = 0;
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="log_cfg" action="/goform/logCfg">
  <table border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="logcfg_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="log_title" align="left" width="20%">LOG</td>
        <td class="tabal_right" align="left" width="80%"><input name="logEnable" value="0" onclick="onClickSwitch(this.value)" type="radio">
          <font id="logDisableTitle"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input name="logEnable" value="1" checked="checked" onclick="onClickSwitch(this.value)" type="radio">
          <font id="logEnableTitle"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
      </tr>
      <tr>
        <td class="tabal_left" id="logLevelTitle">Log Level</td>
        <td class="tabal_right"><select id="logLevel" name="logLevel" size="1" style="width:20%">
            <option value="0">FATAL</option>
            <option value="1">ERROR</option>
            <option value="2">WARN</option>
            <option value="3" selected="selected">INFO</option>
            <option value="4">DEBUG</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" width="100%">
    <tbody>
      <tr>
        <td width="20%"></td>
        <td class="tabal_submit"><input type="submit" name="log_apply" id="log_apply" class="submit" value="Apply">
          <input type="reset" name="log_cancel" id="log_cancel" class="submit" onClick="window.location.reload()" value="Cancel">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
