<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCP MAC BINDING</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;

var URLsize = '<% dhcp_macbandsize_get(); %>';
var pf_ruleSum;
var currentline;

function initTranslation()
{
	var e = document.getElementById("dhcp_macbandPrompt");
	e.innerHTML = _("dhcp_macbandPrompt");
	e = document.getElementById("dhcp_bandListHead");
	e.innerHTML = _("dhcp_bandListHead");	

	e = document.getElementById("dhcpmac_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("dhcpmac_cancel");
	e.value = _("firewall_cancel");
	
}
function LoadFrame()
{ 
	initTranslation();	
	
	pf_ruleSum  = '<% getCfgGeneral(1, "dhcpmac_size"); %>';

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("dhcpmac_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 9)
	{		
//   		alert("最多只能创建8条规则!");
 		alert(_("fw_most8RulesAlert"));
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
	
	for (var i = 0; i < firstRow.cells.length - 1; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	}
	col = row.insertCell(i);
	
	selectLine("record_new");
	document.getElementById("dhcp_mac").focus();
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
			document.getElementById("dhcp_mac").value = "";
			document.getElementById("dhcp_ip").value = "";
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("dhcp_mac").value = html_decode(document.getElementById("dhcp_mac_" + temp).innerHTML);
			document.getElementById("dhcp_ip").value = html_decode(document.getElementById("dhcp_ip_" + temp).innerHTML).split('-')[0].split(':')[0];
		}
		
		setLineHighLight(previousTR, objTR); 
		previousTR = objTR;

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
	var checkNodes = getElement('dhcpmac_removeFlag');
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
//	document.location = "/goform/URL_filterDelete";
	getElement("fw_ruleForm").submit();
	
}
/*校验mac地址的重复性*/
function isMacRepeat(k)
{
	var current_mac = document.getElementById("dhcp_mac");
	var current_mac_lowercast = current_mac.value.toLowerCase();
	var dhcp_mac = document.getElementById("dhcp_mac_" + k).innerHTML;

	if(dhcp_mac == current_mac_lowercast)  /*非当前规则中存在与当前mac相同的规则 */
	{
		//alert("MAC 地址已绑定 ，请重新输入!");
		alert(_("macAddr_RepeatAlert"));
		current_mac.value = current_mac.defaultValue;
		current_mac.focus();
		return true;
	}		
	return false;
}

/*校验ip地址的重复性*/
function isIpRepeat(k)
{
	var current_ip = document.getElementById("dhcp_ip");
	var dhcp_ip = document.getElementById("dhcp_ip_" + k).innerHTML.split('-')[0].split(':')[0];

	if(current_ip.value == dhcp_ip)  /*非当前规则中存在与当前ip相同的规则 */
	{
		//alert("IP地址已绑定 ，请重新输入!");
		alert(_("ip_RepeatAlert"));
		current_ip.value = current_ip.defaultValue;
		current_ip.focus();
		return true;
	}		
	return false;
}

function checkRepeat(temp)
{
	var k = 0;

	if(pf_ruleSum > 0)
	{
		for(k = 0; k < pf_ruleSum; k++)
		{
			if(temp != 'new') /*修改规则*/
			{
				if(temp != k) /*temp 为当前修改规则行号，不和自己进行比较*/
				{
					if(isMacRepeat(k))
					{
						return false;
					}
					if(isIpRepeat(k))
					{
						return false;
					}
				}
			}
			else /*新增规则*/
			{	
				if(isMacRepeat(k))
				{
					return false;
				}
				if(isIpRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}
function checkValue()
{
	var macaddr_value = document.getElementById("dhcp_mac");
	var dhcpIP_value = document.getElementById("dhcp_ip");
	
	if (!CheckNotNull(macaddr_value.value)) 
	{
		//alert(_("请输入需要过滤的MAC地址!"));
		alert(_("fw_nomacalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	if(!checkRepeat(currentline))
	{
		return false;
	}

	if(!validateMAC(macaddr_value.value))
	{
		//alert(_("您输入MAC地址非法!"));
		alert(_("fw_macillegalalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	
	if(!validateIP(dhcpIP_value.value))
	{	
		alert(_("fw_ipIllegalAlert"));
		dhcpIP_value.value = dhcpIP_value.defaultValue;
		dhcpIP_value.focus();
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
              <td id="dhcp_macbandPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
                      <td><input type="button" value="Add" id="fw_add" class="submit" onClick="clickAdd('fw_ruleList');"></td>
                      <td><input type="button" value="Delete" id="fw_delete" class="submit" onClick="clickRemove('fw_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/dhcp_macband_delete">
          <table class="tabal_bg" id = "dhcpmac_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="dhcp_bandListHead">DHCP MAC Binding List</td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center" id="urlport">ID</td>
                <td width="43%" align="center" id="urlip">MAC</td>
                <td width="40%" align="center" id="urltime">IP</td>
                <td width="2%" align="center" ></td>
              </tr>
              <% dhcp_macband_get(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/dhcp_macband_cfg" onSubmit="return checkValue()">
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
                                    <td  class="tabal_left" width="25%">MAC</td>
                                    <td class="tabal_right" width="75%"><input name="dhcp_mac" id="dhcp_mac" size="17"  style="width: 150px;" type="text">
                                      <span>(eg. 00:11:22:33:44:55)</span></td>
                                  </tr>
                                  <tr style="">
                                    <td  class="tabal_left" width="25%">IP</td>
                                    <td class="tabal_right" width="75%"><input name="dhcp_ip" id="dhcp_ip" size="17"  style="width: 150px;" type="text">
                                      <span id="fw_curWanIP"></span></td>
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dhcpmac_apply" id="dhcpmac_apply" class="submit">
                    <input type="reset" value="Cancel" name="dhcpmac_cancel" id="dhcpmac_cancel" class="submit" onClick="window.location.reload();">
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
