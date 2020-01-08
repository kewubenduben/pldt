<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>IPv6 Static Route</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("ipv6", lang);

var previousTR = null;
var Get_ipv6_s_route_sizeSync = '<% Get_ipv6_s_route_sizeSync(); %>';	
var pf_ruleSum = '<% getCfgGeneral(1, "ipv6_s_route_size"); %>';

function initTranslation()
{
	var e = document.getElementById("pt_PortTriggerPrompt");
	e.innerHTML = _("pt_PortTriggerPrompt");

	e = document.getElementById("fw_filterListHead");
	e.innerHTML = _("fw_filterListHead");
	e = document.getElementById("DstPrefix_title");
	e.innerHTML = _("DstPrefix_title");
	e = document.getElementById("Nexthop_title");
	e.innerHTML = _("Nexthop_title");

	e = document.getElementById("pf_DstPrefixTitle");
	e.innerHTML = _("DstPrefix_title");
	e = document.getElementById("pf_NexthopTitle");
	e.innerHTML = _("Nexthop_title");
	e = document.getElementById("pf_wannameTitle");
	e.innerHTML = _("pf_wannameTitle");

	e = document.getElementById("pf_apply");
	e.value = _("ipv6_apply");
	e = document.getElementById("pf_cancel2");
	e.value = _("ipv6_cancel");

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




function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 16)
	{		
 		alert(_("pf_most16RulesAlert"));
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
	document.getElementById("pt_DstPrefix").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("pt_DstPrefix").value = "::/0";
			document.getElementById("pt_Nexthop").value = "";
			document.getElementById("pt_wanindex").value = "wan0";

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("pt_DstPrefix").value = html_decode(document.getElementById("ipv6_dstPrefix_" + temp).innerHTML);
			document.getElementById("pt_Nexthop").value = html_decode(document.getElementById("ipv6_nexthop_" + temp).innerHTML);
			document.getElementById("pt_wanindex").value = document.getElementById("ipv6_wan_index_" + temp).innerHTML;		
            
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

	document.location = "/goform/ipv6_s_routeDeleteAll" + "?csrftoken=" + getCsrftoken();
}

function checkValue()
{
	var DstPrefix = document.getElementById("pt_DstPrefix");
	var Nexthop = document.getElementById("pt_Nexthop");

	if (!CheckNotNull(DstPrefix.value)) 
	{
		alert(_("Please enter DstPrefix!"));
		DstPrefix.value = DstPrefix.defaultValue;
		DstPrefix.focus();
		return false;
	}

	if (!CheckNotNull(Nexthop.value)) 
	{					
		alert(_("Please enter Nexthop!"));
		Nexthop.value = Nexthop.defaultValue;
		Nexthop.focus();
		return false;
	}
	/*add begin by郭心悦，20170210，原因:ipv6静态路由功能新增IPv6地址校验，
											例如2001:a::/65，拆分后"/"前符合ipv6地址校验，"/"后符合1-128范围校验,需求来源:刘涛*/
	var ipv6_info = DstPrefix.value.split("/");
	var ipaddr, prefix;
	ipaddr = ipv6_info[0];
	prefix = ipv6_info[1];	
	var rst_ip = 0;/*ipaddr 校验结果*/
	var rst_prefix = 0;/*prefix 校验结果*/
	
	if(checkIpv6(ipaddr))/*校验前缀*/
	{
		rst_ip = 1;
	}

	/*校验前缀长度，配置时检验是否1～128)*/
	if((parseInt(prefix) >= 1) && (parseInt(prefix) <= 128))
	{
		rst_prefix = 1;	
	}

	if(parseInt(rst_ip) != 1 ||  parseInt(rst_prefix) != 1)/*ipv6 前缀地址或前缀长度有误*/
	{
		alert(_("DstPrefix_IllegalAlert"));
		DstPrefix.value = DstPrefix.defaultValue;
		DstPrefix.focus();	
		return false;
	}
	
	if(!checkIpv6(Nexthop.value))
	{
		alert(_("Nexthop_IllegalAlert"));
		Nexthop.value = Nexthop.defaultValue;
		Nexthop.focus();
		return false;
	}
	/*add end by郭心悦，20170210*/
	
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
              <td id="pt_PortTriggerPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
                      <td><input type="button" value="Delete All" id="fw_deleteAll" class="submit" onClick="clickRemoveAll('fw_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/ipv6_s_routeDelete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="fw_filterListHead">IPv6 Static Route List</td>
              </tr>
              <tr class="tabal_title">
		        <td width="20%"  align="center" id="DstPrefix_title">DstPrefix</td>
		        <td width="35%" align="center" id="Nexthop_title">Nexthop</td>
		        <td width="15%" align="center" id="wan_title">WAN</td> 
		        <td width="7%" align="center" ></td>
		        <td width="2%" align="center" ></td>  
              </tr>

			<% ipv6_s_routeSync(); %>	
              
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/ipv6_s_routeCfg" onSubmit="return checkValue()">
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
                                    <td id="pf_DstPrefixTitle" class="tabal_left" width="25%">DstPrefix</td>
                                    <td class="tabal_right" width="75%"><input name="pt_DstPrefix" id="pt_DstPrefix" size="32"  style="width: 150px;" type="text"></td> 
                                  </tr>
                                  <tr style="">
                                    <td id="pf_NexthopTitle" class="tabal_left" width="25%">Nexthop</td>
                                    <td class="tabal_right" width="75%"><input name="pt_Nexthop" id="pt_Nexthop" size="32"  style="width: 150px;" type="text"></td> 
                                  </tr>
                                  <tr style="">
                                    <td id="pf_wannameTitle" class="tabal_left" width="25%">WAN Name</td>
                                    <td class="tabal_right" width="75%"><select name="pt_wanindex" id="pt_wanindex" size="1" style="width:14%">
                                        <option value="wan0" selected="selected">WAN0</option>
                                        <option value="wan1">WAN1</option>
                                        <option value="wan2">WAN2</option>
                                        <option value="wan3">WAN3</option>
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
			updateForms(); 
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
