<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>IPSec Enable</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ipsec", lang);

//get init value from driver
var ipsecSync = '<% IpsecEnableSync(); %>';

function initTranslation()
{
	var e = document.getElementById("ipsecEnable_title");
	e.innerHTML = _("IPSECEnable_title");
    e = document.getElementById("ipsec_prompt");
	e.innerHTML = _("IPSEC_prompt");

	e = document.getElementById("ipsec_enable");
	e.innerHTML = _("IPSEC_enable");
	e = document.getElementById("ipsec_disable");
	e.innerHTML = _("IPSEC_disable");

	e = document.getElementById("ipsecEnableApply");
	e.value = _("IPSEC basic apply");
	e = document.getElementById("ipsecEnableCancel");
	e.value = _("IPSEC basic cancel");
}

function initValue()
{
	initTranslation();
	var ipsecEnable = document.getElementsByName("ipsecEnable");	
	for(var i = 0;i<ipsecEnable.length;i++)
	{
		if(ipsecEnable[i].value == '<% getCfgGeneral(1, "ipsecEnable"); %>')
		{
			ipsecEnable[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_ipsec_enable" action="/goform/setIpsecEnable">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="ipsec_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="ipsecEnable_title" align="left" width="25%">IPSec</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="ipsecEnable" type="radio">
          <font id="ipsec_enable"></font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="ipsecEnable" type="radio">
          <font id="ipsec_disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;</strong><span class="gray" id="ipsec_portocol"></span> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="ipsecEnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="ipsecEnableCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>

