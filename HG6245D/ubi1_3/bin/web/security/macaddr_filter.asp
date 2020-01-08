<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>macaddr Filter</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var currentline;
var previousTR = null;
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var pf_ruleSum;
var macaddr_filter_enableSync = '<% macaddr_filter_enableSync(); %>';
var macaddr_getsizeSync = '<% macaddr_getsizeSync(); %>';

function initTranslation()
{
	var e = document.getElementById("macaddr_filterPrompt");
	e.innerHTML = _("macaddr_filterPrompt");

	e = document.getElementById("macaddrenable_title");
	e.innerHTML = _("macaddrenable_title");
	e = document.getElementById("enable");
	e.innerHTML = _("firewall_enable");
	e = document.getElementById("disable");
	e.innerHTML = _("firewall_disable");
	e = document.getElementById("macaddrdown_title");
	e.innerHTML = _("macaddrdown_title");
	e = document.getElementById("macaddr_white");
	e.innerHTML = _("firewall_white");
	e = document.getElementById("macaddr_black");
	e.innerHTML = _("firewall_black");
	e = document.getElementById("updown_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("updown_cancel");
	e.value = _("firewall_cancel");

	e = document.getElementById("mf_add");
	e.value = _("fw_add");
	e = document.getElementById("mf_delete");
	e.value = _("fw_delete");
	e = document.getElementById("mf_deleteAll");
	e.value = _("fw_deleteAll");	

	e = document.getElementById("macaddr_filterListHead");
	e.innerHTML = _("macaddr_filterListHead");
	e = document.getElementById("macaddr");
	e.innerHTML = _("macaddr");
	e = document.getElementById("macaddr_macTips");
	e.innerHTML = _("macaddr_macTips");

	e = document.getElementById("mantime");
	e.innerHTML = _("urltime");
	e = document.getElementById("mac_start_time");
	e.innerHTML = _("url_start_time");
	e = document.getElementById("mac_end_time");
	e.innerHTML = _("url_end_time");
	
	e = document.getElementById("mac_time_infor1");
	e.innerHTML = _("url_time_infor");
	e = document.getElementById("mac_time_infor2");
	e.innerHTML = _("url_time_infor");
	
	e = document.getElementById("mac_enableTitle");
	e.innerHTML = _("URLenable_title");
	e = document.getElementById("mac_enableTitle2");
	e.innerHTML = _("URLenable_title");
	
	e = document.getElementById("macaddr_IPTitle");
	e.innerHTML = _("macaddr");
	e = document.getElementById("macaddr_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("macaddr_apply_cancel2");
	e.value = _("firewall_cancel");
}
function LoadFrame()
{ 
	initTranslation();

	var macAddrUp = document.getElementsByName("macaddr_up");	
	for(var i = 0;i<macAddrUp.length;i++)
	{
		if(macAddrUp[i].value == '<% getCfgGeneral(1, "mac_black_white"); %>')
		{
			macAddrUp[i].checked = true;
			break;
		}
	}
	var macfilterable = document.getElementsByName("macaddr_enable");	
	for(var i = 0;i<macfilterable.length;i++)
	{
		if(macfilterable[i].value == '<% getCfgGeneral(1, "macaddr_filter_enable"); %>')
		{
			macfilterable[i].checked = true;
			break;
		}
	}
	
	pf_ruleSum  = '<% getCfgGeneral(1, "macaddr_size"); %>';
	var macaddr_ruletable = getElement("macaddr_ruletable");

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("macaddr_ruletable").rows[0];
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

	if(rowLen > 10 + 1)
	{		
  		alert(_("macaddr_most10rulealert"));
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
	document.getElementById("macaddr_mac").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if (temp == 'new')		//新建
		{					
			//document.getElementById("url_port").value = "";
			document.getElementById("macaddr_mac").value = "";							
			document.getElementById("mac_s_hour").value = "0";
			document.getElementById("mac_s_min").value = "0";
			document.getElementById("mac_e_hour").value = "24";
			document.getElementById("mac_e_min").value = "0";
			
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("macaddr_mac").value = html_decode(document.getElementById("mac_adress_" + temp).innerHTML);
			document.getElementById("mac_s_hour").value = document.getElementById("mac_time_" + temp).innerHTML.split('-')[0].split(':')[0];
			document.getElementById("mac_s_min").value = document.getElementById("mac_time_" + temp).innerHTML.split('-')[0].split(':')[1];
			document.getElementById("mac_e_hour").value = document.getElementById("mac_time_" + temp).innerHTML.split('-')[1].split(':')[0];
			document.getElementById("mac_e_min").value = document.getElementById("mac_time_" + temp).innerHTML.split('-')[1].split(':')[1];

			var mac_rule_enable = document.getElementById("mac_rule_enable_" + temp).innerHTML;
			var mac_rule_enable_ID = document.getElementById("mac_rule_enable");
			if( mac_rule_enable == "Enable")
			{	
				mac_rule_enable_ID.value = "1";
			}
			else
			{
				mac_rule_enable_ID.value = "0";
			}
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}	

		//标志当前编辑规则的id
		document.getElementById("mf_curIndex").value = temp;
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
	var checkNodes = getElement('macaddr_removeFlag');
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
	getElement("mf_ruleForm").submit();
	
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
	var checkNodes = getElement('macaddr_removeFlag');
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

	document.location = "/goform/macaddr_filterDeleteAll" + "?csrftoken=" + getCsrftoken();
	
}

/*add begin by 陈鹏，20190103，原因:校验MAC地址重复性*/
function isMacRepeat(k)
{
	var current_mac = document.getElementById("macaddr_mac");
	var current_mac_lowercast = current_mac.value.toLowerCase();
	var macaddr = document.getElementById("mac_adress_" + k).innerHTML;

	if(macaddr == current_mac_lowercast)  /*非当前规则中存在与当前mac相同的规则 */
	{
		//alert("MAC 地址已绑定 ，请重新输入!");
		alert(_("macAddr_RepeatAlert"));
		current_mac.value = current_mac.defaultValue;
		current_mac.focus();
		return true;
	}		
	return false;
}

/* 校验MAC地址重复性*/
function checkRepeat(temp)
{
	var k = 0;

	if(pf_ruleSum > 0)
	{
		for(k = 0; k < pf_ruleSum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isMacRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isMacRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}

/*add end by 陈鹏，20190103*/

function checkValue()
{

	var macaddr_value = document.getElementById("macaddr_mac");
	var mac_s_hour = document.getElementById("mac_s_hour");
	var mac_e_hour = document.getElementById("mac_e_hour");
	var mac_s_min = document.getElementById("mac_s_min");
	var mac_e_min = document.getElementById("mac_e_min");
	if (!CheckNotNull(macaddr_value.value)) 
	{
		//alert(_("请输入需要过滤的MAC地址!"));
		alert(_("fw_nomacalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}

	if(!validateMAC(macaddr_value.value))
	{
		//alert(_("您输入MAC地址非法!"));
		alert(_("fw_macillegalalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	if(!fw_checkTimeLegal(mac_s_hour))
	{
		alert(_("url_TimeIllegalAlert"));
		mac_s_hour.value = mac_s_hour.defaultValue;
		mac_s_hour.focus();
		return false;
	}
	if(!fw_checkTimeLegal(mac_e_hour))
	{
		alert(_("url_TimeIllegalAlert"));
		mac_e_hour.value = mac_e_hour.defaultValue;
		mac_e_hour.focus();
		return false;
	}
	if(!fw_checkTimeLegal2(mac_s_min))				
	{
		alert(_("url_TimeIllegalAlert"));
		mac_s_min.value = mac_s_min.defaultValue;
		mac_s_min.focus();
		return false;
	}
	if(!fw_checkTimeLegal2(mac_e_min))
	{
		alert(_("url_TimeIllegalAlert"));
		mac_e_min.value = mac_e_min.defaultValue;
		mac_e_min.focus();
		return false;
	}

	if(mac_s_hour.value == 24)
	{
		if(mac_s_min.value != 0)
		{
			alert(_("url_TimeIllegalAlert"));
			mac_s_min.value = 0;
			mac_s_min.focus();
			return false;
		}
	}
	if(mac_e_hour.value == 24)
	{
		if(mac_e_min.value != 0)
		{
			alert(_("url_TimeIllegalAlert"));
			mac_e_min.value = 0;
			mac_e_min.focus();
			return false;
		}
	}

	/*add begin by 陈鹏，20190103，原因:增加起始时间与结束时间大小的合法性校验*/
	if((mac_s_hour.value - mac_e_hour.value > 0) || (mac_s_hour.value - mac_e_hour.value == 0)
		&&(mac_s_min.value - mac_e_min.value > 0))
	{
		alert("The Start Time should not be latter than the End Time!");
		mac_s_hour.value = 0;
		mac_s_min.value = 0;
		mac_s_hour.focus();
		return false;
	}

	/*add end by 陈鹏，20190103*/

	/*add begin by 陈鹏，20190103，原因:检查MAC重复性*/
	if(!checkRepeat(currentline))
	{
		return false;
	}

	/*add end by 陈鹏，20190103*/

	return true;
	
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
              <td id="macaddr_filterPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="macaddr_enable" action="/goform/macaddr_filter_enableCfg">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="macaddrenable_title" align="left" width="25%">MAC Filtering Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value=1 name="macaddr_enable" type="radio">
          <font id="enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value=0 name="macaddr_enable" type="radio">
          <font id="disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="macaddrdown_title" align="left" width="25%">MAC Filtering Blacklist/Whitelist</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value=1 name="macaddr_up" type="radio">
          <font id="macaddr_white"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value=0 name="macaddr_up" type="radio">
          <font id="macaddr_black"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
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
                      <td><input type="button" value="Add" id="mf_add" class="submit" onClick="clickAdd('mf_ruleList');"></td>
                      <td><input type="button" value="Delete" id="mf_delete" class="submit" onClick="clickRemove('mf_ruleList');"></td>
                      <td><input type="button" value="Delete All" id="mf_deleteAll" class="submit" onClick="clickRemoveAll('mf_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="mf_ruleList"><form method="post" id="mf_ruleForm" action="/goform/macaddr_filterDelete">
          <table class="tabal_bg" id = "macaddr_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="macaddr_filterListHead"></td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center" id="macaddrport">ID</td>
                <td width="50%" align="center" id="macaddr">MAC Address</td>
                <td width="15%" align="center" id="mantime">Time</td>
                <td width="8%" align="center" id="mac_enableTitle">Enable</td>
                <td width="2%" align="center" ></td>
              </tr>
              <% macaddr_filterSync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="mf_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/macaddr_filterCfg" onSubmit="return checkValue()">
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
                                    <td id="macaddr_IPTitle" class="tabal_left" width="25%">MAC Address</td>
                                    <td class="tabal_right" width="75%"><input name="macaddr_mac" id="macaddr_mac" size="17"  style="width: 150px;" type="text">
                                      <span class="gray" id="macaddr_macTips"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mac_start_time" class="tabal_left" width="25%">Start Time</td>
                                    <td class="tabal_right" width="75%"><input name="mac_s_hour" id="mac_s_hour" size="2"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;:&nbsp;&nbsp;
                                      <input name="mac_s_min" id="mac_s_min" size="15" style="width: 150px;" type="text">
                                      <span id="mac_time_infor1"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mac_end_time" class="tabal_left" width="25%">End Time</td>
                                    <td class="tabal_right" width="75%"><input name="mac_e_hour" id="mac_e_hour" size="2"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;:&nbsp;&nbsp;
                                      <input name="mac_e_min" id="mac_e_min" size="2" style="width: 150px;" type="text">
                                      <span id="mac_time_infor2"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mac_enableTitle2" class="tabal_left" width="25%">Enable</td>
                                    <td class="tabal_right" width="75%"><select name="mac_rule_enable" id="mac_rule_enable" size="1" style="width:14%" >
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="macaddr_apply" id="macaddr_apply" class="submit">
                    <input type="reset" value="Cancel" name="macaddr_apply_cancel2" id="macaddr_apply_cancel2" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="mf_curIndex" id="mf_curIndex" value="0">
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
