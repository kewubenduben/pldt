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
Butterlate.setTextDomain("restore", lang);//���ñ�ҳ���ȡ�������ļ���

//loadpage
function LoadFrame()
{ 
	initTranslation();	
		
//	makeRequest("/goform/getRestoreSync", "n/a", dealRestoreFailedHandle);
	
	/*�����дʧ����ʾ*/
// 	dealRestoreFailedHandle();
}

/*-----------------------adapte funcion--------------------------*/
function RestoreConfirm()
{
	/*moify by�����ã�20170115��ԭ��:Խ��HGU�汾�˵�Restore���Ƹ�ΪReset*/
	if(ispNameCode == '16')//Խ��HGU
	{
		if(confirm(_("reset_confirm")))
		makeRequest("/goform/restoreSettings", "n/a", restoreHandler);
	}
	else
	{
			
	//	return confirm("������ָ���Ĭ�����ã�����˽�����ý��ᶪʧ��\nȷ��Ҫ�ָ�Ĭ��������?") ;
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
				if(ispNameCode == '16')//Խ��HGU
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
				if(ispNameCode == '16')//Խ��HGU
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
	/*moify by�����ã�20170115��ԭ��:Խ��HGU�汾�˵�Restore���Ƹ�ΪReset*/
	if(ispNameCode == '16')//Խ��HGU
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
 * �� �� ��  : dealRestoreFailedHandle
 * �� �� ��  : ��С��
 * ��������  : 2011��5��30��
 * ��������  : ���ڶ�д�豸����ʧ��ʱ�����ʾ
 * �������  : ��
 * �������  : ��
 * �� �� ֵ  : 
 * ���ù�ϵ  : 
 * ��    ��  : 

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

			/*��ȡ����ʧ�ܵĲ����ڵ�*/
			var infoDom = document.getElementById("restoreFailedInfo");
			if(restoreSetFailedID != "")
			{
				/*��ʾ����ʧ��*/
				infoDom.style.display = style_display_on();
				infoDom.style.fontColor = "RED";
				if(ispNameCode == '16')//Խ��HGU
				{
					infoDom.innerHTML = restoreSetFailedID + _("resetFailedInfo");
				}
				else
				{
					infoDom.innerHTML = restoreSetFailedID + _("restoreFailedInfo");
				}
				
				/*�ٴε���ָ���ť��span����*/
				var submitDom = document.getElementById("restore_apply");
				submitDom.onfocus = function()
								    	{
											infoDom.style.display = "none";
								   		}
			}
			else if(restoreSet == "2")
			{
				if(ispNameCode == '16')//Խ��HGU
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
