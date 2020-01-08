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
<title>QoS Enable</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("vpn_enable", lang);

//get init value from driver
var setQOSenbleSync = '<% setQOSenbleSync(); %>';

function initTranslation()
{
	e = document.getElementById("vpn_enable");
	e.innerHTML = _("VPN_enable");
	e = document.getElementById("vpn_disable");
	e.innerHTML = _("VPN_disable");

	e = document.getElementById("vpnEnableApply");
	e.value = _("VPN basic apply");
	e = document.getElementById("vpnEnableCancel");
	e.value = _("VPN basic cancel");
	
	e = document.getElementById("tr069_qos_prompt");
	e.value = _("Tr069 qos prompt");
	e = document.getElementById("tr069_QoS_Enable_title");
	e.value = _("Tr069 qoS enable title");	
}

function initValue()
{
	initTranslation();
	var tr69_qos = document.getElementsByName("tr69_qos");	
	for(var i = 0;i<tr69_qos.length;i++)
	{
		if(tr69_qos[i].value == '<% getCfgGeneral(1, "tr69_qos"); %>')
		{
			tr69_qos[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">

<form method="post" name="fm_vpn_enable" action="/goform/setQOSenble">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="tr069_qos_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" id="tr069_QoS_Enable_title" align="left" width="25%"></td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="tr69_qos" type="radio">
          <font id="vpn_enable"></font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="tr69_qos" type="radio">
          <font id="vpn_disable"></font></td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="vpnEnableApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="vpnEnableCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>


