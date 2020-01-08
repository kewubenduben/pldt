<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>LAN MAC Limit</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var lan_mac_limit_sync = '<% lan_mac_limit_sync(); %>';

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var G10_LAN_FLAG = '<% getCfgGeneral(1, "G10_LAN_FLAG"); %>';

function initTranslation()
{
	var e = document.getElementById("lan_mac_prompt");
	e.innerHTML = _("lan_mac_prompt");

	for(var i = 1; i <= parseInt(lan_port_num); i++)
	{
		e = document.getElementById("lan" + i + "_mac_limit_title");
		e.innerHTML = "LAN " + i + _("max_mac_title");
	}
	if(parseInt(G10_LAN_FLAG) == 1)
	{
		e = document.getElementById("10glan_mac_limit_title");
		e.innerHTML = "10G LAN" + _("max_mac_title");
	}

	e = document.getElementById("lanMacLinit_apply");
	e.value = _("inet apply");
	e = document.getElementById("lanMacLinit_cancel");
	e.value = _("inet cancel");
}

function initValue()
{
//	initTranslation();

	if(lan_port_num > 1)
	{
		setDisplay("tr_lan2", "");
	}
	if(lan_port_num > 2)
	{
		setDisplay("tr_lan3", "");
	}
	if(lan_port_num > 3)
	{
		setDisplay("tr_lan4", "");
	}
	if(parseInt(G10_LAN_FLAG) == 1)
	{
		setDisplay("tr_10glan", "");
	}

}

function CheckValue()
{
	var lan1Num = getElement('lan1_max_mac');
	if(!checkNumberLegal(lan1Num, 0, 16))
	{		
		alert(_("lanMacLimitIllegalAlert"));
		return false;
	}
	var lan2Num = getElement('lan2_max_mac');
	if(!checkNumberLegal(lan2Num, 0, 16))
	{		
		alert(_("lanMacLimitIllegalAlert"));
		return false;
	}
	var lan3Num = getElement('lan3_max_mac');
	if(!checkNumberLegal(lan3Num, 0, 16))
	{		
		alert(_("lanMacLimitIllegalAlert"));
		return false;
	}
	var lan4Num = getElement('lan4_max_mac');
	if(!checkNumberLegal(lan4Num, 0, 16))
	{		
		alert(_("lanMacLimitIllegalAlert"));
		return false;
	}

	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="lan_mac_form" action="/goform/lan_mac_limit" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="lan_mac_prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can config the maximum number of MAC connections for the device and the maximum number of MAC connections for each LAN port.</td>
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
      <!--tr>
        <td width="24%" class="tabal_left" colspan="2" id="onu_mac_limit_title">ONU MAX. MAC Num</td>
        <td class="tabal_right" colspan="2"><input name="onu_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "onuMaxMac"); %>' style="width:230px"/>
          <span class="gray">(0-64)</span> </td>
      </tr-->
      <tr>
        <td width="25%" class="tabal_left" id="lan1_mac_limit_title">LAN 1 MAX. MAC Num</td>
        <td class="tabal_right"><input name="lan1_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "lan1MaxMac"); %>' style="width:100px"/>
          <span class="gray">(0-16)</span> </td>
      </tr>
      <tr id='tr_lan2' style="display: none">
        <td class="tabal_left" id="lan2_mac_limit_title">LAN 2 MAX. MAC Num</td>
        <td class="tabal_right"><input name="lan2_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "lan2MaxMac"); %>' style="width:100px"/>
          <span class="gray">(0-16)</span> </td>
      </tr>
      <tr id='tr_lan3' style="display: none">
        <td class="tabal_left" id="lan3_mac_limit_title">LAN 3 MAX. MAC Num</td>
        <td class="tabal_right"><input name="lan3_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "lan3MaxMac"); %>' style="width:100px"/>
          <span class="gray">(0-16)</span> </td>
      </tr>
      <tr id='tr_lan4' style="display: none">
        <td class="tabal_left" id="lan4_mac_limit_title">LAN 4 MAX. MAC Num</td>
        <td class="tabal_right"><input name="lan4_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "lan4MaxMac"); %>' style="width:100px"/>
          <span class="gray">(0-16)</span> </td>
      </tr>
      <tr id='tr_10glan' style="display: none">
        <td class="tabal_left" id="10glan_mac_limit_title">10G LAN MAX. MAC Num</td>
        <td class="tabal_right"><input name="10glan_max_mac" maxlength="4" type="text" value='<% getCfgGeneral(1, "10glanMaxMac"); %>' style="width:100px"/>
          <span class="gray">(0-16)</span> </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="20%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="lanMacLinit_apply">
          <input class="submit" type="reset" value="Cancel" id="lanMacLinit_cancel"onclick="window.location.reload();" >
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
