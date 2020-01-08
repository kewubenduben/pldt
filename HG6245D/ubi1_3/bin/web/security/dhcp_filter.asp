<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCP Filter</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var pf_ruleSum;
var macaddr_filter_enableSync = '<% DHCP_filter_enableSync(); %>';
var macaddr_getsizeSync = '<% DHCP_getsizeSync(); %>';

function initTranslation()
{
	var e = document.getElementById("macaddr_filterPrompt");
	e.innerHTML = _("dhcp_filterPrompt");

	e = document.getElementById("macaddrenable_title");
	e.innerHTML = _("dhcpaddrenable_title");
	e = document.getElementById("enable");
	e.innerHTML = _("firewall_enable");
	e = document.getElementById("disable");
	e.innerHTML = _("firewall_disable");
	e = document.getElementById("macaddrdown_title");
	e.innerHTML = _("dhcpaddrdown_title");
	e = document.getElementById("macaddr_white");
	e.innerHTML = _("firewall_white");
	e = document.getElementById("macaddr_black");
	e.innerHTML = _("firewall_black");
	e = document.getElementById("updown_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("updown_cancel");
	e.value = _("firewall_cancel");

	e = document.getElementById("mf_add");
	e.value = _("fw_add");
	e = document.getElementById("mf_delete");
	e.value = _("fw_delete");
	e = document.getElementById("mf_deleteAll");
	e.value = _("fw_deleteAll");	

	e = document.getElementById("macaddr_filterListHead");
	e.innerHTML = _("dhcpaddr_filterListHead");
	e = document.getElementById("macaddr");
	e.innerHTML = _("macaddr");
	e = document.getElementById("macaddr_macTips");
	e.innerHTML = _("macaddr_macTips");

	e = document.getElementById("macaddr_IPTitle");
	e.innerHTML = _("macaddr");
	e = document.getElementById("macaddr_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("macaddr_apply_cancel2");
	e.value = _("firewall_cancel");
}
function LoadFrame()
{ 
	initTranslation();

	var macAddrUp = document.getElementsByName("macaddr_up");	
	for(var i = 0;i<macAddrUp.length;i++)
	{
		if(macAddrUp[i].value == '<% getCfgGeneral(1, "dhcp_black_white"); %>')
		{
			macAddrUp[i].checked = true;
			break;
		}
	}
	var macfilterable = document.getElementsByName("macaddr_enable");	
	for(var i = 0;i<macfilterable.length;i++)
	{
		if(macfilterable[i].value == '<% getCfgGeneral(1, "dhcp_filter_enable"); %>')
		{
			macfilterable[i].checked = true;
			break;
		}
	}
	
	pf_ruleSum  = '<% getCfgGeneral(1, "dhcpmac_size"); %>';
	var macaddr_ruletable = getElement("macaddr_ruletable");

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("macaddr_ruletable").rows[0];
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

	if(rowLen > 10 + 1)
	{		
  		alert(_("macaddr_most10rulealert"));
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
	document.getElementById("macaddr_mac").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{	
			document.getElementById("macaddr_mac").value = "";							
			setLineHighLight(objTR); 
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("macaddr_mac").value = html_decode(document.getElementById("DHCPmac_adress_" + temp).innerHTML);
            setLineHighLight(objTR);		
		}	

		//标志当前编辑规则的id
		document.getElementById("mf_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('mf_curIndex').value);
		
	}	 
}

function clickRemove(tabTitle)
{
	if(pf_ruleSum  == 0)
	{	
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('macaddr_removeFlag');
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

	if(confirm(_("fw_deleteRuleConfirm")) == false)
    	return;
	
	getElement("mf_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('macaddr_removeFlag');
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

	document.location = "/goform/DHCP_filterDeleteAll" + "?csrftoken=" + getCsrftoken(); 
	
}

function checkValue()
{

	var macaddr_value = document.getElementById("macaddr_mac");
	if (!CheckNotNull(macaddr_value.value)) 
	{
		alert(_("fw_nomacalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}

	if(!validateMAC(macaddr_value.value))
	{
		alert(_("fw_macillegalalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	
	return true;
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
              <td id="macaddr_filterPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td height="5"></td>
    </tr>
  </tbody>
</table>
<tr>
  <td id="macaddr_enable"><form method="post" id="macaddr_enable" action="/goform/DHCP_filter_enableCfg">
      <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
        <tbody>
          <tr>
            <td class="tabal_left" id="macaddrenable_title" align="left" width="25%">DHCP Filtering Enable</td>
            <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value=1 name="macaddr_enable" type="radio">
              <font id="enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input value=0 name="macaddr_enable" type="radio">
              <font id="disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
          </tr>
          <tr>
            <td class="tabal_left" id="macaddrdown_title" align="left" width="25%">DHCP Filtering Blacklist/Whitelist</td>
            <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value=1 name="macaddr_up" type="radio">
              <font id="macaddr_white"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              <input value=0 name="macaddr_up" type="radio">
              <font id="macaddr_black"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
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
                      <td><input type="button" value="Add" id="mf_add" class="submit" onClick="clickAdd('mf_ruleList');"></td>
                      <td><input type="button" value="Delete" id="mf_delete" class="submit" onClick="clickRemove('mf_ruleList');"></td>
                      <td><input type="button" value="Delete All" id="mf_deleteAll" class="submit" onClick="clickRemoveAll('mf_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="mf_ruleList"><form method="post" id="mf_ruleForm" action="/goform/DHCP_filterDelete">
          <table class="tabal_bg" id = "macaddr_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="macaddr_filterListHead"></td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center" id="macaddrport">ID</td>
                <td width="60%" align="center" id="macaddr">MAC Address</td>
                <td width="8%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% DHCP_filterSync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/DHCP_filterCfg" onSubmit="return checkValue()">
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
                                  <tr>
                                    <td id="macaddr_IPTitle" class="tabal_left" width="25%">MAC Address</td>
                                    <td class="tabal_right" width="75%"><input name="macaddr_mac" id="macaddr_mac" size="17"  style="width: 150px;" type="text">
                                      <span class="gray" id="macaddr_macTips"></span></td>
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="macaddr_apply" id="macaddr_apply" class="submit">
                    <input type="reset" value="Cancel" name="macaddr_apply_cancel2" id="macaddr_apply_cancel2" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="mf_curIndex" id="mf_curIndex" value="0">
        </form></td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>

