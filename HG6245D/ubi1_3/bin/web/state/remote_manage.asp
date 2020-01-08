<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Remote Manage</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var remote_manage_Sync = '<% remote_manage_Sync(); %>';

function initTranslation()
{
	var e = document.getElementById("remote_manage_prompt");
	e.innerHTML = _("remote_manage_prompt");

	e = document.getElementById("ur_status_title");
	e.innerHTML = _("ur_status_title");
	e = document.getElementById("acs_status_title");
	e.innerHTML = _("acs_status_title");
	e = document.getElementById("service_status_title");
	e.innerHTML = _("service_status_title");		
}

function initValue()
{
	initTranslation();

	var ur_status_node = getElement("ur_status");
	var ur_status_value = '<% getCfgGeneral(1, "ur_status"); %>';	
	if(parseInt(ur_status_value))
	{
		ur_status_node.innerHTML = "Not reported";
	}
	else
	{
		ur_status_node.innerHTML = "Reported";
	}
	
	var acs_status_node = document.getElementById("acs_status");
	var acs_status_value = '<% getCfgGeneral(1, "acs_status"); %>';
	switch(parseInt(acs_status_value))
	{
		case 2:
			acs_status_node.innerHTML = "Connected";
			break;
		case 0,1:
			acs_status_node.innerHTML = "No remote connection request";
			break;
		default:
			acs_status_node.innerHTML = "--";
			break;
	}

	var service_status_node = document.getElementById("service_status");
	var service_status_value = '<% getCfgGeneral(1, "service_status"); %>';
	if(parseInt(service_status_value))
	{
		service_status_node.innerHTML = "Applied";
	}else
	{	
		service_status_node.innerHTML = "Remote service configration not applied";
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
                <td id="remote_manage_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" width="25%" id="ur_status_title">Unsolicited Report Status</td>
        <td class="tabal_right" id = "ur_status"></td>
      </tr>
      <tr id = "hardver_tr">
        <td class="tabal_left" width="25%" id="acs_status_title">ACS Connection Status</td>
        <td class="tabal_right" id = "acs_status"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="service_status_title">Service Provisioning Status</td>
        <td class="tabal_right" id = "service_status"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
