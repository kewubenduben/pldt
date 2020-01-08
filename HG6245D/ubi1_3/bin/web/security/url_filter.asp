<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>URL Filter</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;
var URLsize = '<% GetURLsizeSync(); %>';
var URL_Black_WhiteSync = '<% URL_Black_WhiteSync(); %>';
var pf_ruleSum;

function initTranslation()
{
	var e = document.getElementById("url_filterPrompt");
	e.innerHTML = _("url_filterPrompt");

	e = document.getElementById("URLenable_title");
	e.innerHTML = _("URLenable_title");
	e = document.getElementById("enable");
	e.innerHTML = _("firewall_enable");
	e = document.getElementById("disable");
	e.innerHTML = _("firewall_disable");
	e = document.getElementById("urldown_title");
	e.innerHTML = _("urldown_title");
	e = document.getElementById("URL_white");
	e.innerHTML = _("firewall_white");
	e = document.getElementById("RUL_black");
	e.innerHTML = _("firewall_black");
	e = document.getElementById("updown_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("updown_cancel");
	e.value = _("firewall_cancel");

	e = document.getElementById("urltime");
	e.innerHTML = _("urltime");
	e = document.getElementById("url_enableTitle");
	e.innerHTML = _("url_enableTitle");
	e = document.getElementById("url_enableTitle2");
	e.innerHTML = _("URLenable_title");
	e = document.getElementById("url_start_time");
	e.innerHTML = _("url_start_time");
	e = document.getElementById("url_end_time");
	e.innerHTML = _("url_end_time");
	e = document.getElementById("url_time_infor1");
	e.innerHTML = _("url_time_infor");
	e = document.getElementById("url_time_infor2");
	e.innerHTML = _("url_time_infor");

	e = document.getElementById("fw_add");
	e.value = _("fw_add");
	e = document.getElementById("fw_delete");
	e.value = _("fw_delete");
	e = document.getElementById("fw_deleteAll");
	e.value = _("fw_deleteAll");	

	e = document.getElementById("url_filterListHead");
	e.innerHTML = _("url_filterListHead");
	e = document.getElementById("urlip");
	e.innerHTML = _("urlip");
	e = document.getElementById("url_IPTitle");
	e.innerHTML = _("urlip");
	e = document.getElementById("url_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("url_cancel2");
	e.value = _("firewall_cancel");
	
}
function LoadFrame()
{ 
	initTranslation();


/* add begin by 吕轶超, 20120227, 原因: */
	var upnable = document.getElementsByName("URL_up");	
	for(var i = 0;i<upnable.length;i++)
	{
		if(upnable[i].value == '<% getCfgGeneral(1, "URL_up"); %>')
		{
			upnable[i].checked = true;
			break;
		}
	}
	var urlenable = document.getElementsByName("URL_enable");	
	for(var i = 0;i<urlenable.length;i++)
	{
		if(urlenable[i].value == '<% getCfgGeneral(1, "URL_enable"); %>')
		{
			urlenable[i].checked = true;
			break;
		}
	}

/* add end by 吕轶超, 20120228 */	
	
	pf_ruleSum  = '<% getCfgGeneral(1, "url_size"); %>';
	var url_ruletable = getElement("url_ruletable");

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("url_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
    //alert("pf_ruleSum = " + pf_ruleSum);
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 50)
	{		
//   		alert("最多只能创建50条规则!");
 		alert(_("fw_most50RulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay("ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_new");
	document.getElementById("url_IP").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			//document.getElementById("url_port").value = "";
			document.getElementById("url_IP").value = "";
			document.getElementById("url_s_hour").value = "0";
			document.getElementById("url_s_min").value = "0";
			document.getElementById("url_e_hour").value = "24";
			document.getElementById("url_e_min").value = "0";
			
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("url_IP").value = html_decode(document.getElementById("url_adress_" + temp).innerHTML);
			document.getElementById("url_s_hour").value = document.getElementById("url_time_" + temp).innerHTML.split('-')[0].split(':')[0];
			document.getElementById("url_s_min").value = document.getElementById("url_time_" + temp).innerHTML.split('-')[0].split(':')[1];
			document.getElementById("url_e_hour").value = document.getElementById("url_time_" + temp).innerHTML.split('-')[1].split(':')[0];
			document.getElementById("url_e_min").value = document.getElementById("url_time_" + temp).innerHTML.split('-')[1].split(':')[1];

			var url_rule_enable = document.getElementById("url_rule_enable_" + temp).innerHTML;
			var url_rule_enable_ID = document.getElementById("url_rule_enable");
			if( url_rule_enable == "Enable")
			{	
				url_rule_enable_ID.value = "1";
			}
			else
			{
				url_rule_enable_ID.value = "0";
			}
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;		
		}	

		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);
		
	}	 
}

function clickRemove(tabTitle)
{
//   alert("ruleSum = " + pf_ruleSum);
	if(pf_ruleSum  == 0)
	{			
//   		alert("当前没有规则，不能删除!");
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('url_removeFlag');
    var noChooseFlag = true;
//	var value = checkNodes.getValue();		//判断是否全选了，如果全选了，调用ipFilterDeleteAll
//	console.info("value.length = " + value.length);
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				noChooseFlag = false;
				break;
			}
		}
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
//		alert('请先选择一条规则');
		alert(_("fw_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("fw_deleteRuleConfirm")) == false)
    	return;
//	document.location = "/goform/URL_filterDelete";
	getElement("fw_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{				
//  		alert("当前没有规则，不能删除!");
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('url_removeFlag');
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = true;
		}
	}
	else
	{
		checkNodes.checked = true;
	}		        
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("fw_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}

	document.location = "/goform/URL_filterDeleteAll" + "?csrftoken=" + getCsrftoken();
}

function checkValue()
{

	var url_value = document.getElementById("url_IP");
	var url_s_hour = document.getElementById("url_s_hour");
	var url_e_hour = document.getElementById("url_e_hour");
	var url_s_min = document.getElementById("url_s_min");
	var url_e_min = document.getElementById("url_e_min");

	if (!CheckNotNull(url_value.value)) 
	{					
		//alert(_("Please enter host domain!"));
		alert(_("fw_NoHostURL"));
		url_value.value = url_value.defaultValue;
		url_value.focus();
		return false;
	}
	else if(validateIP(url_value.value))
	{
		alert(_("fw_URLIllegalAlert"));
		url_value.value = url_value.defaultValue;
		url_value.focus();
		return false; 
	}
	else if(! checkURLDomain(url_value.value))
	{
		alert(_("fw_URLIllegalAlert"));
		url_value.value = url_value.defaultValue;
		url_value.focus();
		return false;
	}

	if(!fw_checkTimeLegal(url_s_hour))
	{
		alert(_("url_TimeIllegalAlert"));
		url_s_hour.value = url_s_hour.defaultValue;
		url_s_hour.focus();
		return false;
	}
	if(!fw_checkTimeLegal(url_e_hour))
	{
		alert(_("url_TimeIllegalAlert"));
		url_e_hour.value = url_e_hour.defaultValue;
		url_e_hour.focus();
		return false;
	}
	if(!fw_checkTimeLegal2(url_s_min))				
	{
		alert(_("url_TimeIllegalAlert"));
		url_s_min.value = url_s_min.defaultValue;
		url_s_min.focus();
		return false;
	}
	if(!fw_checkTimeLegal2(url_e_min))
	{
		alert(_("url_TimeIllegalAlert"));
		url_e_min.value = url_e_min.defaultValue;
		url_e_min.focus();
		return false;
	}
	if(url_s_hour.value == 24)
	{
		if(url_s_min.value != 0)
		{
			alert(_("url_TimeIllegalAlert"));
			url_s_min.value = 0;
			url_s_min.focus();
			return false;
		}
	}
	if(url_e_hour.value == 24)
	{
		if(url_e_min.value != 0)
		{
			alert(_("url_TimeIllegalAlert"));
			url_e_min.value = 0;
			url_e_min.focus();
			return false;
		}
	}

	/*add begin by 陈鹏，20190103，原因:增加起始时间与结束时间大小的合法性校验*/
	if((url_s_hour.value - url_e_hour.value > 0) || (url_s_hour.value - url_e_hour.value == 0)
		&&(url_s_min.value - url_e_min.value > 0))
	{
		alert("The Start Time should not be latter than the End Time!");
		url_s_hour.value = 0;
		url_s_min.value =0;
		url_s_hour.focus();
		return false;
	}

	/*add end by 陈鹏，20190103*/
	
	return true;
}

function fw_checkPort(domStart)
{
	if(domStart.value == "")//startPort为空时
	{
			alert("端口号不能为空!");
			//alert(_("pf_PortNullAlert"));
			domStart.value = domStart.defaultValue;
			domStart.focus();
			return false;
	}
	else
	{
		if(!fw_checkPortLegal(domStart))
		{
			return false;
		}
		return true;
	}
}

function fw_checkPortLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 65535)
		{
			return true;
		}
		else
		{
			alert("有效端口范围为1～65535.");
		//	alert(_("pf_portIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
	    alert("有效端口号为非法值!");
		//alert(_("pf_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function fw_checkTimeLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(dom.value <= 24)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{	
		return false;
	}
}
function fw_checkTimeLegal2(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(dom.value < 60)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{	
		return false;
	}
}
function checkURLDomain(str)
{
	var reg = /^[\w-.:\/]{1,31}$/;	//number letter _ -.:/
	if(!reg.test(str))
	{ 
		return false;
	}
	else
	{
		return true;
	}
	return true;
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="url_filterPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="url_enable" action="/goform/URL_Black_WhiteCfg">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="URLenable_title" align="left" width="25%">Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="URL_enable" type="radio">
          <font id="enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="URL_enable" type="radio">
          <font id="disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="urldown_title" align="left" width="25%">URL Blacklist/Whitelist</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="white" name="URL_up" type="radio">
          <font id="URL_white"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="black" name="URL_up" type="radio">
          <font id="RUL_black"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="updown_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="updown_cancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td height="22" width="7"></td>
              <td align="center" valign="bottom" width="120"></td>
              <td width="7"></td>
              <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                  <tbody>
                    <tr>
                      <td><input type="button" value="Add" id="fw_add" class="submit" onClick="clickAdd('fw_ruleList');"></td>
                      <td><input type="button" value="Delete" id="fw_delete" class="submit" onClick="clickRemove('fw_ruleList');"></td>
                      <td><input type="button" value="Delete All" id="fw_deleteAll" class="submit" onClick="clickRemoveAll('fw_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/URL_filterDelete">
          <table class="tabal_bg" id = "url_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="url_filterListHead"></td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center" id="urlport">ID</td>
                <td width="45%" align="center" id="urlip">URL Address</td>
                <td width="26%" align="center" id="urltime">Time</td>
                <td width="10%" align="center" id="url_enableTitle">State</td>
                <td width="2%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% URL_filterSync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/URL_filterCfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td ><div id="div_pf_rule">
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                  <tr style="">
                                    <td id="url_IPTitle" class="tabal_left" width="25%">URL Address</td>
                                    <td class="tabal_right" width="75%"><input name="url_IP" id="url_IP" size="17" maxlength="31" style="width: 150px;" type="text">
                                      <span id="fw_curWanIP"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="url_start_time" class="tabal_left" width="25%">Start Time</td>
                                    <td class="tabal_right" width="75%"><input name="url_s_hour" id="url_s_hour" size="2"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;:&nbsp;&nbsp;
                                      <input name="url_s_min" id="url_s_min" size="15" style="width: 150px;" type="text">
                                      <span id="url_time_infor1"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="url_end_time" class="tabal_left" width="25%">End Time</td>
                                    <td class="tabal_right" width="75%"><input name="url_e_hour" id="url_e_hour" size="2"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;:&nbsp;&nbsp;
                                      <input name="url_e_min" id="url_e_min" size="2" style="width: 150px;" type="text">
                                      <span id="url_time_infor2"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="url_enableTitle2" class="tabal_left" width="25%">Enable</td>
                                    <td class="tabal_right" width="75%"><select name="url_rule_enable" id="url_rule_enable" size="1" style="width:14%" >
                                        <option value="1">Enable</option>
                                        <option value="0" selected="selected">Disable</option>
                                      </select></td>
                                  </tr>
                                </tbody>
                              </table>
                            </div></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="url_apply" id="url_apply" class="submit">
                    <input type="reset" value="Cancel" name="url_cancel2" id="url_cancel2" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="fw_curIndex" id="fw_curIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
