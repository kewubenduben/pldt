<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Port Bandwidth control</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;

var get_port_bandwidth_ctl_sync = '<% get_port_bandwidth_ctl_sync(); %>';
var port_bandwidth_ctl_ruleSum = '<% getCfgGeneral(1, "port_bandwidth_ctl_ruleSum"); %>';

currentline = 0;

function LoadFrame()
{
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	initTranslation();

	var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
	lan_port_num = parseInt(lan_port_num);
	var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num"); %>';
	wifi_chip_num = parseInt(wifi_chip_num);
	var wifi_pur_chip_num = '<% getCfgGeneral(1, "wifi_pur_chip_num"); %>';
	wifi_pur_chip_num = parseInt(wifi_pur_chip_num);
	var portNode = getElement("port_bw_ctl_port");
	var curValue = 0;
	
	if(ispNameCode != 17 && ispNameCode != 18)	//哥伦比亚telebucaramanga/Metrotel不需要LAN口限速
	{
		for(var i = 0; i < lan_port_num; i++)//lan
		{
			portNode.options[portNode.length] = new Option("LAN " + (i + 1), i);
		}
	}
	for(var i = 0; i < wifi_pur_chip_num; i++)//2.4G
	{
		curValue = lan_port_num + i;
		portNode.options[portNode.length] = new Option("2.4G SSID " + (i + 1),	curValue);
	}
	if(wifi_chip_num > 1)
	{
		for(var i = 0; i < wifi_pur_chip_num; i++)//5G
		{
			curValue = lan_port_num + wifi_pur_chip_num + i;
			portNode.options[portNode.length] = new Option("5G SSID " + (i + 1), curValue);
		}
	}

	if(port_bandwidth_ctl_ruleSum == 0)
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
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 4)
	{
 		alert(_("rule_most4RulesAlert"));
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
	getElement("port_bw_ctl_port").focus();
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
			getElement("port_bw_ctl_port").value = 0;
			getElement("port_bw_ctl_up").value = "";
			getElement("port_bw_ctl_down").value = "";
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
			var curPort = getElement("port_bw_ctl_port_" + temp).innerHTML;
			var portNode = getElement("port_bw_ctl_port");
			showSelectNodeByText(portNode, curPort);

			getElement("port_bw_ctl_up").value = getElement("port_bw_ctl_up_" + temp).innerHTML;
			getElement("port_bw_ctl_down").value = getElement("port_bw_ctl_down_" + temp).innerHTML;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = temp;
		}	

	}	 
}

function clickRemove(tabTitle)
{
	if(port_bandwidth_ctl_ruleSum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('port_bw_ctlFlag');
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
	if(port_bandwidth_ctl_ruleSum == 0)
	{
   		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('port_bw_ctlFlag');
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

	document.location = "/goform/port_bandwidth_ctl_delete_all" + "?csrftoken=" + getCsrftoken();   
	
}

function checkValue()
{
	var portNode = getElement("port_bw_ctl_port");
	var curPort = portNode.options[portNode.selectedIndex].text;
	if(!port_bw_ctl_checkPort(curPort))
	{		
		portNode.options[0].selected = true;
		portNode.focus();
		return false;
	}
	
	var upNode = getElement("port_bw_ctl_up");
	if(!port_bw_ctl_checkBandwidth(upNode.value))
	{		
		upNode.value = upNode.defaultValue;
		upNode.focus();
		return false;
	}
	var downNode = getElement("port_bw_ctl_down");
	if(!port_bw_ctl_checkBandwidth(downNode.value))
	{		
		downNode.value = downNode.defaultValue;
		downNode.focus();
		return false;
	}
	
	return true;
}
function port_bw_ctl_checkBandwidth(str)
{
	if(!CheckNotNull(str))
	{
		alert(_("bandwidthIllegalAlert"));
		return false;
	}
	else				//数字 [64, 1000000]
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(str))
		{
			alert(_("bandwidthIllegalAlert"));
			return false; 
		}
		else
		{
			str = parseInt(str);
			if(64 <= str  && str <= 1000000)
			{
				return true;
			}
			else
			{
				alert(_("bandwidthIllegalAlert"));
				return false; 
			}
		}
	}
	return true;
}
function port_bw_ctl_checkPort(curPort)
{
	for(var i = 0; i < port_bandwidth_ctl_ruleSum; i++)
	{
		if(currentline != 'new') /* 修改 */
		{
			if(currentline != i) /*temp 为当前修改wan的行号，不和自己进行比较*/
			{
				if(curPort == getElement("port_bw_ctl_port_" + i).innerHTML)
				{
					alert("This port is configured!");
					return false;
				}
			}
		}
		else /* 新增 */
		{	
			if(curPort == getElement("port_bw_ctl_port_" + i).innerHTML)
			{
				alert("This port is configured!");
				return false;
			}
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
              <td id="port_bw_ctl_Prompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure bandwidth control based on port.</td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/port_bandwidth_ctl_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="6" id="port_bw_ctl_ruleListHead">Port Bandwidth Control Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="20%" align="center" id="bw_ctl_portTitle">Port</td>
                <td width="37%" align="center" id="bw_ctl_upTitle">Up Bandwidth </td>
                <td width="37%" align="center" id="bw_ctl_downTitle">Down Bandwidth</td>
                <td width="6%" align="center"></td>
              </tr>
              <% port_bandwidth_ctl_sync(); %>
              <!--tr id='record_0' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='port_bw_ctl_port_0' align='center'>LAN 1</td>
              <td id='port_bw_ctl_up_0' align='center'>1000</td>
              <td id='port_bw_ctl_down_0' align='center'>2000</td>
              <td align='center'><input type='checkbox' name='port_bw_ctlFlag' value='0'/></td>
              </tr>
              <tr id='record_1' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='port_bw_ctl_port_1' align='center'>2.4G SSID 2</td>
              <td id='port_bw_ctl_up_1' align='center'>2000</td>
              <td id='port_bw_ctl_down_1' align='center'>3000</td>
              <td align='center'><input type='checkbox' name='port_bw_ctlFlag' value='1'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/port_bandwidth_ctl_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="bw_ctl_portTitle2" class="tabal_left" width="25%">Port</td>
                  <td class="tabal_right" width="75%"><select name="port_bw_ctl_port" size="1">
                    </select></td>
                </tr>
                <tr>
                  <td id="bw_ctl_upTitle2" class="tabal_left">Up Bandwidth</td>
                  <td class="tabal_right"><input name="port_bw_ctl_up" maxlength="7" style="width:170px;" type="text">
                    &nbsp;kbps&nbsp; <strong style="color:#FF0033">*</strong><span id="bw_ctl_up_tips" class="gray">(64-1000000)</span></td>
                </tr>
                <tr>
                  <td id="bw_ctl_downTitle2" class="tabal_left">Down Bandwidth</td>
                  <td class="tabal_right"><input name="port_bw_ctl_down" maxlength="7" style="width:170px;" type="text">
                    &nbsp;kbps&nbsp; <strong style="color:#FF0033">*</strong><span id="bw_ctl_down_tips" class="gray">(64-1000000)</span></td>
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
