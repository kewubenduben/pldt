<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Voip_timer</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipProtocolSync = '<% voipProtocolSync(); %>';
var voipTimerSync = '<% voipTimerSync(); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

function LoadFrame()
{
	var voip_logplotmode = "<% getCfgGeneral(1, "voip_logplotmode"); %>";
	var voip_logplotmodeNode = document.getElementById("voip_logplotmode");
	for(var i = 0; i< voip_logplotmodeNode.length; i++)
	{	
		if(voip_logplotmodeNode.options[i].value == voip_logplotmode)
		{
			voip_logplotmodeNode.options[i].selected = true;
			break;
		}
	}
	
	if(voip_port_num == 2)
	{
		setDisplay("Voipport_2table", "");
	}
	else
	{
		setDisplay("Voipport_2table", "none");
	}
	if(ispNameCode == 5)	//X_AIS
	{
		setDisplay("tr_jitterBuffer_1", "");
		setDisplay("tr_jitterRange_1", "");
		setDisplay("tr_jitterBuffer_2", "");
		setDisplay("tr_jitterRange_2", "");

		/*add begin by郭心悦，20170117，原因:泰国AIS普通用户可以显示Jitter Buffer，Min Value，Max Value参数*/
		if(curUserType == 1)
		{
			document.getElementById("tr_logplotmode_title").style.display = "none"; 
			document.getElementById("tr_logplot_title").style.display = "none"; 
			document.getElementById("tr_shortdigittimer_title").style.display = "none";
			document.getElementById("tr_longdigittimer_title").style.display = "none";
			document.getElementById("tr_startdigittimer_title").style.display = "none";
			document.getElementById("tr_voiplongcalltime_title").style.display = "none";
			document.getElementById("tr_voiphanguptime_title").style.display = "none";
			document.getElementById("tr_voipbusytime_title").style.display = "none";
			document.getElementById("tr_voipreinter_title").style.display = "none";
			document.getElementById("tr_voipsonwtime_title").style.display = "none";
			document.getElementById("tr_flashtime_title").style.display = "none";
			document.getElementById("tr_sipregistperiod_title").style.display = "none";
		}
		/*add end by郭心悦，20170117*/
	}
	else
	{
		setDisplay("tr_jitterBuffer_1", "none");
		setDisplay("tr_jitterRange_1", "none");
		setDisplay("tr_jitterBuffer_2", "none");
		setDisplay("tr_jitterRange_2", "none");
	}
	if(ispNameCode == '12')	//厄瓜多尔CNT
		setDisplay("tr_onHookConfirmTime", "");
	else if(ispNameCode == '26')	//add by wuxj, 20171226, for TIM
	{
		setDisplay("tr_dscpSip_title", "");
		setDisplay("tr_dscpRtp_title", "");
		
		var voip_dscpSip = "<% getCfgGeneral(1, 'voip_dscpSip'); %>";
		showSelectNodeByValue(getElement('voip_dscpSip'), voip_dscpSip);
		var voip_dscpRtp = "<% getCfgGeneral(1, 'voip_dscpRtp'); %>";
		showSelectNodeByValue(getElement('voip_dscpRtp'), voip_dscpRtp);
	}
	
	initTranslation();
}

function initTranslation()
{	
	var e = document.getElementById("logplotmode_title");
	e.innerHTML = _("logplotmode_title");
	e = document.getElementById("timer_promt");
	e.innerHTML = _("timer_promt");
	e = document.getElementById("max_title");
	e.innerHTML = _("max_title");
	e = document.getElementById("min_title");
	e.innerHTML = _("min_title");
	e = document.getElementById("logplot_title");
	e.innerHTML = _("logplot_title");
	e = document.getElementById("sipregistperiod_title");
	e.innerHTML = _("sipregistperiod_title");
	e = document.getElementById("shortdigittimer_title");
	e.innerHTML = _("shortdigittimer_title");
	e = document.getElementById("longdigittimer_title");
	e.innerHTML = _("longdigittimer_title");
	e = document.getElementById("startdigittimer_title");
	e.innerHTML = _("startdigittimer_title");
	e = document.getElementById("voipreinter_title");
	e.innerHTML = _("voipreinter_title");
	e = document.getElementById("voipsonwtime_title");
	e.innerHTML = _("voipsonwtime_title");
	
	e = document.getElementById("voiplongcalltime_title");
	e.innerHTML = _("voiplongcalltime_title");
	e = document.getElementById("voiphanguptime_title");
	e.innerHTML = _("voiphanguptime_title");
	e = document.getElementById("voipbusytime_title");
	e.innerHTML = _("voipbusytime_title");
	e = document.getElementById("flashtime_title");
	e.innerHTML = _("flashtime_title");
	e = document.getElementById("slidingspring_tip");
	if(ispNameCode == '12')	//厄瓜多尔CNT
		e.innerHTML = _("slidingspring_50tip");
	else
		e.innerHTML = _("slidingspring_tip");
	e = document.getElementById("timer_title");
	e.innerHTML = _("timer_title");
	
	e = document.getElementById("jitterBuffer_1_title");
	e.innerHTML = _("jitterBuffer_title");
	e = document.getElementById("jitterRange_1_title");
	e.innerHTML = _("jitterRange_title");
	e = document.getElementById("jitterBuffer_2_title");
	e.innerHTML = _("jitterBuffer_title") + _("port2_title_suffix");
	e = document.getElementById("jitterRange_2_title");
	e.innerHTML = _("jitterRange_title") + _("port2_title_suffix");
	
	e = document.getElementById("basic_apply");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel");
	e.value = _("voip_cancel");
}

function CheckTimeForm()
{
	var field;
	
	/* validate voipsipregistperiod"); */
	field = document.getElementById("voipsipregistperiod");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip regist period."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 120, 65535))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voipshortdigittimer"); */
	field = document.getElementById("voipshortdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip short digit timer"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))	//modify by wuxj 20151105, 修改为与网管需求相同
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voiplongdigittimer"); */
	field = document.getElementById("voiplongdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip long digit timer."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))	//modify by wuxj 20151105, 修改为与网管需求相同
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voiplongcalltime */
	field = document.getElementById("voiplongcalltime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip long call time."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voiphanguptime */
	field = document.getElementById("voiphanguptime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input hang up time."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate voipbusytime */
	field = document.getElementById("voipbusytime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert(_("请输入忙音时间!"));
		alert(_("Please input busy time."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

	/* validate voipbusytime */
	field = document.getElementById("voipstartdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input start digit timer."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))	//modify by wuxj 20151105, 修改为与网管需求相同
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

	/* 注册消息重传间隔*/
	field = document.getElementById("voipreinter");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		
		alert(_("Please input Regist Message retransmission interval."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 30, 3600))		/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}

	/* 雪崩定时器*/
	field = document.getElementById("voip_snowtime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		
		alert(_("Please input Avalanche Timer."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	else if(!checkNumberLegal(field, 1, 254))					/* validate whether legal */
	{		
		field.value = field.defaultValue;
		field.focus();
		alert(_("The value you input is illegal"));
		return false;
	}
	
	/* validate slidingspringmintime */
	field = document.getElementById("slidingspringmintime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入拍插簧时间范围!");
		alert(_("Please input sliding spring time."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	if(ispNameCode == '12')	//厄瓜多尔CNT
	{
		if(!checkNumberLegal(field, 50, 900))					/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
	}
	else
	{
		if(!checkNumberLegal(field, 90, 2500))					/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
	}
	if(parseInt(field.value) % 10 != 0)					/* validate whether legal */
	{
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* validate slidingspringmaxtime */
	field = document.getElementById("slidingspringmaxtime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert(_("请输入拍插簧时间范围!"));
		alert(_("Please input sliding spring time."));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	if(ispNameCode == '12')	//厄瓜多尔CNT
	{
		if(!checkNumberLegal(field, 50, 900))					/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
	}
	else
	{
		if(!checkNumberLegal(field, 90, 2500))					/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
	}
	if(parseInt(field.value) % 10 != 0)					/* validate whether legal */
	{
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* slidingspringmaxtime must bigger than or equal to slidingspringmintime */
	var temp = document.getElementById("slidingspringmintime");
	temp.value = trim(temp.value);
	if((parseInt(temp.value) > parseInt(field.value)) || (parseInt(temp.value) == parseInt(field.value)))
	{
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		temp.value = temp.defaultValue;
		field.focus();
		return false;
	}

	if(ispNameCode == '12')	//厄瓜多尔CNT
	{
		/* onHookConfirmTime */
		field = getElement("onHookConfirmTime");
		field.value = trim(field.value);
		if (!CheckNotNull(field.value)) {					/* not null */
			alert(_("onHookConfirmTimeNullAlert"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
		if(!checkNumberLegal(field, 600, 2500))				/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
		if(parseInt(field.value) % 10 != 0)					/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			field.value = field.defaultValue;
			field.focus();
			return false;
		}
	}
	
	if(ispNameCode == 5)	//X_AIS
	{		
		/* maxValue must bigger than or equal to minValue */
		var minValue_1 = getElement("minValue_1");
		minValue_1.value = trim(minValue_1.value);
		if(!checkNumberLegal(minValue_1, 0, 150))	/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
		var maxValue_1 = getElement("maxValue_1");
		maxValue_1.value = trim(maxValue_1.value);
		if(!checkNumberLegal(maxValue_1, 0, 300))	/* validate whether legal */
		{
			alert(_("The value you input is illegal"));
			return false;
		}
		else if(parseInt(minValue_1.value) > parseInt(maxValue_1.value))
		{
			alert(_("maxValueIllegalAlert"));
			maxValue_1.value = maxValue_1.defaultValue;
			maxValue_1.focus();
			return false;
		}
		
		if(voip_port_num == 2)
		{
			var minValue_2 = getElement("minValue_2");
			minValue_2.value = trim(minValue_2.value);
			if(!checkNumberLegal(minValue_2, 0, 150))	/* validate whether legal */
			{
				alert(_("The value you input is illegal"));
				return false;
			}
			var maxValue_2 = getElement("maxValue_2");
			maxValue_2.value = trim(maxValue_2.value);
			if(!checkNumberLegal(maxValue_2, 0, 300))	/* validate whether legal */
			{
				alert(_("The value you input is illegal"));
				return false;
			}
			else if(parseInt(minValue_2.value) > parseInt(maxValue_2.value))
			{
				alert(_("maxValueIllegalAlert"));
				maxValue_2.value = maxValue_2.defaultValue;
				maxValue_2.focus();
				return false;
			}
		}
	}
	
	return true;
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
              <td id="timer_promt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method=post name="fm_voip_timer" action="/goform/setVoipTimer" onSubmit="return CheckTimeForm()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td id="timer_title" class="tabal_head">VoIP Timer Param</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_logplotmode_title">
        <td class="tabal_left" id="logplotmode_title" align="left" width="25%">Logplot Mode</td>
        <td class="tabal_right" align="left"><select name="voip_logplotmode" id="voip_logplotmode" size="1" style="width:182px;">
            <option id="max_title" value="Max">Max</option>
            <option id="min_title" value="Min">Min</option>
          </select>
          &nbsp; &nbsp; </td>
      </tr>
      <tr id="tr_logplot_title">
        <td class="tabal_left" id="logplot_title" align="left" width="25%">Logplot</td>
        <td class="tabal_right" align="left"><textarea name="voip_logplot" id="voip_logplot" rows="5" cols="60"><% getDigitMapString(); %></textarea></td>
      </tr>
      <tr id="tr_sipregistperiod_title">
        <td class="tabal_left" id="sipregistperiod_title" align="left" width="25%">Regist Period</td>
        <td class="tabal_right" align="left"><input type="text" name="voipsipregistperiod" id="voipsipregistperiod" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipsipregistperiod"); %>">
          &nbsp; &nbsp;  120~65535(s) </td>
      </tr>
      <tr id="tr_shortdigittimer_title">
        <td class="tabal_left" id="shortdigittimer_title" align="left" width="25%">Short Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voipshortdigittimer" id="voipshortdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipshortdigittimer"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      <tr id="tr_longdigittimer_title">
        <td class="tabal_left" id="longdigittimer_title" align="left" width="25%">Long Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voiplongdigittimer" id="voiplongdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voiplongdigittimer"); %>">
          &nbsp; &nbsp;  1~254(s) </td>
      </tr>
      <tr id="tr_startdigittimer_title">
        <td class="tabal_left" id="startdigittimer_title" align="left" width="25%">Start Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voipstartdigittimer" id="voipstartdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipstartdigittimer"); %>">
          &nbsp; &nbsp; 1~254(s)</td>
      </tr>
      <tr id="tr_voiplongcalltime_title">
        <td class="tabal_left" id="voiplongcalltime_title" align="left" width="25%">Long Call Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voiplongcalltime" id="voiplongcalltime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voiplongcalltime"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      <tr id="tr_voiphanguptime_title">
        <td class="tabal_left" id="voiphanguptime_title" align="left" width="25%">Hang Up Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voiphanguptime" id="voiphanguptime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voiphanguptime"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      <tr id="tr_voipbusytime_title">
        <td class="tabal_left" id="voipbusytime_title" align="left" width="25%">Busy Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voipbusytime" id="voipbusytime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voipbusytime"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      </tr>
      
      <tr id="tr_voipreinter_title">
        <td class="tabal_left" id="voipreinter_title" align="left" width="25%">Retransmission Interval</td>
        <td class="tabal_right" align="left"><input type="text" name="voipreinter" id="voipreinter" size="30" maxlength="4" value="<% getCfgGeneral(1, "voipreinter"); %>">
          &nbsp; &nbsp; 30~3600(s) </td>
      </tr>
      <tr id="tr_voipsonwtime_title">
        <td class="tabal_left" id="voipsonwtime_title" width="25%">Avalanche Timer</td>
        <td class="tabal_right" align="left"><input name="voip_snowtime" id="voip_snowtime" size="30" maxlength="4" type="text" value="<% getCfgGeneral(1, "voip_snowtime"); %>">
          &nbsp; &nbsp; 1~254(s)</td>
      </tr>
      <tr id="tr_flashtime_title">
        <td class="tabal_left" id="flashtime_title" align="left" width="25%">Sliding Spring Time</td>
        <td class="tabal_right" align="left"><input type="text" name="slidingspringmintime" id="slidingspringmintime" size="10" maxlength="4" value="<% getCfgGeneral(1, "slidingspringmintime"); %>">
          &nbsp;--&nbsp;
          <input type="text" name="slidingspringmaxtime" id="slidingspringmaxtime" size="10" maxlength="4" value="<% getCfgGeneral(1, "slidingspringmaxtime"); %>">
          <span id="slidingspring_tip">&nbsp; &nbsp; 90~2500(ms), multiple of 10</span></td>
      </tr>
      <tr id="tr_onHookConfirmTime" style="display: none">
        <td class="tabal_left" id="onHookConfirmTime_title" align="left" width="25%">OnHook Confirm Time</td>
        <td class="tabal_right" align="left"><input type="text" name="onHookConfirmTime" size="30" maxlength="4" value="<% getCfgGeneral(1, 'onHookConfirmTime'); %>">
          &nbsp; &nbsp; 600~2500(ms) </td>
      </tr>
      <tr id="tr_jitterBuffer_1" style="display: none">
        <td class="tabal_left" id="jitterBuffer_1_title" align="left" width="25%">Jitter Buffer</td>
        <td class="tabal_right" align="left"><input type="text" name="jitterBuffer_1" size="30" maxlength="9" value="<% getCfgGeneral(1, 'voipJitterBuffer_1'); %>"></td>
      </tr>
      <tr id="tr_jitterRange_1">
        <td class="tabal_left" id="jitterRange_1_title" align="left" width="25%">Jitter Buffer Range</td>
        <td class="tabal_right" align="left"><input type="text" name="minValue_1" size="4" maxlength="3" value="<% getCfgGeneral(1, 'voipMinValue_1'); %>">
          &nbsp;0-150(ms)&nbsp;--&nbsp;
          <input type="text" name="maxValue_1" size="4" maxlength="3" value="<% getCfgGeneral(1, 'voipMaxValue_1'); %>">
          &nbsp; &nbsp; 0~300(ms)</td>
      </tr>
      <tr id="tr_dscpSip_title" style="display: none">
        <td class="tabal_left" id="dscpSip_title" align="left" width="25%">DSCP for SIP</td>
        <td class="tabal_right" align="left"><select name="voip_dscpSip" size="1" style="width:185px;">
            <option value="46">EF(101110)</option>
            <option value="14">AF13(001110)</option>
            <option value="12">AF12(001100)</option>
            <option value="10">AF11(001010)</option>
            <option value="8">CS1(001000)</option>
            <option value="22">AF23(010110)</option>
            <option value="20">AF22(010100)</option>
            <option value="18">AF21(010010)</option>
            <option value="16">CS2(010000)</option>
            <option value="30">AF33(011110)</option>
            <option value="28">AF32(011100)</option>
            <option value="26">AF31(011010)</option>
            <option value="24">CS3(011000)</option>
            <option value="38">AF43(100110)</option>
            <option value="34">AF41(100010)</option>
            <option value="32">CS4(100000)</option>
            <option value="40">CS5(101000)</option>
            <option value="48">CS6(110000)</option>
            <option value="56">CS7(111000)</option>
          </select></td>
      </tr>
      <tr id="tr_dscpRtp_title" style="display: none">
        <td class="tabal_left" id="dscpRtp_title" align="left" width="25%">DSCP for RTP</td>
        <td class="tabal_right" align="left"><select name="voip_dscpRtp" size="1" style="width:185px;">
            <option value="46">EF(101110)</option>
            <option value="14">AF13(001110)</option>
            <option value="12">AF12(001100)</option>
            <option value="10">AF11(001010)</option>
            <option value="8">CS1(001000)</option>
            <option value="22">AF23(010110)</option>
            <option value="20">AF22(010100)</option>
            <option value="18">AF21(010010)</option>
            <option value="16">CS2(010000)</option>
            <option value="30">AF33(011110)</option>
            <option value="28">AF32(011100)</option>
            <option value="26">AF31(011010)</option>
            <option value="24">CS3(011000)</option>
            <option value="38">AF43(100110)</option>
            <option value="34">AF41(100010)</option>
            <option value="32">CS4(100000)</option>
            <option value="40">CS5(101000)</option>
            <option value="48">CS6(110000)</option>
            <option value="56">CS7(111000)</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <table id="Voipport_2table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_jitterBuffer_2" style="display: none">
        <td class="tabal_left" id="jitterBuffer_2_title" align="left" width="25%">Jitter Buffer(port 2)</td>
        <td class="tabal_right" align="left"><input type="text" name="jitterBuffer_2" size="30" maxlength="9" value="<% getCfgGeneral(1, 'voipJitterBuffer_2'); %>"></td>
      </tr>
      <tr id="tr_jitterRange_2">
        <td class="tabal_left" id="jitterRange_2_title" align="left" width="25%">Jitter Buffer Range(port 2)</td>
        <td class="tabal_right" align="left"><input type="text" name="minValue_2" size="4" maxlength="3" value="<% getCfgGeneral(1, 'voipMinValue_2'); %>">
          &nbsp;0-150(ms)&nbsp;--&nbsp;
          <input type="text" name="maxValue_2" size="4" maxlength="3" value="<% getCfgGeneral(1, 'voipMaxValue_2'); %>">
          &nbsp; &nbsp; 0~300(ms)</td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" id="basic_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" id="basic_cancel" onClick="window.location.reload()">
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
