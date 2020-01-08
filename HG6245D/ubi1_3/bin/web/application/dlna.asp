<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>DLNA</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("upnp", lang);

//get init value from driver
var set_dlna_sync = '<% set_dlna_sync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("dlna_prompt");
	e.innerHTML = _("dlna_prompt");

	e = document.getElementById("dlna_enable");
	e.innerHTML = _("upnp_enable");
	e = document.getElementById("dlna_disable");
	e.innerHTML = _("upnp_disable");

	e = document.getElementById("dlnaEnable_title");
	e.innerHTML = _("dlnaEnable_title");
	e = document.getElementById("dlna_pathTitle");
	e.innerHTML = _("dlna_pathTitle");
	e = document.getElementById("usb_pathTitle");
	e.innerHTML = _("usb_pathTitle");
	

	e = document.getElementById("upnpEnableApply");
	e.value = _("upnpEnableApply");
	e = document.getElementById("upnpEnableCancel");
	e.value = _("upnpEnableCancel");
}

function CheckValue()
{	
	var dlna_pathnode = document.getElementById("dlna_path");
    var dlnaEnable = document.getElementsByName("dlnaEnable");


	if (!CheckNotNull(dlna_pathnode.value)) 
	{					
		alert(_("dlna_path_noalert"));
		dlna_pathnode.value = dlna_pathnode.defaultValue;
		dlna_pathnode.focus();
		return false;
	}

	
	return true;
}

function initValue()
{
	initTranslation();

	var dlnaEnable = '<% getCfgGeneral(1, "dlnaEnable"); %>';

	//modify by wuxj, 20170614, all version of pldt dlna read only
//	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
//	if(DEV_TYPE == '04F4G' && ispName == '8')	//pldt f4g
	if(ispName == '8')	//pldt
	{
		setDisplay('tr_usb_path', 'none');
		setDisplay('tr_dlna_path', 'none');
		setDisplay('tb_submit', 'none');
		getElement('dlnaEnable').disabled = true;
		dlnaEnable = 0;
	}
	var dlnaEnableNode = document.getElementsByName("dlnaEnable");	
	for(var i = 0;i<dlnaEnableNode.length;i++)
	{
		if(dlnaEnableNode[i].value == dlnaEnable)
		{
			dlnaEnableNode[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="upnp_enable_form" action="/goform/set_dlna_cfg" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="dlna_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id='tr_usb_path'>
        <td class="tabal_left" width="25%" id="usb_pathTitle"><!--USB Partition--></td>
        <td class="tabal_right"><% getCfgGeneral(1, "usb_path"); %>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="dlnaEnable_title" align="left"><!--DLNA Service--></td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="dlnaEnable" type="radio">
          <font id="dlna_enable">
          <!--启用-->
          </font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="dlnaEnable" type="radio">
          <font id="dlna_disable">
          <!--禁用-->
          </font></td>
      </tr>
      <tr id='tr_dlna_path'>
        <td class="tabal_left" width="25%" id="dlna_pathTitle"><!--Media Shared Directory--></td>
        <td class="tabal_right"><input name="dlna_path" id="dlna_path" size="32" maxlength="256" type="text" value="<% getCfgGeneral(1, "dlna_path"); %>">
        </td>
      </tr>
  </table>
  <table id='tb_submit' class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="upnpEnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="upnpEnableCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
