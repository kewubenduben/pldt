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

/* ����û��Ƿ�LOGIN */
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

	/* modify by ��С��, 20150922, ԭ��:Ӧ�߳�Ҫ�󣬷�ֵΪ0/99ʱ���ж�O5 */
	if(reg_state == 0 || reg_state == 99)
	{
		/* modify by ��С��, 20150424, ԭ��:����������֤�ɹ�ʱreg_stateҲΪ99����Ҫ���ж�O5״̬ */
		if(ONT_state == "O5(STATE_OPERATION)")
		{
			codeTxt = "��ע������֤";
		}
		else
		{
			codeTxt = "δע��δ��֤";
		}
	}
	else		//-1
	{
		codeTxt = "��ע��δ��֤";
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
                �ڱ�ҳ������Բο�PON������Ϣ�Լ���״̬�澯��Ϣ��</td>
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
        <td colspan="2" id="powe_Inf">PON������Ϣ</td>
      </tr>
       <tr class="tabal_left" id="pon_state_tr">
        <td class="tabal_left" width="25%" id="pon_reg_title">PON��·����״̬</td>
        <td class="tabal_right">
			                <script language="javascript">
					var codeTxt = codeTransform1();
					document.write(codeTxt);
				</script>
		</td> 
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="in_power_title">FEC����</td>
        <td class="tabal_right">֧��</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="temp_title">FEC״̬</td>
        <td class="tabal_right">����</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="voltage_title">���ؽ�������</td>
        <td class="tabal_right">��ֹ</td>
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
        <td colspan="2" id="powe_Inf">�澯��Ϣ</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="opt_powerstate_title">���ź�״̬</td>
        <td class="tabal_right"></td>
      </tr>
    </tbody>
  </table-->
</form>
</body>
</html>
