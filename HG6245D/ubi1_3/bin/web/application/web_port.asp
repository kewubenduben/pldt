<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script language="JavaScript" src="../js/checkValue.js"></script>
<title>Reboot</title>
<script language="JavaScript" type="text/javascript">
var checkResult = '<% cu_web_access_control(  );%>';
web_access_check(checkResult);
var token = <%  get_random_str(); %>;
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("web_port", lang);

var webPortSync = '<% webPortSync(); %>';

function initTranslation()
{
	var e = document.getElementById("webport_Prompt");
	e.innerHTML = _("webport_Prompt");

	e = document.getElementById("web_portTitle");
	e.innerHTML = _("web_portTitle");
	e = document.getElementById("web_portchangeTitle");
	e.innerHTML = _("web_portchangeTitle");
	e = document.getElementById("web_portchangeTips");
	e.innerHTML = _("web_portchangeTips");
	
	e = document.getElementById("webport_apply");
	e.value = _("webport_apply");
	e = document.getElementById("webport_cancel");
	e.value = _("webport_cancel");
}

function LoadFrame()
{ 
	initTranslation();
}

/*-----------------------adapte funcion--------------------------*/
function ChangeConfirm()
{
//	return confirm("修改端口号后，需重启后生效。");	

	var portvalue = document.getElementById("web_port_change");
	if (portvalue.value == "")
	{
		//	alert("端口不能为空!");
			alert(_("web_PortNullAlert"));
			portvalue.value = portvalue.defaultValue;
			portvalue.focus();
			return false;
	}
	else
	{
		if(!checkWebPortLegal(portvalue))
		{	
			alert(_("web_portIllegalAlert"));
			return false;
		}
	}
	
    alert(_("Change_confirm"));	
	return true;
}

</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<form method="post" name="ddns_form" action="/goform/webPortCfg" onSubmit="return ChangeConfirm()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
		<tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="webport_Prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
		</tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr>
        <td></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="35%" id="web_portTitle">WEB Valid Communication Port</td>
        <td class="tabal_right" width="65%"><input name="web_port" readonly = "readonly" id="web_port" size="10" maxlength="5" type="text" value="<% getCfgGeneral(1, 'web_port_1'); %>">
        </td>
      </tr>
        <tr>
        <td class="tabal_left" width="35%" id="web_portchangeTitle">WEB Communication Port You Modified</td>
        <td class="tabal_right" width="65%"><input name="web_port_change" id="web_port_change" size="10" maxlength="5" type="text" value="<% getCfgGeneral(1, 'web_port_change'); %>">
          <strong style="color:#FF0033">*</strong><span class="gray" id="web_portchangeTips">(Please input 1024-65535 or 80)</span></td>
      </tr>
      </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="Apply" type="submit" id="webport_apply">
          <input class="submit" name="cancel" onclick="window.location.reload();" value="Cancel" id="webport_cancel" type="reset">
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

