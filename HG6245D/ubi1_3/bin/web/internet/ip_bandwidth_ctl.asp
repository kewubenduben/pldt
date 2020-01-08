<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>IP Bandwidth control</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("port_forwarding", lang);

var previousTR = null;

var get_ip_bandwidth_ctl_sync = '<% get_ip_bandwidth_ctl_sync(); %>';
var ip_bandwidth_ctl_ruleSum = '<% getCfgGeneral(1, "ip_bandwidth_ctl_ruleSum"); %>';
//ip_bandwidth_ctl_ruleSum = 4

function LoadFrame()
{
	initTranslation();	

	if(ip_bandwidth_ctl_ruleSum == 0)
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
	getElement("ip_bw_ctl_descrip").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{
			getElement("ip_bw_ctl_descrip").value = "";
			getElement("ip_bw_ctl_ipStart").value = "";
			getElement("ip_bw_ctl_ipEnd").value = "";
			getElement("ip_bw_ctl_up").value = "";
			getElement("ip_bw_ctl_down").value = "";
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
			getElement("ip_bw_ctl_descrip").value = html_decode(getElement("ip_bw_ctl_descrip_" + temp).innerHTML);

			var curIP = html_decode(getElement("ip_bw_ctl_ip_" + temp).innerHTML);
			getElement("ip_bw_ctl_ipStart").value = curIP.split("-")[0];
			getElement("ip_bw_ctl_ipEnd").value = curIP.split("-")[1];
			getElement("ip_bw_ctl_up").value = getElement("ip_bw_ctl_up_" + temp).innerHTML;
			getElement("ip_bw_ctl_down").value = getElement("ip_bw_ctl_down_" + temp).innerHTML;

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;

			//标志当前编辑规则的id
			getElement("curIndex").value = temp;
		}	

	}	 
}

function clickRemove(tabTitle)
{
	if(ip_bandwidth_ctl_ruleSum  == 0)
	{			
 		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('ip_bw_ctlFlag');
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
	if(ip_bandwidth_ctl_ruleSum == 0)
	{
   		alert(_("rule_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('ip_bw_ctlFlag');
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

	document.location = "/goform/ip_bandwidth_ctl_delete_all" + "?csrftoken=" + getCsrftoken();  
	
}

function checkValue()
{
	if(!ip_bw_ctl_checkDescrip(getElement("ip_bw_ctl_descrip")))
	{
		return false;
	}
	if(!ip_bw_ctl_checkIP(getElement("ip_bw_ctl_ipStart")))
	{
		return false;
	}
	if(!ip_bw_ctl_checkIP(getElement("ip_bw_ctl_ipEnd")))
	{
		return false;
	}
	var upNode = getElement("ip_bw_ctl_up");
	if(!ip_bw_ctl_checkBandwidth(upNode.value))
	{		
		upNode.value = upNode.defaultValue;
		upNode.focus();
		return false;
	}
	var downNode = getElement("ip_bw_ctl_down");
	if(!ip_bw_ctl_checkBandwidth(downNode.value))
	{		
		downNode.value = downNode.defaultValue;
		downNode.focus();
		return false;
	}
	
	return true;
}
function ip_bw_ctl_checkDescrip(dom)
{
	var reg = /^[\w-]{0,32}$/;	//数字 英文字母 _ -
	if (!reg.test(dom.value))
	{
		alert(_("descripIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus(); 
		return false;
	}
	else
	{
		return true;
	}
	return true;
}

function ip_bw_ctl_checkIP(dom)
{
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
function ip_bw_ctl_checkBandwidth(str)
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
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="ip_bw_ctl_Prompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure bandwidth control based on IP.</td>
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
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/ip_bandwidth_ctl_delete">
          <table class="tabal_bg" id = "ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="6" id="ip_bw_ctl_ruleListHead">IP Bandwidth Control Rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="20%" align="center" id="bw_ctl_descripTitle">Description</td>
                <td width="30%" align="center">IP</td>
                <td width="22%" align="center" id="bw_ctl_upTitle">Up Bandwidth</td>
                <td width="22%" align="center" id="bw_ctl_downTitle">Down Bandwidth</td>
                <td width="6%" align="center" ></td>
              </tr>
              <% ip_bandwidth_ctl_sync(); %>
              <!--tr id='record_0' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='ip_bw_ctl_descrip_0' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='ip_bw_ctl_ip_0' align='center'>192.168.254.1-192.168.254.100</td>
              <td id='ip_bw_ctl_up_0' align='center'>1000</td>
              <td id='ip_bw_ctl_down_0' align='center'>2000</td>
              <td align='center'><input type='checkbox' name='ip_bw_ctlFlag' value='0'/></td>
              </tr>
              <tr id='record_1' class='tabal_01' onclick='selectLine(this.id);'>
              <td id='ip_bw_ctl_descrip_1' align='center'>VOIP_INTERNET_R_VID_10</td>
              <td id='ip_bw_ctl_ip_1' align='center'>192.168.254.2-192.168.254.200</td>
              <td id='ip_bw_ctl_up_1' align='center'>2000</td>
              <td id='ip_bw_ctl_down_1' align='center'>3000</td>
              <td align='center'><input type='checkbox' name='ip_bw_ctlFlag' value='1'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/ip_bandwidth_ctl_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="bw_ctl_descripTitle2" class="tabal_left" width="25%">Description</td>
                  <td class="tabal_right" width="75%"><input name="ip_bw_ctl_descrip" maxlength="32" style="width:170px;" type="text">
                    <span id="description_tips" class="gray">( 0-32 characters, including alphanumeric, '-' and '_')</span></td>
                </tr>
                <tr>
                  <td class="tabal_left" width="25%">IP</td>
                  <td class="tabal_right" width="75%"><input name="ip_bw_ctl_ipStart" maxlength="15" style="width:170px;" type="text">
                    &nbsp;<strong style="color:#FF0033">*</strong> &nbsp;&nbsp;-&nbsp;&nbsp;
                    <input name="ip_bw_ctl_ipEnd" maxlength="15" style="width: 170px;" type="text">
                    &nbsp;<strong style="color:#FF0033">*</strong></td>
                </tr>
                <tr>
                  <td id="bw_ctl_upTitle2" class="tabal_left">Up Bandwidth</td>
                  <td class="tabal_right"><input name="ip_bw_ctl_up" maxlength="7" style="width:170px;" type="text">
                    &nbsp;kbps&nbsp; <strong style="color:#FF0033">*</strong><span id="ip_bw_ctl_up_tips" class="gray">(64-1000000)</span></td>
                </tr>
                <tr>
                  <td id="bw_ctl_downTitle2" class="tabal_left">Down Bandwidth</td>
                  <td class="tabal_right"><input name="ip_bw_ctl_down" maxlength="7" style="width:170px;" type="text">
                    &nbsp;kbps&nbsp; <strong style="color:#FF0033">*</strong><span id="ip_bw_ctl_down_tips" class="gray">(64-1000000)</span></td>
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
