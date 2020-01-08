<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<title>Restore</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("restore", lang);//设置本页面读取的配置文件名

//loadpage
function LoadFrame()
{ 
	initTranslation();	
		
//	makeRequest("/goform/getRestoreSync", "n/a", dealRestoreFailedHandle);
	
	/*处理读写失败提示*/
// 	dealRestoreFailedHandle();
}

/*-----------------------adapte funcion--------------------------*/
function RestoreConfirm()
{
	/*moify by郭心悦，20170115，原因:越南HGU版本菜单Restore名称改为Reset*/
	if(ispNameCode == '16')//越南HGU
	{
		if(confirm(_("reset_confirm")))
		makeRequest("/goform/restoreSettings", "n/a", restoreHandler);
	}
	else
	{
			
	//	return confirm("如果您恢复了默认配置，您的私有配置将会丢失。\n确定要恢复默认配置吗?") ;
		if(confirm(_("restore_confirm")))
	//		parent.location="/goform/restoreSettings";
		makeRequest("/goform/restoreSettings", "n/a", restoreHandler);
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
				if(ispNameCode == '16')//越南HGU
				{
					getElement("div_info").innerHTML = _("resetSuccessInfo") + _("rebooting");
				}
				else
				{
					getElement("div_info").innerHTML = _("restoreSuccessInfo") + _("rebooting");
				}
				waitToLogin(ispNameCode, curUserType);
			}
			else
			{
				getElement("div_rebootingHead").innerHTML = _("div_rebootingHead");
				if(ispNameCode == '16')//越南HGU
				{
					getElement("div_info").innerHTML = _("resetFailedInfo") + _("rebooting");
				}
				else
				{
					getElement("div_info").innerHTML = _("restoreFailedInfo") + _("rebooting");
				}		
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
	/*moify by郭心悦，20170115，原因:越南HGU版本菜单Restore名称改为Reset*/
	if(ispNameCode == '16')//越南HGU
	{
		var e = document.getElementById("restore_prompt");
		e.innerHTML = _("reset_prompt");

		e = document.getElementById("restore_apply");
		e.value = _("reset_apply");
	}
	else
	{
		var e = document.getElementById("restore_prompt");
		e.innerHTML = _("restore_prompt");

		e = document.getElementById("restore_apply");
		e.value = _("restore_apply");
	}
}

/*****************************************************************************
 * 函 数 名  : dealRestoreFailedHandle
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年5月30日
 * 函数功能  : 用于读写设备数据失败时结果提示
 * 输入参数  : 无
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function dealRestoreFailedHandle(http_request)
{
	var restoreSetFailedID;
	var restoreSet;
	if (http_request.readyState == 4) 
	{
		if (http_request.status == 200) 
		{			
			var responseArray = http_request.responseText.split("\r");
			
			restoreSet = responseArray[0];
			restoreSetFailedID = responseArray[1];

			/*获取处理失败的参数节点*/
			var infoDom = document.getElementById("restoreFailedInfo");
			if(restoreSetFailedID != "")
			{
				/*提示处理失败*/
				infoDom.style.display = style_display_on();
				infoDom.style.fontColor = "RED";
				if(ispNameCode == '16')//越南HGU
				{
					infoDom.innerHTML = restoreSetFailedID + _("resetFailedInfo");
				}
				else
				{
					infoDom.innerHTML = restoreSetFailedID + _("restoreFailedInfo");
				}
				
				/*再次点击恢复按钮后，span隐藏*/
				var submitDom = document.getElementById("restore_apply");
				submitDom.onfocus = function()
								    	{
											infoDom.style.display = "none";
								   		}
			}
			else if(restoreSet == "2")
			{
				if(ispNameCode == '16')//越南HGU
				{
					alert(_("resetSuccessInfo"));
				}
				else
				{
					alert(_("restoreSuccessInfo"));
				}
				infoDom.style.display = "none";
			}			
		}
		else 
		{
			//alert('There was a problem with the request.');
			//alert(_("restorerequestproblem"));
		}
	}	
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
              <td id="restore_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
    <input id="restore_apply" class="submit" style="width: 98px;" value="Restore" type="button" onClick="RestoreConfirm()">
  </div>
  <div id="div_rebootingHead" class="div_rebootingHead"></div>
  <br>
  <div id="div_info"></div>
  <div><span id="restoreFailedInfo"></span></div>
</div>
</body>
</html>
