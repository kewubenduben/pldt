<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>WAN</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var pppoe_wansize_sync = '<% pppoe_wansize_sync(); %>';
var pppoe_wan_ruleSum;

var previousTR = null;
var http_request = getRequest();

function initTranslation()
{
	var e = document.getElementById("wan_prompt");
	e.innerHTML = _("wan_prompt");
	
	e = document.getElementById("WANListHead");
	e.innerHTML = _("WANListHead");
	e = document.getElementById("WAN_nameTitle");
	e.innerHTML = _("WAN_nameTitle");
	e = document.getElementById("WAN_VIDtitle");
	e.innerHTML = _("WAN_VIDtitle");
	
	e = document.getElementById("wPppoeUser");
	e.innerHTML = _("inet user");
	e = document.getElementById("wPppoePassword");
	e.innerHTML = _("inet password");
	e = document.getElementById("wPppoeCon_userTips");
	e.innerHTML = _("wPppoeCon_userTips");
	e = document.getElementById("wPppoeCon_pwdTips");
	e.innerHTML = _("wPppoeCon_pwdTips");

}

function LoadFrame()
{ 
	initTranslation();
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
	//add by wuxj, 20160829,PH X_GLOBE HGU customized
	if((ispName == 15) && (device_type == 1))	//PH X_GLOBE HGU customized
	{
		getElement("pppoe_username" ).maxLength = "63";
		getElement("pppoe_pwd" ).maxLength = "63";
		getElement("wPppoeCon_userTips" ).innerHTML = _("wPppoeCon_userTips_63");
		getElement("wPppoeCon_pwdTips" ).innerHTML = _("wPppoeCon_pwdTips_63");
	}
	
	pppoe_wan_ruleSum  = '<% getCfgGeneral(1, "wan_pppoe_num"); %>';

	if(pppoe_wan_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("wan_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function pppoeWanHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var pppoeWanRDONLY = http_request.responseText;
			if(pppoeWanRDONLY == "1")
			{
				getElement("vlan_id").disabled = 1;
				getElement("pppoe_username").disabled = 1;
				getElement("pppoe_pwd").disabled = 1;
				
				getElement("wApply").value = "Disconnect";
			}
			else
			{
				getElement("vlan_id").disabled = 0;
				getElement("pppoe_username").disabled = 0;
				getElement("pppoe_pwd").disabled = 0;
				
				getElement("wApply").value = "Connect";
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

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			setLineHighLight(previousTR, objTR);
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("vlan_id").value = getElement("wan_vid_pri_" + temp).innerHTML.split("/")[0];
			document.getElementById("pppoe_username").value = getElement("pppoe_username_" + temp).value;
			document.getElementById("pppoe_pwd").value = getElement("pppoe_pwd_" + temp).value;
			setLineHighLight(previousTR, objTR);

			var content = "curwanname=" + getElement("wan_name_" + temp).value;
			content = content + "&x-csrftoken=" + getCsrftoken();
			
			if (!http_request) {
				alert("Giving up :( \nCannot create an XMLHTTP instance!");
				return false;
			}
			
			http_request.onreadystatechange = pppoeWanHandler;
			http_request.open('POST', "/goform/pppoe_wan_diagnosis", true);
			http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			
			http_request.send(content);
		}	

		//标志当前编辑规则的id
		document.getElementById("curIndex").value = temp;
		getElement("curWanname").value = getElement("wan_name_" + temp).value;
	}	 
}

function VIDLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 4094)
		{
			return true;
		}
		else
		{
			alert(_("VID_IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("VID_IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkPPPModify()
{
	var modifyFlag = false;
	
	var curIndex = getElement("curIndex").value;
	var vlan_idNode = document.getElementById("vlan_id");
	var pppoeUserNode = document.getElementById("pppoe_username");
	var pppoePassNode = document.getElementById("pppoe_pwd");

	var oldVid = getElement("wan_vid_pri_" + curIndex).innerHTML.split("/")[0];
	var oldName = getElement("pppoe_username_" + curIndex).value;
	var oldPwd = getElement("pppoe_pwd_" + curIndex).value;
	if(vlan_idNode.value != oldVid)
	{
		modifyFlag = true;
	}
	else if(pppoeUserNode.value != oldName)
	{
		modifyFlag = true;
	}
	else if(pppoePassNode.value != oldPwd)
	{
		modifyFlag = true;
	}
	return modifyFlag;
}

function checkValue()
{
	var pppoeUserNode = document.getElementById("pppoe_username");
	var pppoePassNode = document.getElementById("pppoe_pwd");
	var vlan_idNode = document.getElementById("vlan_id");

	if(!VIDLegal(vlan_idNode))
	{
		return false;
	}
			
	if (!CheckNotNull(pppoeUserNode.value)) 
	{					
		alert(_("wPppoeCon_userNullAlert"));
		pppoeUserNode.value = pppoeUserNode.defaultValue;
		pppoeUserNode.focus();
		return false;
	}
	
	if (!CheckNotNull(pppoePassNode.value))
	{					
		alert(_("wPppoeCon_pwdNullAlert"));
		pppoePassNode.value = pppoePassNode.defaultValue;
		pppoePassNode.focus();
		return false;
	}
//始终提交
/*
	if(!checkPPPModify())
	{
		window.location.reload();
		return false;
	}
*/

	return true;
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wan_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td id="fw_ruleList"><table class="tabal_bg" id = "wan_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
          <tbody>
            <tr class="tabal_head">
              <td colspan="5" id="WANListHead">WAN List</td>
            </tr>
            <tr class="tabal_title">
              <td width="40%" align="center" id="WAN_nameTitle">WAN Name</td>
              <td width="25%" align="center" id="WAN_VIDtitle">VID/Priority</td>
              <td width="25%" align="center" id="WAN_Protocol_title">Protocol Type</td>
              <td width="8%" align="center" ></td>
              <td width="1%" align="center" ></td>
              <td width="1%" align="center" ></td>
            </tr>
            <% pppoe_wan_sync(  ) ; %>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm1" method="post" action="/goform/pppoe_wan_cfg" onSubmit="return checkValue()">
          <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr>
                        <td><table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                            <tbody>
                              <tr style="">
                                <td  class="tabal_left" width="25%" id="wan_vid_title">VLAN ID</td>
                                <td class="tabal_right" width="75%"><input name="vlan_id" id="vlan_id" size="5" maxlength=5 style="width: 150px;" type="text">
                                  <strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (1-4094)</span></td>
                              </tr>
                              <tr style="">
                                <td  class="tabal_left" width="25%"id="wPppoeUser" >Username</td>
                                <td class="tabal_right" width="75%"><input name="pppoe_username" id="pppoe_username" maxlength="31" size="31"  style="width: 150px;" type="text">
                                  <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips"></span></td>
                              </tr>
                              <tr style="">
                                <td  class="tabal_left" width="25%" id="wPppoePassword">Password</td>
                                <td class="tabal_right" width="75%"><input type="password" name="pppoe_pwd" id="pppoe_pwd" maxlength="31" size="31"  style="width: 150px;">
                                  <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips"></span></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
          <table class="tabal_button" width="100%">
            <tbody>
              <tr>
                <td width="25%"></td>
                <td class="tabal_submit"><input type="submit" value="Connect" name="wApply" id="wApply" class="submit">
                </td>
              </tr>
            </tbody>
          </table>
          <input type="hidden" name="curIndex" id="curIndex" value="0">
          <input type="hidden" name="curWanname" id="curWanname" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
<span id="span_info" style="display: none; color:#FF0000"></span>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
