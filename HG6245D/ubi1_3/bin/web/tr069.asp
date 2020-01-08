<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>TR069 Settings</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "tr069.asp");

var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_accesstr069lgoin_check( checkResult) ;

var  tr069BasicSync = '<% tr069BasicSync(  ) ;%>';

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("tr069", lang);

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


	
	e = document.getElementById("tr069GetRPCMethods");
	e.value = _("tr069_getRPCMethods");
}


var code="" ; //在全局 定义验证码
function createCode(){ 
code = "";
var codeLength = 5;//验证码的长度
var checkCode = document.getElementById("checkCode");
checkCode.value = "";

/*modify by 陈鹏 20180709  原因:HG6245D泰国3BB定制化版本要求验证码(not use letter“O”,“I”(i upper case),“l”(L lower case) and number“0”,“1”)*/
var selectChar = new Array(2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');

for(var i=0;i<codeLength;i++) {
   var charIndex = Math.floor(Math.random()*32);
   code +=selectChar[charIndex];
}
if(code.length != codeLength){
   createCode();
}
document.getElementById("checkCode").innerHTML = code;
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
	
	clickAuthCheck();
	Tr069EnableSwitch();

}

function Tr069EnableSwitch()
{
	var tr069Enable = document.getElementsByName("tr069Enable");	
	
	if(tr069Enable[1].checked == true) //Tr069 Disable
	{
		document.getElementById("tr069url").disabled = true;
		document.getElementById("tr069userName").disabled = true;
		document.getElementById("tr069password").disabled = true;

		document.getElementById("tr069path").disabled = true;
		document.getElementById("tr069port").disabled = true;
		document.getElementById("tr069authCheckbox").disabled = true;

		document.getElementById("tr069conReqUsr").disabled = true;
		document.getElementById("tr069conReqPwd").disabled = true;
		
		document.getElementById("tr069InformEnable1").disabled = true;
		document.getElementById("tr069InformEnable2").disabled = true;
		document.getElementById("tr069InformInterval").disabled = true;
		//document.getElementById("tr069BasicApply").disabled = false;
		
	}
	else  //Tr069 enable
	{
		document.getElementById("tr069url").disabled = false;
		document.getElementById("tr069userName").disabled = false;
		document.getElementById("tr069password").disabled = false;

		document.getElementById("tr069path").disabled = false;
		document.getElementById("tr069port").disabled = false;
		document.getElementById("tr069authCheckbox").disabled = false;

		document.getElementById("tr069conReqUsr").disabled = false;
		document.getElementById("tr069conReqPwd").disabled = false;
		
		document.getElementById("tr069InformEnable1").disabled = false;
		document.getElementById("tr069InformEnable2").disabled = false;
		//document.getElementById("tr069BasicApply").disabled = false;

		Tr069InformEnableSwitch();
	}
}

function Tr069InformEnableSwitch()
{
	var tr069InformEnable = document.getElementsByName("tr069InformEnable");	
	
	if(tr069InformEnable[1].checked == true) //Tr069Inform Disable
	{
		document.getElementById("tr069InformInterval").disabled = true;
	}
	else //Tr069Inform enable
	{
		document.getElementById("tr069InformInterval").disabled = false;
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

	var tr069InformEnable = document.getElementsByName("tr069InformEnable");	
	var tr069Enable = document.getElementsByName("tr069Enable");	
	if(tr069Enable[0].checked == true) //Tr069 enable
	{
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

		/* validate path*/
		field = document.fm_tr069_basic.tr069path;
		if (!CheckNotNull(field.value)) {					
			alert(_("Please input path!"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		} 

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
		
		if(tr069InformEnable[0].checked == true) // tr069inform enable
		{
			/* validate tr069InformInterval */
			field = document.fm_tr069_basic.tr069InformInterval;
			if (!CheckNotNull(field.value)) {					/* not null */
				//alert("Please enter tr069 inform interval!");
				alert(_("tr069_noinforminterval"));
				field.value = field.defaultValue;
				field.focus();
				return false;
			}
			if(!checkInformInterval(field))
			{
				return false;
			}
		}

	}
	
	return true;
}

function checkInformInterval(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 2147483647)
		{
			return true;
		}
		else
		{
			alert(_("InformInterval_alert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("InformInterval_alert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
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

<style type="text/css">

.STYLE7 {
    font-family:Arial;  
    font-style:italic;  
    font-weight:bold;  
    border:0;  
    letter-spacing:10px;  
    font-size: 15px;
    color:blue;
}

</style>

</head>
<body class="mainbody" onload="initValue()">
 <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="8px"></td>
      </tr>
    </tbody>
  </table>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
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

<form method=post name="fm_tr069_basic" action="/goform/setTR069Basic_3BB" onsubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
       <!--tr>
        <td class="tabal_left" id="tr069Enable_title" align="left" width="25%">TR069使能:</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><select   name="tr069Enable" id="tr069Enable" onChange="Tr069EnableSwitch();">
			<option value="disable" id="tr069_disable" selected="selected" >Disable</option>
			<option value="enable" id="tr069_enable" >Enable</option>
          </select></td>
      </tr-->
       <tr>
        <td class="tabal_left" id="tr069Enable_title" align="left" width="25%">TR069 Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="tr069Enable" type="radio" onclick="Tr069EnableSwitch();">
          <font id="tr069_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="tr069Enable" type="radio" onclick="Tr069EnableSwitch();">
          <font id="tr069_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069url_title" align="left" width="25%">URL:</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069url" id="tr069url" size="80" maxlength="255" value="">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069userName_title" align="left" width="25%">Username</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069userName" id="tr069userName" maxlength="255" size="80" value="">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069password_title" align="left" width="25%">Password</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="password" name="tr069password" id="tr069password" maxlength="255"  size="80" value="">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
       <tr>
        <td class="tabal_left" id="ConnectionRequestPath_title" align="left" width="25%">ConnectionRequestPath</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069path" id="tr069path" maxlength="255" size="80" value="">
           &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td></td>
      </tr>
        <tr>
        <td class="tabal_left" id="ConnectionRequestPort_title" align="left" width="25%">ConnectionRequestPort</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069port" id="tr069port" size="80" value="">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td> </td>
      </tr>
      <tr>
        <td colspan="2"><input type="checkbox" checked="checked" id="tr069authCheckbox" onclick="clickAuthCheck();"/><span id="tr069auth_Title">连接请求认证</span></td>
      </tr>
      <tr>
        <td id="tr069conReqUsr_title" class="tabal_left" align="left" width="25%">Connection Request Username</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069conReqUsr" id="tr069conReqUsr" maxlength="255" size="80" value="">
          &nbsp; &nbsp;
          <strong style="color:#FF0033">*</strong>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069conReqPwd_title" align="left" width="25%">Connection Request Password</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="password" name="tr069conReqPwd" id="tr069conReqPwd" maxlength="255" size="80" value="">
          &nbsp; &nbsp;
        <strong style="color:#FF0033">*</strong>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformEnable_title" align="left" width="25%">Inform Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="tr069InformEnable"  id="tr069InformEnable1"type="radio" onclick="Tr069InformEnableSwitch();">
          <font id="tr069Inform_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="tr069InformEnable" id="tr069InformEnable2" type="radio" onclick="Tr069InformEnableSwitch();">
          <font id="tr069Inform_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformInterval_title" align="left" width="25%">Inform Interval</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input type="text" name="tr069InformInterval" id="tr069InformInterval" maxlength="9" size="80" value="">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
    </tbody>
  </table>
	 
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="10%"></td>
        <td class="tabal_submit" width="35%" align="left"><input class="submit" type="submit" value="提交" id="tr069BasicApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="tr069BasicCancel" onclick="window.location.reload()">
          &nbsp; &nbsp;
          <input class="submit" type="button" value="GetRPCMethods" id="tr069GetRPCMethods" onclick="getRPCMethods()">
        </td>
      </tr>
      <tr>
        <td colspan="2"><textarea cols="140" rows="5" readonly="readonly" name="rpcMethodsArea" id="rpcMethodsArea" style="display: none">
        </textarea></td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
