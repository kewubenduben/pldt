<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>IPv4 default route</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<%cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("route", lang);

var v4_dr_sync = '<% v4_dr_sync(); %>';
var wanNameSync = '<% wanNameSync(); %>';

function initValue()
{
	initTranslation();	
	
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	
	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");
	
	var v4_dr_wanNode = getElement("v4_dr_wan");
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R") >= 0)//route wan
		{
			v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);//new Option(text, value)
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			v4_dr_wanNode.options[v4_dr_wanNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	showSelectNodeByValue(v4_dr_wanNode, '<% getCfgGeneral(1, "v4_dr_wan"); %>');
	
	var v4_dr_enable = '<% getCfgGeneral(1, "v4_dr_enable"); %>';
	showCheckboxNodeByValue(getElement("v4_dr_enable"), v4_dr_enable);
	clickV4DrEnable();
}
function clickV4DrEnable()
{
	var v4_dr_enableNode = getElement("v4_dr_enable");
	if(v4_dr_enableNode.checked == true)
	{
		getElement("v4_dr_wan").disabled = false;
		getElement("v4_dr_enableFlag").value = 1;	
	}
	else
	{
		getElement("v4_dr_wan").disabled = true;
		getElement("v4_dr_enableFlag").value = 0;
	}
}
function checkValue()
{
	var v4_dr_enableNode = getElement("v4_dr_enable");
	var v4_dr_wanNode = getElement("v4_dr_wan");
	if((v4_dr_enableNode.checked == true) && (v4_dr_wanNode.value == '0'))
	{
		alert(_("dr_wannameNUllAlert"));
		return false;
	}
	else
		return true;
}
function initTranslation()
{
	var e = document.getElementById("v4StaticRoutePrompt");
	e.innerHTML = _("v4StaticRoutePrompt");

	e = document.getElementById("v4_dr_enableTitle");
	e.innerHTML = _("dr_enableTitle");
	e = document.getElementById("v4_dr_wanTitle");
	e.innerHTML = _("dr_wanTitle");
	e = document.getElementById("v4_dr_wanDefaultTitle");
	e.innerHTML = _("dr_wanDefaultTitle");
	
	e = document.getElementById("apply");
	e.value = _("apply");
	e = document.getElementById("cancel");
	e.value = _("cancel");
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" action="/goform/set_v4_def_route" onSubmit="return checkValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="v4StaticRoutePrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" width="25%" id="v4_dr_enableTitle">Enable the default route</td>
        <td class="tabal_right"><input type="checkbox" name="v4_dr_enable" value="1" onClick="clickV4DrEnable()">
          <input type="hidden" name="v4_dr_enableFlag">
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="v4_dr_wanTitle">WAN Name</td>
        <td class="tabal_right"><select name="v4_dr_wan" size="1" style="width:27%" value=3>
            <option value="0" id="v4_dr_wanDefaultTitle" selected="selected">Please choose</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Applay" id="apply">
          <input class="submit" type="reset" onClick="window.location.reload();" value="Cancel" id="cancel">
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

