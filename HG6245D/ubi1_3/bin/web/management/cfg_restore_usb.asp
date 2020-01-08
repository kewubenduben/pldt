<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/ajaxupload.3.2.js"></script>
<title>USB Config Restore</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("usb", lang);

function initTranslation()
{
	var e = document.getElementById("usb_cfgRestorePrompt");
	e.innerHTML = _("usb_cfgRestorePrompt");
    e = document.getElementById("usb_cfgRestoreTitle");
	e.innerHTML = _("usb_cfgRestoreTitle");
    e = document.getElementById("usb_filenameTitle");
	e.innerHTML = _("usb_filenameTitle");
		
	e = document.getElementById("usb_cfgRestore");
	e.value = _("usb_cfgRestore");
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
		usbListNode.options[usbListNode.length] = new Option("ŒﬁUSB¥Ê¥¢…Ë±∏", 0);
		getElement("usb_cfgRestore").disabled = true;
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
	$("#usb_cfgRestore").click(function(){
		var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
		var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
		var obj = $.ajax({
			url:"/goform/usb_cfg_restore", 
			data:"usb_list=" + $("#usb_list").val()
				+ "&usb_cfg_filename=" + $("#usb_cfg_filename").val()
				+ "&x-csrftoken=" + getCsrftoken(),
			async: false
		});
		var errorCode = parseInt(obj.responseText);
		switch(errorCode)
		{
			case 0: 
				$("#usb_cfg_restore_info").text(_("usb_cfgRestoreSuccess") + " " + _("rebooting"));
				waitToLogin(ispName, curUserType);
				break;
			case -1: 
				$("#usb_cfg_restore_info").html(_("usb_serverError"));
				break;
			case -2: 
				$("#usb_cfg_restore_info").html(_("usb_openFileFail"));
				break;
			case -3: 
				$("#usb_cfg_restore_info").html(_("usb_readFileFail"));
				break;
			case -4: 
				$("#usb_cfg_restore_info").html(_("usb_restoreFail"));
				break;
			default: 
				$("#usb_cfg_restore_info").html(_("usb_serverError"));
				break;			
		}
		
	});
});
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="usb_cfgRestorePrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="usb_cfg_restore_fm" id="usb_cfg_restore_fm">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="usb_cfgRestoreTitle" align="left" width="25%">USB Restore Directory</td>
        <td class="tabal_right"><select id="usb_list" name="usb_list" size="1" style="width:35%">
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" id="usb_filenameTitle" align="left" width="25%">Configuration File</td>
        <td class="tabal_right"><input name="usb_cfg_filename" id="usb_cfg_filename" size="15" maxlength="32" type="text"style="width:35%" value="cfg_backup.config"></td>
      </tr>
      <tr>
        <td colspan="2" class="tabal_submit" align="left"><input class="submit" type="button" name="usb_cfgRestore" id="usb_cfgRestore" style="width:120px;" value="Restore">
        </td>
      </tr>
    </tbody>
  </table>
  <div id="usb_cfg_restore_info"></div>
</form>
</body>
</html>
