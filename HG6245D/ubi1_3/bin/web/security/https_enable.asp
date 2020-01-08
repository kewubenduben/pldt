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
<title>Https Enable</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
var token = <%  get_random_str(); %>;
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("remote_control", lang);

//get init value from driver
var RemoteControlSync = '<% HttpsEnableSync(); %>';

function initTranslation()
{
    var e = document.getElementById("https_prompt");
	e.innerHTML = _("https_prompt");

	e = document.getElementById("rc_enable");
	e.innerHTML = _("rc_enable");
	e = document.getElementById("rc_disable");
	e.innerHTML = _("rc_disable");

	e = document.getElementById("recontrolApply");
	e.value = _("recontrolApply");
	e = document.getElementById("recontrolCancel");
	e.value = _("recontrolCancel");

}
function initValue()
{
	initTranslation();
    var HttpsEnable = document.getElementsByName("https_check");	
	var https_enalbe_value = '<% getCfgGeneral(1, "https_enable"); %>';

	if(ispNameCode == 9) //罗马尼亚版本要求HHTPS使能状态永远为Enable
	{
		setDisplay("https_disable", "none");
		setDisplay("rc_disable", "none");
		setDisplay("ta_http_submit", "none");
		HttpsEnable[0].checked = true;
	}
	else
	{
	
		for(var i = 0;i<HttpsEnable.length;i++)
		{
			if(HttpsEnable[i].value == https_enalbe_value)
			{
				HttpsEnable[i].checked = true;
				break;
			}
		}
	}
}
function ChangeConfirm()
{	
    alert(_("Change_confirm"));	
	return true;
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">

<form method="post" name="rc_enableform" action="/goform/setHttpsEnable" onSubmit="return ChangeConfirm()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="https_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" id="https_title" align="left" width="25%">HTTPS</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="https_check" type="radio">
          <font id="rc_enable">Enable</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="https_check" type="radio" id="https_disable">
          <font id="rc_disable">Disable</font></td>
      </tr>
      </tbody>
  </table>
  <table id="ta_http_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="recontrolApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="recontrolCancel" onClick="window.location.reload()">
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