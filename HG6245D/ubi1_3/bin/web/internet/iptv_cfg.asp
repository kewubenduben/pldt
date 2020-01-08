<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<title>IPTV Config</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("iptv", lang);

var iptvCfgSync = '<% iptvCfgSync(); %>';

/*-----------------------adapte funcion--------------------------*/
function initTranslation()
{
	var e = document.getElementById("iptv_prompt");
	e.innerHTML = _("iptv_prompt");
	e = document.getElementById("iptv_infoHead");
	e.innerHTML = _("iptv_infoHead");
	e = document.getElementById("iptv_vlanTitle");
	e.innerHTML = _("iptv_vlanTitle");
	e = document.getElementById("iptv_vlanTips");
	e.innerHTML = _("iptv_vlanTips");
	
	e = document.getElementById("iptv_apply");
	e.value = _("iptv_apply");
	e = document.getElementById("iptv_cancel");
	e.value = _("iptv_cancel");
}

function LoadFrame()
{
	initTranslation();
}

function checkValue()
{
	var multicastVlanNode = document.getElementById("iptv_multicastVlan");
	if(multicastVlanNode.value == -1 || (1 <= multicastVlanNode.value && multicastVlanNode.value <= 4094))
	{
		return true;
	}
	else
	{
		alert(_("iptv_vlanIllegalAlert"));
		multicastVlanNode.value = multicastVlanNode.defaultValue;
		multicastVlanNode.focus();
		return false;
	}
}

</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<form method="post" action="/goform/iptvCfg" onSubmit="return checkValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="iptv_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_head" id="iptv_infoHead"></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_iptvCfg" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="iptv_vlanTitle" width="25%"></td>
        <td class="tabal_right" width="75%"><input name="iptv_multicastVlan" id="iptv_multicastVlan" size="15" maxlength="64" type="text" value="<% getCfgGeneral(1, "iptv_multicastVlan"); %>">
          <strong style="color:#FF0033">*</strong> <span class="gray" id="iptv_vlanTips"></span></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="iptv_apply" id="iptv_apply" value="Apply" type="submit">
          <input class="submit" onclick="window.location.reload();" name="iptv_cancel" id="iptv_cancel" value="Cancel" type="reset">
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
