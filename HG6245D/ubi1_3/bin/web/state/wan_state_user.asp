<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="20">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>WAN STATE</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var previousTR = null;
var setLanstateSync = '<% setLanstateSync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var get_wan_detail = '<% get_wan_detail(); %>';

var wan_num = '<% getCfgGeneral(1, "wan_num"); %>';
var wan_mac_buff = '<% getCfgGeneral(1, "wan_mac_buff"); %>';
var wan_gateway_buff = '<% getCfgGeneral(1, "wan_gateway_buff"); %>';
var uptime_buff = '<% getCfgGeneral(1, "uptime_buff"); %>';

function initTranslation()
{
	var e = document.getElementById("wan_statePrompt");
	e.innerHTML = _("wanstate_prompt");

	e = document.getElementById("wanListHead");
	e.innerHTML = _("wanListHead");
	e = document.getElementById("wan_name");
	e.innerHTML = _("wan_name");
	e = document.getElementById("wan_state");
	e.innerHTML = _("wan_state");
	e = document.getElementById("wan_mode");
	e.innerHTML = _("wan_mode");
	e = document.getElementById("ip_mode");
	e.innerHTML = _("ip_mode");
	e = document.getElementById("wan_mask");
	e.innerHTML = _("wan_mask");
	e = document.getElementById("wan_type");
	e.innerHTML = _("wan_type");

}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		
		if (temp == 'new')		//新建
		{					

		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			var up_time = uptime_buff.split("|")[temp];
			var up_time_hour = parseInt(up_time/3600);
			var up_time_hour_text;
			up_time_hour_text = up_time_hour + " h ";
			
			var up_time_min = parseInt((up_time - up_time_hour*3600)/60);
			var up_time_min_text;
			up_time_min_text = up_time_min + " m ";
		
			var up_time_sec = up_time%60;
			var up_time_sec_text;
			up_time_sec_text = up_time_sec + " s ";
		
			document.getElementById("wan_mac").innerHTML = wan_mac_buff.split("|")[temp];
			document.getElementById("wan_uptime").innerHTML = up_time_hour_text + up_time_min_text + up_time_sec_text;
			document.getElementById("wan_gateway").innerHTML = wan_gateway_buff.split("|")[temp];
            
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}	
	}	 
}

function initValue()
{
	initTranslation();

	selectLine("record_0");
	if((wan_num > 0) && (ispName == 9)) /*罗马尼亚版本，wan计数大于0*/
	{
		setDisplay("wan_state_table", "");
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
              <td id="wan_statePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="tb_wanstate" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="wanListHead">WAN State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="wan_name">Index</td>
      <td width="9%" align="center" id="wan_state">State</td>
      <td width="10%" align="center" id="wan_mode">Mode</td>
      <td width="9%" align="center" id="ip_mode">IP Type</td>
      <td width="14%" align="center" >IP</td>
      <td width="15%" align="center" id="wan_mask">Mask</td>
      <td width="14%" align="center" >DNS</td>
      <td width="12%" align="center" id="wan_type">Connection Type</td>
    </tr>
    <% setwanIinfo_user(); %>
  </tbody>
</table>
<table  border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="wan_state_table" class="tabal_bg" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" >More Information</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">WAN Mac</td>
      <td class="tabal_right" id="wan_mac"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Connection Uptime</td>
      <td class="tabal_right" id="wan_uptime"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Gateway</td>
      <td class="tabal_right" id="wan_gateway"></td>
    </tr>
  </tbody>
</table>
</body>
</html>
