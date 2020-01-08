<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>TR069 Settings</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>';
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("tr069", lang);

//get init value from driver

/*****************************************************************************
 * 函 数 名  : initTranslation
 * 函数功能  :从配置文件中获取页面元素显示名称
 * 输入参数  :无
 * 输出参数  :无
 * 返 回 值  : 无
 * 其    它  : 
 * 记    录
 * 1.日    期: 2011年03月21日
 *   作    者: 吴小娟
 *   修改内容: 新生成函数
 
*****************************************************************************/
function initTranslation()
{
	var e = document.getElementById("tr069_prompt");
	e.innerHTML = _("tr069_prompt");
	
	e = document.getElementById("tr069url_title");
	e.innerHTML = _("tr069url_title");
	e = document.getElementById("tr069userName_title");
	e.innerHTML = _("tr069userName_title");
	e = document.getElementById("tr069password_title");
	e.innerHTML = _("tr069password_title");
	e = document.getElementById("tr069conReqUsr_title");
	e.innerHTML = _("tr069conReqUsr_title");
	e = document.getElementById("tr069conReqPwd_title");
	e.innerHTML = _("tr069conReqPwd_title");
	e = document.getElementById("ConnectionRequestPath_title");
	e.innerHTML = _("ConnectionRequestPath_title");
	e = document.getElementById("ConnectionRequestPort_title");
	e.innerHTML = _("ConnectionRequestPort_title");
	
	e = document.getElementById("tr069InformEnable_title");
	e.innerHTML = _("tr069InformEnable_title");
	e = document.getElementById("tr069InformInterval_title");
	e.innerHTML = _("tr069InformInterval_title");
	e = document.getElementById("tr069Enable_title");
	e.innerHTML = _("tr069Enable_title");
	
	e = document.getElementById("tr069Inform_enable");
	e.innerHTML = _("tr069_enable");
	e = document.getElementById("tr069Inform_disable");
	e.innerHTML = _("tr069_disable");
	e = document.getElementById("tr069_enable");
	e.innerHTML = _("tr069_enable");
	e = document.getElementById("tr069_disable");
	e.innerHTML = _("tr069_disable");
	
	e = document.getElementById("tr069auth_Title");
	e.innerHTML = _("tr069auth_Title");

	e = document.getElementById("tr069BasicApply");
	e.value = _("tr069 basic apply");
	e = document.getElementById("tr069BasicCancel");
	e.value = _("tr069 basic cancel");

	e = document.getElementById("tr069EnableApply");
	e.value = _("tr069 basic apply");
	e = document.getElementById("tr069EnableCancel");
	e.value = _("tr069 basic cancel");
	
	e = document.getElementById("tr069GetRPCMethods");
	e.value = _("tr069_getRPCMethods");
}

/*****************************************************************************
 * 函 数 名  : initValue
 * 函数功能  :页面初始化
 * 输入参数  :无
 * 输出参数  :无
 * 返 回 值  : 无
 * 其    它  : 
 * 记    录
 * 1.日    期: 2011年03月21日
 *   作    者: 吴小娟
 *   修改内容: 新生成函数
 
*****************************************************************************/
function initValue()
{
	initTranslation();
	var tr069InformEnable = document.getElementsByName("tr069InformEnable");	
	for(var i = 0;i<tr069InformEnable.length;i++)
	{
		if(tr069InformEnable[i].value == '<% getCfgGeneral(1, "tr069InformEnable"); %>')
		{
			tr069InformEnable[i].checked = true;
			break;
		}
	}
	var tr069Enable = document.getElementsByName("tr069Enable");	
	for(var i = 0;i<tr069Enable.length;i++)
	{
		if(tr069Enable[i].value == '<% getCfgGeneral(1, "tr069Enable"); %>')
		{
			tr069Enable[i].checked = true;
			break;
		}
	}
}

/*****************************************************************************
 * 函 数 名  : CheckValue
 * 函数功能  :校验页面输入参数的合法性
 * 输入参数  :field: 页面对象
 * 输出参数  :boolean:是否合法
 * 返 回 值  : true false
 * 其    它  : 
 * 记    录
 * 1.日    期: 2011年03月21日
 *   作    者: 吴小娟
 *   修改内容: 新生成函数
 
*****************************************************************************/
function CheckValue()
{
	var field;
	
	/* validate URL */
	field = document.fm_tr069_basic.tr069url;
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("Please enter URL!");
		alert(_("tr069_noURL"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!validateURL(field.value))					/* URL validity */
	{		
		//alert("the URL is illegal!");
		alert(_("tr069_urlillegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	/* validate username */
	field = document.fm_tr069_basic.tr069userName;
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("Please enter username!");
		alert(_("tr069_nousername"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	/* validate path */
	/*field = document.fm_tr069_basic.tr069path;
	if (!CheckNotNull(field.value)) {					
		alert(_("Please enter tr069 path!"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}*/

	/* validate port */
	field = document.fm_tr069_basic.tr069port;
	if(field.value != "")
    {
		if(!fw_checkPortLegal(field))
		{
			return false;
		}
	}
	
	/* validate password */
	field = document.fm_tr069_basic.tr069password;
	if (!CheckNotNull(field.value)) {					
		alert(_("Please input password!"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	/* validate tr069ConReqUsr */
	field = document.fm_tr069_basic.tr069conReqUsr;
	if (!CheckNotNull(field.value)) {					//not null
		//alert("Please enter connectionRequestUsername!");
		alert(_("tr069_noRequestUsername"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	/* validate tr069ConReqPwd */
	field = document.fm_tr069_basic.tr069conReqPwd;
	if (!CheckNotNull(field.value)) {					//not null
		alert("Please enter connectionRequestPassword!");
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	/* validate tr069InformInterval */
	field = document.fm_tr069_basic.tr069InformInterval;
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("Please enter tr069 inform interval!");
		alert(_("tr069_noinforminterval"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	return true;
}

function fw_checkPortLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 65535)
		{
			return true;
		}
		else
		{
	//		alert("有效端口范围为1-65535.");
			alert(_("Please enter valid port value: 1-65535."));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("Please enter valid port value: 1-65535."));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function clickAuthCheck()
{
	var tr069authCheckNode = getElement("tr069authCheckbox");
	if(tr069authCheckNode.checked == true)		//need auth
	{
		getElement("tr069conReqUsr").disabled = false;
		getElement("tr069conReqPwd").disabled = false;
	}
	else										//don't need auth
	{	
		getElement("tr069conReqUsr").disabled = true;
		getElement("tr069conReqPwd").disabled = true;
	}
}

function getRPCMethods()
{		
	makeRequest("/goform/getRPCMethods", "n/a", getRPCMethodsHandler);
}

function getRPCMethodsHandler(http_request)
{
	if (http_request.readyState == 4)							//the operation is completed
	{
		if (http_request.status == 200)						// and the HTTP status is OK 
		{
			var rpcMethodsArea = getElement("rpcMethodsArea");
			setDisplay("rpcMethodsArea", "");
			rpcMethodsArea.innerHTML = http_request.responseText;
		}  
		else													// if request status is different then 200  
		{ 
			alert('Error: ['+http_request.status+'] '+http_request.statusText);  			
		}
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
              <td id="tr069_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="fm_tr069_enable" action="/goform/setTR069Enable">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="tr069Enable_title" align="left" width="25%">TR069 Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="tr069Enable" type="radio">
          <font id="tr069_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="tr069Enable" type="radio">
          <font id="tr069_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="tr069EnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="tr069EnableCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method=post name="fm_tr069_basic" action="/goform/setTR069Basic" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="tr069url_title" align="left" width="25%">URL</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069url" size="80" maxlength="256" value="<% getCfgGeneral(1, "tr069url"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069userName_title" align="left" width="25%">Username</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069userName" size="80" value="<% getCfgGeneral(1, "tr069userName"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069password_title" align="left" width="25%">Password</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="password" name="tr069password" size="80" value="<% getCfgGeneral(1, "tr069password_encode"); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
       <tr>
        <td class="tabal_left" id="ConnectionRequestPath_title" align="left" width="25%">Connection Request Path</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069path" size="80" value="<% getCfgGeneral(1, "tr069path"); %>">
           </td>
      </tr>
        <tr>
        <td class="tabal_left" id="ConnectionRequestPort_title" align="left" width="25%">Connection Request Port</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069port" size="80" value="<% getCfgGeneral(1, "tr069port"); %>">
           </td>
      </tr>
      <tr>
        <td colspan="2"><input type="checkbox" id="tr069authCheckbox" onClick="clickAuthCheck();"/><span id="tr069auth_Title">Connection Request Authentication</span></td>
      </tr>
      <tr>
        <td id="tr069conReqUsr_title" class="tabal_left" align="left" width="25%">Connection Request Username</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069conReqUsr" size="80" value="<% getCfgGeneral(1, "tr069conReqUsr"); %>">
          &nbsp; &nbsp;
          <strong style="color:#FF0033">*</strong>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069conReqPwd_title" align="left" width="25%">Connection Request Password</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="password" name="tr069conReqPwd" size="80" value="<% getCfgGeneral(1, "tr069conReqPwd_encode"); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
          &nbsp; &nbsp;
          <strong style="color:#FF0033">*</strong>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformEnable_title" align="left" width="25%">Inform Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="tr069InformEnable" type="radio">
          <font id="tr069Inform_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="tr069InformEnable" type="radio">
          <font id="tr069Inform_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformInterval_title" align="left" width="25%">Inform Interval</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069InformInterval" size="80" value="<% getCfgGeneral(1, "tr069InformInterval"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="tr069BasicApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="tr069BasicCancel" onClick="window.location.reload()">
          &nbsp; &nbsp;
          <input class="submit" type="button" value="GetRPCMethods" id="tr069GetRPCMethods" onClick="getRPCMethods()">
        </td>
      </tr>
      <tr>
        <td colspan="2"><textarea cols="112" rows="5" readonly="readonly" id="rpcMethodsArea" style="display: none">
        </textarea></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
