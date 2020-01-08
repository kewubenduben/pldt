<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title></title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var alg_sync = '<% alg_sync(); %>';

function initTranslation()
{
	var e = document.getElementById("alg_prompt");
	e.innerHTML = _("alg_prompt");
	e = document.getElementById("alg_head");
	e.innerHTML = _("alg_head");
	e = document.getElementById("alg_Apply");
	e.value = _("inet apply");
	e = document.getElementById("alg_Cancel");
	e.value = _("inet cancel");
}

function initValue()
{
	initTranslation();
	
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	if(ispNameCode == '28')//Ä«Î÷¸çTOTALPLAY Ö»±£ÁôFTP/SIP/L2TP/IPSEC
	{
		setDisplay("tr_h323", "none");
		setDisplay("tr_rtsp", "none");
		setDisplay("tr_pptp", "none");
	}

	var H323BoxNode = getElement("H323Box");
	var RTSPBoxNode = getElement("RTSPBox");
	var L2TPBoxNode = getElement("L2TPBox");
	var IPSECBoxNode = getElement("IPSECBox");
	var SIPBoxNode = getElement("SIPBox");
	var FTPBoxNode = getElement("FTPBox");
	var PPTPBoxNode = getElement("PPTPBox");

	var H323Box_value = '<% getCfgGeneral(1, "H323Box"); %>';
	if(H323Box_value == 1)
	{
		H323BoxNode.checked = true;
	}
	else
	{
		H323BoxNode.checked = false;
	}

	var RTSPBox_value = '<% getCfgGeneral(1, "RTSPBox"); %>';
	if(RTSPBox_value == 1)
	{
		RTSPBoxNode.checked = true;
	}
	else
	{
		RTSPBoxNode.checked = false;
	}

	var L2TPBox_value = '<% getCfgGeneral(1, "L2TPBox"); %>';
	if(L2TPBox_value == 1)
	{
		L2TPBoxNode.checked = true;
	}
	else
	{
		L2TPBoxNode.checked = false;
	}

	var IPSECBox_value = '<% getCfgGeneral(1, "IPSECBox"); %>';
	if(IPSECBox_value == 1)
	{
		IPSECBoxNode.checked = true;
	}
	else
	{
		IPSECBoxNode.checked = false;
	}

	var SIPBox_value = '<% getCfgGeneral(1, "SIPBox"); %>';
	if(SIPBox_value == 1)
	{
		SIPBoxNode.checked = true;
	}
	else
	{
		SIPBoxNode.checked = false;
	}

	var FTPBox_value = '<% getCfgGeneral(1, "FTPBox"); %>';
	if(FTPBox_value == 1)
	{
		FTPBoxNode.checked = true;
	}
	else
	{
		FTPBoxNode.checked = false;
	}

	var PPTPBox_value = '<% getCfgGeneral(1, "PPTPBox"); %>';
	if(PPTPBox_value == 1)
	{
		PPTPBoxNode.checked = true;
	}
	else
	{
		PPTPBoxNode.checked = false;
	}
	
}


</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="alg_form" id="alg_form" action="/goform/alg_cfg">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="alg_prompt" class="title_01" style="padding-left: 10px;" width="100%">You could configure ALG on this page. </td>
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
        <td colspan="2" id="alg_head"></td>
      </tr>
      <tr id="tr_h323">
        <td class="tabal_left" width="25%" id="in_power_title">H.323</td>
        <td class="tabal_right" ><input type="checkbox" name="H323Box" id="H323Box" value="1">
        </td>
      </tr>
      <tr id="tr_rtsp">
        <td class="tabal_left" width="25%" id="in_power_title">RTSP</td>
        <td class="tabal_right" ><input type="checkbox" name="RTSPBox" id="RTSPBox" value="1">
        </td>
      </tr>
      <tr id="tr_l2tp">
        <td class="tabal_left" width="25%" id="in_power_title">L2TP</td>
        <td class="tabal_right" ><input type="checkbox" name="L2TPBox" id="L2TPBox" value="1">
        </td>
      </tr>
      <tr id="tr_ipsec">
        <td class="tabal_left" width="25%" id="in_power_title">IPSEC</td>
        <td class="tabal_right" ><input type="checkbox" name="IPSECBox" id="IPSECBox" value="1">
        </td>
      </tr>
      <tr id="tr_sip">
        <td class="tabal_left" width="25%" id="in_power_title">SIP</td>
        <td class="tabal_right" ><input type="checkbox" name="SIPBox" id="SIPBox" value="1">
        </td>
      </tr>
      <tr id="tr_ftp">
        <td class="tabal_left" width="25%" id="in_power_title">FTP</td>
        <td class="tabal_right" ><input type="checkbox" name="FTPBox" id="FTPBox" value="1">
        </td>
      </tr>
      <tr id="tr_pptp">
        <td class="tabal_left" width="25%" id="in_power_title">PPTP</td>
        <td class="tabal_right" ><input type="checkbox" name="PPTPBox" id="PPTPBox" value="1">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" value="Apply" type="submit" id="alg_Apply">
          <input class="submit" name="cancel" onClick="window.location.reload();" value="Cancel" id="alg_Cancel" type="reset">
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
