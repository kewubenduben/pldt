<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>NAT</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("multi_nat", lang);

var previousTR = null;
var GetMuti_NatsizeSync = '<% GetMuti_NatsizeSync(); %>';	
var GetWANsizeSync = '<% wanNameSync(); %>';	

var pf_ruleSum = '<% getCfgGeneral(1, "Muti_Nat_size"); %>';

function initTranslation()
{
	var e = document.getElementById("muti_natPrompt");
	e.innerHTML = _("muti_natPrompt");

	e = document.getElementById("Muti_natListHead");
	e.innerHTML = _("Muti_natListHead");
	e = document.getElementById("mn_descrip_title");
	e.innerHTML = _("mn_descrip_title");
	e = document.getElementById("description_tips");
	e.innerHTML = _("description_tips");
	e = document.getElementById("mn_descrip_title_1");
	e.innerHTML = _("mn_descrip_title");
	e = document.getElementById("mn_Type_title");
	e.innerHTML = _("mn_Type_title");
		e = document.getElementById("mn_Type_title_1");
	e.innerHTML = _("mn_Type_title");
	e = document.getElementById("mn_locips_title");
	e.innerHTML = _("mn_locips_title");
		e = document.getElementById("mn_locips_title_1");
	e.innerHTML = _("mn_locips_title");
	
	e = document.getElementById("mn_locipe_title");
	e.innerHTML = _("mn_locipe_title");
		e = document.getElementById("mn_locipe_title_1");
	e.innerHTML = _("mn_locipe_title");
	e = document.getElementById("pf_apply");
	e.value = _("pf_apply");
	e = document.getElementById("pf_cancel2");
	e.value = _("pf_cancel2");

	e = document.getElementById("mn_pubips_title");
	e.innerHTML = _("mn_pubips_title");
		e = document.getElementById("mn_pubips_title_1");
	e.innerHTML = _("mn_pubips_title");
	e = document.getElementById("mn_pubipe_title");
	e.innerHTML = _("mn_pubipe_title");
		e = document.getElementById("mn_pubipe_title_1");
	e.innerHTML = _("mn_pubipe_title");

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
	var mn_wanname = document.getElementById("mn_wanname");
	for(var i = 0; i < wan_size; i++ )
	{
		if((wannameArray[i].search("INTERNET") ) >=  0)/*internet相关*/
		{	
			if((wannameArray[i].search("_B_") ) < 0)/*非桥接wan*/
			{
				mn_wanname.options[mn_wanname.length] = new Option(wannameTextArray[i], wannameArray[i]);
			}
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			mn_wanname.options[mn_wanname.length] = new Option(wannameTextArray[i], wannameArray[i]);
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

function ruleTypeSwitch (index)
{
	if(index == 0)
	{
		document.getElementById("mn_locip_e").value = "";
		document.getElementById("mn_pubipe").value = "";
		document.getElementById("mn_locip_e").disabled = 1;
		document.getElementById("mn_pubipe").disabled = 1;

	}
	else if(index == 1)
	{
		document.getElementById("mn_locip_e").value = "";
		document.getElementById("mn_pubipe").value = "";
		document.getElementById("mn_locip_e").disabled = 0;
		document.getElementById("mn_pubipe").disabled = 1;
	}
	else
	{
		document.getElementById("mn_locip_e").disabled = 0;
		document.getElementById("mn_pubipe").disabled = 0;
	}
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
	document.getElementById("mn_Description").focus();
	document.getElementById("mn_ruletype").value = "1";
	ruleTypeSwitch (1);
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("mn_Description").value = "";
			document.getElementById("mn_locips").value = "";
			document.getElementById("mn_locip_e").value = "";
			document.getElementById("mn_pubips").value = "";
			document.getElementById("mn_pubipe").value = "";	
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("mn_Description").value = html_decode(document.getElementById("pt_Description_" + temp).innerHTML);
			
			document.getElementById("mn_locips").value = html_decode(document.getElementById("pt_locips_" + temp).innerHTML);
			document.getElementById("mn_locip_e").value = html_decode(document.getElementById("pt_locipe_" + temp).innerHTML);
			document.getElementById("mn_pubips").value = html_decode(document.getElementById("pt_pubips_" + temp).innerHTML);
			document.getElementById("mn_pubipe").value = html_decode(document.getElementById("pt_pubipe_" + temp).innerHTML);

			var pf_WAN_ID = document.getElementById("mn_wanname");
			var rultype = document.getElementById("pt_ruletype_" + temp).innerHTML;
			pf_WAN_ID.value = document.getElementById("pf_WAN_" + temp).innerHTML;
			
			if(rultype == "One-to-One")
			{
				document.getElementById("mn_ruletype").value = "0";
				document.getElementById("mn_locip_e").disabled = 1;
				document.getElementById("mn_pubipe").disabled = 1;
			}
			else if(rultype == "Many-to-One")
			{
				document.getElementById("mn_ruletype").value = "1";
				document.getElementById("mn_locip_e").disabled = 0;
				document.getElementById("mn_pubipe").disabled = 1;			
			}
								
			else if(rultype == "Many-to-Many Overload")
			{
				document.getElementById("mn_ruletype").value = "2";
				document.getElementById("mn_locip_e").disabled = 0;
				document.getElementById("mn_pubipe").disabled = 0;
			}
			else if(rultype == "Many-to-Many No Overload")
			{
				document.getElementById("mn_ruletype").value = "3";
				document.getElementById("mn_locip_e").disabled = 0;
				document.getElementById("mn_pubipe").disabled = 0;
			}
								
			else if(rultype == "Server")
			{
				document.getElementById("mn_ruletype").value = "4";
				document.getElementById("mn_locip_e").disabled = 0;
				document.getElementById("mn_pubipe").disabled = 0;
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

	document.location = "/goform/Muti_NatDeleteAll" + "?csrftoken=" + getCsrftoken();
	
}

function checkValue()
{
	var locip_e = document.getElementById("mn_locip_e");
	var pubipe = document.getElementById("mn_pubipe");
	var locip_s = document.getElementById("mn_locips");
	var pubips = document.getElementById("mn_pubips");

	if(!checkCommDescription(document.getElementById("mn_Description")))
	{
		return false;
	}
	if(!fw_checkIP(document.getElementById("mn_locips")))
	{
		return false;
	}
	if(locip_e.value != "")
	{
		if(!fw_checkIP(document.getElementById("mn_locip_e")))
		{
			return false;
		}
		
		if ((IpAddress2DecNum(locip_e.value) - IpAddress2DecNum(locip_s.value)) > 256 )
		{
			alert(_("IP_longAlert"));
			locip_e.focus();
			locip_e.value = locip_e.defaultValue;
			return false;
		}

		if((IpAddress2DecNum(locip_e.value) - IpAddress2DecNum(locip_s.value)) < 0 )
		{
			alert(_("pf_endPortTooSmallAlert"));
			locip_e.focus();
			locip_e.value = locip_e.defaultValue;
			return false;

		}
	}
	if(!fw_checkIP(document.getElementById("mn_pubips")))
	{
		return false;
	}
	if(pubipe.value != "")
	{
		if(!fw_checkIP(document.getElementById("mn_pubipe")))
		{
			return false;
		}
		if ((IpAddress2DecNum(pubipe.value) - IpAddress2DecNum(pubips.value)) > 256 )
		{
			alert(_("IP_longAlert"));
			pubipe.focus();
			pubipe.value = pubipe.defaultValue;
			return false;
		}
		if ((IpAddress2DecNum(pubipe.value) - IpAddress2DecNum(pubips.value)) < 0 )
		{
			alert(_("pf_endPortTooSmallAlert"));
			pubipe.focus();
			pubipe.value = pubipe.defaultValue;
			return false;
		}
		
	}
	
	if(document.getElementById("mn_wanname").length <= 0)
	{
		alert(_("Please creat INTERNET WAN first !"));
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

function IpAddress2DecNum(address)
{
    var addrParts = address.split('.');
    var num = 0;
    for (i = 0; i < 4; i++)
    {
        num += parseInt(addrParts[i]) * Math.pow(256, 3 - i);
    }
    return num;
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
              <td id="muti_natPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you could configure Muti NAT.</td>
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/Muti_NatDelete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="Muti_natListHead">Multi NAT Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="8%" align="center" id="muti_wan_1">WAN</td>
                <td width="12%" align="center" id="mn_descrip_title_1">Description</td>
                <td width="13%" align="center" id="mn_Type_title_1">Rule Type</td>
                <td width="15%" align="center" id="mn_locips_title_1">Local Start IP </td>
                <td width="15%" align="center" id="mn_locipe_title_1">Local End IP</td>
                <td width="15%" align="center" id="mn_pubips_title_1">Public Start IP </td>
                <td width="15%" align="center" id="mn_pubipe_title_1">Public End IP</td>
                <td width="5%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% Muti_NatSync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/Muti_NatCfg" onSubmit="return checkValue()">
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
                                    <td class="tabal_right" width="75%"><select name="mn_wanname" id="mn_wanname" size="1" style="width:44%">
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_descrip_title" class="tabal_left" width="25%">Description</td>
                                    <td class="tabal_right" width="75%"><input name="mn_Description" id="mn_Description" size="32" maxlength="31" style="width: 150px;" type="text">
                                      <span id="description_tips" class="gray">&nbsp; ( 0-31 characters, including alphanumeric, '-' and '_')</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_Type_title" class="tabal_left" width="25%">Rule Type</td>
                                    <td class="tabal_right" width="75%"><select name="mn_ruletype" id="mn_ruletype" size="1" style="width:30%" onChange="ruleTypeSwitch(this.value);">
                                        <option value="0" >One-to-One</option>
                                        <option value="1" selected="selected">Many-to-One</option>
                                        <option value="2">Many-to-Many Overload</option>
                                        <option value="3">Many-to-Many No Overload</option>
                                        <option value="4">Server</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_locips_title" class="tabal_left" width="25%">Local Start IP </td>
                                    <td class="tabal_right" width="75%"><input name="mn_locips" id="mn_locips" size="32"  style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_locipe_title" class="tabal_left" width="25%">Local End IP </td>
                                    <td class="tabal_right" width="75%"><input name="mn_locip_e" id="mn_locip_e" size="32"  style="width: 150px;" type="text"></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_pubips_title" class="tabal_left" width="25%">Public Start IP </td>
                                    <td class="tabal_right" width="75%"><input name="mn_pubips" id="mn_pubips" size="32"  style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong></td>
                                  </tr>
                                  <tr style="">
                                    <td id="mn_pubipe_title" class="tabal_left" width="25%">Public End IP </td>
                                    <td class="tabal_right" width="75%"><input name="mn_pubipe" id="mn_pubipe" size="32"  style="width: 150px;" type="text"></td>
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
