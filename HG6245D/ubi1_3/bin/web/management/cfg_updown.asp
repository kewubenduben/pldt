<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/ajaxupload.3.2.js"></script>
<title>Config Backup</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("update", lang);

function initTranslation()
{
	var e = document.getElementById("cfg_download_prompt");
	e.innerHTML = _("cfg_download_prompt");
    e = document.getElementById("cfg_download");
	e.value = _("cfg_download");
	
	e = document.getElementById("cfg_upload_prompt");
	e.innerHTML = _("cfg_upload_prompt");
    e = document.getElementById("cfg_upload_title");
	e.innerHTML = _("cfg_upload_title");
    e = document.getElementById("cfg_uploadTips");
	e.innerHTML = _("cfg_uploadTips");
}
//cfg Import
function ajxUploadFile() {
	var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
	var uploadOption =
	{
		action: "/goform/cfg_upload", 
        onChange: function (file, ext) {
					if (ext && /^(config)$/.test(ext)) {
						$("#filepath").val(file);
                    } else {
                        alert(_("cfg_upload_fileIllegalAlert"));
						return false;
                    }
                },
        onSubmit: function (file, extension) {
                    $("#cfg_upload_info").text(_("cfg_upload_load") + file + " ..");
                },
        onComplete: function (file, response) {
            if (response == "success")
			{
				$("#cfg_upload_info").text(_("cfg_upload_complete") + " " + _("rebooting"));
				waitToLogin(ispNameCode, curUserType);
            }
            else $("#cfg_upload_info").text(_("cfg_upload_failed"));
        }
    };
	var oAjaxUpload = new AjaxUpload('#cfg_upload_import', uploadOption);
}  

function LoadFrame()
{ 
	initTranslation();
	ajxUploadFile();
	if (window.ActiveXObject)// IE
	{ 
		$("#filepath").hide();
	}
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<form method="post" name="down_cfgfile_fm" id="down_cfgfile_fm" action="/goform/cfg_backup">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="cfg_download_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" name="cfg_download" id="cfg_download" style="width:98px;" value="Config Backup">
        </td>
      </tr>
    </tbody>
  </table>
  <div id="cfg_download_info"></div>
</form>
<form method="post" enctype="multipart/form-data">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="cfg_upload_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" rowspan="2" id="cfg_upload_title" name="cfg_upload_title" align="left" width="25%">Update Config File</td>
        <td class="tabal_right"><input type="text" disabled="disabled" id="filepath" />
          <input type="file" name="binary" id="cfg_upload_import"/></td>
      </tr>
      <tr><td class="tabal_right"><span id="cfg_uploadTips" class="gray"></span></td></tr>
    </tbody>
  </table>
  <div id="cfg_upload_info"></div>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
