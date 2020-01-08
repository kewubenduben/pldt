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
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("update", lang);

var http_request = getRequest();
function initTranslation()
{
	var e = document.getElementById("down_cfgFilePrompt");
	e.innerHTML = _("down_cfgFilePrompt");
    e = document.getElementById("down_cfgFileHead");
	e.innerHTML = _("down_cfgFileHead");
    e = document.getElementById("down_cfgFileUserTitle");
	e.innerHTML = _("down_cfgFileUserTitle");
    e = document.getElementById("down_cfgFilePwdTitle");
	e.innerHTML = _("down_cfgFilePwdTitle");
    e = document.getElementById("down_cfgFileIPTitle");
	e.innerHTML = _("down_cfgFileIPTitle");
    e = document.getElementById("down_cfgFileNameTitle");
	e.innerHTML = _("down_cfgFileNameTitle");
	
    e = document.getElementById("down_cfgFileUserTips");
	e.innerHTML = _("down_cfgFileUserTips");
    e = document.getElementById("down_cfgFilePwdTips");
	e.innerHTML = _("down_cfgFilePwdTips");
    e = document.getElementById("down_cfgFileIPTips");
	e.innerHTML = _("down_cfgFileIPTips");
    e = document.getElementById("down_cfgFileNameTips");
	e.innerHTML = _("down_cfgFileNameTips");
	
    e = document.getElementById("down_cfgFileApply");
	e.value = _("content_trans_apply");
    e = document.getElementById("down_cfgFileCancel");
	e.value = _("content_trans_cancel");
}

function initValue()
{
	initTranslation();
}

//未使用
function submitForm()
{
	var down_cfgFileUser = getElement("down_cfgFileUser").value;
	var down_cfgFilePwd = getElement("down_cfgFilePwd").value;
	var down_cfgFileIP = getElement("down_cfgFileIP").value;
	var down_cfgFileName = getElement("down_cfgFileName").value;
	var content;
	if(checkValue())
	{
		if (!http_request) {
			alert("Giving up :( \nCannot create an XMLHTTP instance!");
			return false;
		}
		http_request.onreadystatechange = downCfgFileHandler;
//		http_request.open('GET', "/goform/setConf?" + "logic_sn=" + logic_sn + "&logic_pwd=" + logic_pwd, true);
		http_request.open('POST', "/goform/downCfgFileForm", true);//GET、POST都有效
		http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");

		content = "down_cfgFileUser=" + down_cfgFileUser + "&down_cfgFilePwd=" + down_cfgFilePwd
			+ "&down_cfgFileIP=" + down_cfgFileIP + "&down_cfgFileName=" + down_cfgFileName;

		content = content + "&x-csrftoken=" + getCsrftoken();
		
		http_request.send(content);
	}
}

function downCfgFileHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{
			var responseText = codeTransform(http_request.responseText);
			document.location = "../access_failed.asp"
//				+ "?backPage=" + document.location.href 
//				+ "?backPage=/management/down_cfgfile.asp"
//				+ "&accessNotice=" + responseText;
		}
		else													// if request status is different then 200  
		{ 
			var span_info = document.getElementById("span_info");
			setDisplay(span_info, "");
			span_info.innerHTML = 'Error: ['+http_request.status+'] '+ http_request.statusText;  			
		}
	}
}

function codeTransform(code)
{
	return "haha";
}

function checkValue()
{
	if(!checkFtpUser(getElement("down_cfgFileUser")))
	{
		return false;
	}
	if(!checkFtpPwd(getElement("down_cfgFilePwd")))
	{
		return false;
	}

	if(!checkFtpIP(getElement("down_cfgFileIP")))
	{
		return false;
	}

	if(!checkFtpFileName(getElement("down_cfgFileName")))
	{
		return false;
	}
	
	load_waiting();
	return true;
}

function checkFtpUser(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w.]{1,20}$/;	//数字 英文字母 _ .
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法用户名!");
		alert(_("down_cfgFileUserIllegalAlert"));
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
	var reg = /^[\w.]{0,20}$/;	//数字 英文字母 _ .
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法密码!");
		alert(_("down_cfgFilePwdIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
     	return false; 
    }
	else
	{
		return true;
	}
}

function checkFtpIP(dom)
{
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
//		alert("请输入合法ip!");
		alert(_("down_cfgFileIPIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function checkFtpFileName(dom)
{
	dom.value = trim(dom.value);
	var reg = /^[\w.]{1,64}$/;	//数字 英文字母 _ .
    if (!reg.test(dom.value))
	{ 
//		alert("请输入合法文件名!");
		alert(_("down_cfgFileFileIllegalAlert"));
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
<form method="post" name="down_cfgfile_fm" id="down_cfgfile_fm" action="/goform/downCfgFileForm" onSubmit="return checkValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="down_cfgFilePrompt" class="title_01" style="padding-left: 10px;" width="100%">You may backup several config files from device to PC as your wish after opening the ftp tool first.</td>
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
        <td colspan="2" id="down_cfgFileHead">Config Backup</td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="down_cfgFileUserTitle">Username</td>
        <td class="tabal_right"><input name="down_cfgFileUser" id="down_cfgFileUser" maxlength=20 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="down_cfgFileUserTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="down_cfgFilePwdTitle">Password</td>
        <td class="tabal_right"><input name="down_cfgFilePwd" id="down_cfgFilePwd" maxlength=20 style="width: 150px;" type="password">
          <span class="gray" id="down_cfgFilePwdTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="down_cfgFileIPTitle">Localhost IP</td>
        <td class="tabal_right"><input name="down_cfgFileIP" id="down_cfgFileIP" maxlength=16 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="down_cfgFileIPTips"> </span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="down_cfgFileNameTitle">File Name</td>
        <td class="tabal_right"><input name="down_cfgFileName" id="down_cfgFileName" maxlength=64 style="width: 150px;" type="text">
          <strong style="color:#FF0033">*</strong><span class="gray" id="down_cfgFileNameTips"> </span></td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="20%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="down_cfgFileApply" class="submit">
          <input type="reset" value="Cancel" id="down_cfgFileCancel" class="submit" onClick="window.location.reload()">
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
