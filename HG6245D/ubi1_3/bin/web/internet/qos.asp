<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>QOS</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control();%>'
web_access_check(checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("qos", lang);

var previousTR = null;

var get_qos_sync = '<% get_qos_sync(); %>';
var qos_pri_ruleSum = '<% getCfgGeneral(1, "qos_pri_ruleSum"); %>';
var qos_class_ruleSum = '<% getCfgGeneral(1, "qos_class_ruleSum"); %>';
//qos_pri_ruleSum = 2

function LoadFrame()
{
	initTranslation();
//	var qos_enable = '<% getCfgGeneral(1, "qos_enable"); %>';
//	showRadioNodeByValue(getElement("qos_enable"), qos_enable);
	
	var qos_mode = '<% getCfgGeneral(1, "qos_mode"); %>';
	showSelectNodeByValue(getElement("qos_mode"), qos_mode);

	var qos_dscpFlag = '<% getCfgGeneral(1, "qos_dscpFlag"); %>';
	showCheckboxNodeByValue(getElement("qos_dsctFlag"), qos_dscpFlag);
	clickDsct();

	var qos_802Flag = '<% getCfgGeneral(1, "qos_802Flag"); %>';
	showSelectNodeByValue(getElement("qos_802Flag"), qos_802Flag);
	change802Flag(qos_802Flag);

	var qos_plan = '<% getCfgGeneral(1, "qos_plan"); %>';
	showRadioNodeByValue(getElement("qos_plan"), qos_plan);
	changePlan(qos_plan);
	
	qos_pri_ruleSum = parseInt(qos_pri_ruleSum);
	if(qos_pri_ruleSum == 0)
	{	
		setDisplay("qos_priRuleForm1", "none");
	}
	else
	{
		selectLine("tb_qosPriRule", "recordPri_0");	
		setDisplay("qos_priRuleForm1", "");
	}
	qos_class_ruleSum = parseInt(qos_class_ruleSum);
	if(qos_class_ruleSum == 0)
	{	
		setDisplay("qos_classRuleForm1", "none");
	}
	else
	{
		selectLine("tb_qosClassRule", "recordClass_0_0");	
		setDisplay("qos_classRuleForm1", "");
	}
}
function initTranslation()
{
	var e = document.getElementById("qos_prompt");
	e.innerHTML = _("qos_prompt");
	e = document.getElementById("qos_classDSCPTips");
	e.innerHTML = _("qos_classDSCPTips");
	e = document.getElementById("qos_class802Title2");
	e.innerHTML = _("qos_class802Title2");
	e = document.getElementById("qos_class802Title");
	e.innerHTML = _("qos_class802Title2");
	e = document.getElementById("qos_class802Tips");
	e.innerHTML = _("qos_class802Tips");
	e = document.getElementById("qos_classType1Title");
	e.innerHTML = _("qos_classType1Title");
	e = document.getElementById("qos_classMin1Title2");
	e.innerHTML = _("qos_classMin1Title2");
	e = document.getElementById("qos_classMin2Title2");
	e.innerHTML = _("qos_classMin1Title2");
	e = document.getElementById("qos_classMin3Title2");
	e.innerHTML = _("qos_classMin1Title2");
	e = document.getElementById("qos_classMax2Title2");
	e.innerHTML = _("qos_classMax1Title2");
	e = document.getElementById("qos_classMax3Title2");
	e.innerHTML = _("qos_classMax1Title2");	
	e = document.getElementById("qos_classMinTitle");
	e.innerHTML = _("qos_classMin1Title2");
	e = document.getElementById("qos_classMax1Title2");
	e.innerHTML = _("qos_classMax1Title2");
	e = document.getElementById("qos_classMaxTitle");
	e.innerHTML = _("qos_classMax1Title2");
	e = document.getElementById("qos_classProtocol1Title2");
	e.innerHTML = _("qos_classProtocol1Title2");
	e = document.getElementById("qos_classProtocolTitle");
	e.innerHTML = _("qos_classProtocol1Title2");
	e = document.getElementById("qos_classProtocol2Title2");
	e.innerHTML = _("qos_classProtocol1Title2");
	e = document.getElementById("qos_classProtocol3Title2");
	e.innerHTML = _("qos_classProtocol1Title2");	
	e = document.getElementById("qos_classProtocolTitle");
	e.innerHTML = _("qos_classProtocol1Title2");
	e = document.getElementById("qos_classType2Title");
	e.innerHTML = _("qos_classType2Title");
	e = document.getElementById("qos_classType3Title");
	e.innerHTML = _("qos_classType3Title");
	e = document.getElementById("qos_cfgApplyTitle");
	e.innerHTML = _("qos_cfgApplyTitle");
	e = document.getElementById("qos_classRuleListHead");
	e.innerHTML = _("qos_classRuleListHead");
	e = document.getElementById("qos_classNoTitle");
	e.innerHTML = _("qos_classNoTitle");
	e = document.getElementById("qos_classQueueTitle");
	e.innerHTML = _("qos_classQueueTitle");	
	e = document.getElementById("qos_classQueueTitle2");
	e.innerHTML = _("qos_classQueueTitle");
	e = document.getElementById("qos_priQueueTitle2");
	e.innerHTML = _("qos_classQueueTitle");	
	e = document.getElementById("qos_priQueueTitle");
	e.innerHTML = _("qos_classQueueTitle");	
	e = document.getElementById("qos_classDSCPTitle2");
	e.innerHTML = _("qos_classDSCPTitle2");
	 e = document.getElementById("qos_classDSCPTitle");
	e.innerHTML = _("qos_classDSCPTitle2");
	 e = document.getElementById("qos_classTypeNoTitle");
	e.innerHTML = _("qos_classTypeNoTitle");
	e = document.getElementById("qos_classTypeNoTitle");
	e.innerHTML = _("qos_classTypeNoTitle");				
	e = document.getElementById("qos_classTypeTitle");
	e.innerHTML = _("qos_classTypeTitle");
	e = document.getElementById("qos_priServiceTitle2");
	e.innerHTML = _("qos_priServiceTitle2");
	 e = document.getElementById("qos_priServiceTitle");
	e.innerHTML = _("qos_priServiceTitle2");
	e = document.getElementById("qos_priRuleListHead");
	e.innerHTML = _("qos_priRuleListHead");	
	e = document.getElementById("qos_weiQueueHead");
	e.innerHTML = _("qos_weiQueueHead");
	e = document.getElementById("qos_priQueueHead");
	e.innerHTML = _("qos_weiQueueHead");	
	e = document.getElementById("qos_weiWeightHead");
	e.innerHTML = _("qos_weiWeightHead");
	e = document.getElementById("qos_weiEnableHead");
	e.innerHTML = _("qos_weiEnableHead");
	e = document.getElementById("qos_priEnableHead");
	e.innerHTML = _("qos_weiEnableHead");
	e = document.getElementById("qos_planTitle");
	e.innerHTML = _("qos_planTitle");
	e = document.getElementById("qos_planPriorityTip");
	e.innerHTML = _("qos_planPriorityTip");
	e = document.getElementById("qos_planWeightTip");
	e.innerHTML = _("qos_planWeightTip");
	e = document.getElementById("qos_802FlagTitle");
	e.innerHTML = _("qos_802FlagTitle");
	e = document.getElementById("qos_dsctFlagTitle");
	e.innerHTML = _("qos_dsctFlagTitle");
	e = document.getElementById("qos_bandwidthTitle");
	e.innerHTML = _("qos_bandwidthTitle");
	e = document.getElementById("qos_modeTitle");
	e.innerHTML = _("qos_modeTitle");
	e = document.getElementById("qos_cfgHead");
	e.innerHTML = _("qos_cfgHead");
	e = document.getElementById("qos_priPriorityHead");
	e.innerHTML = _("qos_priPriorityHead");

	e = document.getElementById("option_chose");
	e.innerHTML = _("option_chose");
	e = document.getElementById("qos_classType1_option");
	e.innerHTML = _("option_chose");
	 e = document.getElementById("qos_classType2_option");
	e.innerHTML = _("option_chose");
	 e = document.getElementById("qos_classType3_option");
	e.innerHTML = _("option_chose");
	e = document.getElementById("qos_classProtocol2_option");
	e.innerHTML = _("option_chose");
	e = document.getElementById("qos_classProtocol3_option");
	e.innerHTML = _("option_chose");
	e = document.getElementById("qos_802Flag_option");
	e.innerHTML = _("qos_802Flag_option");
	e = document.getElementById("qos_802Flag_option2");
	e.innerHTML = _("qos_802Flag_option2");
	e = document.getElementById("qos_802Flag_option3");
	e.innerHTML = _("qos_802Flag_option3");
	e = document.getElementById("qos_classType1_option1");
	e.innerHTML = _("qos_classType1_option1");
	e = document.getElementById("qos_classType2_option1");
	e.innerHTML = _("qos_classType1_option1");
	 e = document.getElementById("qos_classType3_option1");
	e.innerHTML = _("qos_classType1_option1");
	e = document.getElementById("qos_classType1_option2");
	e.innerHTML = _("qos_classType1_option2");
	e = document.getElementById("qos_classType2_option2");
	e.innerHTML = _("qos_classType1_option2");
	e = document.getElementById("qos_classType3_option2");
	e.innerHTML = _("qos_classType1_option2");
	e = document.getElementById("qos_classType1_option3");
	e.innerHTML = _("qos_classType1_option3");
	e = document.getElementById("qos_classType2_option3");
	e.innerHTML = _("qos_classType1_option3");
	e = document.getElementById("qos_classType3_option3");
	e.innerHTML = _("qos_classType1_option3");
	e = document.getElementById("qos_classType1_option4");
	e.innerHTML = _("qos_classType1_option4");
	e = document.getElementById("qos_classType2_option4");
	e.innerHTML = _("qos_classType1_option4");
	e = document.getElementById("qos_classType3_option4");
	e.innerHTML = _("qos_classType1_option4");
	e = document.getElementById("qos_classType1_option5");
	e.innerHTML = _("qos_classType1_option5");
	e = document.getElementById("qos_classType2_option5");
	e.innerHTML = _("qos_classType1_option5");
	 e = document.getElementById("qos_classType3_option5");
	e.innerHTML = _("qos_classType1_option5");
	e = document.getElementById("qos_classType1_option6");
	e.innerHTML = _("qos_classType1_option6");
	e = document.getElementById("qos_classType2_option6");
	e.innerHTML = _("qos_classType1_option6");
	e = document.getElementById("qos_classType3_option6");
	e.innerHTML = _("qos_classType1_option6");
	e = document.getElementById("qos_classType1_option7");
	e.innerHTML = _("qos_classType1_option7");
	e = document.getElementById("qos_classType2_option7");
	e.innerHTML = _("qos_classType1_option7");
	e = document.getElementById("qos_classType3_option7");
	e.innerHTML = _("qos_classType1_option7");
	
	e = document.getElementById("qos_class_add");
	e.value = _("qos_class_add");
	e = document.getElementById("qos_class_delete");
	e.value = _("qos_class_delete");
	e = document.getElementById("qos_class_deleteAll");
	e.value = _("qos_class_deleteAll");
	e = document.getElementById("qos_pri_add");
	e.value = _("qos_class_add");
	e = document.getElementById("qos_pri_delete");
	e.value = _("qos_class_delete");
	e = document.getElementById("qos_pri_deleteAll");
	e.value = _("qos_class_deleteAll");
	
	e = document.getElementById("qos_classRuleApply");
	e.value = _("qos_classRuleApply");
	var e = document.getElementById("qos_classRuleCancel");
	e.value = _("qos_classRuleCancel");
	var e = document.getElementById("qos_classRuleCancel2");
	e.value = _("qos_classRuleCancel");
	var e = document.getElementById("qos_basicApply");
	e.value = _("qos_classRuleApply");	
	var e = document.getElementById("qos_basicCancel");
	e.value = _("qos_classRuleCancel");
	var e = document.getElementById("qos_enableTitle");
	e.value = _("qos_classRuleApply");
	var e = document.getElementById("qos_dixableTitle");
	e.value = _("qos_dixableTitle");	
	e = document.getElementById("qos_priRuleApply");
	e.value = _("qos_classRuleApply");
}
function checkValue(tabTitle)
{
	if(tabTitle == "tb_qosPriRule")	//pri
	{
		return true;
	}
	else			//class
	{
		return true;
	}	
}
function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];
	var ruleTableName;
	var ruleForm;

	if(tabTitle == "td_qosPriList")	//pri
	{
		ruleTableName = "tb_qosPriRule";
		ruleForm = "qos_priRuleForm1";
		if(rowLen - 2 >= 4)
		{
	 		alert(_("rule_most4RulesAlert"));
			return;
		}
	}
	else							//classification
	{
		ruleTableName = "tb_qosClassRule";
		ruleForm = "qos_classRuleForm1";
		var lastClassIndex = lastRow.id.split('_')[1];
		if((parseInt(lastClassIndex) + 1) >= 4)
		{
	 		alert(_("rule_most4RulesAlert"));
			return;
		}
	}
	if (lastRow.id == 'record_new')		//新建
	{
		selectLine(ruleTableName, "record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//原无用户
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay(ruleForm, "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine(ruleTableName, "record_null");});
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
	selectLine(ruleTableName, "record_new");
		
	if(tabTitle == "td_qosPriList")	//pri
	{
		getElement("qos_priService").focus();
	}
	else							//classification
	{
		getElement("qos_classQueue").focus();
	}
}
function selectLine(table, id)
{
	var objTR = getElement(id);
	if (objTR == null)
	{
		return ;
	}
	if(table == 'tb_qosPriRule')	//业务优先级表
	{
		var curID = objTR.id.split('_')[1];
		if (curID == 'new')		//新建
		{
			showSelectNodeByValue(getElement("qos_priService"), 0);
			showSelectNodeByValue(getElement("qos_priQueue"), 1);
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
			
			getElement("curPriRuleIndex").value = curID;//标志当前编辑规则的id
		}
        else if (curID == 'no')	//原无用户
        {
        }
		else
		{
			var curService = getElement("qos_priService_" + curID).innerHTML;
			var ServiceNode = getElement("qos_priService");
			showSelectNodeByValue(ServiceNode, curService);
			
			var curQueue = getElement("qos_priQueue_" + curID).innerHTML;
			var queueNode = getElement("qos_priQueue");
			showSelectNodeByText(queueNode, curQueue);

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
			
			getElement("curPriRuleIndex").value = curID;//标志当前编辑规则的id
		}	

	}
	else						//classification
	{
		var classNo = objTR.id.split('_')[1];
		var typeNo = objTR.id.split('_')[2];
		if (classNo == 'new')		//新建
		{
			showSelectNodeByValue(getElement("qos_classQueue"), 1);
			
			showSelectNodeByValue(getElement("qos_classType1"), "SMAC");
			getElement("qos_classMin1").value = "";
			getElement("qos_classMax1").value = "";
			showSelectNodeByValue(getElement("qos_classProtocol1"), "TCP");
			showSelectNodeByValue(getElement("qos_classType2"), 0);
			getElement("qos_classMin2").value = "";
			getElement("qos_classMax2").value = "";
			showSelectNodeByValue(getElement("qos_classProtocol2"), 0);
			showSelectNodeByValue(getElement("qos_classType3"), 0);
			getElement("qos_classMin3").value = "";
			getElement("qos_classMax3").value = "";
			showSelectNodeByValue(getElement("qos_classProtocol3"), 0);
			
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
			
			getElement("curClassRuleIndex").value = classNo;//标志当前编辑规则的id
		}
        else if (classNo == 'no')	//原无用户
        {
        }
		else
		{
			showSelectNodeByText(getElement("qos_classQueue"), getElement("qos_classQueue_" + classNo).innerHTML);

			for(var i = 0; i < 3; i++)
			{
				var temp = getElement("qos_classType_" + classNo + "_" + i);
				if(!temp)
				{
					showSelectNodeByValue(getElement("qos_classType" + (i+1)), 0);
					getElement("qos_classMin" + (i+1)).value = "";
					getElement("qos_classMax" + (i+1)).value = "";
					showSelectNodeByValue(getElement("qos_classProtocol" + (i+1)), 0);
				}
				else
				{
					showSelectNodeByValue(getElement("qos_classType" + (i+1)), getElement("qos_classType_" + classNo + "_" + i).innerHTML);//yuzi
					getElement("qos_classMin" + (i+1)).value = getElement("qos_classMin_" + classNo + "_" + i).innerHTML;
					getElement("qos_classMax" + (i+1)).value = getElement("qos_classMax_" + classNo + "_" + i).innerHTML;
					showSelectNodeByText(getElement("qos_classProtocol" + (i+1)), getElement("qos_classProtocol_" + classNo + "_" + i).innerHTML);
				}
			}
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
			
			getElement("curPriRuleIndex").value = classNo;//标志当前编辑规则的id
		}	

	}
}

function clickRemove(tabTitle)
{
	var checkNodes;
	var curRuleForm;
	if(tabTitle == "td_qosPriList")	//pri
	{
		checkNodes = getElement('qos_pri_removeFlag');
		curRuleForm = getElement("qos_priRuleForm");
		if(qos_pri_ruleSum  == 0)
		{			
	 		alert(_("rule_noRuleAlert"));
	   		return;
		}
	}
	else							//classification
	{
		checkNodes = getElement('qos_class_removeFlag');
		curRuleForm = getElement("qos_classRuleForm");
		if(qos_class_ruleSum  == 0)
		{			
	 		alert(_("rule_noRuleAlert"));
	   		return;
		}
	}
	
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
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
	
	curRuleForm.submit();
	
}
function clickRemoveAll(tabTitle)
{
	var checkNodes;
	var go2Location;
	if(tabTitle == "td_qosPriList")	//pri
	{
		checkNodes = getElement('qos_pri_removeFlag');
		go2Location = "/goform/qos_pri_delete_all" + "?csrftoken=" + getCsrftoken();
		if(qos_pri_ruleSum  == 0)
		{			
	 		alert(_("rule_noRuleAlert"));
	   		return;
		}
	}
	else							//classification
	{
		checkNodes = getElement('qos_class_removeFlag');
		go2Location = "/goform/qos_class_delete_all" + "?csrftoken=" + getCsrftoken();
		if(qos_class_ruleSum  == 0)
		{			
	 		alert(_("rule_noRuleAlert"));
	   		return;
		}
	}
	
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
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

	document.location = go2Location + "?csrftoken=" + getCsrftoken();
}
function clickDsct()
{
	var dsctFlagNode = getElement("qos_dsctFlag");
	if(dsctFlagNode.checked == true)
		setDisplay("tr_qosClassDSCP", "");
	else
		setDisplay("tr_qosClassDSCP", "none");
}
function change802Flag(curFlag)
{
	if(curFlag == 2)//new 802.1p
		setDisplay("tr_qosClass802", "");
	else
		setDisplay("tr_qosClass802", "none");
}
function changePlan(curPlan)
{
	if(curPlan == 0)	//pri
	{
		setDisplay("td_qosPlanPri", "");
		setDisplay("td_qosPlanWei", "none");
		showCheckboxNodeByValue(getElement("qos_priEnableQ1"), '<% getCfgGeneral(1, "qos_enableQ1"); %>');
		showCheckboxNodeByValue(getElement("qos_priEnableQ2"), '<% getCfgGeneral(1, "qos_enableQ2"); %>');
		showCheckboxNodeByValue(getElement("qos_priEnableQ3"), '<% getCfgGeneral(1, "qos_enableQ3"); %>');
		showCheckboxNodeByValue(getElement("qos_priEnableQ4"), '<% getCfgGeneral(1, "qos_enableQ4"); %>');
	}
	else				//weight
	{
		setDisplay("td_qosPlanPri", "none");
		setDisplay("td_qosPlanWei", "");
		showCheckboxNodeByValue(getElement("qos_weiEnableQ1"), '<% getCfgGeneral(1, "qos_enableQ1"); %>');
		showCheckboxNodeByValue(getElement("qos_weiEnableQ2"), '<% getCfgGeneral(1, "qos_enableQ2"); %>');
		showCheckboxNodeByValue(getElement("qos_weiEnableQ3"), '<% getCfgGeneral(1, "qos_enableQ3"); %>');
		showCheckboxNodeByValue(getElement("qos_weiEnableQ4"), '<% getCfgGeneral(1, "qos_enableQ4"); %>');
	}
}
function checkBasicValue()
{
	var planWeiNode = getElement("qos_planWei");
	if(planWeiNode.checked == true)
	{
		var weightSum = 0;
		var curWei = 0;
		for(var i = 1; i <= 4; i++)
		{
			curWei = getElement("qos_weiWeightQ" + i).value;
			weightSum = weightSum + parseInt(curWei);
		}
		if(weightSum != 100)
		{
			alert("权重总和须等于100! 请重新配置!");
			return false;
		}
	}
	return true;
}

function changeMode()
{
	getElement("qos_basicForm").submit();
}

function switchType(typeID, typeValue)
{
	var curMinTextDiv = "div_qosMinText" + typeID;
	var curMinSelectDiv = "div_qosMinSelect" + typeID;
	var curMaxTextDiv = "div_qosMaxText" + typeID;
	var curMaxSelectDiv = "div_qosMaxSelect" + typeID;
	
	if(typeValue == "LANInterface")
	{
		setDisplay(curMinTextDiv, "none");
		setDisplay(curMinSelectDiv, "");
		setDisplay(curMaxTextDiv, "none");
		setDisplay(curMaxSelectDiv, "");
		
		var curMinSelectNode = getElement("qos_classMinSelect" + typeID);
		var curMaxSelectNode = getElement("qos_classMaxSelect" + typeID);
		var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';

		//clear old list
		clearOptions(curMinSelectNode.options);
		clearOptions(curMaxSelectNode.options);
		for(var i = 1; i <= lan_port_num; i++)//create new list
		{
			curMinSelectNode.options[curMinSelectNode.options.length] = new Option("LAN" + i, i);//text, value
			curMaxSelectNode.options[curMaxSelectNode.options.length] = new Option("LAN" + i, i);//text, value
		}
	}
	else
	{
		var minNode = getElement("qos_classMin" + typeID);
		setDisplay(curMinTextDiv, "");
		setDisplay(curMinSelectDiv, "none");
		minNode.value = minNode.defaultValue;

		var maxNode = getElement("qos_classMax" + typeID);
		setDisplay(curMaxTextDiv, "");
		setDisplay(curMaxSelectDiv, "none");
		maxNode.value = maxNode.defaultValue;
	}
}
function qosEnable(flag)
{
	if(flag == '1')
	{
		getElement("qosEnableFlag").value = 1;
	}
	else
	{
		getElement("qosEnableFlag").value = 0;
	}
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
              <td id="qos_prompt" style="padding-left: 10px;" class="title_01" width="100%">在本页面，您可以配置QoS信息。</td>
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
      <td id=""><form method="post" id="qos_basicForm" action="/goform/qos_basic_cfg" onSubmit="return checkBasicValue()">
          <table class="tabal_bg" id="tb_qosBasic" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="2" id="qos_cfgHead">队列设置</td>
              </tr>
              <tr>
                <td width="25%" id="qos_modeTitle" class="tabal_left">QoS模板</td>
                <td class="tabal_right"><select name="qos_mode" size="1" style="width:150px" onChange="changeMode(this.value)">
                    <option value="1" selected="selected">TR069,INTERNET</option>
                    <option value="2">TR069,IPTV,INTERNET</option>
                    <option value="3">TR069,VOIP,INTERNET</option>
                    <option value="4">TR069,VOIP,IPTV,INTERNET</option>
                  </select></td>
              </tr>
              <tr>
                <td id="qos_bandwidthTitle" class="tabal_left">总带宽</td>
                <td class="tabal_right"><input name="qos_bandwidth" maxlength="24" type="text" value="<% getCfgGeneral(1, "qos_bandwidth"); %>">
                  <span>&nbsp;kbit/s&nbsp;&nbsp;</span><strong style="color:#FF0033">*</strong></td>
              </tr>
              <tr>
                <td id="qos_dsctFlagTitle" class="tabal_left">启用DSCT/TC标记</td>
                <td class="tabal_right"><input type="checkbox" name="qos_dsctFlag" value="1" onClick="clickDsct()"/></td>
              </tr>
              <tr>
                <td id="qos_802FlagTitle" class="tabal_left">启用802-1_P标记</td>
                <td class="tabal_right"><select name="qos_802Flag" size="1" style="width:150px" onChange="change802Flag(this.value)">
                    <option value="0" id="qos_802Flag_option" selected="selected">标记为0</option>
                    <option value="1" id="qos_802Flag_option2">透传当前值</option>
                    <option value="2"id="qos_802Flag_option3">标记为新值</option>
                  </select></td>
              </tr>
              <tr>
                <td id="qos_planTitle" class="tabal_left">调度方式</td>
                <td class="tabal_right"><input checked="checked" type="radio" name="qos_plan" id="qos_planPri" value="0" onChange="changePlan(this.value)">
                  <font id="qos_planPriorityTip">按优先级</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  <input type="radio" name="qos_plan" id="qos_planWei" value="1" onChange="changePlan(this.value)">
                  <font id="qos_planWeightTip">按权重</font> </td>
              </tr>
            </tbody>
          </table>
          <table id="tb_qosPlan" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td width="50%" id="td_qosPlanPri"><table class="tabal_bg" id="tb_qosPlanPri" border="0" cellpadding="0" cellspacing="1" width="100%">
                    <tbody>
                      <tr class="tabal_title" align="center">
                        <td id="qos_priQueueHead" width="30%">队列</td>
                        <td id="qos_priPriorityHead" width="50%">优先级</td>
                        <td id="qos_priEnableHead" width="20%">使能</td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q1</td>
                        <td id="qos_priPriorityQ1">1</td>
                        <td><input type="checkbox" name="qos_priEnableQ1" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q2</td>
                        <td id="qos_priPriorityQ2">2</td>
                        <td><input type="checkbox" name="qos_priEnableQ2" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q3</td>
                        <td id="qos_priPriorityQ3">3</td>
                        <td><input type="checkbox" name="qos_priEnableQ3" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q4</td>
                        <td id="qos_priPriorityQ4">4</td>
                        <td><input type="checkbox" name="qos_priEnableQ4" value="1"/></td>
                      </tr>
                    </tbody>
                  </table></td>
                <!-- style="display: none;" -->
                <td id="td_qosPlanWei" style="display: none;"><table class="tabal_bg" id="tb_qosPlanWei" border="0" cellpadding="0" cellspacing="1" width="100%">
                    <tbody>
                      <tr class="tabal_title">
                        <td id="qos_weiQueueHead" width="30%">队列</td>
                        <td id="qos_weiWeightHead" width="50%">权重(%)</td>
                        <td id="qos_weiEnableHead" width="20%">使能</td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q1</td>
                        <td><input name="qos_weiWeightQ1" maxlength="2" type="text" value="<% getCfgGeneral(1, "qos_weiWeightQ1"); %>"/></td>
                        <td><input type="checkbox" name="qos_weiEnableQ1" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q2</td>
                        <td><input name="qos_weiWeightQ2" maxlength="2" type="text" value="<% getCfgGeneral(1, "qos_weiWeightQ2"); %>"/></td>
                        <td><input type="checkbox" name="qos_weiEnableQ2" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q3</td>
                        <td><input name="qos_weiWeightQ3" maxlength="2" type="text" value="<% getCfgGeneral(1, "qos_weiWeightQ3"); %>"/></td>
                        <td><input type="checkbox" name="qos_weiEnableQ3" value="1"/></td>
                      </tr>
                      <tr class='tabal_01' align="center">
                        <td>Q4</td>
                        <td><input name="qos_weiWeightQ4" maxlength="2" type="text" value="<% getCfgGeneral(1, "qos_weiWeightQ4"); %>"/></td>
                        <td><input type="checkbox" name="qos_weiEnableQ4" value="1"/></td>
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
                <td class="tabal_submit"><input type="submit" value="应用" id="qos_basicApply" class="submit">
                  <input type="reset" id="qos_basicCancel"value="取消" class="submit" onClick="window.location.reload()">
                </td>
              </tr>
              <tr>
                <td colspan="2" height="5px"></td>
              </tr>
            </tbody>
          </table>
        </form></td>
    </tr>
    <!-- service pri cfg begin -->
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
                      <td><input type="button" value="新增" id="qos_pri_add" class="submit" onClick="clickAdd('td_qosPriList');"></td>
                      <td><input type="button" value="删除" id="qos_pri_delete" class="submit" onClick="clickRemove('td_qosPriList');"></td>
                      <td><input type="button" value="全删" id="qos_pri_deleteAll" class="submit" onClick="clickRemoveAll('td_qosPriList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="td_qosPriList"><form method="post" id="qos_priRuleForm" action="/goform/qos_pri_rule_delete">
          <table class="tabal_bg" id="tb_qosPriList" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="3" id="qos_priRuleListHead">业务优先级配置</td>
              </tr>
              <tr class="tabal_title">
                <td width="42%" align="center" id="qos_priServiceTitle">业务名称</td>
                <td width="42%" align="center" id="qos_priQueueTitle">进入队列</td>
                <td width="6%" align="center" ></td>
              </tr>
              <% qos_pri_list_sync(); %>
              <!--tr id='recordPri_0' class='tabal_01' onclick='selectLine("tb_qosPriRule", this.id);'>
                <td id='qos_priService_0' name='qos_priService_0' align='center'>TR069</td>
                <td id='qos_priQueue_0' name='qos_priQueue_0' align='center'>Q2</td>
                <td align='center'><input type='checkbox' name='qos_pri_removeFlag' value='0'/></td>
              </tr>
              <tr id='recordPri_1' class='tabal_01' onclick='selectLine("tb_qosPriRule", this.id);'>
                <td id='qos_priService_1' name='qos_priService_1' align='center'>VOIP</td>
                <td id='qos_priQueue_1' name='qos_priQueue_1' align='center'>Q1</td>
                <td align='center'><input type='checkbox' name='qos_pri_removeFlag' value='1'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="qos_priRuleForm" method="post" action="/goform/qos_pri_rule_cfg" onSubmit="return checkValue('tb_qosPriRule')">
          <div id="qos_priRuleForm1">
            <table class="tabal_bg" id="tb_qosPriRule" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="qos_priServiceTitle2" class="tabal_left" width="25%">业务名称</td>
                  <td class="tabal_right" width="75%"><select name="qos_priService" size="1" style="width:150px;">
                      <option value="0" selected="selected"></option>
                      <option value="TR069">TR069</option>
                      <option value="VOIP">VOIP</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_priQueueTitle2" class="tabal_left">进入队列</td>
                  <td class="tabal_right"><select name="qos_priQueue" size="1" style="width:150px;">
                      <option value="1" selected="selected">Q1</option>
                      <option value="2">Q2</option>
                      <option value="3">Q3</option>
                      <option value="4">Q4</option>
                    </select></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" id="qos_priRuleApply" name="qos_priRuleApply" value="应用" class="submit">
                    <input type="reset" id="qos_classRuleCancel" value="取消" class="submit" onClick="window.location.reload()">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curPriRuleIndex" id="curPriRuleIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
    <!-- service pri end -->
    <!-- Classification cfg begin -->
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
                      <td><input type="button" value="新增" id="qos_class_add" class="submit" onClick="clickAdd('td_qosClassList');"></td>
                      <td><input type="button" value="删除" id="qos_class_delete" class="submit" onClick="clickRemove('td_qosClassList');"></td>
                      <td><input type="button" value="全删" id="qos_class_deleteAll" class="submit" onClick="clickRemoveAll('td_qosClassList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="td_qosClassList"><form method="post" id="qos_classRuleForm" action="/goform/qos_class_rule_delete">
          <table class="tabal_bg" id="tb_qosClassList" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="10" id="qos_classRuleListHead">数据流分类配置</td>
              </tr>
              <tr class="tabal_title">
                <td width="5%" align="center" id="qos_classNoTitle">数据流序号</td>
                <td width="12%" align="center" id="qos_classQueueTitle">进入队列</td>
                <td width="10%" align="center" id="qos_classDSCPTitle">DSCP/TC标记为</td>
                <td width="10%" align="center" id="qos_class802Title">802.1p标记为</td>
                <td width="5%" align="center" id="qos_classTypeNoTitle">分类</td>
                <td width="12%" align="center" id="qos_classTypeTitle">类型</td>
                <td width="16%" align="center" id="qos_classMinTitle">最小值</td>
                <td width="16%" align="center" id="qos_classMaxTitle">最大值</td>
                <td width="10%" align="center" id="qos_classProtocolTitle">协议类型</td>
                <td width="4%" align="center" ></td>
              </tr>
              <% qos_class_list_sync(); %>
              <!--tr id='recordClass_0_0' class='tabal_01' onclick='selectLine("tb_qosClassRule", this.id);'>
                <td id='qos_classNo_0' rowspan="2" align='center'>1</td>
                <td id='qos_classQueue_0' rowspan="2" align='center'>Q2</td>
                <td id='qos_classDSCP_0' rowspan="2" align='center'>1</td>
                <td id='qos_class802_0' rowspan="2" align='center'>1</td>
                <td id='qos_classTypeNo_0_0' align='center'>1</td>
                <td id='qos_classType_0_0' align='center'>源IP地址</td>
                <td id='qos_classMin_0_0' align='center'>1</td>
                <td id='qos_classMax_0_0' align='center'>1</td>
                <td id='qos_classProtocol_0_0' align='center'>UDP</td>
                <td align='center'><input type='checkbox' name='qos_class_removeFlag' value='0_0'/></td>
              </tr>
              <tr id='recordClass_0_1' class='tabal_01' onclick='selectLine("tb_qosClassRule", this.id);'>
                <td id='qos_classTypeNo_0_1' align='center'>2</td>
                <td id='qos_classType_0_1' align='center'>源端口号</td>
                <td id='qos_classMin_0_1' align='center'>2</td>
                <td id='qos_classMax_0_1' align='center'>2</td>
                <td id='qos_classProtocol_0_1' align='center'>TCP</td>
                <td align='center'><input type='checkbox' name='qos_class_removeFlag' value='0_1'/></td>
              </tr>
              <tr id='recordClass_1_0' class='tabal_01' onclick='selectLine("tb_qosClassRule", this.id);'>
                <td id='qos_classNo_1' rowspan="3" align='center'>2</td>
                <td id='qos_classQueue_1' rowspan="3" align='center'>Q3</td>
                <td id='qos_classDSCP_1' rowspan="3" align='center'>33</td>
                <td id='qos_class802_1' rowspan="3" align='center'>1</td>
                <td id='qos_classTypeNo_1_0' align='center'>1</td>
                <td id='qos_classType_1_0' align='center'>源IP地址</td>
                <td id='qos_classMin_1_0' align='center'>11</td>
                <td id='qos_classMax_1_0' align='center'>111</td>
                <td id='qos_classProtocol_1_0' align='center'>UDP</td>
                <td align='center'><input type='checkbox' name='qos_class_removeFlag' value='1_0'/></td>
              </tr>
              <tr id='recordClass_1_1' class='tabal_01' onclick='selectLine("tb_qosClassRule", this.id);'>
                <td id='qos_classTypeNo_1_1' align='center'>2</td>
                <td id='qos_classType_1_1' align='center'>源端口号</td>
                <td id='qos_classMin_1_1' align='center'>22</td>
                <td id='qos_classMax_1_1' align='center'>222</td>
                <td id='qos_classProtocol_1_1' align='center'>TCP</td>
                <td align='center'><input type='checkbox' name='qos_class_removeFlag' value='1_1'/></td>
              </tr>
              <tr id='recordClass_1_2' class='tabal_01' onclick='selectLine("tb_qosClassRule", this.id);'>
                <td id='qos_classTypeNo_1_2' align='center'>3</td>
                <td id='qos_classType_1_2' align='center'>源端口号</td>
                <td id='qos_classMin_1_2' align='center'>33</td>
                <td id='qos_classMax_1_2' align='center'>333</td>
                <td id='qos_classProtocol_1_2' align='center'>TCP/UDP</td>
                <td align='center'><input type='checkbox' name='qos_class_removeFlag' value='1_2'/></td>
              </tr-->
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td><form id="qos_classRuleForm" method="post" action="/goform/qos_class_rule_cfg" onSubmit="return checkValue('tb_qosClassRule')">
          <div id="qos_classRuleForm1">
            <table class="tabal_bg" id="tb_qosClassRule" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td id="qos_classQueueTitle2" class="tabal_left">进入队列</td>
                  <td class="tabal_right"><select name="qos_classQueue" size="1" style="width:150px;">
                      <option value="1" selected="selected">Q1</option>
                      <option value="2">Q2</option>
                      <option value="3">Q3</option>
                      <option value="4">Q4</option>
                    </select></td>
                </tr>
                <tr id="tr_qosClassDSCP">
                  <td id="qos_classDSCPTitle2" class="tabal_left">DSCP/TC标记为</td>
                  <td class="tabal_right" width="75%"><input name="qos_classDSCP" maxlength="2" type="text" style="width:150px;"/>
                    <strong style="color:#FF0033">*</strong><span class="gray" id="qos_classDSCPTips">&nbsp;(有效范围：0-63)</span></td>
                </tr>
                <tr id="tr_qosClass802">
                  <td id="qos_class802Title2" class="tabal_left">802.1p标记为</td>
                  <td class="tabal_right" width="75%"><input name="qos_class802" maxlength="1" type="text" style="width:150px;"/>
                    <strong style="color:#FF0033">*</strong><span class="gray" id="qos_class802Tips">&nbsp;(有效范围：0-7)</span></td>
                </tr>
                <tr>
                  <td id="qos_classType1Title" class="tabal_left">分类1</td>
                  <td class="tabal_right" width="75%"><select name="qos_classType1" size="1" style="width:150px;" onChange="switchType(1, this.value)">
                      <option value="0" id="qos_classType1_option">请选择</option>
                      <option value="SMAC" id="qos_classType1_option1"selected="selected">源MAC地址</option>
                      <option value="8021P"id="qos_classType1_option2">802.1p</option>
                      <option value="SIP"id="qos_classType1_option3">源IP地址</option>
                      <option value="DIP"id="qos_classType1_option4">目的IP地址</option>
                      <option value="SPORT"id="qos_classType1_option5">源端口号</option>
                      <option value="DPORT"id="qos_classType1_option6">目的端口号</option>
                      <option value="TOS">TOS</option>
                      <option value="DSCP">DSCP</option>
                      <option value="TC">TC</option>
                      <option value="FL">FL</option>
                      <!--option value="WANInterface">网络连接</option-->
                      <option value="LANInterface"id="qos_classType1_option7">LAN侧接口</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_classMin1Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最小值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMinText1">
                      <input name="qos_classMin1" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMinSelect1" style="display: none;">
                      <select name="qos_classMinSelect1" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classMax1Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最大值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMaxText1">
                      <input name="qos_classMax1" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMaxSelect1" style="display: none;">
                      <select name="qos_classMaxSelect1" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classProtocol1Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;协议类型</td>
                  <td class="tabal_right" width="75%"><select name="qos_classProtocol1" size="1" style="width:150px;">
                      <option value="0" id="option_chose">请选择</option>
                      <option value="TCP" selected="selected">TCP</option>
                      <option value="UDP">UDP</option>
                      <option value="ICMP">ICMP</option>
                      <option value="RTP">RTP</option>
                      <option value="TCP,UDP">TCP/UDP</option>
                      <option value="TCP,UDP,ICMP,RTP">ALL</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_classType2Title" class="tabal_left">分类2</td>
                  <td class="tabal_right" width="75%"><select name="qos_classType2" size="1" style="width:150px;" onChange="switchType(2, this.value)">
                      <option value="0" id ="qos_classType2_option">请选择</option>
                      <option value="SMAC" id ="qos_classType2_option1" selected="selected">源MAC地址</option>
                      <option value="8021P"id ="qos_classType2_option2">802.1p</option>
                      <option value="SIP"id ="qos_classType2_option3">源IP地址</option>
                      <option value="DIP"id ="qos_classType2_option4">目的IP地址</option>
                      <option value="SPORT"id ="qos_classType2_option5">源端口号</option>
                      <option value="DPORT" id ="qos_classType2_option6">目的端口号</option>
                      <option value="TOS">TOS</option>
                      <option value="DSCP">DSCP</option>
                      <option value="TC">TC</option>
                      <option value="FL">FL</option>
                      <!--option value="WANInterface">网络连接</option-->
                      <option value="LANInterface"id ="qos_classType2_option7">LAN侧接口</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_classMin2Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最小值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMinText2">
                      <input name="qos_classMin2" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMinSelect2" style="display: none;">
                      <select name="qos_classMinSelect2" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classMax2Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最大值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMaxText2">
                      <input name="qos_classMax2" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMaxSelect2" style="display: none;">
                      <select name="qos_classMaxSelect2" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classProtocol2Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;协议类型</td>
                  <td class="tabal_right" width="75%"><select name="qos_classProtocol2" size="1" style="width:150px;">
                      <option value="0"id="qos_classProtocol2_option">请选择</option>
                      <option value="TCP" selected="selected">TCP</option>
                      <option value="UDP">UDP</option>
                      <option value="ICMP">ICMP</option>
                      <option value="RTP">RTP</option>
                      <option value="TCP,UDP">TCP/UDP</option>
                      <option value="TCP,UDP,ICMP,RTP">ALL</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_classType3Title" class="tabal_left">分类3</td>
                  <td class="tabal_right" width="75%"><select name="qos_classType3" size="1" style="width:150px;" onChange="switchType(3, this.value)">
                      <option value="0"id="qos_classType3_option">请选择</option>
                      <option value="SMAC" id="qos_classType3_option1"selected="selected">源MAC地址</option>
                      <option value="8021P"id="qos_classType3_option2">802.1p</option>
                      <option value="SIP"id="qos_classType3_option3">源IP地址</option>
                      <option value="DIP"id="qos_classType3_option4">目的IP地址</option>
                      <option value="SPORT"id="qos_classType3_option5">源端口号</option>
                      <option value="DPORT"id="qos_classType3_option6">目的端口号</option>
                      <option value="TOS">TOS</option>
                      <option value="DSCP">DSCP</option>
                      <option value="TC">TC</option>
                      <option value="FL">FL</option>
                      <!--option value="WANInterface">网络连接</option-->
                      <option value="LANInterface"id="qos_classType3_option7">LAN侧接口</option>
                    </select></td>
                </tr>
                <tr>
                  <td id="qos_classMin3Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最小值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMinText3">
                      <input name="qos_classMin3" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMinSelect3" style="display: none;">
                      <select name="qos_classMinSelect3" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classMax3Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;最大值</td>
                  <td class="tabal_right" width="75%"><div id="div_qosMaxText3">
                      <input name="qos_classMax3" maxlength="32" type="text" style="width:150px;"/>
                    </div>
                    <div id="div_qosMaxSelect3" style="display: none;">
                      <select name="qos_classMaxSelect3" size="1" style="width:150px;">
                      </select>
                    </div></td>
                </tr>
                <tr>
                  <td id="qos_classProtocol3Title2" class="tabal_left">&nbsp;&nbsp;&nbsp;&nbsp;协议类型</td>
                  <td class="tabal_right" width="75%"><select name="qos_classProtocol3" size="1" style="width:150px;">
                      <option value="0"id="qos_classProtocol3_option">请选择</option>
                      <option value="TCP" selected="selected">TCP</option>
                      <option value="UDP">UDP</option>
                      <option value="ICMP">ICMP</option>
                      <option value="RTP">RTP</option>
                      <option value="TCP,UDP">TCP/UDP</option>
                      <option value="TCP,UDP,ICMP,RTP">ALL</option>
                    </select></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" id="qos_classRuleApply" name="qos_classRuleApply" value="应用" class="submit">
                    <input type="reset" name="qos_classRuleCancel2" id="qos_classRuleCancel2" value="取消" class="submit" onClick="window.location.reload()">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curClassRuleIndex" id="curClassRuleIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			updateForms();
			</script>
        </form></td>
    </tr>
    <!-- Classification cfg end -->
    <tr>
      <td><form method="post" action="/goform/qos_enable">
          <table class="tabal_bg" id="tb_qosEnable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td width="25%" id="qos_cfgApplyTitle" class="tabal_left">QoS配置应用</td>
                <td class="tabal_right"><input type="submit" id="qos_enableTitle" value="应用" class="submit" onClick="qosEnable(1)">
                  <input type="submit" id="qos_dixableTitle" value="禁用" class="submit" onClick="qosEnable(0)">
                  <input type="hidden" name="qosEnableFlag" value="0"></td>
              </tr>
            </tbody>
          </table>
        </form></td>
    </tr>
  </tbody>
</table>
</body>
