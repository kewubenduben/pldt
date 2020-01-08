<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<title>Admin Restore</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("restore", lang);//设置本页面读取的配置文件名

//loadpage
function LoadFrame()
{ 
	initTranslation();	
}

/*-----------------------adapte funcion--------------------------*/
function RestoreConfirm()
{
	if(confirm(_("restore_confirm")))
	{
//		parent.location="/goform/adminRestore";
		makeRequest("/goform/adminRestore", "n/a", restoreHandler);
	}
}
function restoreHandler(http_request)
{
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
				getElement("div_info").innerHTML = _("restoreSuccessInfo") + _("rebooting");
				waitToLogin(ispNameCode, curUserType);
			}
			else
			{
				getElement("div_rebootingHead").innerHTML = _("div_rebootingHead");
				getElement("div_info").innerHTML = _("restoreFailedInfo") + _("rebooting");
				waitToLogin(ispNameCode, curUserType);
			}
		}  
		else													// if request status is different then 200  
		{
			getElement("div_info").innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}

function initTranslation()  
{
	var e = document.getElementById("adminRestore_prompt");
	e.innerHTML = _("adminRestore_prompt");

	e = document.getElementById("adminRestore_apply");
	e.value = _("adminRestore_apply");

}
</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="adminRestore_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
    <input id="adminRestore_apply" class="submit" style="width: 98px;" value="RestoreAll" type="button" onClick="RestoreConfirm()">
  </div>
  <div id="div_rebootingHead" class="div_rebootingHead"></div>
  <br>
  <div id="div_info"></div>
  <div><span id="restoreFailedInfo"></span></div>
</div>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
