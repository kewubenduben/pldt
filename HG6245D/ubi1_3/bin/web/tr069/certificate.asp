<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/ajaxupload.3.2.js"></script>
<title>Certificate Import</title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("tr069", lang);
 
/*-----------------------adapte funcion--------------------------*/
function initTranslation()
{
	var e = document.getElementById("certi_prompt");
	e.innerHTML = _("certi_prompt");
	
	e = document.getElementById("certi_title");
	e.innerHTML = _("certi_title");
	e = document.getElementById("certi_import");
	e.innerHTML = _("certi_import");
}
 
function DelFile(doc, hidPut) {  
    hidPut.value = "";  
    doc.innerHTML = "<input type=\"text\" disabled=\"disabled\" />";  
}

//Certificate Import
function ajxUploadFile() {
	var uploadOption =
	{
		action: "/goform/tr069_certi", 
        onChange: function (file, ext) {
//                    if (new RegExp(/(pem)|(crt)/i).test(ext)) {
					if (ext && /^(pem|crt)$/.test(ext)) { 						
                        $("#filepath").val(file);
                    } else {
                        alert(_("certi_fileIllegalAlert"));
						return false;
                    }
                    //$("#filepath").val(file);					
                },
        onSubmit: function (file, extension) {
                    $("#update_info").text(_("certi_load") + file + " ..");
                },
        onComplete: function (file, response) {
            if (response == "success") $("#update_info").text(_("certi_complete"));
            else $("#update_info").text(response);
        }
    };
	var oAjaxUpload = new AjaxUpload('#certi_import', uploadOption);
/*
    $("#up").click(function ()
    {
        oAjaxUpload.submit();
    });   
*/
}  
function LoadFrame()
{ 
	initTranslation();
	ajxUploadFile();
}
</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<form method="post" enctype="multipart/form-data">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="certi_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td id="certi_title">TR069 Certificate Import</td>
      </tr>
      <tr>
        <td class="tabal_right"><input type="text" disabled="disabled" id="filepath" />
          <!--input type="button" id="certi_import" value="Import" /-->
          <input type="file" name="binary" id="certi_import"/></td>
      </tr>
    </tbody>
  </table>
  <div id="update_info"></div>
</form>
</body>
</html>
