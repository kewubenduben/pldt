<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Route QOS Enable</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("route_qos", lang);

//get init value from driver
var QosEnableSync = '<% QosEnableSync(); %>';

function initTranslation()
{
	var e = document.getElementById("route_qos_prompt");
	e.innerHTML = _("route_qos_prompt");
    e = document.getElementById("route_qos_title");
	e.innerHTML = _("route_qos_title");

	e = document.getElementById("qos_enable_title");
	e.innerHTML = _("qos_c_enable");
	e = document.getElementById("qos_disable");
	e.innerHTML = _("qos_c_disable");

	e = document.getElementById("pps_apply");
	e.value = _("pps_apply");
	e = document.getElementById("pps_cancel");
	e.value = _("pps_cancel");		
}

function initValue()
{
	initTranslation();
	var qosenable = document.getElementsByName("qos_enable");	
	for(var i = 0;i<qosenable.length;i++)
	{
		if(qosenable[i].value == '<% getCfgGeneral(1, "qos_enable"); %>')
		{
			qosenable[i].checked = true;
			break;
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method=post name="route_qos_basic" action="/goform/setQosEnable">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="route_qos_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="route_qos_title" align="left" width="25%"></td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="qos_enable" type="radio">
          <font id="qos_enable_title">Enable</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="qos_enable" type="radio">
          <font id="qos_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>

  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="pps_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="pps_cancel" onClick="window.location.reload()">
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

