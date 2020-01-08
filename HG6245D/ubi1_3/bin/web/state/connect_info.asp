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
Butterlate.setTextDomain("state", lang);

var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';

var reg_state = '<% getCfgGeneral(1, "reg_state"); %>';
var ONT_state = '<% getCfgGeneral(1, "ONT_state"); %>';

function initTranslation()
{

}

function initValue()
{
	initTranslation();
}

function codeTransform1() 
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

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="connect_info" id="connect_info">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="connect_info_prompt" class="title_01" style="padding-left: 10px;" width="100%">
                在本页面你可以参考PON连接信息以及光状态告警信息。</td>
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
        <td colspan="2" id="powe_Inf">PON连接信息</td>
      </tr>
       <tr class="tabal_left" id="pon_state_tr">
        <td class="tabal_left" width="25%" id="pon_reg_title">PON链路连接状态</td>
        <td class="tabal_right">
			                <script language="javascript">
					var codeTxt = codeTransform1();
					document.write(codeTxt);
				</script>
		</td> 
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="in_power_title">FEC能力</td>
        <td class="tabal_right">支持</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="temp_title">FEC状态</td>
        <td class="tabal_right">开启</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="voltage_title">三重搅动加密</td>
        <td class="tabal_right">禁止</td>
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
  <!--table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="powe_Inf">告警信息</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="opt_powerstate_title">光信号状态</td>
        <td class="tabal_right"></td>
      </tr>
    </tbody>
  </table-->
</form>
</body>
</html>
