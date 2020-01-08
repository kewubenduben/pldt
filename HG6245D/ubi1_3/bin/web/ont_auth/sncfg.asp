<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/versionControl.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<title>SN Config</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("sncfg", lang);

var sncfgSync = '<% sncfgSync();%>';

var http_request = getRequest();

var pwdCfgFlag = 1;
var restoreFlag = 0;

var phySNCfgFlag = '<% getCfgZero("1", "phySNCfgFlag");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';

/* modify by wuxj, 20120314, commit authentication separately*/
function initValue()
{
	var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
	if(userrelog != 1)
	{
//		window.location.href="/login.asp?backurl=" + window.location.href;
	}
	
	initTranslation();
	if(ispNameCode == '22')	//泰国TRUE只需LOID
	{
		pwdCfgFlag = 0;
	}
	
	if(pwdCfgFlag == 1)
	{
		setDisplay("div_pwdcfg", "");
	}
	if(restoreFlag == 1)
	{
		setDisplay("div_restore", "");
	}
	if(parseInt(phySNCfgFlag) == 1)
	{
		setDisplay("div_phySNcfg", "");
	}

	if(ispMinorNameCode == 305) /*广东联通逻辑密码灰显*/
	{
		document.getElementById("logic_pwd").disabled = true;
		setDisplay("div_pwdcfg", "none");
	}
	else
	{
		document.getElementById("sncfg_apply1").disabled = false;
		document.getElementById("logic_sn").disabled = false;
	}

	var oltAuthSetFlag = '<% getCfgGeneral(1, "oltAuthSetFlag");%>';
	if(ispNameCode == '22' && curUserType =='1')	//泰国TRUE普通用户
	{
		if(oltAuthSetFlag == '1')
		{
			setDisplay('tb_sn_submit', 'none');
			document.getElementById("logic_sn").disabled = true;
			document.getElementById("logic_pwd").disabled = true;
		}
	}
	
	/*hint when authentication Failed*/
	dealSnFailedHandle();
	
}

function initTranslation()
{
	var e = document.getElementById("sncfg_prompt");
	if(ispNameCode == '5' && curUserType == '1')	//HGU AIS普通用户
		e.innerHTML = _("sncfg_prompt_user");
	else
		e.innerHTML = _("sncfg_prompt");
	
	e = document.getElementById("sncfg_snTitle");
	e.innerHTML = _("sncfg_snTitle");
	e = document.getElementById("sncfg_pwdTitle");
	e.innerHTML = _("sncfg_pwdTitle");
	e = document.getElementById("oltcfg_phySNTitle");
	e.innerHTML = _("oltcfg_phySNTitle");
	e = document.getElementById("sncfg_restoreTitle");
	e.innerHTML = _("sncfg_restoreTitle");
	
	e = document.getElementById("sncfg_loid");
	e.innerHTML = _("sncfg_loid");
	e = document.getElementById("sncfg_loidTips");
	e.innerHTML = _("sncfg_loidTips");
	e = document.getElementById("sncfg_lopwd");
	e.innerHTML = _("sncfg_lopwd");
	e = document.getElementById("sncfg_lopwdTips");
	e.innerHTML = _("sncfg_lopwdTips");
	e = document.getElementById("sncfg_pwd");
	e.innerHTML = _("sncfg_pwd");
	e = document.getElementById("sncfg_pwdTips");
	e.innerHTML = _("sncfg_pwdTips");
	e = document.getElementById("oltcfg_phySN");
	e.innerHTML = _("oltcfg_phySN");
	e = document.getElementById("oltcfg_phySNTips");
	e.innerHTML = _("oltcfg_phySNTips");
	e = document.getElementById("sncfg_restore");
	e.value = _("sncfg_restore");
	e = document.getElementById("sncfg_restoreTips");
	e.innerHTML = _("sncfg_restoreTips");
	
	e = document.getElementById("sncfg_apply1");
	e.value = _("sncfg_apply");
	e = document.getElementById("sncfg_cancel1");
	e.value = _("sncfg_cancel");
	e = document.getElementById("sncfg_apply2");
	e.value = _("sncfg_apply");
	e = document.getElementById("sncfg_cancel2");
	e.value = _("sncfg_cancel");
	e = document.getElementById("oltcfg_apply3");
	e.value = _("sncfg_apply");
	e = document.getElementById("oltcfg_cancel3");
	e.value = _("sncfg_cancel");
}	

function submitForm(cfgType)
{
	var logic_sn, logic_pwd, pwd_cfg, phySN;
	var content = "cfgType=" + cfgType;

/* modify begin by wuxj, 20120406, 
	use POST to repair Chinese character problem*/
	if(checkValue(cfgType))
	{
		if(cfgType == "sn")
		{
			logic_sn = getElement("logic_sn").value;
			logic_pwd = getElement("logic_pwd").value;
			
			logic_sn = encodeURIComponent(logic_sn);
			logic_pwd = encodeURIComponent(logic_pwd);
			
			content += "&logic_sn=" + logic_sn
				+ "&logic_pwd=" + logic_pwd;
		}
		else if(cfgType == "pwd")
		{
			pwd_cfg = getElement("pwd_cfg").value;
			
			content += "&pwd_cfg=" + encodeURIComponent(pwd_cfg);
		}
		else if(cfgType == "phySN")
		{
			phySN = getElement("phySN").value;
			
			content += "&phySN=" + encodeURIComponent(phySN);
		}
		
		content = content + "&x-csrftoken=" + getCsrftoken();
		
		if (!http_request) {
			alert("Giving up :( \nCannot create an XMLHTTP instance!");
			return false;
		}
		
		http_request.onreadystatechange = sncfgHandler;

		http_request.open('POST', "/goform/setOLTAuth", true);
		http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		http_request.send(content);
	
	}
/* modify end by wuxj, 20120406 */
}

function sncfgHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var errorCode = http_request.responseText;
			if(errorCode == "0")
			{
				if(confirm(_("sncfg_restartConfirm")))
				{
					parent.location="/goform/reboot" + "?csrftoken=" + getCsrftoken()
				}
				else
				{
					document.location = "./sncfg.asp";
				}
			}
			else
			{
				var span_info = document.getElementById("span_info");
				setDisplay("span_info", "");
				if(1 == '<% getCfgGeneral(1, "userrelog");%>')
				{
					span_info.innerHTML = _("physncfg_checkeror");
				}
				else
				{
					span_info.innerHTML = _("sncfg_setFailedInfo");
				}
				
			}
		 }  
		else													// if request status is different then 200  
		{ 
			var span_info = document.getElementById("span_info");
			setDisplay("span_info", "");
			span_info.innerHTML = 'Error: ['+http_request.status+'] '+http_request.statusText;  			
		 }
	}
}

function restoreOntAuth()
{	
	var content = "x-csrftoken=" + getCsrftoken();
	if (!http_request) {
		alert("Giving up :( \nCannot create an XMLHTTP instance!");
		return false;
	}
	http_request.onreadystatechange = sncfgHandler;
	http_request.open('GET', "/goform/restore", true);//only GET
	http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	
	http_request.send(content);
}

function checkValue(cfgType)
{
	if(cfgType == "sn")
	{
		var logicSN = document.getElementById("logic_sn");
		var logicPwd = document.getElementById("logic_pwd");
		if (!CheckNotNull(logicSN.value)) 
		{
			alert(_("sncfg_loidNullAlert"));
			logicSN.value = logicSN.defaultValue;
			logicSN.focus();
			return false;
		}

		if(!checkASCIIChar(logicSN.value))
		{
			alert(_("sncfg_loidchnAlert"));
			logicSN.value = logicSN.defaultValue;
			logicSN.focus();
			return false;
		}
	}
	else if(cfgType == "pwd")
	{
		var pwdCfg = document.getElementById("pwd_cfg");
		if(pwdCfg.value != "<% getCfgGeneral(1, 'pwd_cfg_encode'); %>")
		{
			if(!checkPwdCfg(pwdCfg.value))
			{
				alert(_("sncfg_pwdCfgIllegalAlert"));
				pwdCfg.value = pwdCfg.defaultValue;
				pwdCfg.focus();
				return false;
			}
		}
	}
	else if(cfgType == "phySN")
	{
		var phySNCfg = document.getElementById("phySN");
		if (!CheckNotNull(phySNCfg.value)) 
		{
			alert(_("sncfg_phySNNullAlert"));
			phySNCfg.value = phySNCfg.defaultValue;
			phySNCfg.focus();
			return false;
		}
		if(!checkPhySNCfg(phySNCfg.value))
		{
			alert(_("sncfg_phySNCfgIllegalAlert"));
			phySNCfg.value = phySNCfg.defaultValue;
			phySNCfg.focus();
			return false;
		}
	}
	return true;
}

function checkLogicSN(str)
{
	var reg = /^[\w./]{1,24}$/;	//number letter _ . /
    if (!reg.test(str))
	{ 
     	return false; 
    }
	else
	{
		return true;
	}
}

function checkLogicPwd(str)
{
	if (str.length > 0) 
	{
		var reg = /^[\w]{1,12}$/;	//number letter _
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}

function checkPwdCfg(str)
{
	if (str.length > 0) 
	{
		var reg = /^[\w-]{1,10}$/;	//number letter _ -
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}

function checkPhySNCfg(str)
{
	if(str.length != 12 && str.length != 16)
	{
		return false;
	}
	else	
	{
		var reg = /^[a-fhtA-FHT0-9]{12,16}$/;	//number a-f A-F h t H T
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}
/*****************************************************************************
dealSnFailedHandle
wuxj
2011.5.26
hint when authentication Failed
*****************************************************************************/
function dealSnFailedHandle()
{
	var snSetFailedID = '<% getCfgGeneral(1, "snSetFailedID"); %>';
	if(snSetFailedID != "" && snSetFailedID !="dataFormatError")
	{
		/* get node failed to deal authentication */
		var dom = document.getElementById(snSetFailedID);

		/*hint failed to deal authentication*/
		setFailedDom(dom, 1);				/*1:write*/
	}
	else
	{
		var snGetFailedIDs = '<% getCfgGeneral(1, "snGetFailedIDs"); %>';
		if(snGetFailedIDs != "")
		{
			var idArray = new Array();
			idArray = parseGetFailedIDs(snGetFailedIDs);
			for(var i = 0; i<idArray.length; i++)
			{
				var dom = document.getElementById(idArray[i]);
				setFailedDom(dom, 0);		/*0:read*/
			}
		}
	}

}
</script>
</head>
<body class="mainbody" onload="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="sncfg_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
<div id="div_sncfg">
  <form method="post" name="sncfgForm" id="sncfgForm">
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr class="tabal_head">
          <td colspan="2" id="sncfg_snTitle">LOID Auth</td>
        </tr>
        <tr id="TrLoid">
          <td class="tabal_left" width="20%" id="sncfg_loid">LOID</td>
          <td class="tabal_right"><input name="logic_sn" id="logic_sn" maxlength="24" type="text" value="<% getCfgGeneral(1, "logic_sn"); %>">
            <strong style="color:#FF0033">*</strong><span class="gray" id="sncfg_loidTips">&nbsp;(You can input 1-24 basic Latin characters)</span> </td>
        </tr>
        <tr id="TrLopwd">
          <td class="tabal_left" width="20%" id="sncfg_lopwd">Logic Password</td>
          <td class="tabal_right"><input name="logic_pwd" id="logic_pwd" maxlength="12" type="password" value="<% getCfgGeneral(1, "logic_pwd_encode"); %>" onfocus="clearInputValue(this.id)">
            <span class="gray" id="sncfg_lopwdTips">&nbsp;&nbsp;(You can input 0-12 basic Latin characters)</span> </td>
        </tr>
      </tbody>
    </table>
    <table id="tb_sn_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tbody>
        <tr>
          <td width="15%"></td>
          <td class="tabal_submit" width="10%"><input type="button" name="sncfg_apply1" value="Apply" id="sncfg_apply1" class="submit" onClick="submitForm('sn')">
          </td>
          <td class="tabal_submit"><input type="reset" name="sncfg_cancel1" value="Cancel" id="sncfg_cancel1" class="submit" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
    <br/>
  </form>
</div>
<div id="div_pwdcfg" style="display: none">
  <form method="post" name="pwdcfgForm" id="pwdcfgForm">
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr class="tabal_head">
          <td height="22" colspan="2" id="sncfg_pwdTitle">Password Auth</td>
        </tr>
        <tr id="TrPassword">
          <td class="tabal_left" width="20%" id="sncfg_pwd">Pass Key</td>
          <td class="tabal_right"><input name="pwd_cfg" id="pwd_cfg" maxlength="10" type="password" value="<% getCfgGeneral(1, 'pwd_cfg_encode'); %>" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
            <strong style="color:#FF0033">*</strong> <span class="gray" id="sncfg_pwdTips">&nbsp; (You can input 0-10 characters, including alphanumeric, '-' and '_')</span> </td>
        </tr>
      </tbody>
    </table>
    <table id="tb_pwd_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tbody>
        <tr>
          <td width="15%"></td>
          <td class="tabal_submit" width="10%"><input type="button" name="sncfg_apply2" value="Apply" id="sncfg_apply2" class="submit" onClick="submitForm('pwd')">
          </td>
          <td class="tabal_submit"><input type="reset" name="sncfg_cancel2" value="Cancel" id="sncfg_cancel2" class="submit" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
  <br/>
</div>
<div id="div_phySNcfg" style="display: none">
  <form method="post" name="phySNcfgForm" id="phySNcfgForm">
    <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr class="tabal_head">
          <td height="22" colspan="2" id="oltcfg_phySNTitle">Physical SN Auth</td>
        </tr>
        <tr>
          <td class="tabal_left" width="20%" id="oltcfg_phySN">Physical SN</td>
          <td class="tabal_right"><input name="phySN" id="phySN" maxlength="16" type="text" value="<% getCfgGeneral(1, 'phySN'); %>">
            <strong style="color:#FF0033">*</strong> <span class="gray" id="oltcfg_phySNTips">&nbsp; (You can input 12 or 16 characters, including '0'-'9' 'a'-'f' 'A'-'F' 'h' 't' 'H' 'T')</span> </td>
        </tr>
      </tbody>
    </table>
    <table id="tb_physn_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tbody>
        <tr>
          <td width="15%"></td>
          <td class="tabal_submit" width="10%"><input type="button" name="oltcfg_apply3" value="Apply" id="oltcfg_apply3" class="submit" onClick="submitForm('phySN')">
          </td>
          <td class="tabal_submit"><input type="reset" name="oltcfg_cancel3" value="Cancel" id="oltcfg_cancel3" class="submit" onClick="window.location.reload()">
          </td>
        </tr>
      </tbody>
    </table>
  </form>
  <br/>
</div>
<div id="div_restore" style="display: none">
  <table id="tb_restore_submit" class="tabal_bg" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td height="22" colspan="2" id="sncfg_restoreTitle">Restore Configuration</td>
      </tr>
      <tr>
        <td class="tabal_submit" id="td_restore"><input type="button" name="sncfg_restore" value="Restore" id="sncfg_restore" class="submit" onClick="restoreOntAuth()">
          <span class="gray" id="sncfg_restoreTips">&nbsp;(You can restore configuration of this page to default by clicking this button)</span> </td>
      </tr>
    </tbody>
  </table>
  <br/>
</div>
<span id="span_info" style="display: none; color:#FF0000"></span>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
