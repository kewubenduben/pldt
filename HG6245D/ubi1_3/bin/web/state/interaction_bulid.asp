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
<title></title>
<script language="JavaScript" type="text/javascript">

/* 检查用户是否LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("device_regist", lang);

var devRegisterSync = '<% devRegisterSync(); %>';
var devRegisterSync = '<% tr069_statesync(); %>';


function initTranslation()
{

}

function initValue()
{
	initTranslation();

	
	var inform_state = document.getElementById("inform_state");
	var acs_conn_state = document.getElementById("acs_conn_state");
	var inform_state_value = '<% getCfgGeneral(1, "tr069inform_state"); %>';
	var authResult_value = '<% getCfgGeneral(1, "tr069conn_state"); %>';

	switch(parseInt(inform_state_value))
	{
		case 0:
			inform_state.innerHTML = _("未上报,网关正在启动");
			break;
		case 1:
			inform_state.innerHTML = _("未上报,无远程管理WAN连接");
			break;
		case 2:
			inform_state.innerHTML = _("未上报,远程管理WAN连接未生效");
			break;
		case 3:
			inform_state.innerHTML = _("未上报,无管理通道DNS信息");
			break;
		case 4:
			inform_state.innerHTML = _("未上报,无ACS配置参数");
			break;
		case 5:
			inform_state.innerHTML = _("未上报,无IP地址");
			break;
		case 6:
			inform_state.innerHTML = _("未上报,上报超时");
			break;
		case 7:
			inform_state.innerHTML = _("未上报,ACS域名解析失败");
			break;
		case 8:
			inform_state.innerHTML = _("上报无回应");
			break;
		case 9:
			inform_state.innerHTML = _("上报过程中断");
			break;
		case 10:
			inform_state.innerHTML = _("上报成功");
			break;
		default:
			ONU_regstate.innerHTML = _("未上报,网关正在启动");
			break;
	}

	switch(parseInt(authResult_value))
	{
		case 0:
			acs_conn_state.innerHTML = _("无ITMS主动连接");
			break;
		case 1:
			acs_conn_state.innerHTML = _("ITMS主动连接失败");
			break;
		case 2:
			acs_conn_state.innerHTML = _("ITMS主动连接成功");
			break;
		default:
			acs_conn_state.innerHTML = _("无ITMS主动连接");
			break;
	}

	
	/*逻辑标示认证状态*/
	var ONU_regstate = document.getElementById("ONU_regstate");
	var onu_acs_state = document.getElementById("onu_acs_state");
	var authStatus = '<% getCfgGeneral(1, "auth_status"); %>';
	var authResult = '<% getCfgGeneral(1, "auth_result"); %>';

	switch(parseInt(authStatus))
	{
		case 0:
			switch(parseInt(authResult))
			{
				case 99:
					onu_acs_state.innerHTML = _("ACSAuthSuccessWaitingDistribute");//"终端注册管理平台成功，等待下发业务数据；";
					ONU_regstate.innerHTML = _("注册成功");
					break;
				case 0:
					onu_acs_state.innerHTML = _("serviceDistributing");//"正在下发业务，请勿断电或插拔光纤；";
					ONU_regstate.innerHTML = _("注册成功");
					break;
				case 1:
					onu_acs_state.innerHTML = _("serviceDistributeSuccess");//"注册全部完成，业务下发配置成功，欢迎使用!";
					ONU_regstate.innerHTML = _("注册成功");
					break;
				case 2:
					onu_acs_state.innerHTML = _("serviceDistributeFailed");//"注册成功，下发业务失败。";
					ONU_regstate.innerHTML = _("注册成功");
					break;
				default:
					onu_acs_state.innerHTML = _("ACSAuthSuccess");//"终端注册管理平台成功。";
					ONU_regstate.innerHTML = _("注册成功");
					break;
			}
			break;
		case 1:
			ONU_regstate.innerHTML = _("ACSAuthFailed_pwd");//"用户认证码不存在。"
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
		case 2:
			ONU_regstate.innerHTML = _("ACSAuthFailed_loid");//"用户逻辑ID不存在。"
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
		case 3:
			ONU_regstate.innerHTML = _("ACSAuthFailed_loidpwd");//"用户逻辑ID与用户认证码匹配失败。"
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
		case 4:
			ONU_regstate.innerHTML = _("registTimeout");//"注册超时！请检查线路后重试。";
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
		case 5:
			ONU_regstate.innerHTML = _("registAlready");//"已经注册成功，无需重新注册。";
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
		case 99:
			ONU_regstate.innerHTML = _("ACSAuthing");//"终端正在注册管理平台；";
			onu_acs_state.innerHTML =_("业务下发失败");
			break;
		default:
			ONU_regstate.innerHTML = _("oltAuthFailed");//"注册失败，请重试。";	/* 规范里无此提示信息 --获取注册结果失败 */
			onu_acs_state.innerHTML = _("业务下发失败");
			break;
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="optpower_inf" id="connect_info">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="connect_info_prompt" class="title_01" style="padding-left: 10px;" width="100%">
                在本页面你可以参考远程管理状态。</td>
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
        <td colspan="2" id="DeInf">交互建立</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="inform_state_title">主动上报Inform情况:</td>
        <td class="tabal_right" id = "inform_state"> </td>
      </tr>
        <tr>
        <td class="tabal_left" width="25%" id="acs_conn_state_title">接收到ACS连接请求情况:</td>
        <td class="tabal_right" id="acs_conn_state"> </td>
      </tr>
    </tbody>
  </table>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="15px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="DeInf">业务配置下发状态</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="out_power_title">最近远程业务配置情况:</td>
        <td class="tabal_right" id="onu_acs_state"> </td>
      </tr>
    </tbody>
  </table>

      <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="15px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="DeInf">逻辑标示认证状态</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="logic_auth_title">逻辑标示认证结果:</td>
        <td class="tabal_right" id="ONU_regstate"> </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>