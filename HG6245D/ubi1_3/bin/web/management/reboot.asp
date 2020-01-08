<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<title>Reboot</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("restore", lang);

function initTranslation()
{
	var e = document.getElementById("reboot_Prompt");
	e.innerHTML = _("reboot_Prompt");
	
	e = document.getElementById("reboot_apply");
	e.value = _("reboot_apply");
}

//loadpage
function LoadFrame()
{ 
	initTranslation();
}
/*-----------------------adapte funcion--------------------------*/
function rebootConfirm()
{
//	return confirm("重启设备需要若干时间，WEB网管会自动断开，请稍候重新登录!\n确定要重启设备吗?");	
	if(confirm(_("reboot_confirm")))
//		document.location = "/goform/reboot";
//		parent.location="/goform/reboot";
		makeRequest("/goform/reboot", "n/a", rebootHandler);
}
function rebootHandler(http_request)
{
	var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
	var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
	if (http_request.readyState == 4)									//the operation is completed
	{
		setDisplay("div_button", "none");
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var errorCode = http_request.responseText;
			if(errorCode == "0")
			{
				getElement("div_rebootingHead").innerHTML = _("div_rebootingHead");
				getElement("div_info").innerHTML = _("rebooting");
				waitToLogin(ispName, curUserType);
			}
		 }  
		else													// if request status is different then 200  
		{
			getElement("div_info").innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}

</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="reboot_Prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<div>
  <div id="div_button">
    <input class="submit" id="reboot_apply" style="width: 98px;" value="Reboot" type="button" onClick="rebootConfirm()">
  </div>
  <div id="div_rebootingHead" class="div_rebootingHead"></div>
  <br>
  <div id="div_info"></div>
</div>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
