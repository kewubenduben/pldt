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
			inform_state.innerHTML = _("δ�ϱ�,������������");
			break;
		case 1:
			inform_state.innerHTML = _("δ�ϱ�,��Զ�̹���WAN����");
			break;
		case 2:
			inform_state.innerHTML = _("δ�ϱ�,Զ�̹���WAN����δ��Ч");
			break;
		case 3:
			inform_state.innerHTML = _("δ�ϱ�,�޹���ͨ��DNS��Ϣ");
			break;
		case 4:
			inform_state.innerHTML = _("δ�ϱ�,��ACS���ò���");
			break;
		case 5:
			inform_state.innerHTML = _("δ�ϱ�,��IP��ַ");
			break;
		case 6:
			inform_state.innerHTML = _("δ�ϱ�,�ϱ���ʱ");
			break;
		case 7:
			inform_state.innerHTML = _("δ�ϱ�,ACS��������ʧ��");
			break;
		case 8:
			inform_state.innerHTML = _("�ϱ��޻�Ӧ");
			break;
		case 9:
			inform_state.innerHTML = _("�ϱ������ж�");
			break;
		case 10:
			inform_state.innerHTML = _("�ϱ��ɹ�");
			break;
		default:
			ONU_regstate.innerHTML = _("δ�ϱ�,������������");
			break;
	}

	switch(parseInt(authResult_value))
	{
		case 0:
			acs_conn_state.innerHTML = _("��ITMS��������");
			break;
		case 1:
			acs_conn_state.innerHTML = _("ITMS��������ʧ��");
			break;
		case 2:
			acs_conn_state.innerHTML = _("ITMS�������ӳɹ�");
			break;
		default:
			acs_conn_state.innerHTML = _("��ITMS��������");
			break;
	}

	
	/*�߼���ʾ��֤״̬*/
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
					onu_acs_state.innerHTML = _("ACSAuthSuccessWaitingDistribute");//"�ն�ע�����ƽ̨�ɹ����ȴ��·�ҵ�����ݣ�";
					ONU_regstate.innerHTML = _("ע��ɹ�");
					break;
				case 0:
					onu_acs_state.innerHTML = _("serviceDistributing");//"�����·�ҵ������ϵ���ι��ˣ�";
					ONU_regstate.innerHTML = _("ע��ɹ�");
					break;
				case 1:
					onu_acs_state.innerHTML = _("serviceDistributeSuccess");//"ע��ȫ����ɣ�ҵ���·����óɹ�����ӭʹ��!";
					ONU_regstate.innerHTML = _("ע��ɹ�");
					break;
				case 2:
					onu_acs_state.innerHTML = _("serviceDistributeFailed");//"ע��ɹ����·�ҵ��ʧ�ܡ�";
					ONU_regstate.innerHTML = _("ע��ɹ�");
					break;
				default:
					onu_acs_state.innerHTML = _("ACSAuthSuccess");//"�ն�ע�����ƽ̨�ɹ���";
					ONU_regstate.innerHTML = _("ע��ɹ�");
					break;
			}
			break;
		case 1:
			ONU_regstate.innerHTML = _("ACSAuthFailed_pwd");//"�û���֤�벻���ڡ�"
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
			break;
		case 2:
			ONU_regstate.innerHTML = _("ACSAuthFailed_loid");//"�û��߼�ID�����ڡ�"
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
			break;
		case 3:
			ONU_regstate.innerHTML = _("ACSAuthFailed_loidpwd");//"�û��߼�ID���û���֤��ƥ��ʧ�ܡ�"
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
			break;
		case 4:
			ONU_regstate.innerHTML = _("registTimeout");//"ע�ᳬʱ��������·�����ԡ�";
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
			break;
		case 5:
			ONU_regstate.innerHTML = _("registAlready");//"�Ѿ�ע��ɹ�����������ע�ᡣ";
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
			break;
		case 99:
			ONU_regstate.innerHTML = _("ACSAuthing");//"�ն�����ע�����ƽ̨��";
			onu_acs_state.innerHTML =_("ҵ���·�ʧ��");
			break;
		default:
			ONU_regstate.innerHTML = _("oltAuthFailed");//"ע��ʧ�ܣ������ԡ�";	/* �淶���޴���ʾ��Ϣ --��ȡע����ʧ�� */
			onu_acs_state.innerHTML = _("ҵ���·�ʧ��");
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
                �ڱ�ҳ������Բο�Զ�̹���״̬��</td>
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
        <td colspan="2" id="DeInf">��������</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="inform_state_title">�����ϱ�Inform���:</td>
        <td class="tabal_right" id = "inform_state"> </td>
      </tr>
        <tr>
        <td class="tabal_left" width="25%" id="acs_conn_state_title">���յ�ACS�����������:</td>
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
        <td colspan="2" id="DeInf">ҵ�������·�״̬</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="out_power_title">���Զ��ҵ���������:</td>
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
        <td colspan="2" id="DeInf">�߼���ʾ��֤״̬</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="logic_auth_title">�߼���ʾ��֤���:</td>
        <td class="tabal_right" id="ONU_regstate"> </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>