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
<title>HotLine</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

var voipCodecSync = '<% voip_hotline_sync(); %>';
var voip_port_num = "<% getCfgGeneral(1, 'voip_port_num'); %>";



function initTranslation()
{
	var e = document.getElementById("hotline_Prompt");
	e.innerHTML = _("hotline_Prompt");
	var e = document.getElementById("hotlineport1_title");
	e.innerHTML = _("hotlineport1_title");
	var e = document.getElementById("hotlineport2_title");
	e.innerHTML = _("hotlineport2_title");
	var e = document.getElementById("enableTitle1");
	e.innerHTML = _("enableTitle");
	var e = document.getElementById("enableTitle2");
	e.innerHTML = _("enableTitle");
	var e = document.getElementById("hotline_enableTitle1");
	e.innerHTML = _("voip_enable");
	var e = document.getElementById("hotline_enableTitle2");
	e.innerHTML = _("voip_enable");
	var e = document.getElementById("hotline_disableTitle1");
	e.innerHTML = _("voip_disable");
	var e = document.getElementById("hotline_disableTitle2");
	e.innerHTML = _("voip_disable");
		
	var e = document.getElementById("HotlineNumberTitle1");
	e.innerHTML = _("HotlineNumberTitle");
	var e = document.getElementById("HotlineNumberTitle2");
	e.innerHTML = _("HotlineNumberTitle");
	var e = document.getElementById("HotlineDelayTitle1");
	e.innerHTML = _("HotlineDelayTitle");
	var e = document.getElementById("HotlineDelayTitle2");
	e.innerHTML = _("HotlineDelayTitle");

	e = document.getElementById("hotline_apply");
	e.value = _("voip_apply");
	e = document.getElementById("hotline_cancel");
	e.value = _("voip_cancel");
}
function initValue()
{
	initTranslation();
	var hotline_enable1 = "<% getCfgGeneral(1, "hotline_enable1"); %>";
	var hotline_enableNode1 = getElement("hotline_enable1");

	
	for(var i = 0; i < hotline_enableNode1.length; i++)
	{
		if(hotline_enableNode1[i].value == hotline_enable1)
		{
			hotline_enableNode1[i].checked = true;
			break;
		}
	}

	if(hotline_enableNode1[1].checked == true)
	{
		setDisplay("tr_hotline_number1","none");
		setDisplay("tr_hotline_delay1","none");
	}
	else
	{
		setDisplay("tr_hotline_number1","");
		setDisplay("tr_hotline_delay1","");
	}

	if(voip_port_num > 1)
	{
		setDisplay("hotline_port2_tb", "");
		var hotline_enable2 = "<% getCfgGeneral(1, "hotline_enable2"); %>";
		var hotline_enableNode2 = getElement("hotline_enable2");
		for(var i = 0; i < hotline_enableNode2.length; i++)
		{
			if(hotline_enableNode2[i].value == hotline_enable2)
			{
				hotline_enableNode2[i].checked = true;
				break;
			}
		}

		if(hotline_enableNode2[1].checked == true)
		{
			setDisplay("tr_hotline_number2","none");
			setDisplay("tr_hotline_delay2","none");
		}
		else
		{
			setDisplay("tr_hotline_number2","");
			setDisplay("tr_hotline_delay2","");
		}
	}
}

/*****************************************************************************
 * 函 数 名  : onClickMethod
 * 负 责 人  : yclv
 * 创建日期  : 2016年5月4日
 * 函数功能  : 端口1使能复选框点击事件，使能显示输入框，去使能隐藏
 * 输入参数  : id
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function onClickMethod(chooseValue)
{   
	with(document.forms[0]){
		if(chooseValue == "1"){					/* 启动 */
			setDisplay("tr_hotline_number1","");
			setDisplay("tr_hotline_delay1","");
		}
		else if(chooseValue == "0"){				/* 关闭 */
			setDisplay("tr_hotline_number1","none");
			setDisplay("tr_hotline_delay1","none");
		}
	}	
}

/*****************************************************************************
 * 函 数 名  : onClickMethod2
 * 负 责 人  : yclv
 * 创建日期  : 2016年5月4日
 * 函数功能  : 端口2使能复选框点击事件，使能显示输入框，去使能隐藏
 * 输入参数  : id
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function onClickMethod2(chooseValue)
{   
	with(document.forms[0]){
		if(chooseValue == "1"){					/* 启动 */
			setDisplay("tr_hotline_number2","");
			setDisplay("tr_hotline_delay2","");
		}
		else if(chooseValue == "0"){				/* 关闭 */
			setDisplay("tr_hotline_number2","none");
			setDisplay("tr_hotline_delay2","none");
		}
	}	
}

function checkValue()
{
	var hotline_delay1 = document.getElementById("hotline_delay1");
	var hotline_enableNode1 = getElement("hotline_enable1");

	if(hotline_enableNode1[0].checked == true)
	{
		if (hotline_delay1.value != "")
		{
			if(!checkNumberLegal(hotline_delay1, 0, 10))
			{
				alert(_("The value you input is illegal"));
				return false;
			}
		}
	}

	if(voip_port_num > 1)
	{
		
		var hotline_delay2 = document.getElementById("hotline_delay2");
		var hotline_enableNode2 = getElement("hotline_enable2");
		if(hotline_enableNode2[0].checked == true)
		{
			if (hotline_delay2.value != "")
			{
				if(!checkNumberLegal(hotline_delay2, 0, 10))
				{
					alert(_("The value you input is illegal"));
					return false;
				}
			}
		}
	}

}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="hotline_tb" id="hotline_tb" action="/goform/voip_hotline_cfg" onSubmit="return checkValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="hotline_Prompt" style="padding-left: 10px;" class="title_01" width="100%"> </td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="hotline_port1_tb" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
     <tr>
        <td colspan="2"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="tabal_head"><font id="hotlineport1_title"  face="Arial">Hotline Port1</font></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    <tr>
      <td class="tabal_left" id="enableTitle1" align="left" width="25%">Enable</td>
      <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="hotline_enable1" onclick="onClickMethod(this.value)" type="radio">
        <span id="hotline_enableTitle1">enable</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <input value="0" name="hotline_enable1" onclick="onClickMethod(this.value)" type="radio" checked="checked">
        <span id="hotline_disableTitle1">disable</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong></td>
    </tr>
    <div id="div_hotline1">
    <tr id="tr_hotline_number1">
      <td class="tabal_left" width="20%" id="HotlineNumberTitle1">Hotline Number</td>
      <td class="tabal_right"><input name="hotline_number1" id="hotline_number1" maxlength=64 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "hotline_number1"); %>">
       <span class="gray" id="hotline_numberTips1"></span></td>
    </tr>
    <tr id="tr_hotline_delay1">
      <td class="tabal_left" width="20%" id="HotlineDelayTitle1">Hotline Delay</td>
      <td class="tabal_right"><input name="hotline_delay1" id="hotline_delay1" maxlength=5 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "hotline_delay1"); %>">
        <span class="gray" id="hotline_delayTips1">(0-10)</span></td>
    </tr>
    </div>
  </tbody>
</table>
<table id="hotline_port2_tb" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%"  style="display: none">
  <tbody>
     <tr>
        <td colspan="2"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="tabal_head"><font id="hotlineport2_title"  face="Arial">Hotline Port2</font></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    <tr>
      <td class="tabal_left" id="enableTitle2" align="left" width="25%">Enable</td>
      <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="hotline_enable2" onclick="onClickMethod2(this.value)" type="radio">
        <span id="hotline_enableTitle2">enable</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <input value="0" name="hotline_enable2" onclick="onClickMethod2(this.value)" type="radio" checked="checked">
        <span id="hotline_disableTitle2">disable</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong></td>
    </tr>
    <div id="div_hotline2">
    <tr id="tr_hotline_number2">
      <td class="tabal_left" width="20%" id="HotlineNumberTitle2">Hotline Number</td>
      <td class="tabal_right"><input name="hotline_number2" id="hotline_number2" maxlength=64 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "hotline_number2"); %>">
       <span class="gray" id="hotline_numberTips2"></span></td>
    </tr>
    <tr id="tr_hotline_delay2">
      <td class="tabal_left" width="20%" id="HotlineDelayTitle2">Hotline Delay</td>
      <td class="tabal_right"><input name="hotline_delay2" id="hotline_delay2" maxlength=5 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "hotline_delay2"); %>">
        <span class="gray" id="hotline_delayTips2">(0-10)</span></td>
    </tr>
    </div>
  </tbody>
</table>
<table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="tabal_submit" width="25%"></td>
      <td class="tabal_submit"><input type="submit" value="Apply" id="hotline_apply" class="submit">
        <input type="reset" value="Cancel" id="hotline_cancel" class="submit" onClick="window.location.reload()">
      </td>
    </tr>
  </tbody>
</table>
</form>
</body>
</html>

