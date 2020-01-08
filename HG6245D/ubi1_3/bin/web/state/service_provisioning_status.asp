<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Service Provisioning Status</title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var service_provi_status_sync = '<% service_provi_status_sync(); %>';
function initTranslation()
{
	var e = document.getElementById("service_provisioning_prompt");
	e.innerHTML = _("service_provisioning_prompt");

	e = document.getElementById("os_status");
	e.innerHTML = _("os_status");
	e = document.getElementById("osc_status");
	e.innerHTML = _("osc_status");
	e = document.getElementById("ec_status");
	e.innerHTML = _("ec_status");
	e = document.getElementById("ar_status");
	e.innerHTML = _("ar_status");
}

function initValue()
{
//	initTranslation();

	var ont_regstatus_value = '<% getCfgGeneral(1, "ont_registration_status"); %>';
	var ont_regstatus_value_node = document.getElementById("ont_regstatus_value");	
	if(ont_regstatus_value == "O5")
	{
		ont_regstatus_value_node.innerHTML = "The ONT is registered with the OLT.";
	}
	else
	{
		ont_regstatus_value_node.innerHTML = "The ONT is registering with the OLT. Please wait.";
	}

	var olt_config_status_value = '<% getCfgGeneral(1, "olt_service_config_status"); %>';
	var olt_config_status_value_node= document.getElementById("olt_config_status_value");
	if(olt_config_status_value == "0")
	{
		olt_config_status_value_node.innerHTML = "--";
	}
	else
	{
		olt_config_status_value_node.innerHTML = "OLT service configured";
	}

	var acs_regstatus_value = '<% getCfgGeneral(1, "acs_registration_status"); %>';
	var acs_regstatus_value_node= document.getElementById("acs_regstatus_value");
	if(acs_regstatus_value == "0")
	{
		acs_regstatus_value_node.innerHTML = "--";
	}
	else
	{
		acs_regstatus_value_node.innerHTML = "Already registered to ACS";
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="remote_manage" id="remote_manage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="service_provisioning_prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can query the service provisioning status.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="25%" id="os_status">ONT Registration Status</td>
        <td class="tabal_right" id="ont_regstatus_value"></td>  
      </tr>
      <tr id = "hardver_tr">
        <td class="tabal_left" width="25%" id="osc_status">OLT Service Configuration Status</td>
        <td class="tabal_right" id="olt_config_status_value"></td> 
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ec_status">EMS Configuration Status</td>
        <td class="tabal_right">--</td>
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="ar_status">ACS Registration Status</td>
        <td class="tabal_right" id="acs_regstatus_value"></td> 
      </tr>
    </tbody>
  </table>
  <table id="tb_refresh" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left"><input type="reset" value="Refresh" class="submit" onClick="window.location.reload()"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
