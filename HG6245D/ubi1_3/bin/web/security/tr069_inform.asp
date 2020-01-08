<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>TR069 Settings</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var  tr069BasicSync = '<% tr069BasicSync(  ) ;%>'

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("tr069", lang);
var tr069Inform_infor = '<% getCfgZero("1", "tr069Inform_infor");%>';


function initTranslation()
{
	var e = document.getElementById("tr069_inform_prompt");
	e.innerHTML = _("tr069_inform_prompt");
	
	e = document.getElementById("tr069ManualTriggerInform_title");
	e.innerHTML = _("tr069ManualTriggerInform_title");
	e = document.getElementById("ManualTriggerInform");
	e.value = _("ManualTriggerInform");	
}
function initValue()
{
	initTranslation();

	if ( tr069Inform_infor == '1')
		{
			document.getElementById("inform_infor").innerHTML = _("NoWan_alert");    
		}
		else if ( tr069Inform_infor == '5')
		{
			document.getElementById("inform_infor").innerHTML = _("NoIP_alert");  
		}
		else if ( tr069Inform_infor == '6')
		{
			document.getElementById("inform_infor").innerHTML = _("Timeout_alert"); 
		}
		else if ( tr069Inform_infor == '10')
		{
			document.getElementById("inform_infor").innerHTML = _("InformSuccess_infor") + "<% getCfgGeneral(1, "informTime"); %>";
		}
		else
		{
			document.getElementById("inform_infor").innerHTML = "";
		}

}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="tr069_inform_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/setTR069ManualTriggerInform">
  <table cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="tr069ManualTriggerInform_title" align="left" width="25%">TR069 Manual Inform</td>
        <td class="tabal_right" colspan="6" align="left" width="25%"><input class="submit" name="ManualTriggerInform" id="ManualTriggerInform" style="width: 98px;" value="Inform" type="submit">
        <td align="left" id="inform_infor" style="color:#FF0000"></td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
