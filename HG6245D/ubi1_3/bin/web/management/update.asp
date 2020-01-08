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
<title>Update</title>
<style type="text/css"> 
#progress
{
	height: 24px;
	width: 200px;
	border: none;
}
.inner-progress 
{
	background: #2C5EA4;
}
 </style>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("update", lang);

var updateSync = '<% updateSync(); %>';
var free_mem_flag = '<% getCfgGeneral(1, "free_mem_flag"); %>';

function initTranslation()
{
	var e = document.getElementById("update_prompt");
	e.innerHTML = _("update_prompt");
	
	e = document.getElementById("update_chooseFile");
	e.innerHTML = _("update_chooseFile");
	e = document.getElementById("update_info");
	e.innerHTML = _("update_info");
	e = document.getElementById("update_back_a");
	e.innerHTML = _("update_back");
}

function LoadFrame()
{ 
	initTranslation();
	setDisplay("div_update","");
	setDisplay("div_info","none");
} 
 
/*-----------------------adapte funcion--------------------------*/

$(function()
{  
	var complete = 0; 
	var interval; 
	var purWidth = parseInt($("#progress").css("width"))/100; 
	   	
	new AjaxUpload("#fileButton",{  
    action:"/goform/upldForm",  
    autoSubmit:true,  
    name:"binary",  
    onSubmit :function(file, ext){
    			if (!(ext && /^(bin|img)$/.test(ext))) {  
	                alert(_("update_format_illegal"));
	                return false;
    			}
				setDisplay("div_update","none");
				$("#div_info").show();
				interval = window.setInterval(function(){
					if(complete < 100){
						$("#progress").show();
						complete = complete + 1;
						$(".inner-progress").css("width", complete * purWidth);
					}
					else {
						complete = 0;
					}
				},1000);
        },

    onComplete:function(file, response){                        
		window.clearInterval(interval);
		if(response == "success")
		{
			$("#update_info").text(_("update_success") + _("update_restart"));			
		}
		else if(response == "Failed to write file to flash!")
		{
			$("#update_info").text(_("update_fail") + _("update_api_error"));
		}
		else if(response == "Failed! Space isn't enough!")
		{
			$("#update_info").text(_("update_space_not_enough"));
		}
		else
		{
			$("#update_info").text(response);
		}
		$(".inner-progress").css("width", 100 * purWidth);
               
		$("#update_back").show(); 
		
		var alertinfo;
		var confirminfo;
		if(response == "success")
		{
			alertinfo = _("update_success") + _("update_restartAlert");
			confirminfo = _("update_success") + _("update_restartConfirm");			
		}
		else
		{
			alertinfo = _("update_fail") + _("update_restartAlert");
			confirminfo = _("update_fail") + _("update_restartConfirm");
		}
		//modify by wuxj, 20180913, reboot whatever. from qiankai
//		if(parseInt(free_mem_flag) == 1)
		{
			alert(alertinfo);
			parent.location="/goform/reboot" + "?csrftoken=" + getCsrftoken();
		}
/*		else if(confirm(confirminfo))
		{
			parent.location="/goform/reboot" + "?csrftoken=" + getCsrftoken();
		}*/
    }  
   });  
}); 

</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<form method="post" action="#" enctype="multipart/form-data">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="update_prompt" class="title_01" style="padding-left: 10px;" width="100%"> </td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <div id="div_update">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr1" name="tr1">
        <td class="tabal_left" id="update_chooseFile" name="update_chooseFile" align="left" width="25%">Choose file and Upgrade</td>
        <td class="tabal_right" id="td1_2" name="td1_2"><input type="file" name="binary" id="fileButton"/></td>
      </tr>
    </tbody>
  </table>
  </div>
  <div id="div_info" style="display: none;">
    <div id="update_info">Upgrades will take time, please be patient.</div>
    <div id="progress" style="display: none;">
      <div class="inner-progress">&nbsp;</div>
    </div>
    <div id="update_back" style="display: none;"><a id="update_back_a" href="update.asp">Back</a></div>
  </div>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
