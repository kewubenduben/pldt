<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Port Trigger</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_trigger", lang);

var GetPortForwardsizeSync = '<% GetportTriggersizeSync(); %>';	
var pf_ruleSum = '<% getCfgGeneral(1, "portTrigger_size"); %>';

var GetWANsizeSync = '<% wanNameSync(); %>';

function initTranslation()
{
	var e = document.getElementById("pt_PortTriggerPrompt");
	e.innerHTML = _("pt_PortTriggerPrompt");

	e = document.getElementById("fw_filterListHead");
	e.innerHTML = _("fw_filterListHead");
	e = document.getElementById("PFdescrip");
	e.innerHTML = _("PFdescrip");
	e = document.getElementById("The_trigger_Port");
	e.innerHTML = _("The_trigger_Port");
	e = document.getElementById("The_open_Port");
	e.innerHTML = _("The_open_Port");
	
	e = document.getElementById("The_TriggerProtocol");
	e.innerHTML = _("The_TriggerProtocol");

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
	e = document.getElementById("pf_triPortTitle");
	e.innerHTML = _("pf_triPortTitle");
	e = document.getElementById("pf_openPortTitle");
	e.innerHTML = _("pf_openPortTitle");
	e = document.getElementById("pf_triprotocolTitle");
	e.innerHTML = _("pf_triprotocolTitle");

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
	var pt_WAN = document.getElementById("pt_WAN");
	for( i = 0; i < wan_size; i++ )
	{
		if((wannameArray[i].search("INTERNET") ) >=  0)/*internet相关*/
		{	
			if((wannameArray[i].search("_B_") ) < 0)/*非桥接wan*/
			{
				pt_WAN.options[pt_WAN.length] = new Option(wannameTextArray[i], wannameArray[i]);
			}
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			pt_WAN.options[pt_WAN.length] = new Option(wannameTextArray[i], wannameArray[i]);
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

	if(rowLen > 9)
	{		
//   		alert("最多只能创建8条规则!");
 		alert(_("pf_mostRulesAlert"));
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
	document.getElementById("pt_Description").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("pt_Description").value = "";
			document.getElementById("pt_TriPortStart").value = "";
			document.getElementById("pt_TriPortEnd").value = "";
			document.getElementById("pt_Triprotocol").value = "";
			document.getElementById("pt_openPortStart").value = "";
			document.getElementById("pt_openPortEnd").value = "";
			document.getElementById("pf_enable").value = "0";						
			setLineHighLight(objTR); 
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("pt_Description").value = html_decode(document.getElementById("pt_Description_" + temp).innerHTML);
			document.getElementById("pt_TriPortStart").value = document.getElementById("pt_TriPort_" + temp).innerHTML.split('-')[0];
			document.getElementById("pt_TriPortEnd").value = document.getElementById("pt_TriPort_" + temp).innerHTML.split('-')[1];
			document.getElementById("pt_openPortStart").value = document.getElementById("pt_openPort_" + temp).innerHTML.split('-')[0];
			document.getElementById("pt_openPortEnd").value = document.getElementById("pt_openPort_" + temp).innerHTML.split('-')[1];
			var Triprotocol_value = document.getElementById("pt_Triprotocol_" + temp).innerHTML;
			var pt_Triprotocol_ID = document.getElementById("pt_Triprotocol");

			var enable_value = document.getElementById("pf_enable_" + temp).innerHTML;
			var pf_enable_ID = document.getElementById("pf_enable");
			var pf_WAN_ID = document.getElementById("pt_WAN");

			pf_WAN_ID.value = document.getElementById("pt_WAN_" + temp).innerHTML;
			
			if( Triprotocol_value == "TCP")
			{
				pt_Triprotocol_ID.value = "1";
			}
			else if(Triprotocol_value == "UDP")
			{
				pt_Triprotocol_ID.value = "2";
			}
			else
			{
				pt_Triprotocol_ID.value = "3";
			}
			
			if( enable_value == "Enable")
			{	 
				pf_enable_ID.value = "1";
			}
			else
			{
				pf_enable_ID.value = "0";
			}		


			
            setLineHighLight(objTR);		

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

	document.location = "/goform/portTriggerDeleteAll" + "?csrftoken=" + getCsrftoken();
    	
	
}

function checkValue()
{
	if(!checkCommDescription(document.getElementById("pt_Description")))
	{
		return false;
	}
	if(!fw_checkPort(document.getElementById("pt_TriPortStart"), 
						document.getElementById("pt_TriPortEnd")))
	{
		return false;
	}
	
	if(!fw_checkPort(document.getElementById("pt_openPortStart"), 
						document.getElementById("pt_openPortEnd")))
	{
		return false;
	}

	if(document.getElementById("pt_WAN").length <= 0)
	{
		alert(_("noInternetWan_alert"));
		return false;
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



var previousTR = null;
function setLineHighLight(objTR)
{
    if (previousTR != null)
	{
	    previousTR.style.backgroundColor = '#f4f4f4';
		for (var i = 0; i < previousTR.cells.length; i++)
		{
			previousTR.cells[i].style.color = '#000000';
		}
	}
	
	objTR.style.backgroundColor = '#B7E3E3';//c7e7fe
	for (var i = 0; i < objTR.cells.length; i++)
	{
		objTR.cells[i].style.color = '#000000';		
	}
	previousTR = objTR;
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
              <td id="pt_PortTriggerPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/portTriggerDelete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="fw_filterListHead">Port Trigger Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="10%" align="center" id="PFwan">WAN</td>
                <td width="18%" align="center" id="PFdescrip">Description</td>
                <td width="18%" align="center" id="The_trigger_Port">Trigger Port</td>
                <td width="13%" align="center" id="The_TriggerProtocol">Trigger Protocol</td>
                <td width="18%" align="center" id="The_open_Port">Open Port</td>
                <td width="8%" align="center" id="Enable">Enable</td>
                <td width="7%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% portTriggerSync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/portTriggerCfg" onSubmit="return checkValue()">
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
                                    <td id="pt_WANTitle" class="tabal_left" width="25%">WAN</td>
                                    <td class="tabal_right" width="75%"><select name="pt_WAN" id="pt_WAN" size="1" style="width:44%">
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_DescriptionTitle" class="tabal_left" width="25%">Description</td>
                                    <td class="tabal_right" width="75%"><input name="pt_Description" id="pt_Description" size="32"  style="width: 150px;" type="text">
                                      <span id="description_tips" class="gray">&nbsp; ( 0-31 characters, including alphanumeric, '-' and '_')</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_triPortTitle" class="tabal_left" width="25%">Trigger Port</td>
                                    <td class="tabal_right" width="75%"><input name="pt_TriPortStart" id="pt_TriPortStart" size="15"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="pt_TriPortEnd" id="pt_TriPortEnd" size="15" style="width: 150px;" type="text"></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_triprotocolTitle" class="tabal_left" width="25%">Trigger Protocol</td>
                                    <td class="tabal_right" width="75%"><select name="pt_Triprotocol" id="pt_Triprotocol" size="1" style="width:14%">
                                        <option value="3" selected="selected">ALL</option>
                                        <option value="1">TCP</option>
                                        <option value="2">UDP</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="pf_openPortTitle" class="tabal_left" width="25%">Open Port</td>
                                    <td class="tabal_right" width="75%"><input name="pt_openPortStart" id="pt_openPortStart" size="15"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="pt_openPortEnd" id="pt_openPortEnd" size="15" style="width: 150px;" type="text"></td>
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
