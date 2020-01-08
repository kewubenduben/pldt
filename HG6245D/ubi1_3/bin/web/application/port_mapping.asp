<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Port Mapping</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);
var token = <%  get_random_str(); %>;

var previousTR = null;

var get_port_mapping_sync = '<% get_port_mapping_sync(); %>';
var pm_ruleSum = '<% getCfgGeneral(1, "pm_ruleSum"); %>';

var wanNameSync = '<% wanNameSync(); %>';
var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
var wannameArray = wanname_all.split("|");

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function LoadFrame()
{
	initTranslation();

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
	var wannameNode = getElement("pm_wan");
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("INTERNET") >= 0 && wannameArray[i].search("_R") >= 0)	// 路由INTERNET相关
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}

	if(pm_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	else
	{	
		var row0 = getElement("ruleTable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function initTranslation()
{
	var e = document.getElementById("portMappingPrompt");
	if(ispNameCode == '15')	//X_GLOBE
		e.innerHTML = _("pf_PortforwardingPrompt");
	else
		e.innerHTML = _("portMappingPrompt");

	e = document.getElementById("pm_ruleListHead");
	if(ispNameCode == '15')	//X_GLOBE
		e.innerHTML = _("fw_filterListHead");
	else
		e.innerHTML = _("pm_ruleListHead");
	
	e = document.getElementById("pm_descripTitle");
	e.innerHTML = _("pm_descripTitle");
	e = document.getElementById("pm_protocolTitle");
	e.innerHTML = _("Protocol");
	e = document.getElementById("pm_pubIPTitle");
	e.innerHTML = _("pm_pubIPTitle");
	e = document.getElementById("pm_pubPortTitle");
	e.innerHTML = _("pm_pubPortTitle");
	e = document.getElementById("pm_priIPTitle");
	e.innerHTML = _("pm_priIPTitle");
	e = document.getElementById("pm_priPortTitle");
	e.innerHTML = _("pm_priPortTitle");
	e = document.getElementById("pm_enableTitle");
	e.innerHTML = _("Enable");
	
	e = document.getElementById("pm_apply");
	e.value = _("apply");
	e = document.getElementById("pm_cancel");
	e.value = _("cancel");

	e = document.getElementById("pm_descripTitle2");
	e.innerHTML = _("pm_descripTitle");
	e = document.getElementById("description_tips");
	e.innerHTML = _("description_tips");
	e = document.getElementById("pm_protocolTitle2");
	e.innerHTML = _("Protocol");
	e = document.getElementById("pm_pubIPTitle2");
	e.innerHTML = _("pm_pubIPTitle");
	e = document.getElementById("pm_pubPortTitle2");
	e.innerHTML = _("pm_pubPortTitle");
	e = document.getElementById("pm_priIPTitle2");
	e.innerHTML = _("pm_priIPTitle");
	e = document.getElementById("pm_priPortTitle2");
	e.innerHTML = _("pm_priPortTitle");
	e = document.getElementById("pm_enableTitle2");
	e.innerHTML = _("Enable");

	e = document.getElementById("rule_add");
	e.value = _("rule_add");
	e = document.getElementById("rule_delete");
	e.value = _("rule_delete");
	e = document.getElementById("rule_deleteAll");
	e.value = _("rule_deleteAll");
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 12)
	{
 		alert(_("rule_most12RulesAlert"));
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
	getElement("pm_wan").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{
			showSelectNodeByValue(getElement("pm_wan"), wannameArray[0]);
			getElement("pm_description").value = "";
			showSelectNodeByValue(getElement("pm_protocol"), "1");
			getElement("pm_pubIP").value = "";
			getElement("pm_pubPortStart").value = "";
			getElement("pm_pubPortEnd").value = "";
			getElement("pm_priIP").value = "";
			getElement("pm_priPortStart").value = "";
			getElement("pm_priPortEnd").value = "";
			showSelectNodeByValue(getElement("pm_enable"), "0");
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = temp;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			var curWan = getElement("pm_wan_" + temp).innerHTML;
			var wanNode = getElement("pm_wan");
//			showSelectNodeByValue(wanNode, curWan);
			wanNode.value = curWan;
			
			getElement("pm_description").value = html_decode(getElement("pm_description_" + temp).innerHTML);
			
			var curProtocol = getElement("pm_protocol_" + temp).innerHTML;
			var protocolNode = getElement("pm_protocol");
			if( curProtocol == "TCP")
			{
				protocolNode.value = "1";
			}
			else if(curProtocol == "UDP")
			{
				protocolNode.value = "2";
			}
			else if(curProtocol == "ALL")
			{
				protocolNode.value = "3";
			}
			
			getElement("pm_pubIP").value = html_decode(getElement("pm_pubIP_" + temp).innerHTML);			
			getElement("pm_pubPortStart").value = getElement("pm_pubPort_" + temp).innerHTML.split('-')[0];
			getElement("pm_pubPortEnd").value = getElement("pm_pubPort_" + temp).innerHTML.split('-')[1];
			
			getElement("pm_priIP").value = html_decode(getElement("pm_priIP_" + temp).innerHTML);
			getElement("pm_priPortStart").value = getElement("pm_priPort_" + temp).innerHTML.split('-')[0];
			getElement("pm_priPortEnd").value = getElement("pm_priPort_" + temp).innerHTML.split('-')[1];
			
			var curEnable = getElement("pm_enable_" + temp).innerHTML;
			var enableNode = getElement("pm_enable");
			if( curEnable == "Enable")
			{	 
				enableNode.value = "1";
			}
			else
			{
				enableNode.value = "0";
			}

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = getElement("pm_id_" + temp).innerHTML;
		}	

	}	 
}

function clickRemove(tabTitle)
{
	if(pm_ruleSum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pm_removeFlag');
    var noChooseFlag = true;
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
		alert(_("rule_noChooseAlert"));
		return ;
	}
	        
	if(confirm(_("pf_deleteRuleConfirm")) == false)
    	return;
	
	getElement("ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pm_ruleSum == 0)
	{
   		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('pm_removeFlag');
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

	if(confirm(_("pf_deleteRuleConfirm")) == false)
	{		
		if(checkNodes.length > 0)
		{
			for(var i = 0; i < checkNodes.length; i++)
			{
				checkNodes[i].checked = false;
			}
		}
		else
		{
			checkNodes.checked = false;
		}	        
		return;
	}

	document.location = "/goform/portMappingDeleteAll" + "?csrftoken=" + getCsrftoken();  
	
}

function checkValue()
{
	if(!pm_checkDescription(document.getElementById("pm_description")))
	{
		return false;
	}
	if((getElement("pm_pubIP").value != "") && !pm_checkIP(document.getElementById("pm_pubIP")))
	{
		return false;
	}
	if(!pm_checkPort(document.getElementById("pm_pubPortStart"), 
						document.getElementById("pm_pubPortEnd")))
	{
		return false;
	}
	//当protocol为udp时可以设置为255.255.255.255
	if((getElement("pm_protocol").value == "2") && (getElement("pm_priIP") == "255.255.255.255"))
	{
		return true;
	}
	else if(!pm_checkIP(document.getElementById("pm_priIP")))
	{
		return false;
	}
	
	if(!pm_checkPort(document.getElementById("pm_priPortStart"), 
						document.getElementById("pm_priPortEnd")))
	{
		return false;
	}
	
	return true;
}
function pm_checkDescription(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	var reg = /^[\w-]{0,31}$/;	//number letter _ -
	if (!reg.test(dom.value))
	{
		alert(_("descripIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false; 
	}
	return true;
}
function pm_checkIP(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
		alert(_("pf_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function pm_checkPort(domStart, domEnd)
{
	domStart.value = trim(domStart.value);
	domEnd.value = trim(domEnd.value);
	if(domStart.value == "")//startPort为空时
	{
			alert(_("pf_PortNullAlert"));
			domStart.value = domStart.defaultValue;
			domStart.focus();
			return false;
	}
	else if(domEnd.value == "")//endPort为空时
	{
			alert(_("pf_PortNullAlert"));
			domEnd.value = domEnd.defaultValue;
			domEnd.focus();
			return false;
	}
	else
	{
		if(!pm_checkPortStartLegal(domStart))
		{
			return false;
		}
		if(!pm_checkPortEndLegal(domEnd))
		{
			return false;
		}
		if(parseInt(domEnd.value) != 0)
		{
			if( parseInt(domStart.value) >  parseInt(domEnd.value))
			{
	//			alert("结束端口应大于或等于起始端口!");
				alert(_("pf_endPortTooSmallAlert"));
				domEnd.value = domEnd.defaultValue;
				domEnd.focus();
				return false;
			}
		}
		return true;
	}
}

function pm_checkPortStartLegal(dom)
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
			alert(_("pm_portStartIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("pm_portStartIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function pm_checkPortEndLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 65535)
		{
			return true;
		}
		else
		{
			alert(_("pm_portEndIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
		alert(_("pm_portEndIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
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
              <td id="portMappingPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
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
                      <td><input type="button" value="Add" id="rule_add" class="submit" onClick="clickAdd('ruleList');"></td>
                      <td><input type="button" value="Delete" id="rule_delete" class="submit" onClick="clickRemove('ruleList');"></td>
                      <td><input type="button" value="Delete All" id="rule_deleteAll" class="submit" onClick="clickRemoveAll('ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/portMappingDelete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="9" id="pm_ruleListHead">Port Mapping Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="3%" align="center" id="pm_idTitle">ID</td>
                <td width="18%" align="center" id="pm_wanTitle">WAN</td>
                <td width="16%" align="center" id="pm_descripTitle">Description</td>
                <td width="8%" align="center" id="pm_protocolTitle">Protocol</td>
                <td width="10%" align="center" id="pm_pubIPTitle">Public IP</td>
                <td width="12%" align="center" id="pm_pubPortTitle">Public Port</td>
                <td width="10%" align="center" id="pm_priIPTitle">Private IP</td>
                <td width="12%" align="center" id="pm_priPortTitle">Private Port</td>
                <td width="7%" align="center" id="pm_enableTitle">Enable</td>
                <td width="4%" align="center" ></td>
              </tr>
              <% port_mapping_sync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/portMappingCfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="pm_wanTitle2" class="tabal_left" width="25%">WAN</td>
                  <td class="tabal_right" width="75%"><select name="pm_wan" size="1" style="width:150px;">
                    </select></td>
                </tr>
                <tr>
                  <td id="pm_descripTitle2" class="tabal_left">Description</td>
                  <td class="tabal_right"><input name="pm_description" id="pm_description" size="32" maxlength="31" style="width: 150px;" type="text">
                    <span id="description_tips" class="gray">&nbsp; ( 0-31 characters, including alphanumeric, '-' and '_')</span></td>
                </tr>
                <tr>
                  <td id="pm_protocolTitle2" class="tabal_left">Protocol</td>
                  <td class="tabal_right"><select name="pm_protocol" id="pm_protocol" size="1" style="width:150px">
                      <option value="1" selected="selected">TCP</option>
                      <option value="2">UDP</option>
                      <option value="3">ALL</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="pm_pubIPTitle2" class="tabal_left">Pubilc IP</td>
                  <td class="tabal_right"><input name="pm_pubIP" id="pm_pubIP" size="15"  style="width: 150px;" type="text">
                    <span id="pm_pubIPTips"></span></td>
                </tr>
                <tr>
                  <td id="pm_pubPortTitle2" class="tabal_left">Pubilc Port</td>
                  <td class="tabal_right"><input name="pm_pubPortStart" id="pm_pubPortStart" size="15" style="width: 150px;" type="text">
				  <strong style="color:#FF0033">*</strong>&nbsp; <span class="gray">(1-65535)</span>
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    <input name="pm_pubPortEnd" id="pm_pubPortEnd" size="15" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong>&nbsp; <span class="gray">(0-65535)</span></td>
                </tr>
                <tr>
                  <td id="pm_priIPTitle2" class="tabal_left">Private IP</td>
                  <td class="tabal_right"><input name="pm_priIP" id="pm_priIP" size="15"  style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong><span id="pm_priIPTips"></span></td>
                </tr>
                <tr>
                  <td id="pm_priPortTitle2" class="tabal_left">Private Port</td>
                  <td class="tabal_right"><input name="pm_priPortStart" id="pm_priPortStart" size="15"  style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong>&nbsp; <span class="gray">(1-65535)</span>
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                    <input name="pm_priPortEnd" id="pm_priPortEnd" size="15" style="width: 150px;" type="text">
                    <strong style="color:#FF0033">*</strong>&nbsp; <span class="gray">(0-65535)</span></td>
                </tr>
                <tr>
                  <td id="pm_enableTitle2" class="tabal_left">Enable</td>
                  <td class="tabal_right"><select name="pm_enable" id="pm_enable" size="1" style="width:150px" >
                      <option value="1">Enable</option>
                      <option value="0" selected="selected">Disable</option>
                    </select></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" name="pm_apply" id="pm_apply" class="submit">
                    <input type="reset" name="pm_cancel" id="pm_cancel" class="submit" onClick="window.location.reload()">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curIndex" id="curIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			updateForms();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
