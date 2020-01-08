<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>VoIP WAN Setting</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ddns", lang);

var voip_wan_sync = '<% voip_wan_sync(); %>';
var http_request = getRequest();

function initTranslation()
{
}

function voipWanHandler()
{
	if (http_request.readyState == 4)									//the operation is completed
	{
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var voipWanRDONLY = http_request.responseText;
			if(voipWanRDONLY == "1")
			{
				getElement("wan_vid").disabled = 1;
				getElement("staticIp").disabled = 1;
				getElement("staticNetmask").disabled = 1;
				getElement("staticGateway").disabled = 1;
				
				getElement("wApply").disabled = 1;
				getElement("wCancel").disabled = 1;
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

function initValue()
{
//	initTranslation();
	var content = "voip_status_diagnosis";
	content = content + "&x-csrftoken=" + getCsrftoken();
	
	if (!http_request) {
		alert("Giving up :( \nCannot create an XMLHTTP instance!");
		return false;
	}
	
	http_request.onreadystatechange = voipWanHandler;
	http_request.open('POST', "/goform/voip_status_diagnosis", true);
	http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	
	http_request.send(content);
}

function checkVoipWanModify()
{
	var modifyFlag = false;
	
	var vlan_idNode = getElement("wan_vid");
	var ipNode = getElement("staticIp");
	var maskNode = getElement("staticNetmask");
	var gwNode = getElement("staticGateway");

	var oldVid = "<% getCfgGeneral(1, 'wan_voip_vid'); %>";
	var oldIP = "<% getCfgGeneral(1, 'wan_static_ip'); %>";
	var oldMask = "<% getCfgGeneral(1, 'wan_static_mask'); %>";
	var oldGw = "<% getCfgGeneral(1, 'wan_static_gw'); %>";
	if(vlan_idNode.value != oldVid)
	{
		modifyFlag = true;
	}
	else if(ipNode.value != oldIP)
	{
		modifyFlag = true;
	}
	else if(maskNode.value != oldMask)
	{
		modifyFlag = true;
	}
	else if(gwNode.value != oldGw)
	{
		modifyFlag = true;
	}
	return modifyFlag;
}

function CheckValue()
{	
	var wan_vidNode = getElement("wan_vid");
	if(!VIDLegal(wan_vidNode))
	{
		return false;
	}

	var staticIpNode = getElement("staticIp");
	if (!checkIpAddr(staticIpNode, false))
		return false;
	
	var staticNetmaskNode = getElement("staticNetmask");
	if (!checkIpAddr(staticNetmaskNode, true))
		return false;
	
	var staticGatewayNode = getElement("staticGateway");
	if (staticGatewayNode.value != "")
		if (!checkIpAddr(staticGatewayNode, false))
			return false;
	
	if(!checkVoipWanModify())
	{
		window.location.reload();
		return false;
	}
	return true;
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

function checkIpAddr(field, ismask)
{
	if (!CheckNotNull(field.value)) {
		alert(_("wan_IPempty"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}

	if (ismask) {
		if(!validateMask(field.value))
		{
			alert(_("wan_mask_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}		
	}
	else {
		if (!validateIP(field.value))
		{
			alert(_("wan_ip_illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	return true;
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" action="/goform/voip_static_cfg" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="voip_static_prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can configuration the parameters of VoIP WAN.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_head">VoIP WAN Settings</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_vlan">
        <td id="wan_vid_title" class="tabal_left" width="25%">VLAN ID</td>
        <td class="tabal_right" width="75%"><input name="wan_vid" maxlength=5 style="width: 200px;" type="text" value="<% getCfgGeneral(1, 'wan_voip_vid'); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (1-4094)</span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wStaticIp">IP Address</td>
        <td class="tabal_right"><input name="staticIp" maxlength=15 size=33 value="<% getCfgGeneral(1, 'wan_static_ip'); %>">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticNetmask">Subnet Mask</td>
        <td class="tabal_right"><input name="staticNetmask" maxlength=15 size=33 value="<% getCfgGeneral(1, 'wan_static_mask'); %>">
          <strong style="color:#FF0033">*</strong></td>
      </tr>
      <tr>
        <td class="tabal_left" id="wStaticGateway">Default Gateway</td>
        <td class="tabal_right"><input name="staticGateway" maxlength=15 size=33 value="<% getCfgGeneral(1, 'wan_static_gw'); %>">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="wApply">
          <input class="submit" type="reset" value="Cancel" id="wCancel"onclick="window.location.reload();" >
        </td>
      </tr>
    </tbody>
  </table>
</form>
<span id="span_info" style="display: none; color:#FF0000"></span>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
