<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Voip_advanced</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var voipAdvancedSync = '<% voipAdvancedSync(); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num");%>';
var device_type = '<% getCfgGeneral(1, "device_type");%>';
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

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

	if(ispNameCode == '26')	//add by wuxj, 20171226, for TIM
	{
		setDisplay("tr_call_type", "");
		var call_type = '<% getCfgGeneral(1, "call_type"); %>';
		showSelectNodeByValue(getElement('call_type'), call_type);
		
		setDisplay("tr_num_disp_title", "none");
		setDisplay("tr_num_disp_title2", "none");
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

	var Get_callflag = '<% getCfgGeneral(1, "callerfalg"); %>';
	var callflag = document.getElementById("num_disp");
	for(var i = 0; i< callflag.length; i++)
	{	
		if(callflag.options[i].value == Get_callflag)
		{
			callflag.options[i].selected = true;
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

	var Get_fanji_signal = '<% getCfgGeneral(1, "fanji_signal"); %>';
	var fanji_signal = document.getElementById("fanji_signal");
	for(var i = 0; i< fanji_signal.length; i++)
	{	
		if(fanji_signal.options[i].value == Get_fanji_signal)
		{
			fanji_signal.options[i].selected = true;
			break;
		}
	}

	var Get_ring_wait = '<% getCfgGeneral(1, "ring_wait"); %>';
	var ring_wait = document.getElementById("ring_wait");
	for(var i = 0; i< ring_wait.length; i++)
	{	
		if(ring_wait.options[i].value == Get_ring_wait)
		{
			ring_wait.options[i].selected = true;
			break;
		}
	}

	var Get_3_ring = '<% getCfgGeneral(1, "3_ring"); %>';
	var three_ring = document.getElementById("3_ring");
	for(var i = 0; i< three_ring.length; i++)
	{	
		if(three_ring.options[i].value == Get_3_ring)
		{
			three_ring.options[i].selected = true;
			break;
		}
	}

	var Get_to_23 = '<% getCfgGeneral(1, "to_23"); %>';
	var to_23 = document.getElementById("to_23");
	for(var i = 0; i< to_23.length; i++)
	{	
		if(to_23.options[i].value == Get_to_23)
		{
			to_23.options[i].selected = true;
			break;
		}
	}

	var Get_num_from = '<% getCfgGeneral(1, "num_from"); %>';
	var num_from = document.getElementById("num_from");
	for(var i = 0; i< num_from.length; i++)
	{	
		if(num_from.options[i].value == Get_num_from)
		{
			num_from.options[i].selected = true;
			break;
		}
	}

	var silence_suppression = '<% getCfgGeneral(1, "silence_suppression"); %>';
	var SilenceSuppression = document.getElementById("SilenceSuppression");
	for(var i = 0; i< SilenceSuppression.length; i++)
	{	
		if(SilenceSuppression.options[i].value == silence_suppression)
		{
			SilenceSuppression.options[i].selected = true;
			break;
		}
	}

	if(voip_port_num == 2)
	{
		var Get_voip_back2 = '<% getCfgGeneral(1, "voip_back2"); %>';
		var voip_back2 = document.getElementById("voip_back2");
		for(var i = 0; i< voip_back2.length; i++)
		{	
			if(voip_back2.options[i].value == Get_voip_back2)
			{
				voip_back2.options[i].selected = true;
				break;
			}
		}

		var Get_ring_wait2 = '<% getCfgGeneral(1, "ring_wait2"); %>';
		var ring_wait2 = document.getElementById("ring_wait2");
		for(var i = 0; i< ring_wait2.length; i++)
		{	
			if(ring_wait2.options[i].value == Get_ring_wait2)
			{
				ring_wait2.options[i].selected = true;
				break;
			}
		}

		var Get_3_ring2 = '<% getCfgGeneral(1, "3_ring2"); %>';
		var three_ring2 = document.getElementById("3_ring2");
		for(var i = 0; i< three_ring2.length; i++)
		{	
			if(three_ring2.options[i].value == Get_3_ring2)
			{
				three_ring2.options[i].selected = true;
				break;
			}
		}

		var Get_callflag2 = '<% getCfgGeneral(1, "callerfalg2"); %>';
		var callflag2 = document.getElementById("num_disp2");
		for(var i = 0; i< callflag.length; i++)
		{	
			if(callflag2.options[i].value == Get_callflag2)
			{
				callflag2.options[i].selected = true;
				break;
			}
		}

		var silence_suppression2 = '<% getCfgGeneral(1, "silence_suppression2"); %>';
		var SilenceSuppression2 = document.getElementById("SilenceSuppression2");
		for(var i = 0; i< SilenceSuppression2.length; i++)
		{	
			if(SilenceSuppression2.options[i].value == silence_suppression2)
			{
				SilenceSuppression2.options[i].selected = true;
				break;
			}
		}

	}
	
	/*add begin by郭心悦，20170117，原因:泰国AIS普通用户可以显示Call waiting,Three-party Call参数*/
	if((ispNameCode == 5) && (curUserType == 1))
	{
		/*port1*/
		document.getElementById("tr_RFC2833_title").style.display = "none"; 
		document.getElementById("tr_RFC2198_title").style.display = "none"; 
		document.getElementById("tr_alive_time_title").style.display = "none"; 
		document.getElementById("tr_alive_title").style.display = "none"; 
		document.getElementById("tr_fox_title").style.display = "none"; 
		document.getElementById("tr_fanji_title").style.display = "none"; 
		document.getElementById("tr_tran_title").style.display = "none"; 
		document.getElementById("tr_dtmf_title").style.display = "none"; 
		document.getElementById("tr_num_disptype_title").style.display = "none"; 
		document.getElementById("tr_alivetype_title").style.display = "none"; 
		document.getElementById("tr_localPort_title").style.display = "none"; 
		document.getElementById("tr_voipback_title").style.display = "none"; 
		document.getElementById("tr_SilenceSuppression_title").style.display = "none"; 
		document.getElementById("tr_num_disp_title").style.display = "none"; 
		document.getElementById("tr_set_gain_title").style.display = "none"; 
		document.getElementById("tr_rec_gain_title").style.display = "none"; 

		/*port2*/
		document.getElementById("tr_voipback_title2").style.display = "none"; 
		document.getElementById("tr_SilenceSuppression2_title").style.display = "none"; 			
		document.getElementById("tr_num_disp_title2").style.display = "none"; 
		document.getElementById("tr_set_gain_title2").style.display = "none"; 
		document.getElementById("tr_rec_gain_title2").style.display = "none"; 
	}
	/*add end by郭心悦，20170117*/
	
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
	//	alert("增益值输入值非法!");
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
     	//	alert("有效RFC2833默认PT范围为96～127.");
			alert(_("web_RFC2833IllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		//alert("RFC2833默认PT 输入值非法!");
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
     	//	alert("有效RFC2198默认PT范围为96～127.");
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
		//	alert("RFC2198 PT值不能为空!");
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
		//	alert("心跳时长/心跳超时 不能为空!");
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
		//	alert("心跳时长/心跳超时 不能为空!");
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
	
	var localPort = getElement("localPort");
	if(!checkNumberLegal(localPort, 1024, 65535))	//modify by wuxj 20151105, 修改为与网管需求相同
	{
		alert(_("The value you input is illegal"));
		return false;
	}
	
	var set_gain1value = document.getElementById("set_gain1");
	if (set_gain1value.value == "")
	{
		//	alert("请输入发送增益!");
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
		//	alert("请输入接受增益!");
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
	e = document.getElementById("voip_enable2");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable2");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable3");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable3");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable4");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable4");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_disable5");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_disable6");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("num_disptype1");
	e.innerHTML = _("num_disptype1");
	e = document.getElementById("num_disptype2");
	e.innerHTML = _("num_disptype2");
	e = document.getElementById("voip_Escape1");
	e.innerHTML = _("voip_Escape1");
	e = document.getElementById("voip_Escape0");
	e.innerHTML = _("voip_Escape0");
	e = document.getElementById("active_enable");
	e.innerHTML = _("active_enable");

	e = document.getElementById("voipback_title2");
	e.innerHTML = _("voipback_title2");
	e = document.getElementById("num_disp_title2");
	e.innerHTML = _("num_disp_title2");
	e = document.getElementById("callwait_title2");
	e.innerHTML = _("callwait_title2");
	e = document.getElementById("3call_title2");
	e.innerHTML = _("3call_title2");
	e = document.getElementById("set_gain_title2");
	e.innerHTML = _("set_gain_title2");
	e = document.getElementById("rec_gain_title2");
	e.innerHTML = _("rec_gain_title2");
	e = document.getElementById("voip_enable12");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable12");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable32");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable32");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable42");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable42");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_disable52");
	e.innerHTML = _("voip_disable");
	
	e = document.getElementById("fanji_title");
	e.innerHTML = _("fanji_title");
	e = document.getElementById("callwait_title");
	e.innerHTML = _("callwait_title");
	e = document.getElementById("3call_title");
	e.innerHTML = _("3call_title");
	e = document.getElementById("tran_title");
	e.innerHTML = _("tran_title");
	e = document.getElementById("num_disp_title");
	e.innerHTML = _("num_disp_title");
	e = document.getElementById("num_disptype_title");
	e.innerHTML = _("num_disptype_title");
	e = document.getElementById("alive_time_title");
	e.innerHTML = _("alive_time_title");
	e = document.getElementById("alive_title");
	e.innerHTML = _("alive_title");
	e = document.getElementById("alivetype_title");
	e.innerHTML = _("alivetype_title");
	e = document.getElementById("localPort_title");
	e.innerHTML = _("localPort_title");
	
	e = document.getElementById("num_disp_title");
	e.innerHTML = _("num_disp_title");
	
	e = document.getElementById("set_gain_title");
	e.innerHTML = _("set_gain_title");
	e = document.getElementById("rec_gain_title");
	e.innerHTML = _("rec_gain_title");
		
	e = document.getElementById("voip_trans1");
	e.innerHTML = _("voip_trans");
	e = document.getElementById("voip_trans2");
	e.innerHTML = _("voip_trans");

	e = document.getElementById("SilenceSuppression_title");
	e.innerHTML = _("SilenceSuppression_title");
	e = document.getElementById("SilenceSuppression2_title");
	e.innerHTML = _("SilenceSuppression2_title");
	
	e = document.getElementById("voip_enable_SilenceSuppression");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable_SilenceSuppression");
	e.innerHTML = _("voip_disable");
	e = document.getElementById("voip_enable2_SilenceSuppression");
	e.innerHTML = _("voip_enable");
	e = document.getElementById("voip_disable2_SilenceSuppression");
	e.innerHTML = _("voip_disable");

	e = document.getElementById("basic_apply");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel");
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
      <td id="advance_title" class="tabal_head"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="voip_advanced_form" action="/goform/voipAdvancedUser" onSubmit="return CheckForm()">
  <!--table class="tabal_bg" id="voipUserTable" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_title">
        <td width="13%">编号</td>
        <td width="35%">VoIP用户名</td>
        <td width="52%">编码方式</td>
      </tr>
      <tr class="tabal_01">
        <td align="left">1</td>
        <td align="left"><% getCfgGeneral(1, "voip_userName"); %></td>
        <td align="left"><select name="voip_codec" id="voip_codec" size="1" style="width:200px;">
            <option value="0">G.711MuLaw</option>
            <option value="8">G.711ALaw</option>
            <option value="4">G.723.1</option>
            <option value="18">G.729</option>
            <option value="9">G.722</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" height="15" width="100%">
    <tbody>
      <tr>
        <td></td>
      </tr>
    </tbody>
  </table-->
  <table class="tabal_bg" id="voipback" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_RFC2833_title">
        <td id="RFC2833_title" class="tabal_left" width="25%">RFC2833 PT Value</td>
        <td class="tabal_right"><input name="voip_RFC2833" id="voip_RFC2833" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "voip_RFC2833"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0,96~127)</span></td>
      </tr>
      <tr id="tr_RFC2198_title">
        <td id="RFC2198_title" class="tabal_left" width="25%">RFC2198 PT Value</td>
        <td class="tabal_right"><input name="voip_RFC2198" id="voip_RFC2198" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "voip_RFC2198"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(0,96~127)</span></td>
      </tr>
      <tr id="tr_alive_time_title">
        <td id="alive_time_title" class="tabal_left" width="25%">Alive Times</td>
        <td class="tabal_right"><input name="aliveout" id="aliveout" size="8" maxlength="5" type="text" value="<% getCfgGeneral(1, "alive_out"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1~120)</span></td>
      </tr>
      <tr id="tr_alive_title">
        <td id="alive_title" class="tabal_left" width="25%">Alive Interval</td>
        <td class="tabal_right"><input name="aliveinter" id="aliveinter" size="8" maxlength="5" type="text" value="<% getCfgGeneral(1, "alive_interval"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(1~43200)</span></td>
      </tr>
      <tr id="tr_fox_title">
        <td id="fox_title" class="tabal_left" width="25%">Fax Mode</td>
        <td class="tabal_right" align="left"><select name="fox_type" id="fox_type" size="1" style="width:200px;">
            <option id="voip_trans2" value="0" selected="selected">Transparent</option>
            <option value="1">T38</option>
          </select></td>
      </tr>
      <tr id="tr_fanji_title">
        <td id="fanji_title" class="tabal_left" width="25%">ReversedPolarity</td>
        <td class="tabal_right" align="left"><select name="fanji_signal" id="fanji_signal" size="1" style="width:200px;">
            <option id="voip_enable2" value="1" selected="selected">Enable</option>
            <option id="voip_disable2" value="0">Disable</option>
          </select></td>
      </tr>
      <tr  id="tr_tran_title">
        <td id="tran_title" class="tabal_left" width="25%">Character Escape Mode</td>
        <td class="tabal_right" align="left"><select name="to_23" id="to_23" size="1" style="width:200px;">
            <option id="voip_Escape1" value="1" selected="selected">Not escape</option>
            <option id="voip_Escape0" value="0">Escape</option>
          </select></td>
      </tr>
      <tr id="tr_dtmf_title">
        <td class="tabal_left" id="dtmf_title" width="25%">DTMF Mode</td>
        <td class="tabal_right" align="left"><select name="voip_dtmf" id="voip_dtmf" size="1" style="width:200px;">
            <option id="voip_trans1" value="0" selected="selected">Transparent</option>
            <option value="1">RFC2833</option>
          </select></td>
      </tr>
      <!--tr>
	<td class="tabal_left" width="25%">启用同步话机时间:</td>
  	 <td class="tabal_right" align="left">自动</td>    
	</tr>
		<tr>
	 <td class="tabal_left" width="25%">订阅开关:</td>
  	 <td class="tabal_right" align="left">打开</td>    
	</tr>
	<tr>
	 <td class="tabal_left" width="25%">URL格式:</td>
  	 <td class="tabal_right" align="left">SIP</td>    
	</tr>
	<tr>
	 <td class="tabal_left" width="25%">传真控制方式:</td>
  	 <td class="tabal_right" align="left">软交换全控模式</td>    
	</tr>

	<tr>
	 <td class="tabal_left" width="25%">编解码和打包周期协商模式:</td>
     <td class="tabal_right">远端优先</td>
	</tr-->
      <tr id="tr_num_disptype_title">
        <td id="num_disptype_title" class="tabal_left" width="25%">Caller-ID Head Field</td>
        <td class="tabal_right" align="left"><select name="num_from" id="num_from" size="1" style="width:200px;">
            <option id="num_disptype1" value="1" selected="selected">From</option>
            <option id="num_disptype2" value="0">P-Asserted-id</option>
          </select></td>
      </tr>
      <tr id="tr_alivetype_title">
        <td id="alivetype_title" class="tabal_left" width="25%">Keepalive Mode</td>
        <td class="tabal_right" align="left"><select name="jump_type" id="jump_type" size="1" style="width:200px;">
            <option id="voip_disable6" value="0" selected="selected">Disable</option>
            <option id="active_enable" value="1">Active</option>
          </select></td>
      </tr>
      <tr id="tr_localPort_title">
        <td id="localPort_title" class="tabal_left" width="25%">Local Port</td>
        <td class="tabal_right"><input name="localPort" id="localPort" size="8" maxlength="5" type="text" value="<% getCfgGeneral(1, 'localPort'); %>">
          <span class="gray">(1024~65535)</span></td>
      </tr>
      <tr id="tr_call_type" style="display: none">
        <td id="num_disp_title" class="tabal_left" width="25%">CallerIDMode</td>
        <td class="tabal_right"><select name="call_type" id="call_type" size="1" style="width:200px;">
            <option value="FSK">FSK</option>
            <option value="DTMF" selected="selected">DTMF</option>
          </select></td>
      </tr>
      <tr id="tr_voipback_title">
        <td class="tabal_left" id="voipback_title" width="25%">EchoCancel</td>
        <td class="tabal_right" align="left"><select name="voip_back" id="voip_back" size="1" style="width:200px;">
            <option id="voip_enable1" value="1" selected="selected">Enable</option>
            <option id="voip_disable1" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_SilenceSuppression_title">
        <td id="SilenceSuppression_title" class="tabal_left" width="25%">Silence Suppression</td>
        <td class="tabal_right" align="left"><select name="SilenceSuppression" id="SilenceSuppression" size="1" style="width:200px;">
            <option id="voip_enable_SilenceSuppression" value="1" selected="selected">Enable</option>
            <option id="voip_disable_SilenceSuppression" value="0">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td id="callwait_title" class="tabal_left" width="25%">Call-waiting</td>
        <td class="tabal_right" align="left"><select name="ring_wait" id="ring_wait" size="1" style="width:200px;">
            <option id="voip_enable3" value="1" selected="selected">Enable</option>
            <option id="voip_disable3" value="0">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td id="3call_title" class="tabal_left" width="25%">Call Conference</td>
        <td class="tabal_right" align="left"><select name="3_ring" id="3_ring" size="1" style="width:200px;">
            <option id="voip_enable4" value="1" selected="selected">Enable</option>
            <option id="voip_disable4" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_num_disp_title">
        <td id="num_disp_title" class="tabal_left" width="25%">CallerIDMode</td>
        <td class="tabal_right" align="left"><select name="num_disp" id="num_disp" size="1" style="width:200px;">
            <option value="1" selected="selected">FSK</option>
            <option id="voip_disable5" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_set_gain_title">
        <td id="set_gain_title" class="tabal_left" width="25%">Output Gain</td>
        <td class="tabal_right"><input name="set_gain1" id="set_gain1" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "set_gain1"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
      </tr>
      <tr id="tr_rec_gain_title">
        <td id="rec_gain_title" class="tabal_left" width="25%">Input Gain</td>
        <td class="tabal_right"><input name="rec_gain1" id="rec_gain1" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "rec_gain1"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
      </tr>
    </tbody>
  </table>
  <table id="Voipport_2table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_voipback_title2">
        <td class="tabal_left" id="voipback_title2" width="25%">EchoCancel(port 2)</td>
        <td class="tabal_right" align="left"><select name="voip_back2" id="voip_back2" size="1" style="width:200px;">
            <option id="voip_enable12" value="1" selected="selected">Enable</option>
            <option id="voip_disable12" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_SilenceSuppression2_title">
        <td id="SilenceSuppression2_title" class="tabal_left" width="25%">Silence Suppression(port 2)</td>
        <td class="tabal_right" align="left"><select name="SilenceSuppression2" id="SilenceSuppression2" size="1" style="width:200px;">
            <option id="voip_enable2_SilenceSuppression" value="1" selected="selected">Enable</option>
            <option id="voip_disable2_SilenceSuppression" value="0">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td id="callwait_title2" class="tabal_left" width="25%">Call-waiting(port 2)</td>
        <td class="tabal_right" align="left"><select name="ring_wait2" id="ring_wait2" size="1" style="width:200px;">
            <option id="voip_enable32" value="1" selected="selected">Enable</option>
            <option id="voip_disable32" value="0">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td id="3call_title2" class="tabal_left" width="25%">Call Conference(port 2)</td>
        <td class="tabal_right" align="left"><select name="3_ring2" id="3_ring2" size="1" style="width:200px;">
            <option id="voip_enable42" value="1" selected="selected">Enable</option>
            <option id="voip_disable42" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_num_disp_title2">
        <td id="num_disp_title2" class="tabal_left" width="25%">CallerIDMode(port 2)</td>
        <td class="tabal_right" align="left"><select name="num_disp2" id="num_disp2" size="1" style="width:200px;">
            <option value="1" selected="selected">FSK</option>
            <option id="voip_disable52" value="0">Disable</option>
          </select></td>
      </tr>
      <tr id="tr_set_gain_title2">
        <td id="set_gain_title2" class="tabal_left" width="25%">Output Gain(port 2)</td>
        <td class="tabal_right"><input name="set_gain2" id="set_gain2" size="8" maxlength="4" type="text" value="<% getCfgGeneral(1, "set_gain2"); %>">
          <strong style="color:#FF0033">*</strong><span class="gray">(-12~6)</span></td>
      </tr>
      <tr id="tr_rec_gain_title2">
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
