<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DDNS信息</title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ddns", lang);

var ddns_state_sync = '<% ddns_state_sync(); %>';

function initTranslation()
{
	var e = document.getElementById("ddns_state_prompt");
	e.innerHTML = _("ddns_state_prompt");

	e = document.getElementById("ddns_infoTitle");
	e.innerHTML = _("ddns_infoTitle");
	e = document.getElementById("ddns_updateTitle");
	e.innerHTML = _("ddns_updateTitle");
}

function initValue()
{
	initTranslation();
	var ddns_update_info = '<% getCfgGeneral(1, "ddns_update_info"); %>';
	var updateInfo;
	switch(parseInt(ddns_update_info))
	{
		case 0:
			updateInfo = _("ddns_init");
			break;
		case 1:
			updateInfo = _("ddns_modify");
			break;
		case 2:
			updateInfo = _("ddns_success");
			break;
		case 3:
			updateInfo = _("ddns_param_error");
			break;
		case 4:
			updateInfo = _("ddns_cfgfile_error");
			break;
		case 5:
			updateInfo = _("ddns_ifname_error");
			break;
		case 6:
			updateInfo = _("ddns_devIP_error");
			break;
		case 7:
			updateInfo = _("ddns_connect_error");
			break;
		case 8:
			updateInfo = _("ddns_response_error");
			break;
		case 9:
			updateInfo = _("ddns_noResp_error");
			break;
		case 10:
			updateInfo = _("ddns_memory_error");
			break;
		default:
			updateInfo = _("ddns_init");
			break;			
	}
	getElement("ddns_updateInfo").innerHTML = updateInfo;
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="ddns_state_prompt" style="padding-left: 10px;" class="title_01" width="100%">你在本页可以查看DDNS信息。</td>
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
      <tr class="tabal_head">
        <td colspan="2" id="ddns_infoTitle">DDNS信息</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ddns_updateTitle">更新信息</td>
        <td class="tabal_right" id="ddns_updateInfo"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
