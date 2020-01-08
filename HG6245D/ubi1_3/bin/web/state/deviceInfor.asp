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
<title>Device Information</title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';
var sncfgSync = '<% sncfgSync();%>';

var catvFlag = '<% getCfgGeneral(1, "CatvFlag"); %>'; 
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var reg_state = '<% getCfgGeneral(1, "reg_state"); %>';
var ONT_state = '<% getCfgGeneral(1, "ONT_state"); %>';
var defaultpassword = '<% getCfgGeneral(1, "defaultpassword"); %>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

function initTranslation()
{
	var e = document.getElementById("deviceinf_prompt");
	e.innerHTML = _("deviceinf_prompt");

	e = document.getElementById("DeInf");
	e.innerHTML = _("DeInf");
	e = document.getElementById("softver");
	e.innerHTML = _("softver");
	e = document.getElementById("hardver");
	e.innerHTML = _("hardver");
	e = document.getElementById("device_model");
	e.innerHTML = _("device_model");
	e = document.getElementById("device_descrip");
	e.innerHTML = _("device_descrip");
	e = document.getElementById("ONU_state");
	e.innerHTML = _("ONU_state");
	e = document.getElementById("ONU_reg_title");
	e.innerHTML = _("ONU_reg_title");
	e = document.getElementById("pon_reg_title");
	e.innerHTML = _("pon_reg_title");
	e = document.getElementById("CPU_rate");
	e.innerHTML = _("CPU_rate");
	e = document.getElementById("mem_rate");
	e.innerHTML = _("mem_rate");
	e = document.getElementById("flash_rate");
	e.innerHTML = _("flash_rate");
	e = document.getElementById("server_port");
	e.innerHTML = _("server_port");
	e = document.getElementById("rf_power_title");
	e.innerHTML = _("rf_power_title");
	e = document.getElementById("catv_revpower_title");
	e.innerHTML = _("catv_revpower_title");
	e = document.getElementById("catv_enable_title");
	e.innerHTML = _("catv_enable_title");
	
			
}

function codeTransform1()  /*广东联通显示pon注册认证状态*/
{
	var codeTxt;
	reg_state = parseInt(reg_state);

	/* modify by 吴小娟, 20150922, 原因:应高超要求，返值为0/99时都判断O5 */
	if(reg_state == 0 || reg_state == 99)
	{
		/* modify by 吴小娟, 20150424, 原因:物理密码认证成功时reg_state也为99，需要再判断O5状态 */
		if(ONT_state == "O5(STATE_OPERATION)")
		{
			codeTxt = "已注册已认证";
		}
		else
		{
			codeTxt = "未注册未认证";
		}
	}
	else		//-1
	{
		codeTxt = "已注册未认证";
	}

	return codeTxt;
}

function initValue()
{
	/* modify by wuxj, 20170904, 原因: 维护账号首次登录仍需强制修改密码.需求来源:钱凯 */
	if(ispNameCode == 8 || ispNameCode == 22) /* pldt/泰国TRUE */
	{
		if(defaultpassword == 1) /*使用默认密码登陆*/
		{
			top.location = "../management/account_self_admin_pldt.asp";
		}
	}

	initTranslation();
	
	/*add begin by yclv, 20160927, 罗马尼亚版本普通用户使用默认账号密码登陆，跳转到账号管理页面*/
	if((ispNameCode == 9) && (curUserType == 1))
	{
		if(defaultpassword == 1) /*使用默认密码登陆*/
		{
			alert("Please modify the default password!");
			this.location = "../management/account_self_admin.asp";
		}
	}
	if(catvFlag == 1)
	{
		setDisplay("catv_rf", "");
	}
	else
	{
		setDisplay("catv_rf", "none");
	}

	if(ispMinorNameCode == 305) /*广东联通显示pon注册认证状态*/
	{
		setDisplay("pon_state_tr", "");
	}

	if(ispNameCode == 9) /*罗马尼亚版本*/
	{
		if(curUserType == 1)
		{
			setDisplay("hardver_tr", "none");
			setDisplay("device_descrip_tr", "none");
			setDisplay("loid_tr", "none");
			setDisplay("CPU_rate_tr", "none");
			setDisplay("mem_rate_tr", "none");
			setDisplay("server_port_tr", "none");
			setDisplay("serial_number_tr", "none");
		}
		else
		{
			setDisplay("serial_number_tr", "");
		}
	}
	else if(ispNameCode == 15 || ispNameCode == 22)	//GLOBE /泰国TRUE要求显示System UpTime(需求来源:钱凯)
		setDisplay("sysUpTime_tr", "");

	if(ispNameCode == 4 || ispNameCode == 16)//3BB/viettel
		setDisplay("serial_number_tr", "");

	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
	if(DEV_TYPE == '01A9G' && ispNameCode == '4')	//3BB A9G
	{
		setDisplay("flash_rate_tr", "");
	}
	
	var port_value = document.getElementById("server_port_value");
	var web_port = '<% getCfgGeneral(1, "web_port"); %>';
	port_value.innerHTML = web_port;
	
	var ONU_regstate = document.getElementById("ONU_regstate");
	var loid_state = '<% getCfgGeneral(1, "loid_state"); %>';
	switch(parseInt(loid_state))
	{
		case 0:
		ONU_regstate.innerHTML = _("INIT");
		break;
		case 1:
		ONU_regstate.innerHTML = _("OK");
		break;
		case 2:
		ONU_regstate.innerHTML = _("LOID_ERR");
		break;
		case 3:
		ONU_regstate.innerHTML = _("LPWD_ERR");
		break;
		case 4:
		ONU_regstate.innerHTML = _("LOID_COLLISION");
		break;
		case 10:
		ONU_regstate.innerHTML = _("SN_COLLISION");
		break;
		case 11:
		ONU_regstate.innerHTML = _("NO_RESOURCE");
		break;
		case 12:
		ONU_regstate.innerHTML = _("TYPE_ERR");
		break;
		case 13:
		ONU_regstate.innerHTML = _("SN_ERR");
		break;
		case 14:
		ONU_regstate.innerHTML = _("PWD_ERR");
		break;
		case 15:
		ONU_regstate.innerHTML = _("PWD_COLLISION");
		break;
		default:
		ONU_regstate.innerHTML = _("INIT");
		break;
	}

	var onustate_value = '<% getCfgGeneral(1, "ONT_state"); %>';
	var onu_state_node = document.getElementById("onu_state_value");
	if((ispNameCode == 9) && (curUserType == 1)) /*罗马尼亚普通用户*/
	{
		if(onustate_value == "O5(STATE_OPERATION)")
		{
			onu_state_node.innerHTML = "Online";
		}
		else
		{
			onu_state_node.innerHTML = "Offline";
		}
	}
	else
	{
		onu_state_node.innerHTML = '<% getCfgGeneral(1, "ONT_state"); %>';
	}

	var catv_enable_value = '<% getCfgGeneral(1, "catv_enable"); %>';
	var catv_enable_node = document.getElementById("catv_enable");
	if(catv_enable_value == 1)
	{
		catv_enable_node.innerHTML = _("Enable");
	}
	else
	{
		catv_enable_node.innerHTML = _("Disable");
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="deviceinf" id="deviceinf">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="deviceinf_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="DeInf">Device Information</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="softver">Software Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "software_version"); %></td>
      </tr>
      <tr id = "hardver_tr">
        <td class="tabal_left" width="25%" id="hardver">Hardware Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "hardware_version"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="device_model">Device Model</td>
        <td class="tabal_right"><% getCfgGeneral(1, "DeviceType"); %></td>
      </tr>
      <tr id = "device_descrip_tr">
        <td class="tabal_left" width="25%" id="device_descrip">Device Description</td>
        <td class="tabal_right"><% getCfgGeneral(1, "PonType"); %></td>
      </tr>
      <tr id ="serial_number_tr">
        <td class="tabal_left" width="25%" id="serial_number">Serial Number</td>
        <td class="tabal_right"><% getCfgGeneral(1, "ONT_ID"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ONU_state">ONU State</td>
        <td class="tabal_right" id="onu_state_value"></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="ONU_reg_title">ONU Regist State</td>
        <td class="tabal_right" id="ONU_regstate"></td>
      </tr>
      <tr id="pon_state_tr" style="display: none">
        <td class="tabal_left" width="25%" id="pon_reg_title">PON Authentication State</td>
        <td class="tabal_right"><script language="javascript">
					var codeTxt = codeTransform1();
					document.write(codeTxt);
				</script>
        </td>
      </tr>
      <tr id = "loid_tr">
        <td class="tabal_left" width="25%" >LOID</td>
        <td class="tabal_right" id="ONU_LOID"><% getCfgGeneral(1, "logic_sn"); %></td>
      </tr>
      <tr id = "CPU_rate_tr">
        <td class="tabal_left" width="25%" id="CPU_rate">CPU Usage</td>
        <td class="tabal_right"><% getCfgGeneral(1, "CPU_rate"); %></td>
      </tr>
      <tr id = "mem_rate_tr">
        <td class="tabal_left" width="25%" id="mem_rate">Memory Usage</td>
        <td class="tabal_right"><% getCfgGeneral(1, "mem_rate"); %></td>
      </tr>
      <tr id = "flash_rate_tr" style="display: none">
        <td class="tabal_left" width="25%" id="flash_rate">Flash Usage</td>
        <td class="tabal_right"><% getCfgGeneral(1, "flash_rate"); %></td>
      </tr>
      <tr id = "server_port_tr">
        <td class="tabal_left" width="25%" id="server_port">Web Server port</td>
        <td class="tabal_right" id="server_port_value"></td>
      </tr>
      <tr id= "sysUpTime_tr" style="display: none">
        <td class="tabal_left" width="25%" id="upTimeTitle">System UpTime</td>
        <td class="tabal_right" id="upTime"><% getCfgGeneral(1, "sysUpTimeDate"); %>
          d
          <% getCfgGeneral(1, "sysUpTimeHour"); %>
          h
          <% getCfgGeneral(1, "sysUpTimeMin"); %>
          m
          <% getCfgGeneral(1, "sysUpTimeSec"); %>
          s</td>
      </tr>
    </tbody>
  </table>
  <table id="catv_rf" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr >
        <td class="tabal_left" width="25%" id="catv_enable_title">CATV State</td>
        <td class="tabal_right" id="catv_enable" ></td>
      </tr>
      <tr >
        <td class="tabal_left" width="25%" id="catv_revpower_title">CATV Received Power</td>
        <td class="tabal_right" ><% getCfgGeneral(1, "catv_revpower"); %>
          dBm</td>
      </tr>
      <tr >
        <td class="tabal_left" width="25%" id="rf_power_title">CATV RF Power</td>
        <td class="tabal_right"  ><% getCfgGeneral(1, "rf_power"); %>
          dBmV</td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>