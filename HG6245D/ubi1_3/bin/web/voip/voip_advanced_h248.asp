<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Voip_advanced</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipAdvancedSync = '<% voipBasicH248Sync(); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num");%>';

function LoadFrame()
{
	initTranslation();


	if(voip_port_num == 2)
	{
		setDisplay("Voipport_2table", "");
	}
	else
	{
		setDisplay("Voipport_2table", "none");
	}

	
	var Get_voip_back = '<% getCfgGeneral(1, "voip_back1"); %>';
	var voip_back = document.getElementById("voip_back");
	for(var i = 0; i< voip_back.length; i++)
	{	
		if(voip_back.options[i].value == Get_voip_back)
		{
			voip_back.options[i].selected = true;
			break;
		}
	}

	var Get_voip_dtmf = '<% getCfgGeneral(1, "voip_DTMFtype"); %>';
	var voip_dtmf = document.getElementById("voip_dtmf");
	for(var i = 0; i< voip_dtmf.length; i++)
	{	
		if(voip_dtmf.options[i].value == Get_voip_dtmf)
		{
			voip_dtmf.options[i].selected = true;
			break;
		}
	}

	var Get_call_type = '<% getCfgGeneral(1, "call_type"); %>';
	var call_typeNode = document.getElementById("call_type");
	for(var i = 0; i< call_typeNode.length; i++)
	{	
		if(call_typeNode.options[i].value == Get_call_type)
		{
			call_typeNode.options[i].selected = true;
			break;
		}
	}

	var Get_fax_type = '<% getCfgGeneral(1, "fax_type"); %>';
	var fox_type = document.getElementById("fox_type");
	for(var i = 0; i< fox_type.length; i++)
	{	
		if(fox_type.options[i].value == Get_fax_type)
		{
			fox_type.options[i].selected = true;
			break;
		}
	}
	
	var Get_fox_ctlmode = '<% getCfgGeneral(1, "fox_ctlmode"); %>';
	var fox_ctlmode = document.getElementById("fox_ctlmode");
	for(var i = 0; i< fox_ctlmode.length; i++)
	{	
		if(fox_ctlmode.options[i].value == Get_fox_ctlmode)
		{
			fox_ctlmode.options[i].selected = true;
			break;
		}
	}

	var Get_jump_type = '<% getCfgGeneral(1, "jump_type"); %>';
	var jump_type = document.getElementById("jump_type");
	for(var i = 0; i< jump_type.length; i++)
	{	
		if(jump_type.options[i].value == Get_jump_type)
		{
			jump_type.options[i].selected = true;
			break;
		}
	}
	
}

function fw_checkGainLegal(dom)
{
	var exp = /^[\d+-]/;	
	if(exp.test(dom.value))
	{
		if(-12 <= dom.value && dom.value <= 6 )
		{
			return true;
		}
		else
		{
     	//	alert("有效增益值范围为-12～6.");
			alert(_("web_gainIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("web_gainIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function fw_checkRFC2833Legal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(96 <= dom.value && dom.value <= 127)
		{
			return true;
		}
		else if(dom.value == 0)
		{
			return true;
		}
		else
		{
     		//alert("有效RFC2833默认PT范围为96～127.");
			alert(_("web_RFC2833IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("web_RFC2833IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function fw_checkRFC2198Legal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(96 <= dom.value && dom.value <= 127)
		{
			return true;
		}
		else if(dom.value == 0)
		{
			return true;
		}
		else
		{
     		//alert("有效RFC2198默认PT范围为96～127.");
		    alert(_("web_RFC2198IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("web_RFC2198IllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function CheckForm()
{
	var portvalue = document.getElementById("voip_RFC2833");
	if (portvalue.value == "")
	{
			//alert("RFC2833默认PT不能为空!");
			alert(_("web_RFC2833NullAlert"));
			portvalue.value = portvalue.defaultValue;
			portvalue.focus();
			return false;
	}
	else
	{
		if(!fw_checkRFC2833Legal(portvalue))
		{				
			return false;
		}
	}

	var RFC2198 = document.getElementById("voip_RFC2198");
	if (RFC2198.value == "")
	{
			//alert("RFC2198 PT值不能为空!");
			alert(_("web_RFC2198NullAlert"));
			RFC2198.value = RFC2198.defaultValue;
			RFC2198.focus();
			return false;
	}
	else
	{
		if(!fw_checkRFC2198Legal(RFC2198))
		{	
			return false;
		}
	}

	var aliveinter = document.getElementById("aliveinter");
	if (aliveinter.value == "")
	{
			//alert("心跳时长/心跳超时 不能为空!");
			alert(_("web_aliveNullAlert"));
			aliveinter.value = aliveinter.defaultValue;
			aliveinter.focus();
			return false;
	}
	else if(!checkNumberLegal(aliveinter, 1, 43200))	//modify by wuxj 20151105, 修改为与网管需求相同
	{
		alert(_("The value you input is illegal"));
		return false;
	}

	var aliveout = document.getElementById("aliveout");
	if (aliveout.value == "")
	{
			//alert("心跳时长/心跳超时 不能为空!");
			alert(_("web_aliveNullAlert"));
			aliveout.value = aliveout.defaultValue;
			aliveout.focus();
			return false;
	}
	else if(!checkNumberLegal(aliveout, 1, 120))	//modify by wuxj 20151105, 修改为与网管需求相同
	{
		alert(_("The value you input is illegal"));
		return false;
	}
	
	var set_gain1value = document.getElementById("set_gain1");
	if (set_gain1value.value == "")
	{
			//alert("请输入发送增益!");
			alert(_("web_setgainNullAlert"));
			set_gain1value.value = set_gain1value.defaultValue;
			set_gain1value.focus();
			return false;
	}
	else
	{
		if(!fw_checkGainLegal(set_gain1value))
		{
			return false;
		}
	}

	var rec_gain1value = document.getElementById("rec_gain1");
	if (rec_gain1value.value == "")
	{
			//alert("请输入接受增益!");
			alert(_("web_recgainNullAlert"));
			rec_gain1value.value = rec_gain1value.defaultValue;
			rec_gain1value.focus();
			return false;
	}
	else
	{
		if(!fw_checkGainLegal(rec_gain1value))
		{
			return false;
		}
	}

	if(voip_port_num == 2)
	{
		var set_gain2value = document.getElementById("set_gain2");
		if (set_gain2value.value == "")
		{
			//	alert("请输入发送增益!");
				alert(_("web_setgainNullAlert"));
				set_gain2value.value = set_gain2value.defaultValue;
				set_gain2value.focus();
				return false;
		}
		else
		{
			if(!fw_checkGainLegal(set_gain2value))
			{
				return false;
			}
		}

		var rec_gain2value = document.getElementById("rec_gain2");
		if (rec_gain2value.value == "")
		{
			//	alert("请输入接受增益!");
				alert(_("web_recgainNullAlert"));
				rec_gain2value.value = rec_gain2value.defaultValue;
				rec_gain2value.focus();
				return false;
		}
		else
		{
			if(!fw_checkGainLegal(rec_gain2value))
			{
				return false;
			}
		}
	
	}
	return true;

	
}

function initTranslation()
{
	var e = document.getElementById("voipadvance_prompt");
	e.innerHTML = _("voipadvance_prompt");

	e = document.getElementById("advance_title");
	e.innerHTML = _("advance_title");
	e = document.getElementById("voipback_title");
	e.innerHTML = _("voipback_title");
	e = document.getElementById("dtmf_title");
	e.innerHTML = _("dtmf_title");
	e = document.getElementById("RFC2833_title");
	e.innerHTML = _("RFC2833_title");
	e = document.getElementById("RFC2198_title");
	e.innerHTML = _("RFC2198_title");
	e = document.getElementById("fox_title");
	e.innerHTML = _("fox_title");
	e = document.getElementById("voip_enable1");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable1");
	e.innerHTML = _("voip_disable");

	
	e = document.getElementById("foxctl_title");
	e.innerHTML = _("foxctl_title");

	e = document.getElementById("num_disp_title");
	e.innerHTML = _("num_disp_title");

	e = document.getElementById("alive_time_title");
	e.innerHTML = _("alive_time_title");
	e = document.getElementById("alive_title");
	e.innerHTML = _("alive_title");
	e = document.getElementById("alivetype_title");
	e.innerHTML = _("alivetype_title");
	
	e = document.getElementById("set_gain_title");
	e.innerHTML = _("set_gain_title");
	e = document.getElementById("rec_gain_title");
	e.innerHTML = _("rec_gain_title");
	e = document.getElementById("active_tip");
	e.innerHTML = _("active_tip");
	e = document.getElementById("passive_tip");
	e.innerHTML = _("passive_tip");
	e = document.getElementById("disable_tip");
	e.innerHTML = _("disable_tip");
	e = document.getElementById("softswitch");
	e.innerHTML = _("softswitch");
	e = document.getElementById("auto_negotiation");
	e.innerHTML = _("auto_negotiation");
	e = document.getElementById("voip_trans1");
	e.innerHTML = _("voip_trans");
	e = document.getElementById("voip_trans2");
	e.innerHTML = _("voip_trans");

	e = document.getElementById("set_gain_title2");
	e.innerHTML = _("set_gain_title2");
	e = document.getElementById("rec_gain_title2");
	e.innerHTML = _("rec_gain_title2");

	e = document.getElementById("voip_apply");
	e.value = _("voip_apply");
	e = document.getElementById("voip_cancel");
	e.value = _("voip_cancel");
	
}
</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="voipadvance_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td id="advance_title" class="tabal_head">VoIP Advance Param</td>
    </tr>
  </tbody>
</table>
<form method="post" name="voip_advanced_form" action="/goform/voipAdvanceH248" onSubmit="return CheckForm()">
  <table class="tabal_bg" id="voipback" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="voipback_title" width="25%">EchoCancel</td>
        <td class="tabal_right" align="left"><select name="voip_back" id="voip_back" size="1" style="width:200px;">
            <option id="voip_enable1" value="1" selected="selected">Enable</option>
            <option id="voip_disable1" value="0">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" id="dtmf_title" width="25%">DTMF Mode</td>
        <td class="tabal_right" align="left"><select name="voip_dtmf" id="voip_dtmf" size="1" style="width:200px;">
            <option value="0" id="voip_trans1" selected="selected">Transparent</option>
            <option value="1">RFC2833</option>
          </select></td>
      </tr>
      <tr>
        <td id="RFC2833_title" class="tabal_left" width="25%">RFC2833 PT Value</td>
        <td class="tabal_right"><input name="voip_RFC2833" id="voip_RFC2833" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "voip_RFC2833"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0,96~127)</span></td>
      </tr>
      <tr>
        <td id="RFC2198_title" class="tabal_left" width="25%">RFC2198 PT Value</td>
        <td class="tabal_right"><input name="voip_RFC2198" id="voip_RFC2198" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "voip_RFC2198"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0,96~127)</span></td>
      </tr>
      <tr>
        <td id="fox_title" class="tabal_left" width="25%">Fax Mode</td>
        <td class="tabal_right" align="left"><select name="fox_type" id="fox_type" size="1" style="width:200px;">
            <option value="0" id="voip_trans2" selected="selected">Transparent</option>
            <option value="1">T38</option>
          </select></td>
      </tr>
      <tr>
        <td id="foxctl_title" class="tabal_left" width="25%">Fax Control Mode</td>
        <td class="tabal_right" align="left"><select name="fox_ctlmode" id="fox_ctlmode" size="1" style="width:200px;">
            <option value="1" id="softswitch">Softswitch</option>
            <option value="2" id="auto_negotiation" selected="selected">Auto-negotiation</option>
          </select></td>
      </tr>
      <tr>
        <td id="alivetype_title" class="tabal_left" width="25%">Keepalive mode</td>
        <td class="tabal_right" align="left"><select name="jump_type" id="jump_type" size="1" style="width:200px;">
            <option value="0" id="disable_tip" selected="selected">Disable</option>
            <option value="2" id="active_tip">Active</option>
            <option value="1" id="passive_tip">Passive</option>
          </select></td>
      </tr>
      <tr>
        <td id="num_disp_title" class="tabal_left" width="25%">CallerIDMode</td>
        <td class="tabal_right" align="left"><select name="call_type" id="call_type" size="1" style="width:200px;">
            <option value="FSK" selected="selected">FSK</option>
            <option value="DTMF">DTMF</option>
          </select></td>
      </tr>
      <tr>
        <td id="alive_time_title" class="tabal_left" width="25%">Alive Times</td>
        <td class="tabal_right"><input name="aliveout" id="aliveout" size="8" maxlength="5" type="text" value="<% getCfgGeneral(1, "alive_out"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1~120)</span></td>
      </tr>
      <tr>
        <td id="alive_title" class="tabal_left" width="25%">Alive Interval</td>
        <td class="tabal_right"><input name="aliveinter" id="aliveinter" size="8" maxlength="5" type="text" value="<% getCfgGeneral(1, "alive_interval"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1~43200)</span></td>
      </tr>
      <tr>
        <td id="set_gain_title" class="tabal_left" width="25%">Output Gain</td>
        <td class="tabal_right"><input name="set_gain1" id="set_gain1" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "set_gain1"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
      </tr>
      <tr>
        <td id="rec_gain_title" class="tabal_left" width="25%">Input Gain</td>
        <td class="tabal_right"><input name="rec_gain1" id="rec_gain1" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "rec_gain1"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
      </tr>
      <tr>
    </tbody>
  </table>
    <table id="Voipport_2table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
     <tr>
		  <td id="set_gain_title2" class="tabal_left" width="25%">Output Gain(port 2)</td>
		  <td class="tabal_right"><input name="set_gain2" id="set_gain2" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "set_gain2"); %>">
		    <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
		</tr>
		<tr>
		  <td id="rec_gain_title2" class="tabal_left" width="25%">Input Gain(port 2)</td>
		  <td class="tabal_right"><input name="rec_gain2" id="rec_gain2" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "rec_gain2"); %>">
		    <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
	  </tr>

  </tbody>
</table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" name="button" id="voip_apply" type="submit">
          <input class="submit" name="cancel" onclick="window.location.reload();" id="voip_cancel" type="reset">
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
