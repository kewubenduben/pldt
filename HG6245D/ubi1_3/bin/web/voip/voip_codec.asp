<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Voip_codec</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipCodecSync = '<% voipCodecSync(); %>';
var voip_port_num = "<% getCfgGeneral(1, 'voip_port_num'); %>";

function LoadFrame()
{
	initTranslation();

	var voip1CodecArray = new Array();	
	voip1CodecArray[0] = "<% getCfgGeneral(1, 'voip1_pri1codec'); %>";
	voip1CodecArray[1] = "<% getCfgGeneral(1, 'voip1_pri2codec'); %>";
	voip1CodecArray[2] = "<% getCfgGeneral(1, 'voip1_pri3codec'); %>";
	voip1CodecArray[3] = "<% getCfgGeneral(1, 'voip1_pri4codec'); %>";
	voip1CodecArray[4] = "<% getCfgGeneral(1, 'voip1_pri5codec'); %>";
	voip1CodecArray[5] = "<% getCfgGeneral(1, 'voip1_pri6codec'); %>";

	var voip1_pri1codec = document.getElementById("voip1_pri1codec");
	var voip1_pri2codec = document.getElementById("voip1_pri2codec");
	var voip1_pri3codec = document.getElementById("voip1_pri3codec");
	var voip1_pri4codec = document.getElementById("voip1_pri4codec");
	var voip1_pri5codec = document.getElementById("voip1_pri5codec");
	var voip1_pri6codec = document.getElementById("voip1_pri6codec");
	
	if(ispNameCode == 10)  /*墨西哥版本*/
	{
		setDisplay("tr_voipcodec1_6", "");
		voip1_pri1codec.options[voip1_pri1codec.length] = new Option("G.729B", "G.729B");
		voip1_pri1codec.options[voip1_pri1codec.length] = new Option("AMR", "AMR");
		voip1_pri2codec.options[voip1_pri2codec.length] = new Option("G.729B", "G.729B");
		voip1_pri2codec.options[voip1_pri2codec.length] = new Option("AMR", "AMR");
		voip1_pri3codec.options[voip1_pri3codec.length] = new Option("G.729B", "G.729B");
		voip1_pri3codec.options[voip1_pri3codec.length] = new Option("AMR", "AMR");
		voip1_pri4codec.options[voip1_pri4codec.length] = new Option("G.729B", "G.729B");
		voip1_pri4codec.options[voip1_pri4codec.length] = new Option("AMR", "AMR");
		voip1_pri5codec.options[voip1_pri5codec.length] = new Option("G.729B", "G.729B");
		voip1_pri5codec.options[voip1_pri5codec.length] = new Option("AMR", "AMR");
		voip1_pri6codec.options[voip1_pri6codec.length] = new Option("G.729B", "G.729B");
		voip1_pri6codec.options[voip1_pri6codec.length] = new Option("AMR", "AMR");
	}

	var nodeNameVoip1;
	for(var i = 1; i <= 6; i++)
	{
		nodeNameVoip1 = "voip1_pri" + i + "codec";
		initVoipCodec(nodeNameVoip1, voip1CodecArray[i-1]);
	}
	
	if(voip_port_num > 1)
	{
		setDisplay("voipCodecTable2", "");
		
		var voip2CodecArray = new Array();	
		voip2CodecArray[0] = "<% getCfgGeneral(1, 'voip2_pri1codec'); %>";
		voip2CodecArray[1] = "<% getCfgGeneral(1, 'voip2_pri2codec'); %>";
		voip2CodecArray[2] = "<% getCfgGeneral(1, 'voip2_pri3codec'); %>";
		voip2CodecArray[3] = "<% getCfgGeneral(1, 'voip2_pri4codec'); %>";
		voip2CodecArray[4] = "<% getCfgGeneral(1, 'voip2_pri5codec'); %>";
		voip2CodecArray[5] = "<% getCfgGeneral(1, 'voip2_pri6codec'); %>";
		
		var voip2_pri1codec = document.getElementById("voip2_pri1codec");
		var voip2_pri2codec = document.getElementById("voip2_pri2codec");
		var voip2_pri3codec = document.getElementById("voip2_pri3codec");
		var voip2_pri4codec = document.getElementById("voip2_pri4codec");
		var voip2_pri5codec = document.getElementById("voip2_pri5codec");
		var voip2_pri6codec = document.getElementById("voip2_pri6codec");
		
		if(ispNameCode == 10)  /*墨西哥版本*/
		{
			setDisplay("tr_voipcodec2_6", "");
			voip2_pri1codec.options[voip2_pri1codec.length] = new Option("G.729B", "G.729B");
			voip2_pri1codec.options[voip2_pri1codec.length] = new Option("AMR", "AMR");
			voip2_pri2codec.options[voip2_pri2codec.length] = new Option("G.729B", "G.729B");
			voip2_pri2codec.options[voip2_pri2codec.length] = new Option("AMR", "AMR");
			voip2_pri3codec.options[voip2_pri3codec.length] = new Option("G.729B", "G.729B");
			voip2_pri3codec.options[voip2_pri3codec.length] = new Option("AMR", "AMR");
			voip2_pri4codec.options[voip2_pri4codec.length] = new Option("G.729B", "G.729B");
			voip2_pri4codec.options[voip2_pri4codec.length] = new Option("AMR", "AMR");
			voip2_pri5codec.options[voip2_pri5codec.length] = new Option("G.729B", "G.729B");
			voip2_pri5codec.options[voip2_pri5codec.length] = new Option("AMR", "AMR");
			voip2_pri6codec.options[voip2_pri6codec.length] = new Option("G.729B", "G.729B");
			voip2_pri6codec.options[voip2_pri6codec.length] = new Option("AMR", "AMR");
		}
		

		var nodeNameVoip2;		
		for(var i = 1; i <= 6; i++)
		{
			nodeNameVoip2 = "voip2_pri" + i + "codec";
			initVoipCodec(nodeNameVoip2, voip2CodecArray[i-1]);
		}

	}
}
function initVoipCodec(curNodeName, curCodec)
{
	var curNode = getElementById(curNodeName);
	for(var i = 0; i < curNode.length; i++)
	{	
		if(curNode.options[i].value == curCodec)
		{
			curNode.options[i].selected = true;
			break;
		}
	}	
}

/*****************************************************************************
 * 函 数 名  : checkCodec
 * 负 责 人  : yclv
 * 创建日期  : 2016年5月4日
 * 函数功能  : 编码方式不能重复，如果有G.729B的情况，G.729和G.729B也不能重复
 * 输入参数  : newCodec :当前选择的编码方式，port:端口号; priority:优先级
 * 输出参数  : 无
 * 返 回 值  : ture ，false
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function checkCodec(newCodec, port, priority)
{
	if(newCodec.value == "")
	{
		return true;
	}
	var curNode;
	for(var i = 1; i <= 6; i++)
	{
		if(i == priority)
		{
			continue;
		}
		else
		{
			curNode = getElementById("voip" + port + "_pri" + i + "codec");
			if(curNode.value == newCodec.value)
			{
				alert(_("codingrepeat"));
				newCodec[0].selected = true;
				curNode[0].selected = true;
				return false;
			}
			
			if((curNode.value == "G.729") && ((newCodec.value == "G.729B")))
			{
				alert(_("codingrepeat"));
				newCodec[0].selected = true;
				curNode[0].selected = true;
				return false;
			}
			
		}
	}
	return true;
}
function checkCodecForm()
{
	var nodeVoip1;
	var nodeVoip2;
	for(var i = 1; i <= 6; i++)
	{
		nodeVoip1 = getElementById("voip1_pri" + i + "codec");
		if(checkCodec(nodeVoip1, 1, i) == false)
		{
			return false;
		}
		var nodeVoip1_period = getElementById("voippacketizationperiod1" + i);
		if(nodeVoip1_period.value != "")
		{
			if(!checkNumberLegal(nodeVoip1_period, 10, 60))	/* validate rtp periodl */
			{
				alert(_("The value you input is illegal"));
				nodeVoip1_period.value = nodeVoip1_period.defaultValue;
				nodeVoip1_period.focus();
				return false;
			}
		}
		
		if(voip_port_num > 1)
		{
			nodeVoip2 = getElementById("voip2_pri" + i + "codec");
			if(checkCodec(nodeVoip2, 2, i) == false)
			{
				return false;
			}
			var nodeVoip2_period = getElementById("voippacketizationperiod2" + i);
			if(nodeVoip2_period.value != "")
			{
				if(!checkNumberLegal(nodeVoip2_period, 10, 60))	/* validate rtp period */
				{
					alert(_("The value you input is illegal"));
					nodeVoip2_period.value = nodeVoip2_period.defaultValue;
					nodeVoip2_period.focus();
					return false;
				}
			}
		}
			
	}
	return true;
}

function initTranslation()
{
	var e = document.getElementById("voip_codec_funcPrompt");
	e.innerHTML = _("voip_codec_funcPrompt");
	e = document.getElementById("port1_title");
	e.innerHTML = _("port1_title");
	e = document.getElementById("port2_title");
	e.innerHTML = _("port2_title");
	e = document.getElementById("voip_codecPriTitle");
	e.innerHTML = _("voip_codecPriTitle");
	e = document.getElementById("voip_codecTitle");
	e.innerHTML = _("voip_codecTitle");
	e = document.getElementById("voip_codecPriTitle2");
	e.innerHTML = _("voip_codecPriTitle");
	e = document.getElementById("voip_codecTitle2");
	e.innerHTML = _("voip_codecTitle");
	e = document.getElementById("packetizationperiod_title");
	e.innerHTML = _("packetizationperiod_title");
	e = document.getElementById("packetizationperiod_title2");
	e.innerHTML = _("packetizationperiod_title");	

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
              <td id="voip_codec_funcPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" name="voip_codec_form" action="/goform/voipCodecCfg" onSubmit="return checkCodecForm()">
  <table class="tabal_bg" id="voipCodecTable1" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td colspan="2"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="tabal_head"><font id="port1_title" face="Arial">Port1</font></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr class="tabal_title">
        <td width="25%" align="center" id="voip_codecPriTitle">Priority</td>
        <td width="40%" align="left" id="voip_codecTitle">Mode</td>
        <td width="35%" align="left" id="packetizationperiod_title">Packetization Period</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">1</td>
        <td class="tabal_right"><select name="voip1_pri1codec" id="voip1_pri1codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod11" id="voippacketizationperiod11" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod11"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">2</td>
        <td class="tabal_right"><select name="voip1_pri2codec" id="voip1_pri2codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod12" id="voippacketizationperiod12" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod12"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">3</td>
        <td class="tabal_right"><select name="voip1_pri3codec" id="voip1_pri3codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod13" id="voippacketizationperiod13" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod13"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">4</td>
        <td class="tabal_right"><select name="voip1_pri4codec" id="voip1_pri4codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod14" id="voippacketizationperiod14" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod14"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">5</td>
        <td class="tabal_right"><select name="voip1_pri5codec" id="voip1_pri5codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod15" id="voippacketizationperiod15" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod15"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr id="tr_voipcodec1_6" style="display: none;">
        <td class="tabal_left" align="center">6</td>
        <td class="tabal_right"><select name="voip1_pri6codec" id="voip1_pri6codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod16" id="voippacketizationperiod16" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod16"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
    </tbody>
    
  </table>
  <table class="tabal_bg" id="voipCodecTable2" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none">
    <tbody>
      <tr>
        <td colspan="2"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="tabal_head"><font id="port2_title" face="Arial">Port2</font></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr class="tabal_title">
        <td width="25%" align="center" id="voip_codecPriTitle2">Priority</td>
        <td width="40%" align="left" id="voip_codecTitle2">Mode</td>
        <td width="35%" align="left" id="packetizationperiod_title2">Packetization Period</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">1</td>
        <td class="tabal_right"><select name="voip2_pri1codec" id="voip2_pri1codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod21" id="voippacketizationperiod21" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod21"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">2</td>
        <td class="tabal_right"><select name="voip2_pri2codec" id="voip2_pri2codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod22" id="voippacketizationperiod22" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod22"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">3</td>
        <td class="tabal_right"><select name="voip2_pri3codec" id="voip2_pri3codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod23" id="voippacketizationperiod23" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod23"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">4</td>
        <td class="tabal_right"><select name="voip2_pri4codec" id="voip2_pri4codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod24" id="voippacketizationperiod24" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod24"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr class="tabal_01">
        <td class="tabal_left" align="center">5</td>
        <td class="tabal_right"><select name="voip2_pri5codec" id="voip2_pri5codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod25" id="voippacketizationperiod25" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod25"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
      <tr id="tr_voipcodec2_6" style="display: none;">
        <td class="tabal_left" align="center">6</td>
        <td class="tabal_right"><select name="voip2_pri6codec" id="voip2_pri6codec" size="1" style="width:200px;">
            <option value="" selected="selected"></option>
            <option value="G.711MuLaw">G.711MuLaw</option>
            <option value="G.711ALaw">G.711ALaw</option>
            <option value="G.723.1">G.723.1</option>
            <option value="G.729">G.729</option>
            <option value="G.722">G.722</option>
          </select></td>
        <td class="tabal_right" align="left"><input type="text" name="voippacketizationperiod26" id="voippacketizationperiod26" size="5" maxlength="2" value="<% getCfgGeneral(1, "voippacketizationperiod26"); %>">
          &nbsp; &nbsp; 10~60(ms)</td>
      </tr>
    </tbody>
    
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit"  id="basic_apply" type="submit">
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
