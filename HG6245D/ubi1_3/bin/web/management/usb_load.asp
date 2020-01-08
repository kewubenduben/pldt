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
<title>USB Load</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("usb", lang);

function initTranslation()
{
	var e = document.getElementById("usb_loadPrompt");
	e.innerHTML = _("usb_loadPrompt");
    e = document.getElementById("usb_storgeHead");
	e.innerHTML = _("usb_storgeHead");
    e = document.getElementById("usb_typeTitle");
	e.innerHTML = _("usb_typeTitle");
    e = document.getElementById("usb_ftpUserTitle");
	e.innerHTML = _("usb_ftpUserTitle");
    e = document.getElementById("usb_ftpPwdTitle");
	e.innerHTML = _("usb_ftpPwdTitle");
    e = document.getElementById("usb_ftpIPTitle");
	e.innerHTML = _("usb_ftpIPTitle");
    e = document.getElementById("usb_ftpPortTitle");
	e.innerHTML = _("usb_ftpPortTitle");
    e = document.getElementById("usb_localFileTitle");
	e.innerHTML = _("usb_localFileTitle");
    e = document.getElementById("usb_remoteFileTitle");
	e.innerHTML = _("usb_remoteFileTitle");
    e = document.getElementById("usb_diskNoTitle");
	e.innerHTML = _("usb_diskNoTitle");
	
    e = document.getElementById("usb_ftpUserTips");
	e.innerHTML = _("usb_ftpUserTips");
    e = document.getElementById("usb_ftpPwdTips");
	e.innerHTML = _("usb_ftpPwdTips");
    e = document.getElementById("usb_ftpIPTips");
	e.innerHTML = _("usb_ftpIPTips");
    e = document.getElementById("usb_ftpPortTips");
	e.innerHTML = _("usb_ftpPortTips");
    e = document.getElementById("usb_localFileTips");
	e.innerHTML = _("usb_localFileTips");
    e = document.getElementById("usb_remoteFileTips");
	e.innerHTML = _("usb_remoteFileTips");
	
	e = document.getElementById("usb_apply");
	e.value = _("usb apply");
	e = document.getElementById("usb_cancel");
	e.value = _("usb cancel");
}

function initValue()
{
	initTranslation();
/* delete by 吴小娟, 20120229, 原因:由于现在FTP客户端实现为基于ONU USB设备的操作，故恢复盘符选择 */
//	setDisplay("tr_usb_diskNo", "none");
}

function checkValue()
{
	if(!checkFtpUser(getElement("usb_ftpUser")))
	{
		return false;
	}
	if(!checkFtpPwd(getElement("usb_ftpPwd")))
	{
		return false;
	}

	if(!usb_checkIP(getElement("usb_ftpIP")))
	{
		return false;
	}
	if(!usb_checkPort(getElement("usb_ftpPort")))
	{
		return false;
	}

	if(!checkLocFtpFileName(getElement("usb_localFile")))
	{
		return false;
	}
/*	else if(!checkFtpLocFileDir(getElement("usb_localFile")))
	{
		return false;
	}*/
		
	if(!checkRemoFtpFileName(getElement("usb_remoteFile")))
	{
		return false;
	}

	return true;
}

function checkFtpUser(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w]{1,32}$/;	//数字 英文字母 _
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法用户名!");
		alert(_("usb_userIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
     	return false;
    }
	else
	{
		return true;
	}
}

function checkFtpPwd(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w]{0,32}$/;	//数字 英文字母 _
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法密码!");
		alert(_("usb_pwdIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
     	return false; 
    }
	else
	{
		return true;
	}
}

function usb_checkIP(dom)
{
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
//		alert("请输入合法ip!");
		alert(_("usb_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function usb_checkPort(dom)
{
	dom.value = trim(dom.value);
	if(1 <=  parseInt(dom.value) &&  parseInt(dom.value) <= 65535)
	{
		return true;
	}
	else
	{
//		alert("有效端口范围为1～65535.");
		alert(_("usb_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkLocFtpFileName(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w/.-]{1,128}$/;	//数字 英文字母 _ / . -
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法文件名!");
		alert(_("usb_fileIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
     	return false; 
    }
	else
	{
		return true;
	}
}

function checkRemoFtpFileName(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w/.-]{1,128}$/;	//数字 英文字母 _ / . -
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法文件名!");
		alert(_("usb_fileIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
     	return false; 
    }
	else
	{
		return true;
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="usb_load_fm" id="usb_load_fm" action="/goform/usbLoad" onSubmit="return checkValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="usb_loadPrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="usb_storgeHead">USB Storge</td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_typeTitle">Type</td>
        <td class="tabal_right"><select name="usb_type" id="usb_type" size="1" style="width:28%">
            <option value="0" id="usb_upload">Upload</option>
            <option value="1" id="usb_download">Download</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_ftpUserTitle">Username</td>
        <td class="tabal_right"><input name="usb_ftpUser" id="usb_ftpUser" maxlength=32 style="width: 150px;" type="text" value="anonymous">
          <strong style="color:#FF0033">*</strong><span class="gray" id="usb_ftpUserTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_ftpPwdTitle">Password</td>
        <td class="tabal_right"><input name="usb_ftpPwd" id="usb_ftpPwd" maxlength=32 style="width: 150px;" type="password">
          <span class="gray" id="usb_ftpPwdTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_ftpIPTitle">FTP Server IP</td>
        <td class="tabal_right"><input name="usb_ftpIP" id="usb_ftpIP" maxlength=16 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="usb_ftpIPTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_ftpPortTitle">FTP Server Port</td>
        <td class="tabal_right"><input name="usb_ftpPort" id="usb_ftpPort" maxlength=5 style="width: 150px;" type="text" value="21">
          <strong style="color:#FF0033">*</strong><span class="gray" id="usb_ftpPortTips">(0-65535)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_remoteFileTitle">Remote File Name</td>
        <td class="tabal_right"><input name="usb_remoteFile" id="usb_remoteFile" maxlength=128 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="usb_remoteFileTips"> </span></td>
      </tr>
      <tr id="tr_usb_diskNo">
        <td class="tabal_left" width="20%" id="usb_diskNoTitle">Disk NO.</td>
        <td class="tabal_right"><select name="usb_diskNo" id="usb_diskNo" size="1" style="width:28%">
            <option value="sda1" id="usb_diskA">sda1</option>
            <!--<option value="sdb1" id="usb_diskB">sdb1</option>-->
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="usb_localFileTitle">Local File Name</td>
        <td class="tabal_right"><input name="usb_localFile" id="usb_localFile" maxlength=128 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="usb_localFileTips"> </span></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="usb_apply" class="submit">
          <input type="reset" value="Cancel" id="usb_cancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>

