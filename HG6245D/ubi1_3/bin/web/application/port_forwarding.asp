<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Port Forwarding</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>';
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;
var GetPortForwardsizeSync = '<% GetPortForwardsizeSync(); %>';	
var pf_ruleSum = '<% getCfgGeneral(1, "portforward_size"); %>';

var GetWANsizeSync = '<% wanNameSync(); %>';	

function initTranslation()
{
	var e = document.getElementById("pf_PortforwardingPrompt");
	e.innerHTML = _("pf_PortforwardingPrompt");

	e = document.getElementById("fw_filterListHead");
	e.innerHTML = _("fw_filterListHead");
	e = document.getElementById("PFdescrip");
	e.innerHTML = _("PFdescrip");
	e = document.getElementById("The_public_Port");
	e.innerHTML = _("The_public_Port");
	e = document.getElementById("The_private_Port");
	e.innerHTML = _("The_private_Port");
	e = document.getElementById("Protocol");
	e.innerHTML = _("Protocol");
	e = document.getElementById("Enable");
	e.innerHTML = _("Enable");
	e = document.getElementById("pf_apply");
	e.value = _("pf_apply");
	e = document.getElementById("pf_cancel2");
	e.value = _("pf_cancel2");

	e = document.getElementById("pf_DescriptionTitle");
	e.innerHTML = _("pf_DescriptionTitle");
	e = document.getElementById("description_tips");
	e.innerHTML = _("description_tips");
	e = document.getElementById("pf_PubPortTitle");
	e.innerHTML = _("pf_PubPortTitle");
	e = document.getElementById("pf_PriPortTitle");
	e.innerHTML = _("pf_PriPortTitle");
	e = document.getElementById("pf_protocolTitle");
	e.innerHTML = _("pf_protocolTitle");
	e = document.getElementById("pf_enabelTitle");
	e.innerHTML = _("pf_enabelTitle");

	e = document.getElementById("fw_add");
	e.value = _("pf_add");
	e = document.getElementById("fw_delete");
	e.value = _("pf_delete");
	e = document.getElementById("fw_deleteAll");
	e.value = _("pf_deleteAll");
}

function LoadFrame()
{ 
	initTranslation();

	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	var pf_WAN = document.getElementById("pf_WAN");	
	for(var i = 0; i < wan_size; i++ )
	{
		if((wannameArray[i].search("INTERNET") ) >=  0)/*internet相关*/
		{	
			if((wannameArray[i].search("_B_") ) < 0)/*非桥接wan*/
			{
				pf_WAN.options[pf_WAN.length] = new Option(wannameTextArray[i], wannameArray[i]);
			}
		}
	}

	var fw_ruletable = getElement("fw_ruletable");

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	
	else
	{	
		var row0 = getElement("fw_ruletable").rows[0];
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

	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	if(ispNameCode == '16')/* VIETTEL */
	{
		if(rowLen - 2 >= 20)//up to 20
		{
	 		alert(_("rule_most20RulesAlert"));
			return;
		}
	}
	else		
//		if(rowLen > 13)		
		if(rowLen - 2 >= 16)//modify by wuxj, 20180723
		{
//	 		alert(_("rule_most12RulesAlert"));
	 		alert(_("rule_most16RulesAlert"));
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
	document.getElementById("pf_Description").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("pf_Description").value = "";
			document.getElementById("pf_PubPortStart").value = "";
			document.getElementById("pf_PubPortEnd").value = "";
			document.getElementById("pf_IP").value = "";
			document.getElementById("pf_PriPortStart").value = "";
			document.getElementById("pf_PriPortEnd").value = "";
			document.getElementById("pf_enable").value = "0";
			document.getElementById("pf_protocol").value = "3";
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("pf_Description").value = html_decode(document.getElementById("pf_description_" + temp).innerHTML);
			document.getElementById("pf_PubPortStart").value = document.getElementById("pf_publicport_" + temp).innerHTML.split('-')[0];
			document.getElementById("pf_PubPortEnd").value = document.getElementById("pf_publicport_" + temp).innerHTML.split('-')[1];
			document.getElementById("pf_IP").value = html_decode(document.getElementById("pf_ip_" + temp).innerHTML);
			document.getElementById("pf_PriPortStart").value = document.getElementById("pf_privateport_" + temp).innerHTML.split('-')[0];
			document.getElementById("pf_PriPortEnd").value = document.getElementById("pf_privateport_" + temp).innerHTML.split('-')[1];
			var protocol_value = document.getElementById("pf_protocol_" + temp).innerHTML;
			var pf_protocol_ID = document.getElementById("pf_protocol");
			var enable_value = document.getElementById("pf_enable_" + temp).innerHTML;
			var pf_enable_ID = document.getElementById("pf_enable");
			var pf_WAN_ID = document.getElementById("pf_WAN");
		
			pf_WAN_ID.value = document.getElementById("pf_WAN_" + temp).innerHTML;
			
			if( protocol_value == "TCP")
			{
				pf_protocol_ID.value = "1";
			}
			else if(protocol_value == "UDP")
			{
				pf_protocol_ID.value = "2";
			}
			else
			{
				pf_protocol_ID.value = "3";
			}
			
			if( enable_value == "Enable")
			{	 
				pf_enable_ID.value = "1";
			}
			else
			{
				pf_enable_ID.value = "0";
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
 		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pf_removeFlag');
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
		alert(_("pf_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;
	
	getElement("fw_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{				
//   		alert("当前没有规则，不能删除!");
   		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pf_removeFlag');
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
	if(confirm(_("pf_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}
	document.location = "/goform/portforwardingDeleteAll" + "?csrftoken=" + getCsrftoken();
	
}

function checkValue()
{
	if(!checkCommDescription(document.getElementById("pf_Description")))
	{
		return false;
	}
	if(!fw_checkIP(document.getElementById("pf_IP")))
	{
		return false;
	}

	if(!fw_checkPort(document.getElementById("pf_PubPortStart"), 
						document.getElementById("pf_PubPortEnd")))
	{
		return false;
	}
	
	if(!fw_checkPort(document.getElementById("pf_PriPortStart"), 
						document.getElementById("pf_PriPortEnd")))
	{
		return false;
	}

	if(document.getElementById("pf_WAN").length <= 0)
	{
		alert(_("noInternetWan_alert"));
		return false;
	}

	//modify by wuxj, 20181126, 重复性校验规则修改为同IP时端口不得交叉(王炎原)
	//add by wuxj, 20180828, 增加重复性校验(王炎原)
	var curIndex = document.getElementById("fw_curIndex").value;
	if(pf_ruleSum > 0)
	{
		for(var k = 0; k < pf_ruleSum; k++)
	    {
			if(curIndex != 'new') /*修改wan*/
			{
				if(curIndex != k) /*temp 为当前修改wan的行号，不和自己进行比较*/
				{
					if(!fw_checkRuleWanRepeat(k))
					{
						return false;
					}
					else if(!fw_checkRuleLanRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增wan*/
			{	
				if(!fw_checkRuleWanRepeat(k))
				{
					return false;
				}
				else if(!fw_checkRuleLanRepeat(k))
				{
					return false;
				}
			}
		}
	}
		
	return true;
}

function fw_checkIP(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
//		alert("请输入合法ip!");
		alert(_("pf_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function fw_checkPort(domStart, domEnd)
{
	domStart.value = trim(domStart.value);
	domEnd.value = trim(domEnd.value);
	if(domStart.value == "")//startPort为空时
	{
//			alert("端口不能为空!");
			alert(_("pf_PortNullAlert"));
			domStart.value = domStart.defaultValue;
			domStart.focus();
			return false;
	}
	else if(domEnd.value == "")//startPort为空时
	{
//			alert("端口不能为空!");
			alert(_("pf_PortNullAlert"));
			domEnd.value = domEnd.defaultValue;
			domEnd.focus();
			return false;
	}
	else
	{
		if(!fw_checkPortLegal(domStart))
		{
			return false;
		}
		if(!fw_checkPortLegal(domEnd))
		{
			return false;
		}
		if( parseInt(domStart.value) >  parseInt(domEnd.value))
		{
//			alert("结束端口应大于或等于起始端口!");
			alert(_("pf_endPortTooSmallAlert"));
			domEnd.value = domEnd.defaultValue;
			domEnd.focus();
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
	//		alert("有效端口范围为1～65535.");
			alert(_("pf_portIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("pf_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function fw_checkRuleWanRepeat(curIndex)
{
	var pubWanNode = getElement('pf_WAN');
	var pubPortStartNode = getElement('pf_PubPortStart');
	var pubPortEndNode = getElement('pf_PubPortEnd');

	var curPubWan = getElement('pf_WAN_' + curIndex).innerHTML;
	var curPubPort = getElement('pf_publicport_' + curIndex).innerHTML;
	var pubArr = curPubPort.split('-');

	if(pubWanNode.value != curPubWan)
	{
		return true;
	}
	else
	{
		if(parseInt(pubPortEndNode.value) < pubArr[0] || pubArr[1] < parseInt(pubPortStartNode.value))
		{
			return true;
		}
		else
		{	
			alert(_("pf_portRepeadAlert"));
			pubPortStartNode.value = pubPortStartNode.defaultValue;
			pubPortEndNode.value = pubPortEndNode.defaultValue;
			pubPortStartNode.focus();
			return false;
		}
	}
}
function fw_checkRuleLanRepeat(curIndex)
{
	var priLanNode = getElement('pf_IP');
	var priPortStartNode = getElement('pf_PriPortStart');
	var priPortEndNode = getElement('pf_PriPortEnd');

	var curPriLan = getElement('pf_ip_' + curIndex).innerHTML;
	var curPriPort = getElement('pf_privateport_' + curIndex).innerHTML;
	var priArr = curPriPort.split('-');

	if(priLanNode.value != curPriLan)
	{
		return true;
	}
	else
	{
		if(parseInt(priPortEndNode.value) < priArr[0] || priArr[1] < parseInt(priPortStartNode.value))
		{
			return true;
		}
		else
		{	
			alert(_("pf_portRepeadAlert"));
			priPortStartNode.value = priPortStartNode.defaultValue;
			priPortEndNode.value = priPortEndNode.defaultValue;
			priPortStartNode.focus();
			return false;
		}
	}
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
              <td id="pf_PortforwardingPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/portforwardingDelete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="fw_filterListHead">Port Forwarding Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="10%" align="center" id="PFwan">WAN</td>
                <td width="27%" align="center" id="PFdescrip">Description</td>
                <td width="12%" align="center" id="The_public_Port">Public Port</td>
                <td width="15%" align="center">IP</td>
                <td width="12%" align="center" id="The_private_Port">Private Port</td>
                <td width="8%" align="center" id="Protocol">Protocol</td>
                <td width="10%" align="center" id="Enable">Enable</td>
                <td width="5%" align="center" ></td>
                <td width="1%" align="center" ></td>
              </tr>
              <% portForwardingSync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/portForwardingCfg" onSubmit="return checkValue()">
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
                                    <td id="pf_WANTitle" class="tabal_left" width="25%">WAN</td>
                                    <td class="tabal_right" width="75%"><select name="pf_WAN" id="pf_WAN" size="1" style="width:44%">
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_DescriptionTitle" class="tabal_left" width="25%">Description</td>
                                    <td class="tabal_right" width="75%"><input name="pf_Description" id="pf_Description" size="32" maxlength="31" style="width: 150px;" type="text">
                                      <span id="description_tips" class="gray">&nbsp; ( 0-31 characters, including alphanumeric, '-' and '_')</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_PubPortTitle" class="tabal_left" width="25%">Pubilc Port</td>
                                    <td class="tabal_right" width="75%"><input name="pf_PubPortStart" id="pf_PubPortStart" size="15"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="pf_PubPortEnd" id="pf_PubPortEnd" size="15" style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (1-65535)</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_IPTitle" class="tabal_left" width="25%">IP</td>
                                    <td class="tabal_right" width="75%"><input name="pf_IP" id="pf_IP" size="15"  style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong><span id="fw_curWanIP"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_PriPortTitle" class="tabal_left" width="25%">Private Port</td>
                                    <td class="tabal_right" width="75%"><input name="pf_PriPortStart" id="pf_PriPortStart" size="15"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="pf_PriPortEnd" id="pf_PriPortEnd" size="15" style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (1-65535)</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_protocolTitle" class="tabal_left" width="25%">Protocol</td>
                                    <td class="tabal_right" width="75%"><select name="pf_protocol" id="pf_protocol" size="1" style="width:14%">
                                        <option value="3" selected="selected">ALL</option>
                                        <option value="1">TCP</option>
                                        <option value="2">UDP</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_enabelTitle" class="tabal_left" width="25%">Enable</td>
                                    <td class="tabal_right" width="75%"><select name="pf_enable" id="pf_enable" size="1" style="width:14%" >
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="pf_apply" id="pf_apply" class="submit">
                    <input type="reset" value="Cancel" name="pf_cancel2" id="pf_cancel2" class="submit" onClick="window.location.reload()">
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
</html>
