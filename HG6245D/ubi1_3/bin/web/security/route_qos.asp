<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Route QOS</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
//web_access_check_admin( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("route_qos", lang);

var GetRouteQOSSync = '<% GetRouteQOSSync(); %>';	
var pf_ruleSum = '<% getCfgGeneral(1, "qos_size"); %>';

function initTranslation()
{
    var e = document.getElementById("route_qosPrompt");
	e.innerHTML = _("route_qosPrompt");
	e = document.getElementById("route_qosListHead");
	e.innerHTML = _("route_qosListHead");
	
	e = document.getElementById("qosstype");
	e.innerHTML = _("qostypetitle");
	e = document.getElementById("qospriority");
	e.innerHTML = _("qosPrioritytitle");
	e = document.getElementById("protocoltype");
	e.innerHTML = _("qosprotocoltitle");
	e = document.getElementById("s_ip");
	e.innerHTML = _("qossrciptitle");
	e = document.getElementById("s_port");
	e.innerHTML = _("qossrcporttitle");
    e = document.getElementById("d_ip");
	e.innerHTML = _("qosdisiptitle");
	e = document.getElementById("d_port");
	e.innerHTML = _("qosdisporttitle");
	e = document.getElementById("Enable");
	e.innerHTML = _("qoscontroltitle");	
	
	e = document.getElementById("qos_apply");
	e.value = _("qos_apply");
	e = document.getElementById("qos_cancel");
	e.value = _("qos_cancel");

	e = document.getElementById("qostypetitle");
	e.innerHTML = _("qostypetitle");
	e = document.getElementById("qosPrioritytitle");
	e.innerHTML = _("qosPrioritytitle");
	e = document.getElementById("qosprotocoltitle");
	e.innerHTML = _("qosprotocoltitle");
	e = document.getElementById("qossrciptitle");
	e.innerHTML = _("qossrciptitle");
	e = document.getElementById("qossrcporttitle");
	e.innerHTML = _("qossrcporttitle");

	e = document.getElementById("qosdisiptitle");
	e.innerHTML = _("qosdisiptitle");
	e = document.getElementById("qosdisporttitle");
	e.innerHTML = _("qosdisporttitle");
	e = document.getElementById("qoscontroltitle");
	e.innerHTML = _("qoscontroltitle");

	e = document.getElementById("qos_c_enable");
	e.innerHTML = _("qos_c_enable");
	e = document.getElementById("qos_c_disable");
	e.innerHTML = _("qos_c_disable");
	e = document.getElementById("qoscontroltitle");
	e.innerHTML = _("qoscontroltitle");	

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
	//alert("pf_ruleSum = " + pf_ruleSum);
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

}
function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 6)
	{		
   		//alert("最多只能创建6条规则!");
 		alert(_("pf_mostRulesAlert"));
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
	document.getElementById("qos_priority").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{	
			document.getElementById("qos_priority").value = "";
			document.getElementById("qos_srcip").value = "";
			document.getElementById("qos_srcport").value = "";
			document.getElementById("qos_dstip").value = "";
			document.getElementById("qos_dstport").value = "";
			setLineHighLight(objTR); 
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("qos_priority").value = document.getElementById("qos_PriValue_" + temp).innerHTML;
			document.getElementById("qos_srcip").value = document.getElementById("qos_SrcIp_" + temp).innerHTML;	
			document.getElementById("qos_srcport").value = document.getElementById("qos_SrcPort_" + temp).innerHTML;	
			document.getElementById("qos_dstip").value = document.getElementById("qos_DstIp_" + temp).innerHTML;
			document.getElementById("qos_dstport").value = document.getElementById("qos_DstPort_" + temp).innerHTML;	
			var QoSType_value = document.getElementById("qos_QoSType_" + temp).innerHTML;
			var qos_type_ID = document.getElementById("qos_type");
			var qos_Protocol_value = document.getElementById("qos_Protocol_" + temp).innerHTML;
			var qos_protocol_ID = document.getElementById("qos_protocol");
			var qos_control_value = document.getElementById("qos_control_" + temp).innerHTML;
			var qos_control_ID = document.getElementById("qos_control");
			
			
			if( QoSType_value == "DSCP")
			{
				qos_type_ID.value = "0";
			}
			else if(QoSType_value == "802.1q")
			{
				qos_type_ID.value = "1";
			}
			else
			{	
			
			}
			
			if( qos_Protocol_value == "ALL")
			{	 
				qos_protocol_ID.value = "0";
			}
			else if (qos_Protocol_value == "TCP")
			{					
				qos_protocol_ID.value = "6";
			}	
			else
			{
				qos_protocol_ID.value = "17";
			}

			if( qos_control_value == "enable")
			{
				qos_control_ID.value = "1";
			}
			else if(qos_control_value == "disable")
			{
				qos_control_ID.value = "0";
			}
			else
			{
				
			}
			
            setLineHighLight(objTR);		
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
   		//alert("当前没有规则，不能删除!");
 		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('qos_removeFlag');
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
		//alert('请先选择一条规则');
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
  		//alert("当前没有规则，不能删除!");
  		alert(_("pf_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('qos_removeFlag');
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

	document.location = "/goform/RouteQOSDeleteAll" + "?csrftoken=" + getCsrftoken();
    	
	
}

function checkValue()
{	 
    var srcport = document.getElementById("qos_srcport");
	var dstport = document.getElementById("qos_dstport");
    var srcip = document.getElementById("qos_srcip");
	var dstip = document.getElementById("qos_dstip");
	var priority = document.getElementById("qos_priority");
	var qostype = document.getElementById("qos_type");

	if (!CheckNotNull(priority.value)) 
	{					
		//alert(_("请输入优先级!"));
		alert(_("priority_alert"));
		priority.value = priority.defaultValue;
		priority.focus();
		return false;
	}

	if(qostype.value== 0)
	{
		if(!HSCP_checkPriority(priority))					
		{
			return false;
		}
	}
	else if(qostype.value== 1)
	{
		if(!Q8021_checkPriority(priority))					
		{
			return false;
		}
	}
	
	if(!fw_checkPort(srcport))					
	{
		return false;
	}
	if(!fw_checkPort(dstport))					
	{
		return false;
	}
    if(srcip.value.length > 0)
    {
		if(!validateIP(srcip.value))
		{
			//alert("请输入合法ip!");
			alert(_("pf_ipIllegalAlert"));
			srcip.value = srcip.defaultValue;
			srcip.focus();
			return false;
		}
    }
	if(dstip.value.length > 0)
    {
		if(!validateIP(dstip.value))
		{
			//alert("请输入合法ip!");
			alert(_("pf_ipIllegalAlert"));
			dstip.value = dstip.defaultValue;
			dstip.focus();
			return false;
		}
	}

	
	return true;
}

function fw_checkPort(domStart)
{
	if(domStart.value == "")//startPort为空时
	{
			return true;
	}
	else
	{
		if(!fw_checkPortLegal(domStart))
		{
			return false;
		}
		
		return true;
	}
}


function fw_checkPortLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(1 <= dom.value && dom.value <= 65535)
		{
			return true;
		}
		else
		{
			//alert("有效端口范围为1～65535.");
			alert(_("pf_portIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
	    //alert("有效端口号为非法值!");
		alert(_("pf_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function Q8021_checkPriority(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 7)
		{
			return true;
		}
		else
		{
			//alert("有效优先级范围为0～7.");
			alert(_("pf_8021PriorityIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
	    //alert("有效优先级为非法值，请输入0 ~ 7!");
		alert(_("pf_8021PriorityIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function HSCP_checkPriority(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(0 <= dom.value && dom.value <= 63)
		{
			return true;
		}
		else
		{
			//alert("有效优先级范围为0～63.");
			alert(_("pf_hscpPriorityIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
	    //alert("有效优先级为非法值，请输入0 ~ 63!");
		alert(_("pf_hscpPriorityIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
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
              <td id="route_qosPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/RouteQOSDelete">
          <table class="tabal_bg" id = "url_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="route_qosListHead">Route QOS List</td>
              </tr>
              <tr class="tabal_title">
                <td width="5%" align="center" id="qos_ID">ID</td>
		        <td width="10%" align="center" id="qosstype">Type</td>
		        <td width="8%" align="center" id="qospriority">Priority</td>
		        <td width="8%" align="center" id="protocoltype">Protocol</td>
		        <td width="15%" align="center" id="s_ip">Source IP</td>
		        <td width="11%" align="center" id="s_port">Source Port</td>
		        <td width="15%" align="center" id="d_ip">Target IP</td>
		        <td width="11%" align="center" id="d_port">Target Port</td>
		        <td width="10%" align="center" id="Enable">Enable</td>
		        <td width="5%" align="center" ></td>
		        <td width="2%" align="center" ></td> 
              </tr>

				<% RouteQOSSync(); %>
              
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/RouteQOSCfg" onSubmit="return checkValue()">
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
                                    <td id="qostypetitle" class="tabal_left" width="10%">QOS Type</td>
                                    <td class="tabal_right" width="35%"><select name="qos_type" id="qos_type" size="1" style="width:14%">
                                        <option value="0" selected="selected">DSCP</option>
                                        <!--option value="1">802.1q</option-->  
                                      </select></td>
                                   </tr>

                                  <tr style="">
                                    <td id="qosPrioritytitle" class="tabal_left" width="10%">Priority</td>
                                    <td class="tabal_right" width="35%"><input name="qos_priority" id="qos_priority" size="32"  style="width: 150px;" type="text">
                                        <strong style="color:#FF0033">*</strong></td>
                                  </tr>

                         
                                  <tr style="">
                                    <td id="qosprotocoltitle" class="tabal_left" width="10%">Protocol</td>
                                    <td class="tabal_right" width="35%"><select name="qos_protocol" id="qos_protocol" size="1" style="width:14%">
                                        <option value="0" selected="selected">ALL</option>
                                        <option value="6">TCP</option>  
                                        <option value="17">UDP</option>  
                                      </select></td>
                                   </tr>
                              
                                   <tr style="">
                                    <td id="qossrciptitle" class="tabal_left" width="10%">Source IP</td>
                                    <td class="tabal_right" width="35%"><input name="qos_srcip" id="qos_srcip" size="32"  style="width: 150px;" type="text"></td>
                                    </tr>  
                                    
                                  <tr style="">
                                    <td id="qossrcporttitle" class="tabal_left" width="25%">Source Port</td>
                                    <td class="tabal_right" width="75%"><input name="qos_srcport" id="qos_srcport" size="32"  style="width: 150px;" type="text"></td>
                                  </tr>

                                  <tr style="">
                                    <td id="qosdisiptitle" class="tabal_left" width="10%">Target IP</td>
                                    <td class="tabal_right" width="35%"><input name="qos_dstip" id="qos_dstip" size="32"  style="width: 150px;" type="text"></td>
									 </tr>

                                  <tr style="">
                                    <td id="qosdisporttitle" class="tabal_left" width="25%">Target Port</td>
                                    <td class="tabal_right" width="75%"><input name="qos_dstport" id="qos_dstport" size="32"  style="width: 150px;" type="text"></td>
                                  </tr>

                                   <tr style="">
                                    <td id="qoscontroltitle" class="tabal_left" width="25%">Enable</td>
                                    <td class="tabal_right" width="75%"><select name="qos_control" id="qos_control" size="1" style="width:14%">
                                        <option value="1" id = "qos_c_enable" selected="selected">Enable</option>
                                        <option value="0" id = "qos_c_disable">Disable</option>  
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="qos_apply" id="qos_apply" class="submit">
                    <input type="reset" value="Cancel" name="qos_cancel" id="qos_cancel" class="submit" onClick="window.location.reload()">
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
