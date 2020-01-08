<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<title>WAN ACL</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var aclsize = '<% wan_acl_multipro_size_sync(); %>';
var wan_acl_ruleSum;
var previousTR = null;

function initTranslation()
{
	var e = document.getElementById("wanAclPrompt");
	e.innerHTML = _("wanAclPrompt");

	e = document.getElementById("ACLenable_title");
	e.innerHTML = _("ACLenable_title");
	e = document.getElementById("enable");
	e.innerHTML = _("firewall_enable");
	e = document.getElementById("disable");
	e.innerHTML = _("firewall_disable");
	
	e = document.getElementById("enable_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("enable_cancel");
	e.value = _("firewall_cancel");

	e = document.getElementById("fw_add");
	e.value = _("fw_add");
	e = document.getElementById("fw_delete");
	e.value = _("fw_delete");
	e = document.getElementById("fw_deleteAll");
	e.value = _("fw_deleteAll");	

	e = document.getElementById("acl_head");
	e.innerHTML = _("acl_head");
	e = document.getElementById("acl_ip_title1");
	e.innerHTML = _("acl_ip_title");
	e = document.getElementById("acl_apptype_title1");
	e.innerHTML = _("acl_apptype_title");
	e = document.getElementById("acl_enable_title1");
	e.innerHTML = _("acl_enable_title");
	
	e = document.getElementById("acl_ip_title2");
	e.innerHTML = _("acl_ip_title");
	e = document.getElementById("acl_apptype_title2");
	e.innerHTML = _("acl_apptype_title");
	e = document.getElementById("acl_enable_title2");
	e.innerHTML = _("firewall_enable");
	
	e = document.getElementById("acl_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("acl_cancel");
	e.value = _("firewall_cancel");
	
}
function LoadFrame()
{ 
	initTranslation();

	var acl_ctl = document.getElementsByName("acl_ctl");	
	showRadioNodeByValue(acl_ctl, '<% getCfgGeneral(1, "wan_acl_up"); %>');
	
	wan_acl_ruleSum  = '<% getCfgGeneral(1, "wan_acl_size"); %>';
	var url_ruletable = getElement("url_ruletable");

	if(wan_acl_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("url_ruletable").rows[0];
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

	if(rowLen - 2 >= 8)	//0--head; 1--title
	{
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
	
	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_new");
	if(ispNameCode != 22)//非泰国TRUE
	{
		document.getElementById("acl_startip").focus();
	}
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{	
			if(ispNameCode != 22)//非泰国TRUE
			{
				document.getElementById("acl_startip").value = "";
				document.getElementById("acl_netmask").value = "";	
			}
			$("input[name='acl_apptype_http']").attr("checked", false);
			$("input[name='acl_apptype_ftp']").attr("checked", false);
			$("input[name='acl_apptype_icmp']").attr("checked", false);
			$("input[name='acl_apptype_telnet']").attr("checked", false);
			
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			if(ispNameCode != 22)//非泰国TRUE
			{
				if(document.getElementById("acl_adress_" + temp).innerHTML == 'Any')
				{
					document.getElementById("acl_startip").value = "";
					document.getElementById("acl_netmask").value = "";
				}
				else
				{
					document.getElementById("acl_startip").value = document.getElementById("acl_adress_" + temp).innerHTML.split('/')[0];
					document.getElementById("acl_netmask").value = document.getElementById("acl_adress_" + temp).innerHTML.split('/')[1];
				}
			}
			var set_acl_apptype = {				
				"HTTP": function(){
					$("input[name='acl_apptype_http']").attr("checked", true);
				},
				"FTP": function(){
					$("input[name='acl_apptype_ftp']").attr("checked", true);
				},
				"ICMP": function(){
					$("input[name='acl_apptype_icmp']").attr("checked", true);
				},
				"TELNET": function(){
					$("input[name='acl_apptype_telnet']").attr("checked", true);
				}	
			}
			
			$("input[name='acl_apptype_http']").attr("checked", false);
			$("input[name='acl_apptype_ftp']").attr("checked", false);
			$("input[name='acl_apptype_icmp']").attr("checked", false);
			$("input[name='acl_apptype_telnet']").attr("checked", false);
			var acl_apptype_value_arr = document.getElementById("acl_apptype_" + temp).innerHTML.split(',');
			if(acl_apptype_value_arr != '' && acl_apptype_value_arr[0] != '--')
			{
				for (var index = 0; index < acl_apptype_value_arr.length; index++) 
				{
					set_acl_apptype[acl_apptype_value_arr[index]]();
				}
			}

			if(ispNameCode != 22)//非泰国TRUE
			{
				var acl_atctive_value = document.getElementById("acl_active_" + temp).innerHTML;
				var acl_active_ID = document.getElementById("acl_active");
				if (acl_atctive_value == "Enable")
				{
					acl_active_ID.value = "1";
				}
				else
				{	
					acl_active_ID.value = "0";
				}
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
//   alert("ruleSum = " + wan_acl_ruleSum);
	if(wan_acl_ruleSum  == 0)
	{
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

	if(confirm(_("fw_deleteRuleConfirm")) == false)
    	return;
	
	getElement("fw_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(wan_acl_ruleSum == 0)
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

	document.location = "/goform/wan_acl_multipro_delete_all" + "?csrftoken=" + getCsrftoken();
}
function validateWanACLNetmask(mask) //8-32
{ 
	var obj = mask;
	var exp = /^\d{1,2}$/;; 

	var reg = obj.match(exp); 
	if(reg==null) 
	{ 
		return false;
	} 
	else if(parseInt(mask) < 8 || parseInt(mask) > 32)
	{
		return false;
	}
	else
	{
		return true;
	}
} 
function checkValue()
{
	var acl_startip = document.getElementById("acl_startip");
	var acl_netmask = document.getElementById("acl_netmask");
	
	//modify by wuxj, 20170223, ip could be null(from wangyanyuan)
	if(CheckNotNull(acl_startip.value))//ip not null
	{
		if(!validateIP(acl_startip.value))
		{
			alert(_("fw_ipIllegalAlert"));
			acl_startip.value = acl_startip.defaultValue;
			acl_startip.focus();
			return false;
		}
		if(!validateWanACLNetmask(acl_netmask.value))
		{
			alert(_("fw_maskIllegalAlert"));
			acl_netmask.value = acl_netmask.defaultValue;
			acl_netmask.focus();
			return false;
		}
	}
	else	//ip is null
	{
		if(CheckNotNull(acl_netmask.value))//mask not null
		{
			alert(_("fw_maskIllegalAlert"));
			acl_netmask.value = acl_netmask.defaultValue;
			acl_netmask.focus();
			return false;
		}
	}

	/*add begin by 陈鹏 20181018，原因:泰国TRUE要求在WAN ACL的界面，配置打开WAN测HTTP访问时，增加提示框，提示用户要配置WAN测的WEB登陆密码（默认是空的）需求来源:钱凯*/
	if(ispNameCode == 22)
	{
		if($("input[name='acl_apptype_http']").attr("checked") == true)
		{
			alert(_("modifyWANPassword"));
		}
	}

	/*add end by 陈鹏 20181018*/
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
              <td id="wanAclPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
  <td><form method="post" id="acl_ctl_table" action="/goform/wan_acl_multipro_up_cfg">
      <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
        <tbody>
          <tr>
            <td class="tabal_left" id="ACLenable_title" align="left" width="25%">WAN ACL Enable</td>
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
            <td class="tabal_submit" align="left"><input class="submit" type="submit" id="enable_apply">
              &nbsp; &nbsp;
              <input class="submit" type="reset" id="enable_cancel" onClick="window.location.reload()">
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/wan_acl_multipro_delete">
          <table class="tabal_bg" id = "url_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="acl_head">Access Control List</td>
              </tr>
              <tr class="tabal_title">
                <td width="8%" align="center">ID</td>
                <td width="50%" align="center" id="acl_ip_title1">Secure IP Address</td>
                <td width="20%" align="center" id="acl_apptype_title1">Application</td>
                <td width="15%" align="center" id="acl_enable_title1">State</td>
                <td width="7%" align="center" ></td>
              </tr>
              <% wan_acl_multipro_sync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="5"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/wan_acl_multipro_cfg" onSubmit="return checkValue()">
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
                                  <tr id="tr_secure_ip">
                                    <td id="acl_ip_title2" class="tabal_left" width="25%">Secure IP Address</td>
                                    <td class="tabal_right" width="75%"><input name="acl_startip" id="acl_startip" size="32"  style="width: 150px;" type="text">
                                      (IP)&nbsp;&nbsp;/&nbsp;&nbsp;
                                      <input name="acl_netmask" id="acl_netmask" maxlength="2" size="32" style="width: 30px;" type="text">
                                      <span>(8-32)</span></td>
                                  </tr>
                                  <tr>
                                    <td id="acl_apptype_title2" class="tabal_left" width="25%">Application</td>
                                    <td class="tabal_right" width="75%"><label for="acl_apptype"> FTP
                                      <input type="checkbox" name="acl_apptype_ftp" value="1">
                                      </label>
                                      <label for="acl_apptype"> HTTP
                                      <input type="checkbox" name="acl_apptype_http" value="1">
                                      </label>
                                      <label for="acl_apptype"> TELNET
                                      <input type="checkbox" name="acl_apptype_telnet" value="1">
                                      </label>
                                      <label for="acl_apptype"> ICMP
                                      <input type="checkbox" name="acl_apptype_icmp" value="1">
                                      </label>
                                    </td>
                                  </tr>
                                  <tr id="tr_acl_enable">
                                    <td id="acl_enable_title2" class="tabal_left" width="25%">Enable</td>
                                    <td class="tabal_right" width="75%"><select name="acl_active" id="acl_active" size="1" style="width:14%">
                                        <option id="disable" value="0" selected="selected">Disable</option>
                                        <option id="enable" value="1">Enable</option>
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
                  <td class="tabal_submit"><input type="submit" id="acl_apply" class="submit">
                    <input type="reset" id="acl_cancel" class="submit" onClick="window.location.reload();">
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
