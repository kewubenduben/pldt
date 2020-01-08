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
web_access_check( checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipProtocolSync = '<% voipProtocolSync(); %>';
var voipTimerSync = '<% voipTimerSync(); %>';

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
	initTranslation();
}

function initTranslation()
{
	
	var e = document.getElementById("logplotmode_title");
	e.innerHTML = _("logplotmode_title");
	e = document.getElementById("timer_promt");
	e.innerHTML = _("timer_promt");
	
	var e = document.getElementById("startdigittimer_title");
	e.innerHTML = _("startdigittimer_title");
	e = document.getElementById("max_title");
	e.innerHTML = _("max_title");
	e = document.getElementById("min_title");
	e.innerHTML = _("min_title");
	e = document.getElementById("timer_title");
	e.innerHTML = _("timer_title");	

	e = document.getElementById("shortdigittimer_title");
	e.innerHTML = _("shortdigittimer_title");
	e = document.getElementById("longdigittimer_title");
	e.innerHTML = _("longdigittimer_title");
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
	
	e = document.getElementById("basic_apply");
	e.value = _("voip_apply");
	e = document.getElementById("basic_cancel");
	e.value = _("voip_cancel");
}

function CheckTimeForm()
{
	var field;
	
	/* validate voipshortdigittimer"); */
	field = document.getElementById("voipshortdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip short digit timer"));
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
	
	/* validate voiplongdigittimer"); */
	field = document.getElementById("voiplongdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		alert(_("Please input voip long digit timer."));
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
	
	/* validate voipstartdigittimer"); */
	field = document.getElementById("voipstartdigittimer");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入起始定时器时长!");
		alert(_("Please input start digit timer"));
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
	
	/* validate voiplongcalltime */
	field = document.getElementById("voiplongcalltime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入久叫不应的时间!");
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
		//alert("请输入催挂音时间!");
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
		//alert("请输入忙音时间!");
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
		if(!checkNumberLegal(field, 50, 2500))					/* validate whether legal */
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
		//alert("输入值有误！");
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* validate slidingspringmaxtime */
	field = document.getElementById("slidingspringmaxtime");
	field.value = trim(field.value);
	if (!CheckNotNull(field.value)) {					/* not null */
		//alert("请输入拍插簧时间范围!");
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	if(ispNameCode == '12')	//厄瓜多尔CNT
	{
		if(!checkNumberLegal(field, 50, 2500))					/* validate whether legal */
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
		//alert("输入值有误！");
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		field.focus();
		return false;
	}
	
	/* slidingspringmaxtime must bigger than or equal to slidingspringmintime */
	var temp = document.getElementById("slidingspringmintime");
	temp.value = trim(temp.value);
	if(parseInt(temp.value) > parseInt(field.value))
	{
		//alert("拍插簧时间范围不合法! ");
		alert(_("The value you input is illegal"));
		field.value = field.defaultValue;
		temp.value = temp.defaultValue;
		field.focus();
		return false;
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
      <tr>
        <td class="tabal_left" id="logplotmode_title" align="left" width="25%">Logplot Mode</td>
        <td class="tabal_right" align="left"><select name="voip_logplotmode" id="voip_logplotmode" size="1" style="width:182px;">
            <option id="max_title" value="Max">Max</option>
            <option id="min_title" value="Min">Min</option>
          </select>
          &nbsp; &nbsp; </td>
      </tr>
      <tr>
        <td class="tabal_left" id="shortdigittimer_title" align="left" width="25%">Short Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voipshortdigittimer" id="voipshortdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipshortdigittimer"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      <tr>
        <td class="tabal_left" id="longdigittimer_title" align="left" width="25%">Long Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voiplongdigittimer" id="voiplongdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voiplongdigittimer"); %>">
          &nbsp; &nbsp;1~254(s)</td>
      </tr>
      <tr>
        <td class="tabal_left" id="startdigittimer_title" align="left" width="25%">Start Digit Timer</td>
        <td class="tabal_right" align="left"><input type="text" name="voipstartdigittimer" id="voipstartdigittimer" size="30" maxlength="5" value="<% getCfgGeneral(1, "voipstartdigittimer"); %>">
          &nbsp; &nbsp; 1~254(s)</td>
      </tr>
      <tr>
        <td class="tabal_left" id="voiplongcalltime_title" align="left" width="25%">Long Call Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voiplongcalltime" id="voiplongcalltime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voiplongcalltime"); %>">
          &nbsp; &nbsp; 1~254(s) </td>
      </tr>
      <tr>
        <td class="tabal_left" id="voiphanguptime_title" align="left" width="25%">Hang Up Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voiphanguptime" id="voiphanguptime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voiphanguptime"); %>">
          &nbsp; &nbsp; 1~254(s)</td>
      </tr>
      <tr>
        <td class="tabal_left" id="voipbusytime_title" align="left" width="25%">Busy Time</td>
        <td class="tabal_right" align="left"><input type="text" name="voipbusytime" id="voipbusytime" size="30" maxlength="3" value="<% getCfgGeneral(1, "voipbusytime"); %>">
          &nbsp; &nbsp;  1~254(s) </td>
      </tr>
      <tr>
        <td class="tabal_left" id="flashtime_title" align="left" width="25%">Sliding Spring Time</td>
        <td class="tabal_right" align="left"><input type="text" name="slidingspringmintime" id="slidingspringmintime" size="10" maxlength="4" value="<% getCfgGeneral(1, "slidingspringmintime"); %>">
          &nbsp;--&nbsp;
          <input type="text" name="slidingspringmaxtime" id="slidingspringmaxtime" size="10" maxlength="4" value="<% getCfgGeneral(1, "slidingspringmaxtime"); %>">
          <span  id="slidingspring_tip">90~2500(ms), multiple of 10</span></td>
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
