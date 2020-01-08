<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>WIFI ACL</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;

var get_wifi_acl_mode_sync = '<% get_wifi_acl_mode_sync(); %>';
var get_wifi_acl_sync = '<% get_wifi_acl_sync(); %>';
var wifi_acl_ruleSum = '<% getCfgGeneral(1, "wifi_acl_ruleSum"); %>';
//wifi_acl_ruleSum = 2

function LoadFrame()
{
	initTranslation();

	var wifi_acl_mode = '<% getCfgGeneral(1, "wifi_acl_mode"); %>';
	wifi_acl_mode = parseInt(wifi_acl_mode);
	var enableNode = getElement("wifi_acl_enable");
	var modeNode = getElement("wifi_acl_mode");
	if(wifi_acl_mode == 0)
	{
		showRadioNodeByValue(enableNode, wifi_acl_mode);
	}
	else
	{
		setDisplay("tr_wifi_acl_mode", "");
		showRadioNodeByValue(enableNode, 1);
		showSelectNodeByValue(modeNode, wifi_acl_mode);
	}	

	if(wifi_acl_ruleSum == 0)
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
	var e = document.getElementById("wifi_acl_Prompt");
	e.innerHTML = _("wifi_acl_Prompt");
	e = document.getElementById("wifi_acl_enable_title");
	e.innerHTML = _("wifi_acl_enable_title");
	e = document.getElementById("wifi_acl_enable");
	e.innerHTML = _("Enable");
	e = document.getElementById("wifi_acl_disable");
	e.innerHTML = _("Disable"); 
	e = document.getElementById("wifi_acl_ruleListHead");
	e.innerHTML = _("wifi_acl_ruleListHead");  
	  
	e = document.getElementById("rule_add");
	e.value = _("rule_add");
	e = document.getElementById("rule_delete");
	e.value = _("rule_delete");
	e = document.getElementById("rule_deleteAll");
	e.value = _("rule_deleteAll");	
	e = document.getElementById("wifi_acl_mode_apply");
	e.value = _("apply");
	e = document.getElementById("wifi_acl_mode_cancel");
	e.value = _("cancel");
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 32)
	{
 		alert(_("rule_most32RulesAlert"));
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
	getElement("wifi_acl_mac").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{
			getElement("wifi_acl_mac").value = "";
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
			getElement("wifi_acl_mac").value = getElement("wifi_acl_mac_" + temp).innerHTML;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = temp;
		}	

	}	 
}

function clickRemove(tabTitle)
{
	if(wifi_acl_ruleSum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('wifi_acl_ctlFlag');
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
	
	load_waiting();
	getElement("ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(wifi_acl_ruleSum == 0)
	{
   		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('wifi_acl_ctlFlag');
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
	load_waiting();
	document.location = "/goform/wifi_acl_delete_all" + "?csrftoken=" + getCsrftoken();
	
}

function checkValue()
{
	var macNode = getElement("wifi_acl_mac");
	if(!validateMAC(macNode.value))
	{
		alert(_("macIllegalAlert"));
		macNode.value = macNode.defaultValue;
		macNode.focus();
		return false;
	}
	load_waiting();
	return true;
}
function switchModeEnable(switchValue)
{
	if(parseInt(switchValue) == 1)	//enable
	{
		setDisplay("tr_wifi_acl_mode", "");
	}
	else					//disable
	{
		setDisplay("tr_wifi_acl_mode", "none");
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
              <td id="wifi_acl_Prompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you could configure WIFI ACL enable/disable, and enabled rules.</td>
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
      <td><form method="post" id="url_enable" action="/goform/wifi_acl_mode_cfg">
          <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td class="tabal_left" id="wifi_acl_enable_title" align="left" width="25%">Blacklist/Whitelist</td>
                <td class="tabal_right" align="left"><input checked="checked" value="1" name="wifi_acl_enable" onclick="switchModeEnable(this.value)" type="radio">
                  <font id="wifi_acl_enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  <input value="0" name="wifi_acl_enable" onclick="switchModeEnable(this.value)" type="radio">
                  <font id="wifi_acl_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
              </tr>
              <tr id="tr_wifi_acl_mode" style="display: none">
                <td class="tabal_left" id="wifi_acl_mode_title" align="left"></td>
                <td class="tabal_right" align="left"><select name="wifi_acl_mode" size="1" style="width:20%">
                    <option value="1" selected="selected">Whitelist</option>
                    <option value="2">Blacklist</option>
                  </select>
                  <strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
              </tr>
          </table>
          <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td class="tabal_submit" width="25%"></td>
                <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="wifi_acl_mode_apply">
                  &nbsp; &nbsp;
                  <input class="submit" type="reset" value="Cancel" id="wifi_acl_mode_cancel" onClick="window.location.reload()">
                </td>
              </tr>
            </tbody>
          </table>
        </form></td>
    </tr>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/wifi_acl_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="6" id="wifi_acl_ruleListHead">Access Control List</td>
              </tr>
              <tr class="tabal_title">
                <td width="18%" align="center">ID</td>
                <td width="80%" align="center" id="wifi_acl_macTitle">MAC</td>
                <td width="2%" align="center"></td>
              </tr>
              <% wifi_acl_sync(); %>
              <!--tr id='record_0' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='wifi_acl_id_0' align='center'>1</td>
              <td id='wifi_acl_mac_0' align='center'>192.168.254.1-192.168.254.100</td>
              <td align='center'><input type='checkbox' name='wifi_acl_ctlFlag' value='0'/></td>
              </tr>
              <tr id='record_1' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='ip_bw_ctl_descrip_1' align='center'>2</td>
              <td id='ip_bw_ctl_ip_1' align='center'>192.168.254.2-192.168.254.200</td>
              <td align='center'><input type='checkbox' name='wifi_acl_ctlFlag' value='1'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/wifi_acl_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="wifi_acl_macTitle2" class="tabal_left" width="20%">MAC</td>
                  <td class="tabal_right" width="75%"><input name="wifi_acl_mac" maxlength="32" style="width:170px;" type="text">
                    <span id="mac_tips" class="gray">" (You can input alphanumeric and ':', such as 00:24:21:19:BD:E4)"</span></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" name="apply" class="submit" value="Apply">
                    <input type="reset" name="cancel" class="submit" value="Cancel" onClick="window.location.reload()">
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

