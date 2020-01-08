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

var aclsize = '<% acl_ipv6size_sync(); %>';
var pf_ruleSum;

var previousTR = null;
function initTranslation()
{

}
function LoadFrame()
{ 
	//initTranslation();
	var acl_ctl = document.getElementsByName("acl_ipv6_ctl");	
	showRadioNodeByValue(acl_ctl, '<% getCfgGeneral(1, "acl_ipv6_up"); %>');

	pf_ruleSum  = '<% getCfgGeneral(1, "acl_ipv6_size"); %>';

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	else
	{	
		var row0 = getElement("acl_ipv6_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 17)
	{		
//   	alert("最多只能创建16条规则!");
 		alert(_("fw_most16RulesAlert"));
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
	document.getElementById("acl_ipv6_startip").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("acl_ipv6_startip").value = "";
			document.getElementById("acl_ipv6_endip").value = "";	
			setLineHighLight(objTR);
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("acl_ipv6_startip").value = document.getElementById("acl_v6_adress_" + temp).innerHTML.split('-')[0];
			document.getElementById("acl_ipv6_endip").value = document.getElementById("acl_v6_adress_" + temp).innerHTML.split('-')[1];
			var acl_atctive_value = document.getElementById("acl_v6_active_" + temp).innerHTML;
			var acl_apptype_value = document.getElementById("acl_v6_apptype_" + temp).innerHTML;
			var acl_direction_value = document.getElementById("acl_v6_direction_" + temp).innerHTML;
			var acl_active_ID = document.getElementById("acl_ipv6_active");
			var acl_apptype_ID = document.getElementById("acl_ipv6_apptype");
			var acl_direction_ID = document.getElementById("acl_ipv6_direction");
			if (acl_atctive_value == "Yes")
			{
				acl_active_ID.value = "1";
			}
			else
			{	
				acl_active_ID.value = "0";
			}

			if(acl_apptype_value == "WEB")
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
			else if(acl_apptype_value == "PING")
			{
				acl_apptype_ID.value = "5"
			}			
			else if(acl_apptype_value == "SSH")
			{
				acl_apptype_ID.value = "6"
			}
			else
			{
				acl_apptype_ID.value = "0"
			}

			if (acl_direction_value == "LAN")
			{
				acl_direction_ID.value = "0";
			}
			else
			{	
				acl_direction_ID.value = "1";
			}
            setLineHighLight(objTR);
		}	

		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);		
	}	 
}

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

	if(confirm(_("fw_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}

	document.location = "/goform/acl_ipv6_delete_all" + "?csrftoken=" + getCsrftoken(); 
}

function checkValue()
{
	var startip_node = document.getElementById("acl_ipv6_startip");
	var endip_node = document.getElementById("acl_ipv6_endip");
	if(startip_node.value == "")
	{
		if(endip_node.value != "")
		{
			alert(_("please input start IPv6!"));
			return false;
		}
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
              <td id="ACL_ipv6Prompt" style="padding-left: 10px;" class="title_01" width="100%">You could configure IPv6 ACL here!</td>
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
  <td id="acl_ctl_table1"><form method="post" id="acl_ctl_table" action="/goform/acl_ipv6_enable_cfg">
      <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
        <tbody>
          <tr>
            <td class="tabal_left" id="ACL_ipv6enable_title" align="left" width="25%">IPv6 ACL Enable</td>
            <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" name="acl_ipv6_ctl" type="radio">
              <font id="enable_title">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input value="0" name="acl_ipv6_ctl" type="radio">
              <font id="disable_title">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/acl_ipv6_delete">
          <table class="tabal_bg" id = "acl_ipv6_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="ipv6acl_ListHead">IPv6 ACL Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="6%" align="center" >ID</td>
                <td width="8%" align="center" >Active</td>
                <td width="60%" align="center">Secure IPv6 Address</td>
                <td width="8%" align="center" >Protocol</td>
                <td width="8%" align="center" >Interface</td>
                <td width="8%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% acl_ipv6_sync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/acl_ipv6_cfg" onSubmit="return checkValue()">
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
                                    <td class="tabal_right" width="75%"><select name="acl_ipv6_active" id="acl_ipv6_active" size="1" style="width:14%">
                                        <option value="0" selected="selected">No</option>
                                        <option value="1">Yes</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_ip_title" class="tabal_left" width="25%">Secure IPv6 Address</td>
                                    <td class="tabal_right" width="75%"><input name="acl_ipv6_startip" id="acl_ipv6_startip" size="32"  style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="acl_ipv6_endip" id="acl_ipv6_endip" size="32" style="width: 150px;" type="text">
                                      </td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_protype_title" class="tabal_left" width="25%">Protocol</td>
                                    <td class="tabal_right" width="75%"><select name="acl_ipv6_apptype" id="acl_ipv6_apptype" size="1" style="width:14%">
                                        <option value="1">WEB</option>
                                        <option value="5" selected="selected">PING</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="acl_Interface_title" class="tabal_left" width="25%">Interface</td>
                                    <td class="tabal_right" width="75%"><select name="acl_ipv6_direction" id="acl_ipv6_direction" size="1" style="width:14%">
                                        <option value="0" selected="selected">LAN</option>
                                        <option value="1">WAN</option>
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
