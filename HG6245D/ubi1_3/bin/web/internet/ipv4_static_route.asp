<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>IPv4 Static Route</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>';
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;

var get_v4_static_route_sync = '<% get_v4_static_route_sync(); %>';
var v4_sr_ruleSum = '<% getCfgGeneral(1, "v4_sr_ruleSum"); %>';
//v4_sr_ruleSum = 4
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
	var wannameNode = getElement("v4_sr_wan");
	if(wan_size > 0)
	{
		wannameNode.options.remove(0);
	}
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R") >= 0)	// 路由相关
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			wannameNode.options[wannameNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}

	if(v4_sr_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}
	else
	{	
		var row0 = getElement("ruleTable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");

		var curFlagNode;
		for(var i = 0; i < v4_sr_ruleSum; i++)
		{
			curFlagNode = getElement("v4_sr_state_" + i);
			if(curFlagNode.innerHTML == "0")
			{
				curFlagNode.innerHTML = _("ruleDisable");
			}
			else
			{
				curFlagNode.innerHTML = _("ruleEnable");
			}
		}
	}
}

function initTranslation()
{
	var e = document.getElementById("v4StaticRoutePrompt");
	e.innerHTML = _("v4StaticRoutePrompt");

	e = document.getElementById("v4_sr_ruleListHead");
	e.innerHTML = _("v4_sr_ruleListHead");
	e = document.getElementById("v4_sr_wanTitle");
	e.innerHTML = _("wannameTitle");
	e = document.getElementById("v4_sr_ipTitle");
	e.innerHTML = _("ipTitle");
	e = document.getElementById("v4_sr_gwTitle");
	e.innerHTML = _("gwTitle");
	e = document.getElementById("v4_sr_maskTitle");
	e.innerHTML = _("maskTitle");
	e = document.getElementById("v4_sr_stateTitle");
	e.innerHTML = _("stateTitle");
	
	e = document.getElementById("apply");
	e.value = _("apply");
	e = document.getElementById("cancel");
	e.value = _("cancel");

	e = document.getElementById("v4_sr_wanTitle2");
	e.innerHTML = _("wannameTitle");
	e = document.getElementById("v4_sr_wanDisableTitle");
	e.innerHTML = _("wanDisableTitle");
	e = document.getElementById("v4_sr_ipTitle2");
	e.innerHTML = _("ipTitle");
	e = document.getElementById("v4_sr_gwTitle2");
	e.innerHTML = _("gwTitle");
	e = document.getElementById("v4_sr_maskTitle2");
	e.innerHTML = _("maskTitle");

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
	var firstRow = tab[0].rows[1];
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
		row.attachEvent("onclick", function(){selectLine("record_new");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length - 1; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	}
	col = row.insertCell(i);
	
	selectLine("record_new");
	getElement("v4_sr_wan").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{
			showSelectNodeByValue(getElement("v4_sr_wan"), wannameArray[0]);
			getElement("v4_sr_ip").value = "";
			getElement("v4_sr_gw").value = "";
			getElement("v4_sr_mask").value = "";
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
			var curWan = html_decode(getElement("v4_sr_wan_" + temp).innerHTML);
			var wanNode = getElement("v4_sr_wan");
			showSelectNodeByValue(wanNode, curWan);
			if(wanNode.value != curWan)
			{
				wanNode.value = 0;
			}
			
			getElement("v4_sr_ip").value = html_decode(getElement("v4_sr_ip_" + temp).innerHTML);			
			getElement("v4_sr_gw").value = html_decode(getElement("v4_sr_gw_" + temp).innerHTML);			
			getElement("v4_sr_mask").value = html_decode(getElement("v4_sr_mask_" + temp).innerHTML);

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = temp;
		}	

	}	 
}

function clickRemove(tabTitle)
{
	if(v4_sr_ruleSum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('v4_sr_removeFlag');
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
	if(v4_sr_ruleSum == 0)
	{
   		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('v4_sr_removeFlag');
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

	document.location = "/goform/v4_static_route_delete_all" + "?csrftoken=" + getCsrftoken();  
	
}

function checkValue()
{
	if(getElement("v4_sr_wan").value == '0')
	{
		alert(_("pf_wanIllegalAlert"));
		return false;
	}
	if(!v4_sr_checkIP(getElement("v4_sr_ip")))
	{
		return false;
	}
	if(!v4_sr_checkMask(getElement("v4_sr_mask")))
	{
		return false;
	}
	if((getElement("v4_sr_gw").value != "") && !v4_sr_checkIP(document.getElementById("v4_sr_gw")))
	{
		return false;
	}
	
	return true;
}
function v4_sr_checkIP(dom)
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
function v4_sr_checkMask(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	if(!validateMask(dom.value))
	{
		alert(_("pf_maskIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
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
              <td id="v4StaticRoutePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/v4_static_route_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="6" id="v4_sr_ruleListHead">IPV4 Static Route Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="20%" align="center" id="v4_sr_wanTitle">WAN Name</td>
                <td width="22%" align="center" id="v4_sr_gwTitle">Gateway</td>
                <td width="22%" align="center" id="v4_sr_ipTitle">IP Address</td>
                <td width="22%" align="center" id="v4_sr_maskTitle">Subnet Mask</td>
                <td width="9%" align="center" id="v4_sr_stateTitle">State</td>
                <td width="5%" align="center" ></td>
              </tr>
              <% v4_static_route_sync(); %>
              <!--tr id='record_0' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='v4_sr_wan_0' name='v4_sr_wan_0' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='v4_sr_ip_0' name='v4_sr_ip_0' align='center'>192.168.1.0</td>
              <td id='v4_sr_gw_0' name='v4_sr_gw_0' align='center'>255.255.255.0</td>
              <td id='v4_sr_mask_0' name='v4_sr_mask_0' align='center'>192.168.1.0</td>
              <td align='center'><input type='checkbox' name='v4_sr_removeFlag' value='0'/></td>
              </tr>
              <tr id='record_1' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='v4_sr_wan_1' name='v4_sr_wan_1' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='v4_sr_ip_1' name='v4_sr_ip_1' align='center'>192.168.1.1</td>
              <td id='v4_sr_gw_1' name='v4_sr_gw_1' align='center'>255.255.255.0</td>
              <td id='v4_sr_mask_1' name='v4_sr_mask_1' align='center'>192.168.1.1</td>
              <td align='center'><input type='checkbox' name='v4_sr_removeFlag' value='1'/></td>
              </tr>
              <tr id='record_2' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='v4_sr_wan_2' name='v4_sr_wan_2' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='v4_sr_ip_2' name='v4_sr_ip_2' align='center'>192.168.1.2</td>
              <td id='v4_sr_gw_2' name='v4_sr_gw_2' align='center'>255.255.255.0</td>
              <td id='v4_sr_mask_2' name='v4_sr_mask_2' align='center'>192.168.1.2</td>
              <td align='center'><input type='checkbox' name='v4_sr_removeFlag' value='2'/></td>
              </tr>
              <tr id='record_3' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='v4_sr_wan_3' name='v4_sr_wan_3' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='v4_sr_ip_3' name='v4_sr_ip_3' align='center'>192.168.1.3</td>
              <td id='v4_sr_gw_3' name='v4_sr_gw_3' align='center'>255.255.255.0</td>
              <td id='v4_sr_mask_3' name='v4_sr_mask_3' align='center'>192.168.1.3</td>
              <td align='center'><input type='checkbox' name='v4_sr_removeFlag' value='3'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/v4_static_route_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="v4_sr_wanTitle2" class="tabal_left" width="25%">WAN</td>
                  <td class="tabal_right" width="75%"><select name="v4_sr_wan" size="1" style="width:170px;">
                      <option value="0" id="v4_sr_wanDisableTitle">Current WAN isn't available</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="v4_sr_gwTitle2" class="tabal_left">Gateway</td>
                  <td class="tabal_right"><input name="v4_sr_gw" id="v4_sr_gw" size="15"  style="width: 170px;" type="text"></td>
                </tr>
                <tr>
                  <td id="v4_sr_ipTitle2" class="tabal_left">IP Address</td>
                  <td class="tabal_right"><input name="v4_sr_ip" id="v4_sr_ip" size="15"  style="width: 170px;" type="text">
                    <strong style="color:#FF0033">*</strong><span id="v4_sr_ip_tips" class="gray"></span></td>
                </tr>
                <tr>
                  <td id="v4_sr_maskTitle2" class="tabal_left">Subnet Mask</td>
                  <td class="tabal_right"><input name="v4_sr_mask" id="v4_sr_mask" size="15"  style="width: 170px;" type="text">
                    <strong style="color:#FF0033">*</strong><span id="pm_pubIPTips"></span></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" name="apply" id="apply" class="submit">
                    <input type="reset" name="cancel" id="cancel" class="submit" onClick="window.location.reload()">
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
