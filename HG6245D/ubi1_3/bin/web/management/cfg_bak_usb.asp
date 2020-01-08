<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/ajaxupload.3.2.js"></script>
<title>USB Config Backup</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("usb", lang);
var http_request = getRequest();
function initTranslation()
{
	var e = document.getElementById("usb_cfgBakPrompt");
	e.innerHTML = _("usb_cfgBakPrompt");
    e = document.getElementById("usb_cfgBakTitle");
	e.innerHTML = _("usb_cfgBakTitle");
	
	e = document.getElementById("usb_cfgBak");
	e.value = _("usb_cfgBak");
}
function LoadFrame()
{ 
	initTranslation();
	var usb_sum = '<% get_usb_sum(); %>';
	var usb_partition_num = "<% getCfgGeneral(1, 'usb_partition_num'); %>";
	var usb_partition_num_arr = usb_partition_num.split("|");
	var usbListNode = getElement("usb_list");
	var partition_index = 0;
	if(usb_sum == 0)
	{
		usbListNode.options[usbListNode.length] = new Option(_("usb_idle"), 0);
		getElement("usb_cfgBak").disabled = true;
	}
	else
	{
		for(var i = 0; i < 8; i++)
		{
			if(usb_partition_num_arr[i] != 0)
				for(var j = 0; j < usb_partition_num_arr[i]; j++)
				{
					usbListNode.options[usbListNode.length] = new Option("USB" + (i + 1) + "_" + (j + 1), partition_index);
					partition_index++;
				}
		}
	}
}
///*
$(document).ready(function(){
	$("#usb_cfgBak").click(function(){
		var obj = $.ajax({
			url:"/goform/usb_cfg_bak", 
			data:"usb_list=" + $("#usb_list").val() + "&x-csrftoken=" + getCsrftoken(),
			async: false
		});
		var errorCode = parseInt(obj.responseText);
		switch(errorCode)
		{
			case 0: 
				$("#usb_cfg_bak_info").html(_("usb_cfg_bak_success"));
				break;
			case -1: 
				$("#usb_cfg_bak_info").html(_("usb_server_error1"));
				break;
			case -2: 
				$("#usb_cfg_bak_info").html(_("usb_server_error2"));
				break;
			case -3: 
				$("#usb_cfg_bak_info").html(_("usb_server_error3"));
				break;
		}
	});
});
//*/
/*
function submitForm()
{
	makeRequest("/goform/usb_cfg_bak", "usb_list=" + getElement("usb_list").value, downCfgFileHandler);
}
function downCfgFileHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{
			getElement("usb_cfg_bak_info").innerHTML = http_request.responseText;
		}
		else													// if request status is different then 200  
		{ 
			var span_info = document.getElementById("usb_cfg_bak_info");
			setDisplay(span_info, "");
			span_info.innerHTML = 'Error: ['+http_request.status+'] '+ http_request.statusText;  			
		}
	}
}
*/
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="usb_cfgBakPrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="usb_cfg_bak_fm" id="usb_cfg_bak_fm">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="usb_cfgBakTitle" align="left" width="25%">USB Backup Directory</td>
        <td class="tabal_right"><select id="usb_list" name="usb_list" size="1" style="width:35%">
          </select></td>
      </tr>
      <tr>
        <td colspan="2" class="tabal_submit" align="left"><input class="submit" type="button" name="usb_cfgBak" id="usb_cfgBak" style="width:120px;" value="Download Backup">
        </td>
      </tr>
    </tbody>
  </table>
  <div id="usb_cfg_bak_info"></div>
</form>
</body>
</html>
