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

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var  tr069BasicSync = '<% tr069BasicSync(  ) ;%>';

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("tr069", lang);

var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';

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
	if(ispNameCode == '15')	//GLOBE
		e.innerHTML = _("tr069_prompt_cfgfile");
	else
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
	e = document.getElementById("tr069CertificateEnable_title");
	e.innerHTML = _("tr069CertificateEnable_title");
	
	e = document.getElementById("tr069Inform_enable");
	e.innerHTML = _("tr069_enable");
	e = document.getElementById("tr069Inform_disable");
	e.innerHTML = _("tr069_disable");
	e = document.getElementById("tr069_enable");
	e.innerHTML = _("tr069_enable");
	e = document.getElementById("tr069_disable");
	e.innerHTML = _("tr069_disable");
	e = document.getElementById("tr069Certificate_enable");
	e.innerHTML = _("tr069_enable");
	e = document.getElementById("tr069Certificate_disable");
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

	/*哥伦比亚telebucaramanga 及哥伦比亚 Metrotel 越南HGU灰色显示周期上报使能按钮*/
	if((ispNameCode == '17') || (ispNameCode == '18') ||  (ispNameCode == '16'))
	{
		for(var i = 0;i<tr069InformEnable.length;i++)
		{
			tr069InformEnable[i].disabled = true;					
		}
	}
	if(ispNameCode == '15')	//GLOBE
	{
		setDisplay("tb_tr069Enable", "none");
		setDisplay("tb_tr069EnableCfg", "none");
		setDisplay("tb_tr069Basic", "none");
		setDisplay("tb_tr069BasicCfg", "none");
		setDisplay("fm_tr069_cfg_file", "");
		var tr069CfgFile = '<% getCfgGeneral(1, "tr069CfgFile"); %>';
		showRadioNodeByValue(getElement("tr069CfgFile"), tr069CfgFile);
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
	
	/*哥伦比亚telebucaramanga及哥伦比亚 Metrotel灰色显示tr069使能按钮*/
	if((ispNameCode == '17') || (ispNameCode == '18'))
	{
		for(var i = 0;i<tr069Enable.length;i++)
		{
			tr069Enable[i].disabled = true;					
		}
	}
	if((ispNameCode == '5') ||  (ispNameCode == '17') || (ispNameCode == '18'))	//HGU X_AIS,SFU COLUMBIA_TELEBU，COLUMBIA_METRO
	{
		setDisplay("tr_certifi", ""); 
		var tr069CertificateEnable = document.getElementsByName("tr069CertificateEnable");	
		for(var i = 0;i<tr069CertificateEnable.length;i++)
		{
			if(tr069CertificateEnable[i].value == '<% getCfgGeneral(1, "tr069CertificateEnable"); %>')
			{
				tr069CertificateEnable[i].checked = true;
				break;
			}
		}

		/*哥伦比亚telebucaramanga及哥伦比亚 Metrotel灰色显示证书使能按钮*/
		if((ispNameCode == '17') || (ispNameCode == '18'))
		{
			for(var i = 0;i<tr069CertificateEnable.length;i++)
			{
				tr069CertificateEnable[i].disabled = true;					
			}
		}
	}

	/* 灰色显示tr069配置 */
	/*广东联通,四川移动,黑龙江移动,智利Telsur,哥伦比亚telebucaramanga及哥伦比亚 Metrotel,越南 */
	if((ispMinorNameCode == '305') || (ispMinorNameCode == '202') 
		|| (ispMinorNameCode == '203') || (ispNameCode == '11')
		|| (ispNameCode == '17') || (ispNameCode == '18')
		|| (ispNameCode == '16')) 
	{
		document.getElementById("tr069url").disabled = 1;
		document.getElementById("tr069Enable").disabled = 1;
		document.getElementById("tr069userName").disabled = 1;
		document.getElementById("tr069password").disabled = 1;
		document.getElementById("tr069path").disabled = 1;
		document.getElementById("tr069port").disabled = 1;
		document.getElementById("tr069conReqUsr").disabled = 1;
		document.getElementById("tr069conReqPwd").disabled = 1;
		document.getElementById("tr069InformEnable").disabled = 1;
		document.getElementById("tr069InformInterval").disabled = 1;
		setDisplay("tb_tr069EnableCfg", "none");
		setDisplay("tb_tr069BasicCfg", "none");
	}

/*add begin by郭心悦，20170111，原因:越南HGU当前版本disable功能无效，可直接删除TR069 ENABLE 部分*/
	if(ispNameCode == '16')
	{
		setDisplay("tb_tr069Enable", "none");
	}
/*add begin by郭心悦，20170111*/	
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
	field = document.fm_tr069_basic.tr069path;
	if (!CheckNotNull(field.value)) {					
		alert(_("Please input path!"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}


	/* validate port */
	field = document.fm_tr069_basic.tr069port;
	if(!fw_checkPortLegal(field))
	{
		return false;
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
		alert(_("Please enter connectionRequestPassword!"));
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

	if(!checkInformInterval(field))
	{
		return false;
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
<form method="post" id="fm_tr069_enable" action="/goform/setTR069Enable">
  <table id="tb_tr069Enable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr >
        <td class="tabal_left" id="tr069Enable_title" align="left" width="30%">TR069 Enable</td>
        <td class="tabal_right" align="left"><input checked="checked" value="enable"  id="tr069Enable" name="tr069Enable" type="radio">
          <font id="tr069_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="tr069Enable" type="radio">
          <font id="tr069_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table id="tb_tr069EnableCfg" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="30%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="tr069EnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="tr069EnableCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<form method=post name="fm_tr069_basic" action="/goform/setTR069Basic" onSubmit="return CheckValue()">
  <table id="tb_tr069Basic" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="tr069url_title" width="30%">URL</td>
        <td class="tabal_right"><input type="text" id="tr069url"name="tr069url" size="60" maxlength="256" value="<% getCfgGeneral(1, "tr069url"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069userName_title">Username</td>
        <td class="tabal_right"><input type="text" id="tr069userName" name="tr069userName" size="60" value="<% getCfgGeneral(1, "tr069userName"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069password_title">Password</td>
        <td class="tabal_right"><input type="password" id="tr069password" name="tr069password" size="60" value="<% getCfgGeneral(1, 'tr069password_encode'); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr id="tr_acsPath">
        <td class="tabal_left" id="ConnectionRequestPath_title">Connection Request Path</td>
        <td class="tabal_right"><input type="text" id="tr069path" name="tr069path" size="60" value="<% getCfgGeneral(1, "tr069path"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr id="tr_acsPort">
        <td class="tabal_left" id="ConnectionRequestPort_title">Connection Request Port</td>
        <td class="tabal_right"><input type="text" id="tr069port" name="tr069port" size="60" value="<% getCfgGeneral(1, "tr069port"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <!-- delete by wuxj, 20150427, there is no requirement of this node, so hide it -->
      <tr style="display:none">
        <td colspan="2"><input type="checkbox" id="tr069authCheckbox" onClick="clickAuthCheck();"/>
          <span id="tr069auth_Title">Connection Request Authentication</span></td>
      </tr>
      <tr>
        <td id="tr069conReqUsr_title" class="tabal_left">Connection Request Username</td>
        <td class="tabal_right"><input type="text" id="tr069conReqUsr" name="tr069conReqUsr" size="60" value="<% getCfgGeneral(1, "tr069conReqUsr"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069conReqPwd_title">Connection Request Password</td>
        <td class="tabal_right"><input type="password" id="tr069conReqPwd" name="tr069conReqPwd" size="60" value="<% getCfgGeneral(1, 'tr069conReqPwd_encode'); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformEnable_title">Inform Enable</td>
        <td class="tabal_right"><input checked="checked" value="1" id="tr069InformEnable" name="tr069InformEnable" type="radio">
          <font id="tr069Inform_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="tr069InformEnable" type="radio">
          <font id="tr069Inform_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="tr069InformInterval_title">Inform Interval</td>
        <td class="tabal_right"><input type="text" id="tr069InformInterval" name="tr069InformInterval" size="60" value="<% getCfgGeneral(1, "tr069InformInterval"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr id="tr_certifi" style="display:none">
        <td class="tabal_left" id="tr069CertificateEnable_title">Enable Certificate</td>
        <td class="tabal_right"><input checked="checked" value="1" name="tr069CertificateEnable" type="radio">
          <font id="tr069Certificate_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input checked="checked" value="0" name="tr069CertificateEnable" type="radio">
          <font id="tr069Certificate_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_tr069BasicCfg" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="30%"></td>
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
<form style="display:none" method="post" id="fm_tr069_cfg_file" action="/goform/setTR069CfgFile">
  <table id="tb_tr069CfgFile" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="tr069CfgFile_title" align="left" width="30%">TR069 Configuration</td>
        <td class="tabal_right" align="left"><input checked="checked" value="0" name="tr069CfgFile" type="radio">
          <font id="tr069ProductTitle">Production</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="1" name="tr069CfgFile" type="radio">
          <font id="tr069StagingTitle">Staging</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table id="tb_tr069CfgFileCfg" class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="30%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="tr069CfgFileApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="tr069CfgFileCancel" onClick="window.location.reload()">
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
