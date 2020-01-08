<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>CATV Config</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("dmz", lang);
var RF_powerOffsetSync = '<% RF_powerOffsetSync(); %>';

function initTranslation()
{
	var e = document.getElementById("rf_prompt");
	e.innerHTML = _("rf_prompt");

	e = document.getElementById("rf_hostTips");
	e.innerHTML = _("rf_hostTips");

	e = document.getElementById("dmz_apply");
	e.value = _("dmz_apply");
	e = document.getElementById("dmz_cancel");
	e.value = _("dmz_cancel");
	e = document.getElementById("reset_rf");
	e.value = _("reset_rf");	
}

function initValue()
{
	initTranslation();
}

function rfRsetConfirm()
{
	document.location = "/goform/rfRset" + "?csrftoken=" + getCsrftoken();
}

function CheckValue()
{	
	var revpower_value_node = document.getElementById("revpower_value");
   if(revpower_value_node.value != "")
	   {
	   if(!RFPower(revpower_value_node))
	   {
			return false;
	   }
   }

	return true;
}

function RFPower(dom)
{
	var exp = /^-?\d+$/;
	if(exp.test(dom.value))
	{
		if(-127 <= parseInt(dom.value) && parseInt(dom.value) <= +127)
		{
			return true;
		}
		else
		{
			alert(_("rf_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("rf_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="rf_form" action="/goform/addRF_power" onSubmit="return CheckValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="rf_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
    </tbody>
  </table>
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="rf_hostTips">RF Power Adjustment Range</td>
        <td class="tabal_right" width="75%"><input name="revpower_value" id="revpower_value" size="10" type="text" value="<% getCfgGeneral(1, "rf_offset"); %>">
			<span class="gray">[-127, 127]</span></td>
      </tr> 
      </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="Apply" type="submit" id="dmz_apply">
          <input class="submit" name="cancel" onClick="window.location.reload();" value="Cancel" id="dmz_cancel" type="reset">
        </td>
         <td class="tabal_submit" align="left"><input class="submit" id="reset_rf"  value="Reset" type="button" onClick="rfRsetConfirm()">
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