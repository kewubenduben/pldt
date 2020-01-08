<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css" />
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<title>LAN ACL</title>
<script language="JavaScript" type="text/javascript">
var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var aclsize = '<% lan_acl_multipro_size_sync(); %>';

function initTranslation()
{
	var e = document.getElementById("lanAclPrompt");
	e.innerHTML = _("lanAclPrompt");

	e = document.getElementById("lan_acl_ftp_enable_title");
	e.innerHTML = _("lan_acl_ftp_enable_title");
	e = document.getElementById("lan_acl_http_enable_title");
	e.innerHTML = _("lan_acl_http_enable_title");
	e = document.getElementById("lan_acl_telnet_enable_title");
	e.innerHTML = _("lan_acl_telnet_enable_title");

	e = document.getElementById("acl_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("acl_cancel");
	e.value = _("firewall_cancel");
}

function LoadFrame()
{
	initTranslation();

	var _acl_enable_http = '<% getCfgGeneral(1, "acl_enable_http"); %>';
	var _acl_enable_ftp = '<% getCfgGeneral(1, "acl_enable_ftp"); %>';
	var _acl_enable_telnet = '<% getCfgGeneral(1, "acl_enable_telnet"); %>';

	if(_acl_enable_http == "1") $("input[name='acl_enable_http']").attr("checked", true);
	if(_acl_enable_ftp == "1") $("input[name='acl_enable_ftp']").attr("checked", true);
	if(_acl_enable_telnet == "1") $("input[name='acl_enable_telnet']").attr("checked", true);
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
              <td id="lanAclPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
  </tbody>
</table>
<form id="ConfigForm" method="post" action="/goform/lan_acl_multipro_cfg">
  <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="5">LAN Service</td>
      </tr>
      <tr>
        <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td><table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                    <tbody>
                      <tr>
                        <td id="lan_acl_http_enable_title" class="tabal_left" width="50%">Enable the LAN-Side PC to access the ONT through HTTP</td>
                        <td class="tabal_right" width="50%"><input type="checkbox" name="acl_enable_http" value="1">
                        </td>
                      </tr>
                      <tr>
                        <td id="lan_acl_ftp_enable_title" class="tabal_left" width="50%">Enable the LAN-Side PC to access the ONT through FTP</td>
                        <td class="tabal_right" width="50%"><input type="checkbox" name="acl_enable_ftp" value="1">
                        </td>
                      </tr>
                      <tr>
                        <td id="lan_acl_telnet_enable_title" class="tabal_left" width="50%">Enable the LAN-Side PC to access the ONT through Telnet</td>
                        <td class="tabal_right" width="50%"><input type="checkbox" name="acl_enable_telnet" value="1">
                        </td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
    </tbody>
  </table>
  <table class="tabal_button" width="100%">
    <tbody>
      <tr>
        <td width="25%"></td>
        <td class="tabal_submit"><input type="submit" id="acl_apply" class="submit">
          <input type="reset" id="acl_cancel" class="submit" onClick="window.location.reload();">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</td>
</tr>
</tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
