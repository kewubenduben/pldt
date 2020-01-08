<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Voip_enable</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voip_enable_sync = '<% voip_enable_sync(); %>';
var curVoipPro = '<% getCfgGeneral(1, "voip_pro"); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num");%>';

function initTranslation()
{
	var e = document.getElementById("voipenable_prompt");
	e.innerHTML = _("voipenable_prompt");
	
	e = document.getElementById("port1_title");
	e.innerHTML = _("port1_title");
	e = document.getElementById("port2_title");
	e.innerHTML = _("port2_title");

	e = document.getElementById("voip_enable1_enableTitle");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_enable1_disableTitle");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable2_enableTitle");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_enable2_disableTitle");
	e.innerHTML = _("voip_disable");

	e = document.getElementById("voip_protocolTitle");
	e.innerHTML = _("protocol_title");
	
	e = document.getElementById("basic_apply");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel");
	e.value = _("voip_cancel");

	e = document.getElementById("basic_apply1");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel1");
	e.value = _("voip_cancel");
}
function initValue()
{
	initTranslation();
	if(ispNameCode == 5 || ispNameCode == 15)	//X_AIS 菲律宾GLOBE
	{
		setDisplay("form_voip_pro", "none");//single voip pro
	}
	else
	{
		setDisplay("form_voip_pro", "");
		
		var voip_pro = document.getElementById("voip_protocol");
		for(var i = 0; i < voip_pro.length; i++)
		{
			if(voip_pro.options[i].value == curVoipPro)
			{
				voip_pro.options[i].selected = true;
				break;
			}
		}
	}
	
	var voip_enable1 = document.getElementsByName("voip_enable1");	
	for(var i = 0; i < voip_enable1.length; i++)
	{
		if(voip_enable1[i].value == '<% getCfgGeneral(1, "voip_enable1"); %>')
		{
			voip_enable1[i].checked = true;
			break;
		}
	}
	if(voip_port_num > 1)
	{
		setDisplay("tr_voip_port2", "");
		var voip_enable2 = document.getElementsByName("voip_enable2");	
		for(var i = 0; i < voip_enable2.length; i++)
		{
			if(voip_enable2[i].value == '<% getCfgGeneral(1, "voip_enable2"); %>')
			{
				voip_enable2[i].checked = true;
				break;
			}
		}
	}

	if(ispNameCode == 2) /*移动版本没有H.248协议*/
	{
		getElement("voip_protocol").options.remove(1);//H248
		document.getElementById("basic_apply1").disabled = 1;
	}

	if((ispNameCode == 17) || (ispNameCode == 18))	/*哥伦比亚telebucaramanga及哥伦比亚 Metrotel没有H.248*/
	{
		getElement("voip_protocol").options.remove(1);//H248
		document.getElementById("basic_apply1").disabled = 1;
	}
}

function ProtoclConfirm()
{
	//no change, no submit
	if(getElement("voip_protocol").value == curVoipPro)
	{
		window.location.reload();
		return false;
	}
	
	if(confirm(_("Protocl_confirm")))
		return true;
	else
		return false;
}

</script>
</head>
<body class="mainbody" onload="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="voipenable_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form id="form_voip_pro" method="post" action="/goform/voip_protocol_cfg" onSubmit="return ProtoclConfirm()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
		<tr>
        <td class="tabal_left" width="25%" id="voip_protocolTitle">VoIP Protocol</td>
        <td class="tabal_right"><select id="voip_protocol" name="voip_protocol" size="1" style="width:35%" >
            <option value="4">SIP</option>
            <option value="2">H.248</option>
          </select>
        </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" id="basic_apply1" type="submit"  >
          <input class="submit" id="basic_cancel1" onclick="window.location.reload();" type="reset">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/voip_enable_cfg">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="port1_title" align="left" width="25%">Port1</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="Enabled" name="voip_enable1" type="radio">
          <font id="voip_enable1_enableTitle">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="Disabled" name="voip_enable1" type="radio">
          <font id="voip_enable1_disableTitle">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr id="tr_voip_port2" style="display:none">
        <td class="tabal_left" id="port2_title" align="left" width="25%">Port2</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="Enabled" name="voip_enable2" type="radio">
          <font id="voip_enable2_enableTitle">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="Disabled" name="voip_enable2" type="radio">
          <font id="voip_enable2_disableTitle">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" id="basic_apply" type="submit">
          <input class="submit" id="basic_cancel" onclick="window.location.reload();" type="reset">
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
