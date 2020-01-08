<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>IP Filter</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var previousTR = null;
var ipFilterSync = '<% ipFilterSync_v6(); %>';

var fw_rulesSum = '<% getCfgGeneral(1, "fw_rulesSum_v6"); %>';

var fw_directionList = '<% getCfgGeneral(1, "fw_ruleDirectionList_v6"); %>';
var directionArray = fw_directionList.split("|");

var fw_srcIPStartList = '<% getCfgGeneral(1, "fw_ruleSrcIPStartList_v6"); %>';
var srcIPStartArray = fw_srcIPStartList.split("|");
var fw_srcIPEndList = '<% getCfgGeneral(1, "fw_ruleSrcIPEndList_v6"); %>';
var srcIPEndArray = fw_srcIPEndList.split("|");
var fw_srcPortStartList = '<% getCfgGeneral(1, "fw_ruleSrcPortStartList_v6"); %>';
var srcPortStartArray = fw_srcPortStartList.split("|");
var fw_srcPortEndList = '<% getCfgGeneral(1, "fw_ruleSrcPortEndList_v6"); %>';
var srcPortEndArray = fw_srcPortEndList.split("|");

var fw_dstIPStartList = '<% getCfgGeneral(1, "fw_ruleDstIPStartList_v6"); %>';
var dstIPStartArray = fw_dstIPStartList.split("|");
var fw_dstIPEndList = '<% getCfgGeneral(1, "fw_ruleDstIPEndList_v6"); %>';
var dstIPEndArray = fw_dstIPEndList.split("|");
var fw_dstPortStartList = '<% getCfgGeneral(1, "fw_ruleDstPortStartList_v6"); %>';
var dstPortStartArray = fw_dstPortStartList.split("|");
var fw_dstPortEndList = '<% getCfgGeneral(1, "fw_ruleDstPortEndList_v6"); %>';
var dstPortEndArray = fw_dstPortEndList.split("|");

var fw_protocolList = '<% getCfgGeneral(1, "fw_ruleProtocolList_v6"); %>';
var protocolArray = fw_protocolList.split("|");



function fw_checkPort(domStart, domEnd)
{
	domStart.value = trim(domStart.value);
	domEnd.value = trim(domEnd.value);
	if(domStart.value == "")//startPort为空时
	{
		if(domEnd.value != "" && domEnd.value != "0")
		{
//			alert("如果指定结束端口，请同时指定起始端口!");
			alert(_("fw_startPortNullAlert"));
			domStart.value = domStart.defaultValue;
			domStart.focus();
			return false;
		}
		else				//endPort为空
		{
			return true;		
		}
	}
	else
	{
		if(!fw_checkPortLegal(domStart))
		{
			return false;
		}
		if(!fw_checkPortLegal(domEnd))
		{
			return false;
		}
		if( parseInt(domStart.value) > parseInt(domEnd.value))
		{
//			alert("结束端口应大于或等于起始端口!");
			alert(_("fw_endPortTooSmallAlert"));
			domEnd.value = domEnd.defaultValue;
			domEnd.focus();
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
			alert(_("fw_portIllegalAlert"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{	
	    //alert("有效端口号为非法值!");
		alert(_("fw_portIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

//当协议是0或1时，所有端口输入框不可用
function changeProtocol(protocolValue)
{
	if(protocolValue == 0 || protocolValue == 1)
	{
		getElement("fw_srcPortStart").disabled = 1;
//		getElement("fw_srcPortStart").value = "0";
		
		getElement("fw_srcPortEnd").disabled = 1;
//		getElement("fw_srcPortEnd").value = "0";
		
		getElement("fw_dstPortStart").disabled = 1;
//		getElement("fw_dstPortStart").value = "0";
		
		getElement("fw_dstPortEnd").disabled = 1;
//		getElement("fw_dstPortEnd").value = "0";
	}
	else
	{		
		getElement("fw_srcPortStart").disabled = 0;		
		getElement("fw_srcPortEnd").disabled = 0;
		getElement("fw_dstPortStart").disabled = 0;
		getElement("fw_dstPortEnd").disabled = 0;			
	}
}

function clickRemove(tabTitle)
{
	if(fw_rulesSum == 0)
	{			
//   		alert("当前没有规则，不能删除!");
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('fw_removeFlag');
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
	if(fw_rulesSum == 0)
	{				
//   		alert("当前没有规则，不能删除!");
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('fw_removeFlag');
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
	if(confirm(_("fw_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}

	document.location = "/goform/ipFilterDeleteAll_v6" + "?csrftoken=" + getCsrftoken();
}

function checkValue()
{
	var startipnode = document.getElementById("fw_srcIPStart");
	var endipnode = document.getElementById("fw_dstIPStart");

	/*add by gxy,20170316，原因:新增端口校验*/
	if(!fw_checkPort(document.getElementById("fw_srcPortStart"), 
						document.getElementById("fw_srcPortEnd")))
	{
		return false;
	}
	
	if(!fw_checkPort(document.getElementById("fw_dstPortStart"), 
						document.getElementById("fw_dstPortEnd")))
	{
		return false;
	}
	
	
//modify by wuxj, 20160621, 修改为起始IP与结束IP不能同时为空
/*	
	if(!CheckNotNull(startipnode.value))
	{
		alert(_("fw_ipv6_sourceIllegalAlert"));
		startipnode.value = startipnode.defaultValue;
		startipnode.focus();
		return false;
	}
	if(!CheckNotNull(endipnode.value))
	{
		alert(_("fw_ipv6_dstIllegalAlert"));
		endipnode.value = endipnode.defaultValue;
		endipnode.focus();
		return false;
	}
*/
	if((!CheckNotNull(startipnode.value)) && (!CheckNotNull(endipnode.value)))//不能同时为空
	{
		alert(_("fw_ipv6_ipNullAlert"));
		startipnode.value = startipnode.defaultValue;
		startipnode.focus();
		return false;
	}

	
	return true;
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("fw_direction").value = "0";
			document.getElementById("fw_srcIPStart").value = "";
			document.getElementById("fw_srcIPEnd").value = "";
			document.getElementById("fw_srcPortStart").value = "";
			document.getElementById("fw_srcPortEnd").value = "";
			document.getElementById("fw_dstIPStart").value = "";
			document.getElementById("fw_dstIPEnd").value = "";
			document.getElementById("fw_dstPortStart").value = "";
			document.getElementById("fw_dstPortEnd").value = "";
			document.getElementById("fw_protocol").value = "6";	
//			getElement("fw_dstWan").option[0].selected = true;
//			getElement("fw_curWanIP").innerHTML = _("ipFilter_curWanIP") + devWanIPArray[0];

			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			var index = parseInt(temp);				
			document.getElementById("fw_direction").value = html_decode(directionArray[index]);
			document.getElementById("fw_srcIPStart").value = html_decode(srcIPStartArray[index]);
			document.getElementById("fw_srcIPEnd").value = html_decode(srcIPEndArray[index]);
			document.getElementById("fw_srcPortStart").value = html_decode(srcPortStartArray[index]);
			document.getElementById("fw_srcPortEnd").value = html_decode(srcPortEndArray[index]);
			document.getElementById("fw_dstIPStart").value = html_decode(dstIPStartArray[index]);
			document.getElementById("fw_dstIPEnd").value = html_decode(dstIPEndArray[index]);
			document.getElementById("fw_dstPortStart").value = html_decode(dstPortStartArray[index]);
			document.getElementById("fw_dstPortEnd").value = html_decode(dstPortEndArray[index]);
			document.getElementById("fw_protocol").value = html_decode(protocolArray[index]);
/*
			var dstWanNode = getElement("fw_dstWan");
			for(var i = 0; i < dstWanNode.length; i++)
			{
				if(dstWanNode.option[i].value == ruleWanArray[0])
				{
					dstWanNode.option[i].selected = true;
					getElement("fw_curWanIP").innerHTML = _("ipFilter_curWanIP") + devWanIPArray[i];
					if(devWanIPArray[i] != dstIPArray[0])	//当前WAN IP与规则目的IP不同
						getElement("fw_userResetPrompt").innerHTML = _("ipFilter_userResetPrompt");
					else
						getElement("fw_userResetPrompt").innerHTML = "";
				}
			}
*/
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;

		}	

		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;
//		console.info("fw_curIndex value = " + getElement('fw_curIndex').value);
		
		changeProtocol(document.getElementById("fw_protocol").value);	
	}	 
}

function initTranslation()
{
	var e = document.getElementById("fw_ipfilterPrompt");
	e.innerHTML = _("fw_ipfilterPrompt");
	
	e = document.getElementById("fw_add");
	e.value = _("fw_add");
	
	e = document.getElementById("fw_delete");
	e.value = _("fw_delete");
	e = document.getElementById("fw_deleteAll");
	e.value = _("fw_deleteAll");
//	e = document.getElementById("fw_cancel");
//	e.value = _("firewall_cancel");
	
	e = document.getElementById("fw_filterListHead");
	e.innerHTML = _("fw_filterListHead");
	e = document.getElementById("fw_directionTitle");
	e.innerHTML = _("fw_directionTitle");
	e = document.getElementById("fw_srcIPTitle");
	e.innerHTML = _("fw_srcIPv6Title");
	e = document.getElementById("fw_srcPortTitle");
	e.innerHTML = _("fw_srcPortTitle");
	e = document.getElementById("fw_dstIPTitle");
	e.innerHTML = _("fw_dstIPv6Title");
	e = document.getElementById("fw_dstPortTitle");
	e.innerHTML = _("fw_dstPortTitle");	
	e = document.getElementById("fw_protocolTitle");
	e.innerHTML = _("fw_protocolTitle");
	
	e = document.getElementById("fw_directionTitle2");
	e.innerHTML = _("fw_directionTitle");
	e = document.getElementById("fw_srcIPTitle2");
	e.innerHTML = _("fw_srcIPv6Title");
	e = document.getElementById("fw_startPortTitle2");
	e.innerHTML = _("fw_srcPortTitle");
	e = document.getElementById("fw_dstIPTitle2");
	e.innerHTML = _("fw_dstIPv6Title");
	e = document.getElementById("fw_dstPortTitle2");
	e.innerHTML = _("fw_dstPortTitle");	
	e = document.getElementById("fw_protocolTitle2");
	e.innerHTML = _("fw_protocolTitle");
	
	e = document.getElementById("fw_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("fw_cancel2");
	e.value = _("firewall_cancel");

	e = document.getElementById("ipfilterup_title");
	e.innerHTML = _("firewall_ipfilterup_title");
	e = document.getElementById("ipfilterdown_title");
	e.innerHTML = _("firewall_ipfilterdown_title");
	e = document.getElementById("up_white");
	e.innerHTML = _("firewall_white");
	e = document.getElementById("up_black");
	e.innerHTML = _("firewall_black");
	e = document.getElementById("down_white");
	e.innerHTML = _("firewall_white");
	e = document.getElementById("down_black");
	e.innerHTML = _("firewall_black");
	e = document.getElementById("updown_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("updown_cancel");
	e.value = _("firewall_cancel");
}
function LoadFrame()
{ 
	initTranslation();

/* add begin by 吕轶超, 20120227, 原因: */
	var upnable = document.getElementsByName("ipfilter_up_v6");	
	for(var i = 0;i<upnable.length;i++)
	{
		if(upnable[i].value == '<% getCfgGeneral(1, "ipfilter_up_v6"); %>')
		{
			upnable[i].checked = true;
			break;
		}
	}
    var downnable = document.getElementsByName("ipfilter_down_v6");	
	for(var i = 0;i<downnable.length;i++)
	{
		if(downnable[i].value == '<% getCfgGeneral(1, "ipfilter_down_v6"); %>')
		{
			downnable[i].checked = true;
			break;
		}
	}
	
	
	if(ipFilterSync == -1)
	{
		alert(_("ipFilter_syncAlert"));
	}
	else if(ipFilterSync == -2)
	{
//		alert(_("ipFilter_tooMuchDataAlert"));		//WEB只显示前50条，不提示用户内部错误
	}
	
	/* 生成WAN通道列表 */
/*	var dstWanNode = getElement("fw_dstWan");
	dstWanNode.length = 0;
	for(var i = 0; i < devWanArray.length; i++)
	{
		dstWanNode.options[i] = new Option("wan" + devWanArray[i], devWanArray[i], false, false);
	}
*/	
	var fw_ruletable = getElement("fw_ruletable");
	if(fw_rulesSum > 0)
	{	
		var row0 = getElement("fw_ruletable").rows[1];
//		selectLine(row0.id);
		selectLine("record_0");
/*		document.getElementById("fw_srcIP").value =  srcIPArray[0];
		document.getElementById("fw_stPort").value =  startPortArray[0];
		document.getElementById("fw_endPort").value =  endPortArray[0];
		document.getElementById("fw_protocol").value =  protocolArray[0];

		for(var i = 0; i < dstWanNode.length; i++)
		{
			if(dstWanNode.option[i].value == ruleWanArray[0])
			{
				dstWanNode.option[i].selected = true;
				getElement("fw_curWanIP").innerHTML = _("ipFilter_curWanIP") + devWanIPArray[i];
				if(devWanIPArray[i] != dstIPArray[0])	//当前WAN IP与规则目的IP不同
					getElement("fw_userResetPrompt").innerHTML = _("ipFilter_userResetPrompt");
				else
					getElement("fw_userResetPrompt").innerHTML = "";
			}
		}
*/		
		setDisplay("ConfigForm1", "");
	}
	else
	{	
		setDisplay("ConfigForm1", "none");
	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 50)
	{		
//   		alert("最多只能创建50条规则!");
 		alert(_("fw_most50RulesAlert"));
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
		row.className = 'tabal_01';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','tabal_01');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_new");
	document.getElementById("fw_direction").focus();
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
              <td id="fw_ipfilterPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="fw_white_enable" action="/goform/Black_White_Cfg_v6">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="ipfilterup_title" align="left" width="25%">Uplink</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="white" name="ipfilter_up_v6" type="radio">
          <span id="up_white">White List</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="black" name="ipfilter_up_v6" type="radio">
          <span id="up_black">Black List</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" id="ipfilterdown_title" align="left" width="25%">Downlink</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="white" name="ipfilter_down_v6" type="radio">
          <span id="down_white">White List</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="black" name="ipfilter_down_v6" type="radio">
          <span id="down_black">Black List</span><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
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
                      <!--td><input type="reset" value="Cancel" id="fw_cancel"class="submit" onClick="window.location.reload();" ></td-->
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/ipFilterDelete_v6">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="fw_filterListHead">Filtering rules List</td>
              </tr>
              <tr class="tabal_title">
                <td width="2%" align="center">ID</td>
                <td width="12%" align="center" id="fw_directionTitle">Direction</td>
                <td width="26%" align="center" id="fw_srcIPTitle">Src IP</td>
                <td width="10%" align="center" id="fw_srcPortTitle">Src Port</td>
                <td width="26%" align="center" id="fw_dstIPTitle">Dst IP</td>
                <td width="10%" align="center" id="fw_dstPortTitle">Dst Port</td>
                <td width="10%" align="center" id="fw_protocolTitle">Protocol</td>
                <td width="4%" align="center" id="fw_removeFlagTitle"></td>
              </tr>
              <script language="JavaScript" type="text/javascript">
		if(fw_rulesSum == 0)
		{
			document.write('<TR id="record_no"' + ' class="tabal_01" >');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center">--</TD>');
			document.write('<TD align="center"></TD>');
			document.write('</TR>');
		}
		else
		{
       		for (var i = 0; i < fw_rulesSum; i++)
			{
				document.write('<TR id="record_' + i + '" class="tabal_01" onclick="selectLine(this.id);">');
				
				document.write('<TD align="center">' + (i + 1) + ' </TD>');	
				
				if(directionArray[i] == 0)
				{
					document.write('<TD align="center">Lan -> Wan</TD>');
				}
				else if(directionArray[i] == 1)
				{
					document.write('<TD align="center">Wan -> Lan</TD>');
				}
				else
				{
					document.write('<TD align="center">ERROR</TD>');
				}
//				document.write('<TD align="center">' + srcIPStartArray[i] + '--'+ srcIPEndArray[i] + '</TD>');
				if(srcIPStartArray[i] == " ")
				{document.write('<TD align="center">' + '--' + '</TD>');}
				else
				{document.write('<TD align="center">' + srcIPStartArray[i] + '</TD>');}
				document.write('<TD align="center">' + srcPortStartArray[i] + '--'+ srcPortEndArray[i] + '</TD>');
//				document.write('<TD align="center">' + dstIPStartArray[i] + '--'+ dstIPEndArray[i] + '</TD>');
				if(dstIPStartArray[i] == " ")
				{document.write('<TD align="center">' + '--' + '</TD>');}
				else
				{document.write('<TD align="center">' + dstIPStartArray[i] + '</TD>');}
				document.write('<TD align="center">' + dstPortStartArray[i] + '--'+ dstPortEndArray[i] + '</TD>');
				if(protocolArray[i] == 0)
				{
					document.write('<TD align="center">ALL</TD>');
				}
				else if(protocolArray[i] == 1)
				{
					document.write('<TD align="center">ICMP</TD>');
				}
				else if(protocolArray[i] == 6)
				{
					document.write('<TD align="center">TCP</TD>');
				}
				else if(protocolArray[i] == 17)
				{
					document.write('<TD align="center">UDP</TD>');
				}
				else
				{
					document.write('<TD align="center">ERROR</TD>');
				}
				document.write('<TD align="center">' + '<input type="checkbox" name="fw_removeFlag"' + ' value="'
			 + i + '" </TD>');
				document.write('</TR>');
			}
		}
       </script>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/ipFilterCfg_v6" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td ><div id="div_fw_rule">
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                  <tr style="">
                                    <td id="fw_directionTitle2" class="tabal_left" width="25%">Direction</td>
                                    <td class="tabal_right" width="75%"><select name="fw_direction" id="fw_direction" size="1" style="width:29%">
                                        <option value="0" selected="selected">Lan -> Wan</option>
                                        <option value="1">Wan -> Lan</option>
                                      </select></td>
                                  </tr>
                                  <tr style="">
                                    <td id="fw_srcIPTitle2" class="tabal_left" width="25%">Src IPv6</td>
                                    <td class="tabal_right" width="75%"><input name="fw_srcIPStart" id="fw_srcIPStart" maxlength="40" style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="fw_srcIPEnd" id="fw_srcIPEnd" maxlength="40" style="width: 150px; display: none;" type="text"></td>
                                  </tr>
                                  <tr style="">
                                    <td id="fw_startPortTitle2" class="tabal_left" width="25%">Src Port</td>
                                    <td class="tabal_right" width="75%"><input name="fw_srcPortStart" id="fw_srcPortStart" style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="fw_srcPortEnd" id="fw_srcPortEnd" style="width: 150px;" type="text">
                                      <span class="gray">&nbsp; (1-65535)</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="fw_dstIPTitle2" class="tabal_left" width="25%">Dst IPv6</td>
                                    <td class="tabal_right" width="75%"><input name="fw_dstIPStart" id="fw_dstIPStart" maxlength="40" style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="fw_dstIPEnd" id="fw_dstIPEnd" maxlength="40" style="width: 150px; display: none;" type="text">
                                      <span id="fw_curWanIP"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="fw_dstPortTitle2" class="tabal_left" width="25%">Dst Port</td>
                                    <td class="tabal_right" width="75%"><input name="fw_dstPortStart" id="fw_dstPortStart" style="width: 150px;" type="text">
                                      &nbsp;&nbsp;-&nbsp;&nbsp;
                                      <input name="fw_dstPortEnd" id="fw_dstPortEnd" style="width: 150px;" type="text">
                                      <span class="gray">&nbsp; (1-65535)</span></td>
                                  </tr>
                                  <tr style="">
                                    <td id="fw_protocolTitle2" class="tabal_left" width="25%">Portocol</td>
                                    <td class="tabal_right" width="75%"><select name="fw_protocol" id="fw_protocol" size="1" style="width:29%" onChange="changeProtocol(this.value)">
                                        <option value="6" selected="selected">TCP</option>
                                        <option value="17">UDP</option>
                                        <option value="1">ICMP</option>
                                        <option value="0">ALL</option>
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="fw_apply" id="fw_apply" class="submit">
                    <input type="reset" value="Cancel" name="fw_cancel2" id="fw_cancel2" class="submit" onClick="window.location.reload();" >
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
