<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>ACL</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var aclsize = '<% ACL_3bbSizeSync(); %>';
var pf_ruleSum;

var previousTR = null;
function initTranslation()
{

}

function InterfaceChange()
{
	var acl_direction_node = document.getElementById("acl_direction");
	var acl_apptypeNode = getElement("acl_apptype");

	/*modify by郭心悦，20161208，解决初始页面刷新wan/lan下拉框问题*/
	if(ispNameCode == 17 || ispNameCode == 18)/*COLUMBIA_TELEBU COLUMBIA_METRO*/	
	{
		if(acl_direction_node.options.selectedIndex == 0)/*LAN 侧*/
		{
			if(  acl_apptypeNode.length == 6)/*页面初始状态，下拉框有6个选项分别是:ALL,HTTP,TELNET,ICMP,SNMP,FTP*/
			{
				acl_apptypeNode.options.remove(5);
				acl_apptypeNode.options.remove(4);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('FTP', 2);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('SSH', 6);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('DNS', 7);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('TFTP', 8);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('HTTPS', 9);
			}
			if(  acl_apptypeNode.length == 4)/*由wan侧(有4个选项:ALL,HTTP,TELNET,ICMP)切换到lan侧*/
			{
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('FTP', 2);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('SSH', 6);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('DNS', 7);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('TFTP', 8);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('HTTPS', 9);
			}			
		}
		else/*WAN 侧*/
		{
			if(  acl_apptypeNode.length == 9)/*由lan侧切换到wan侧状态，lan侧下拉框有9个选项:ALL,HTTP,TELNET,ICMP,FTP,SSH,DNS,TFTP,HTTPS*/
			{			
				acl_apptypeNode.options.remove(8);
				acl_apptypeNode.options.remove(7);
				acl_apptypeNode.options.remove(6);
				acl_apptypeNode.options.remove(5);
				acl_apptypeNode.options.remove(4);
			}
			if(  acl_apptypeNode.length == 6)/*页面初始状态，下拉框有6个选项分别是:ALL,HTTP,TELNET,ICMP,SNMP,FTP*/
			{
				acl_apptypeNode.options.remove(5);
				acl_apptypeNode.options.remove(4);
			}
		}
	}	
	else if(ispNameCode == 15)	//GLOBE LAN:ALL/HTTP/TELNET/SNMP/FTP WAN:ALL/SNMP/FTP
	{
		if(acl_direction_node.options.selectedIndex == 0)/* LAN */
		{
			if(acl_apptypeNode.length < 5)
			{
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('HTTP', 1);
				acl_apptypeNode.options[acl_apptypeNode.length] = new Option('TELNET', 4);
			}
		}
		else	//wan
		{
			if(acl_apptypeNode.length > 3)
			{
				acl_apptypeNode.options.remove(4);
				acl_apptypeNode.options.remove(3);
			}
		}
	}
}
function LoadFrame()
{ 
	//initTranslation();
	var acl_ctl = document.getElementsByName("acl_ctl");	
	showRadioNodeByValue(acl_ctl, '<% getCfgGeneral(1, "acl_up"); %>');

	var acl_apptypeNode = getElement("acl_apptype");
	if(ispNameCode == '12')//厄瓜多尔HGU
	{
		acl_apptypeNode.options[acl_apptypeNode.length] = new Option('SSH', 6);
	}
	else if(ispNameCode == '15')//HGU GLOBE
	{
		setDisplay("tr_prompGlobe", "");
		acl_apptypeNode.options.remove(3);	//delete by wuxj, 20160906, descrip:delete ping
		acl_apptypeNode.options.remove(2);	//delete by wuxj, 20171214, descrip:wan不支持telnet
		acl_apptypeNode.options.remove(1);	//delete by wuxj, 20171214, descrip:wan不支持http
	}
	else if(ispNameCode == '25')//HGU X_GEO
	{
		//delete by wuxj, 20171023, descrip:delete snmp/ftp
		acl_apptypeNode.options.remove(5);
		acl_apptypeNode.options.remove(4);	
	}
	
	pf_ruleSum  = '<% getCfgGeneral(1, "acl_size"); %>';
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

	if((ispNameCode == 17) || (ispNameCode == 18))/*COLUMBIA_TELEBU与COLUMBIA_METRO*/
	{
		if(rowLen > 33)
		{		
			//   	alert("最多只能创建32条规则!");
	 		alert(_("fw_most32RulesAlert"));
			return;
		}
	}
	else
	{
		if(rowLen > 17)
		{		
			//   	alert("最多只能创建16条规则!");
	 		alert(_("fw_most16RulesAlert"));
			return;
		}
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
	document.getElementById("acl_startip").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{			    
			InterfaceChange();

			document.getElementById("acl_startip").value = "";
			document.getElementById("acl_endip").value = "";	
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("acl_startip").value = document.getElementById("acl_adress_" + temp).innerHTML.split('-')[0];
			document.getElementById("acl_endip").value = document.getElementById("acl_adress_" + temp).innerHTML.split('-')[1];
			var acl_atctive_value = document.getElementById("acl_active_" + temp).innerHTML;
			var acl_apptype_value = document.getElementById("acl_apptype_" + temp).innerHTML;
			var acl_direction_value = document.getElementById("acl_direction_" + temp).innerHTML;
			var acl_active_ID = document.getElementById("acl_active");
			var acl_apptype_ID = document.getElementById("acl_apptype");
			var acl_direction_ID = document.getElementById("acl_direction");
			if (acl_atctive_value == "Yes")
			{
				acl_active_ID.value = "1";
			}
			else
			{	
				acl_active_ID.value = "0";
			}

			if (acl_direction_value == "LAN")
			{
				acl_direction_ID.value = "0";
			}
			else
			{	
				acl_direction_ID.value = "1";
			}	    
			InterfaceChange();

			if(acl_apptype_value == "HTTP")
			{
				acl_apptype_ID.value = "1"
			}
			else if(acl_apptype_value == "FTP")
			{
				acl_apptype_ID.value = "2"
			}
			else if(acl_apptype_value == "SNMP")
			{
				acl_apptype_ID.value = "3"
			}
			else if(acl_apptype_value == "Telnet")
			{
				acl_apptype_ID.value = "4"
			}			
			else if(acl_apptype_value == "ICMP")
			{
				acl_apptype_ID.value = "5"
			}			
			else if(acl_apptype_value == "SSH")
			{
				acl_apptype_ID.value = "6"
			}
			else if(acl_apptype_value == "DNS")
			{
				acl_apptype_ID.value = "7"
			}			
			else if(acl_apptype_value == "TFTP")
			{
				acl_apptype_ID.value = "8"
			}			
			else if(acl_apptype_value == "HTTPS")
			{
				acl_apptype_ID.value = "9"
			}
			else
			{
				acl_apptype_ID.value = "0"
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
		alert(_("fw_noChooseAlert"));
		return ;
	}
	
	if(ispNameCode == '25')	//格鲁吉亚
	{
		if(confirm(_("aclChange_confirm"))== false)
			return ;
	}
	else
	{
		if(confirm(_("fw_deleteRuleConfirm")) == false)
    		return;
	}
	
//	document.location = "/goform/URL_filterDelete";
	getElement("fw_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{
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

	if(ispNameCode == '25')	//格鲁吉亚
	{
		if(confirm(_("aclChange_confirm"))== false)
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
	}
	else
	{		
		if(confirm(_("fw_deleteRuleConfirm")) == false)
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
	}

	document.location = "/goform/ACL_3bbDeleteAll" + "?csrftoken=" + getCsrftoken();
}

function checkValue()
{
	var acl_startip = document.getElementById("acl_startip");
	var acl_endip = document.getElementById("acl_endip");

	if(ispNameCode == 4) /*泰国3bb*/
	{
		if((acl_startip.value == "0.0.0.0") && (acl_endip.value == "0.0.0.0"))
		{ 
			return true;
		}
	}
	
	if(acl_startip.value == "")
	{
		if(acl_endip.value != "")
		{
			alert(_("Please input start IP!"));
			acl_startip.value = acl_startip.defaultValue;
			acl_startip.focus();
			return false;
		}
	}
	else		//start is not null
	{
		if(!validateIP(acl_startip.value))
		{
			alert(_("fw_ipIllegalAlert"));
			acl_startip.value = acl_startip.defaultValue;
			acl_startip.focus();
			return false;
		}
		if(acl_endip.value != "")
		{
			if(!validateIP(acl_endip.value))
			{
				alert(_("fw_ipIllegalAlert"));
				acl_endip.value = acl_endip.defaultValue;
				acl_endip.focus();
				return false;
			}
			if(compareIP(acl_startip.value, acl_endip.value) == 1)
			{
				alert(_("fw_endIPTooSmallAlert"));
				acl_endip.value = acl_endip.defaultValue;
				acl_endip.focus();
				return false;
			}
		}
	}

	if(ispNameCode == '25')	//格鲁吉亚
	{
		var fw_curIndexNode = getElement('fw_curIndex');
		if(fw_curIndexNode.value == 'new')
			return true;
		else	//modify
		{
			if(confirm(_("aclChange_confirm")))
				return true;
			else
				return false;
		}
	}
	else
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
              <td id="ACLPrompt" style="padding-left: 10px;" class="title_01" width="100%">You could configure ACL here!</td>
            </tr>
            <tr id="tr_prompGlobe" style="display: none">
              <td style="padding-left: 10px;color:#FF0033" class="title_01" width="100%">WAN ACL telnet and web are locked.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<tr>
  <td id="acl_ctl_table1"><form method="post" id="acl_ctl_table" action="/goform/AclUpCfg">
      <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
        <tbody>
          <tr>
            <td class="tabal_left" id="ACLenable_title" align="left" width="25%">ACL Enable</td>
            <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="acl_ctl" type="radio">
              <font id="enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input value="0" name="acl_ctl" type="radio">
              <font id="disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
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
</tr>
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/ACL_3bbDelete">
          <table class="tabal_bg" id = "url_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="url_filterListHead">ACL Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="6%" align="center" >ID</td>
                <td width="8%" align="center" >Active</td>
                <td width="60%" align="center">Secure IP Address</td>
                <td width="8%" align="center" >Protocol</td>
                <td width="8%" align="center" >Interface</td>
                <td width="8%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% ACL_3bbSync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/ACL_3bbCfg" onSubmit="return checkValue()">
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
                                    <td id="acl_active_title" class="tabal_left" width="25%">Active</td>
                                    <td class="tabal_right" width="75%"><select name="acl_active" id="acl_active" size="1" style="width:14%">
                                        <option value="0" selected="selected">No</option>
                                        <option value="1">Yes</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_ip_title" class="tabal_left" width="25%">Secure IP Address</td>
                                    <td class="tabal_right" width="75%"><input name="acl_startip" id="acl_startip" size="32"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="acl_endip" id="acl_endip" size="32" style="width: 150px;" type="text">
                                      </td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_Interface_title" class="tabal_left" width="25%">Interface</td>
                                    <td class="tabal_right" width="75%"><select name="acl_direction" id="acl_direction" size="1" style="width:14%" onChange="InterfaceChange()">
                                        <option value="0" selected="selected">LAN</option>
                                        <option value="1">WAN</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_protype_title" class="tabal_left" width="25%">Protocol</td>
                                    <td class="tabal_right" width="75%"><select name="acl_apptype" id="acl_apptype" size="1" style="width:14%">
                                        <option value="0">ALL</option>
                                        <option value="1" selected="selected">HTTP</option>
                                        <option value="4">Telnet</option>
                                        <option value="5">ICMP</option>                                       
                                        <option value="3">SNMP</option>
                                        <option value="2">FTP</option>
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
