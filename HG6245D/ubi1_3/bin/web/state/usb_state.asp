<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Lan State</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var setLanstateSync = '<% setLanstateSync(); %>';

function initTranslation()
{
	var e = document.getElementById("usbstate_prompt");
	e.innerHTML = _("usbstate_prompt");

	e = document.getElementById("usb_state_head");
	e.innerHTML = _("usb_state_head");
	e = document.getElementById("usb_interface_title");
	e.innerHTML = _("usb_interface_title");
}

function initValue()
{
	initTranslation();
	var usb_sum = '<% get_usb_sum(); %>';
	if(usb_sum != 0)
	{
		getElement("usb_state").innerHTML = _("usb_using");
	}
	else
	{
		getElement("usb_state").innerHTML = _("usb_idle");
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="usbstate_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
      <td colspan="2" id="usb_state_head">USB State</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="usb_interface_title">USB Interface</td>
      <td class="tabal_right" id="usb_state"></td>
    </tr>
  </tbody>
</table>
</body>
</html>
