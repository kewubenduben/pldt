
var sumPerPortArr = new Array(0, 0, 0, 0);

var previousTR = null;
function initTranslation()
{ 
	var e = document.getElementById("acl_funcPrompt");
	e.innerHTML = _("acl_funcPrompt");
	e = document.getElementById("acl_usePrompt");
	e.innerHTML = _("acl_usePrompt");
	
	e = document.getElementById("acl_refresh");
	e.value = _("acl_refresh");	
	e = document.getElementById("acl_submit");
	e.value = _("acl_submit");
	e = document.getElementById("acl_apply");
	e.value = _("acl_apply");	
	e = document.getElementById("acl_cancel");
	e.value = _("acl_cancel");
	e = document.getElementById("acl_add");
	e.value = _("acl_add");
	e = document.getElementById("acl_delete");
	e.value = _("acl_delete");
	e = document.getElementById("acl_deleteAll");
	e.value = _("acl_deleteAll");
	
	e = document.getElementById("acl_switchTitle");
	e.innerHTML = _("acl_switchTitle");
	e = document.getElementById("acl_disableTitle");
	e.innerHTML = _("acl_disableTitle");	
	e = document.getElementById("acl_enableTitle");
	e.innerHTML = _("acl_enableTitle");	
	e = document.getElementById("acl_modeTitle");
	e.innerHTML = _("acl_modeTitle");
	e = document.getElementById("acl_modeBlackTitle");
	e.innerHTML = _("acl_modeBlackTitle");
	e = document.getElementById("aacl_modeWhiteTitle");
	e.innerHTML = _("aacl_modeWhiteTitle");
	e = document.getElementById("acl_typeTitle0");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_typeTitle");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_typeTitle2");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_listHead");
	e.innerHTML = _("acl_listHead");	
	e = document.getElementById("acl_portTitle");
	e.innerHTML = _("acl_portTitle");	
	e = document.getElementById("acl_portTitle2");
	e.innerHTML = _("acl_portTitle");
		
	e = document.getElementById("acl_portTips");
	e.innerHTML = _("acl_portTips");
	e = document.getElementById("acl_ipTips");
	e.innerHTML = _("acl_ipTips");
	e = document.getElementById("acl_macTips");
	e.innerHTML = _("acl_macTips");
	e = document.getElementById("acl_vidTips");
	e.innerHTML = _("acl_vidTips");
}
function LoadFrame()
{ 
	initTranslation();
	
	showAclBasicData();

	setDisplay("ConfigForm1", "none");
	initSumPerPortArr();
	
}

function showAclBasicData()
{
	if(acl_mode == 0)	//disable
	{
		getElement("acl_switch")[0].checked = true;
		onClickSwitch(0);
	}
	else
	{
		getElement("acl_switch")[1].checked = true;
		onClickSwitch(1);	
		if(acl_mode == 2)	//black
		{
			getElement("acl_mode")[0].checked = true;
		}
		else if(acl_mode == 1)	//white
		{
			getElement("acl_mode")[1].checked = true;
		}
	}

	getElement("acl_type")[acl_type].selected = true;
	
}

function initSumPerPortArr()
{
	var tab = getElement("acl_ruleTable");

	if(acl_rulesSum > 0)
	{
		var curPort;
		for(var i = 2; i < tab.rows.length; i++)
		{
			curPort = parseInt(tab.rows[i].cells[0].getElementsByTagName("input")[0].value);
			sumPerPortArr[curPort-1]++;
		}
	}
}

function onClickSwitch(switchValue)
{
	if(switchValue == 0)	//disable
	{
		setDisplay("tr_aclMode", "none");
//		getElement("acl_mode")[0].checked = false;	//radio不可用未实现--yuzi
//		getElement("acl_mode")[1].checked = false;
		getElement("acl_type").disabled = 1;
		getElement("acl_add").disabled = 1;
		getElement("acl_delete").disabled = 1;
		getElement("acl_deleteAll").disabled = 1;
		
		var tab = getElement("acl_ruleList").getElementsByTagName('table');
		var rowLen = tab[0].rows.length;
		var lastRow = tab[0].rows[rowLen - 1];
		var temp = lastRow.id.split('_')[1];
		if(temp == "new")
		{
			tab[0].deleteRow(rowLen-1);	
		}
		setDisplay("ConfigForm1", "none");

	}
	else
	{
		setDisplay("tr_aclMode", "")
		getElement("acl_mode")[0].checked = true;
//		getElement("acl_mode").disabled = 0;
		getElement("acl_type").disabled = 0;
		getElement("acl_add").disabled = 0;
		getElement("acl_delete").disabled = 0;
		getElement("acl_deleteAll").disabled = 0;
	}
}

function changeType(newType, tabTitle)
{
//	if(confirm("规则分类发生变化，将删除原有规则，是否继续?") == false)
	if(confirm(_("acl_changeTypeConfirm")) == false)
	{
		getElement("acl_type")[acl_type].selected = true;
		return ;	
	}
	else	//确认删除
	{
		acl_type = newType;
		removeAll(tabTitle);
	}
	
	setDisplay("ConfigForm1", "none");
}

function removeAll(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	var row, col;
	var rowLen = tab[0].rows.length;

	for(var i = 2; i < rowLen; i++)		//0--head; 1--title
	{
		tab[0].deleteRow(2);
	}
	
	acl_rulesSum = 0;
	for(var i = 0; i < 4; i++)
	{
		sumPerPortArr[i] = 0;
	}
}

function remove(tabTitle, removeArr)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	var row, col;
	var indexLen = removeArr.length;
	var curDelIndex;
	var curPort;

	for(var i = indexLen - 1; i >= 0; i--)
	{
		for(var j = 0; j < tab[0].rows.length; j ++)
		{
			if(tab[0].rows[j].id.split('_')[1] == removeArr[i])
			{
				curDelIndex = tab[0].rows[j].rowIndex;
				break;
			}
		}
		//更新port条目数
		curPort = tab[0].rows[curDelIndex].cells[0].getElementsByTagName("input")[0].value;;
		sumPerPortArr[curPort-1]--;
		
		tab[0].deleteRow(curDelIndex);
		acl_rulesSum--;
	}
}

function add(tab)
{	
	var curPort = parseInt(getElement("acl_port").value);
	
	//检验合法性
	if(!checkValue())
		return;
	
	if(curPort != 0)	//not ALL
	{
		//检验条目数
		if(!checkDataSum(curPort))
			return;
		
		//检验重复性
		if(!checkDataRepeatability(tab, curPort, "new"))
			return;
		
		addNewData(tab, curPort);
	}
	else
	{		
		for(var i = 1; i <= 4; i++)
		{
			//检验条目数
			if(!checkDataSum(i))
				return;
			
			//检验重复性
			if(!checkDataRepeatability(tab, i, "new"))
				return;
		}
		
		addNewData(tab, 1);
		for(var i = 2; i <= 4; i++)
		{
			addNewRow(tab);
			addNewData(tab, i);
		}
	}
	selectLine(tab[0].rows[tab[0].rows.length-1].id);
}

function addNewRow(tab)
{
	var row, col;
	var rowLen = tab[0].rows.length;
	var titleRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(acl_rulesSum > 32)		//4*8
	{		
//   		alert("最多只能创建32条规则!");
 		alert(_("acl_mostRulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无数据
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'tabal_01';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
		row.align = 'center';
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','tabal_01');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
		row.setAttribute('align','center');
	}
	row.insertCell(0).innerHTML = '<input readonly="readonly" style="width:43px"  value="--">';
	row.insertCell(1).innerHTML = '<input readonly="readonly" style="width:142px" value="--">';
	row.insertCell(2).innerHTML = '<input readonly="readonly" style="width:170px" value="--">';
	row.insertCell(3).innerHTML = '<input readonly="readonly" style="width:170px" value="--">';
	row.insertCell(4).innerHTML = '<input readonly="readonly" style="width:100px" value="--">';
	row.insertCell(5).innerHTML = '<input type="checkbox" name="acl_removeFlag" >'
		
}
function addNewData(tab, curPort)
{		
	var curRow = getElement("record_new");
	
	var rowLen = tab[0].rows.length;
	
	var newRowID;
	if(acl_rulesSum == 0)//当前无数据
	{
		newRowID = 0;
	}
	else
	{
		var lastRow = tab[0].rows[rowLen-2];		//上一行
		newRowID = parseInt(lastRow.id.split('_')[1]) + 1;
	}
	curRow.id = "record_" + newRowID;
	
	curRow.cells[0].getElementsByTagName("input")[0].name = "acl_port_" + newRowID;
	curRow.cells[1].getElementsByTagName("input")[0].name = "acl_type_" + newRowID;
	curRow.cells[2].getElementsByTagName("input")[0].name = "acl_ip_" + newRowID;
	curRow.cells[3].getElementsByTagName("input")[0].name = "acl_mac_" + newRowID;
	curRow.cells[4].getElementsByTagName("input")[0].name = "acl_vid_" + newRowID;
	
	curRow.cells[0].getElementsByTagName("input")[0].value = curPort;
	curRow.cells[2].getElementsByTagName("input")[0].value = getElement("acl_ip").value;
	curRow.cells[5].getElementsByTagName("input")[0].value = newRowID;

	switch(parseInt(acl_type))
	{
		case 0: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP";
			break;
		case 1: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP + Mac";
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			break;
		case 2: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP + Mac + Vid";
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			curRow.cells[4].getElementsByTagName("input")[0].value = getElement("acl_vid").value;
			break;
		default:
			break;			
	}
	sumPerPortArr[curPort-1]++;
	acl_rulesSum++;
	
}

function checkDataSum(curPort)
{
	if(sumPerPortArr[curPort-1] >= 8)
	{		
//   	alert("端口" + curPort + "已创建8条规则! 不能再创建!");
 		alert(_("acl_portTitle") + curPort + _("acl_portMostRulesAlert"));
		return false;
	}
	return true;
}

function checkDataRepeatability(tab, curPort, curIndex)
{
	var rowLen = tab[0].rows.length;
	var newIP = getElement("acl_ip").value;
	var newMAC = getElement("acl_mac").value;
	var newVID = getElement("acl_vid").value;
	var i;

	if(rowLen == 3)	//当前无数据，第3行为record_new
	{
		return true;
	}
	
	for(i = 2; i < rowLen; i++)
	{
		if(tab[0].rows[i].cells[0].getElementsByTagName("input")[0].value != curPort)//port
			continue;
		else
		{
			if(tab[0].rows[i].cells[2].getElementsByTagName("input")[0].value != newIP)//ip
				continue;
			else if(acl_type == 0)
			{
				if(curIndex == tab[0].rows[i].id.split("_")[1])
				{
					continue;
				}
				else
				{
//					alert("与已有规则重复，请重新配置!");
					alert(_("acl_ruleRepeatAlert"));
					return false;
				}
				
			}
			else if(acl_type == 1)
			{
				if(tab[0].rows[i].cells[3].getElementsByTagName("input")[0].value != newMAC)//mac
					continue;
				else
				{
					if(curIndex == tab[0].rows[i].id.split("_")[1])
					{
						continue;
					}
					else
					{
	//					alert("与已有规则重复，请重新配置!");
						alert(_("acl_ruleRepeatAlert"));
						return false;
					}
				}
			}
			else if(acl_type == 2)
			{
				if(tab[0].rows[i].cells[3].getElementsByTagName("input")[0].value != newMAC)//mac
					continue;
				else
				{
					if(tab[0].rows[i].cells[4].getElementsByTagName("input")[0].value != newVID)//vid
						continue;
					else
					{
						if(curIndex == tab[0].rows[i].id.split("_")[1])
						{
							continue;
						}
						else
						{
		//					alert("与已有规则重复，请重新配置!");
							alert(_("acl_ruleRepeatAlert"));
							return false;
						}
					}
				}
			}
			
		}
	}
	return true;
	
}

function modify(tab, curIndex)
{	
	var curPort = parseInt(getElement("acl_port").value);
	
	//检验合法性
	if(!checkValue())
		return;

	//检验重复性
	if(!checkDataRepeatability(tab, curPort, curIndex))
		return;
	
	var curRow = getElement("record_" + curIndex);
	
	var rowLen = tab[0].rows.length;
		
	curRow.cells[0].getElementsByTagName("input")[0].value = curPort;
	curRow.cells[2].getElementsByTagName("input")[0].value = getElement("acl_ip").value;

	switch(parseInt(acl_type))
	{
		case 0: 
			break;
		case 1: 
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			break;
		case 2: 
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			curRow.cells[4].getElementsByTagName("input")[0].value = getElement("acl_vid").value;
			break;
		default:
			break;			
	}
	selectLine(curRow);
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	addNewRow(tab);
	
	selectLine("record_new");
	getElement("acl_port").focus();
	
//	setDisplay("ConfigForm1", "");	//全删后该表被隐藏
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		if(getElement("acl_switch")[0].checked)	//disable
		{
			return;
		}
		
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			getElement("acl_port").value = "0";
			getElement("acl_type2").value = acl_type;			
			getElement("acl_ip").value = "";
			getElement("acl_mac").value = "";
			getElement("acl_vid").value = "";
			
			getElement("acl_port").disabled = 0;
						
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			getElement("acl_port").value = objTR.cells[0].getElementsByTagName("input")[0].value;
			getElement("acl_type2").value = acl_type;			
			getElement("acl_ip").value = objTR.cells[2].getElementsByTagName("input")[0].value;
			getElement("acl_mac").value = objTR.cells[3].getElementsByTagName("input")[0].value;
			getElement("acl_vid").value = objTR.cells[4].getElementsByTagName("input")[0].value;

			getElement("acl_port").disabled = 1;
		
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
		//type不可修改
		getElement("acl_type2").disabled = 1;
		
		switch(parseInt(acl_type))
		{
			case 0:		//ip
				getElement("acl_mac").disabled = 1;
				getElement("acl_vid").disabled = 1;
				getElement("acl_mac").value = "--";
				getElement("acl_vid").value = "--";
				break;
			case 1:		//ip+mac
				getElement("acl_mac").disabled = 0;
				getElement("acl_vid").disabled = 1;
				getElement("acl_vid").value = "--";
				break;
			case 2:		//ip+mac+vid
				getElement("acl_mac").disabled = 0;
				getElement("acl_vid").disabled = 0;
				break;
			default:
				break;
		}
		
		//标志当前编辑规则的id
		getElement("acl_curIndex").value = temp;	
		
		setDisplay("ConfigForm1", "");	
		getElement("acl_ip").focus();
		
	}	 
}

function clickRemove(tabTitle)
{
	if(acl_rulesSum == 0)
	{			
// 		alert("当前没有规则，不能删除!");
 		alert(_("acl_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('acl_removeFlag');
    var noChooseFlag = true;

	var removeArr = new Array();
	var j = 0;
	
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				removeArr[j++] = checkNodes[i].value;
			}
		}
		if(removeArr.length > 0)
			noChooseFlag = false;
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		removeArr[0] = checkNodes.value;
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
//		alert('请先至少选择一条规则');
		alert(_("acl_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("acl_deleteRuleConfirm")) == false)
    	return;
	else
		remove(tabTitle, removeArr);

	if(tab[0].rows.length > 2)
		selectLine(tab[0].rows[2].id);	//显示第一个数据行
	else
		setDisplay("ConfigForm1", "none");
}

function clickRemoveAll(tabTitle)
{
	if(acl_rulesSum == 0)
	{				
// 		alert("当前没有规则，不能删除!");
   		alert(_("acl_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('acl_removeFlag');
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
	if(confirm(_("acl_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}
	else
	{
		removeAll(tabTitle);
	}

	setDisplay("ConfigForm1", "none");
}

function clickApply(tabTitle)
{	
	var curIndex = getElement("acl_curIndex").value;
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	//add
	if(curIndex == "new")
	{
		add(tab);
	}
	else
	{
		modify(tab, curIndex);
	}
}

function cancelRuleEdit()
{
	if(acl_rulesSum > 0)
	{	
		var row0 = getElement("acl_ruleTable").rows[2];
		selectLine(row0.id);
		setDisplay("ConfigForm1", "");
	}
	else
	{	
		setDisplay("ConfigForm1", "none");
	}
}

function clickSubmit()
{
	var tab = getElement("acl_ruleList").getElementsByTagName('table');
	var acl_lastRowNo;
	if(acl_rulesSum == 0)
	{
		acl_lastRowNo = -1;
	}
	else
	{
		acl_lastRowNo = tab[0].rows[tab[0].rows.length - 1].id.split("_")[1];
	}
	getElement("acl_lastRowNo").value = acl_lastRowNo;
	getElement("acl_ruleForm").submit();
}
function checkValue()
{
	if(!acl_checkIP(getElement("acl_ip")))
	{
		return false;
	}
	
	if(acl_type == 1 || acl_type == 2)
		if(!acl_checkMAC(getElement("acl_mac")))
		{
			return false;
		}
	
	if(acl_type == 2)
		if(!acl_checkVID(getElement("acl_vid")))
		{
			return false;
		}
	
	return true;
}

function acl_checkIP(dom)
{
	dom.value = trim(dom.value);
	if(!CheckNotNull(dom.value))	//不允许为空
	{
//		alert("请输入IP!");
		alert(_("acl_ipNullAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	if(!validateIP(dom.value))
	{
//		alert("请输入合法IP!");
		alert(_("acl_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function acl_checkMAC(dom)
{
	dom.value = trim(dom.value);
	if(!CheckNotNull(dom.value))	//不允许为空
	{
//		alert("请输入Mac!");
		alert(_("acl_macNullAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	if(!validateMAC(dom.value))
	{
//		alert("Mac地址不正确！Mac地址格式为00:24:21:19:BD:E4"); 
		alert(_("acl_macIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}
function acl_checkVID(dom)
{
	dom.value = trim(dom.value);
	if(isAllNum(dom.value))
	{
		dom.value = parseInt(dom.value);
		if(1 <= dom.value && dom.value <= 4095)
		{
			return true;
		}
		else
		{
	//		alert("有效VID范围为1～4095.");
			alert(_("acl_vidIllegalAlert1"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{
//		alert("请输入正整数.");
		alert(_("acl_vidIllegalAlert2"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

