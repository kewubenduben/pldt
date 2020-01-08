
function initTranslation()
{
	var e = document.getElementById("dmz_prompt");
	e.innerHTML = _("dmz_prompt");

	e = document.getElementById("dmzEnable_title");
	e.innerHTML = _("dmzEnable_title");
	e = document.getElementById("dmz_enable");
	e.innerHTML = _("dmz_enable");
	e = document.getElementById("dmz_disable");
	e.innerHTML = _("dmz_disable");
	e = document.getElementById("dmz_auto");
	e.innerHTML = _("dmz_auto");
	e = document.getElementById("dmz_hostTips");
	e.innerHTML = _("dmz_hostTips");
	e = document.getElementById("dmz_apply");
	e.value = _("dmz_apply");
	e = document.getElementById("dmz_cancel");
	e.value = _("dmz_cancel");
	
	e = document.getElementById("dmz_add");
	e.value = _("dmz_add");
	e = document.getElementById("dmz_delete");
	e.value = _("dmz_delete");
	e = document.getElementById("dmz_deleteAll");
	e.value = _("dmz_deleteAll");
	e = document.getElementById("dmzRuleListHead");
	e.innerHTML = _("dmzRuleListHead");
	e = document.getElementById("ip_title");
	e.innerHTML = _("dmz_hostTips");
	e = document.getElementById("ip_title2");
	e.innerHTML = _("dmz_hostTips");
	e = document.getElementById("wanname_title");
	e.innerHTML = _("dmz_wannameTips");
	e = document.getElementById("wanname_title2");
	e.innerHTML = _("dmz_wannameTips");	

	e = document.getElementById("dmz_apply_wan");
	e.value = _("dmz_apply");
	e = document.getElementById("dmz_cancel_wan");
	e.value = _("dmz_cancel");
}
function initValueDMZWan()
{
	var dmz_ruletable = getElement("dmz_ruletable");
	var dmz_wannamenode  = document.getElementById("dmz_wanname");

	for(var i = 0; i < wan_ruleSum; i++ )
	{
		if(wannameArray[i].search("INTERNET") >= 0)
		{
			if((wannameArray[i].search("_B_") ) < 0)/*非桥接wan*/
			{
				dmz_wannamenode.options[dmz_wannamenode.length] = new Option(wannameArray[i], wannameArray[i]);
			}
		}
		else if(ispNameCode == 5 && (wannameArray[i].search("aisfibre_ipv4_pppoe") >= 0))	//HGU X_AIS
		{
			dmz_wannamenode.options[dmz_wannamenode.length] = new Option(wannameArray[i], wannameArray[i]);
		}
	}

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("dmz_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}

}
function initValueDMZ()
{
	var dmzEnable = document.getElementsByName("DMZEnable");	
	for(var i = 0;i<dmzEnable.length;i++)
	{
		if(dmzEnable[i].value == dmz_enable)
		{
			dmzEnable[i].checked = true;
			break;
		}
	}
	if(ispNameCode == 9 ) /*罗马尼亚版本不显示auto*/
	{
		document.getElementById("DMZ_auto_radio").style.visibility = "hidden";
		document.getElementById("dmz_auto").style.visibility = "hidden";
	}
}
function initValue()
{
	initTranslation();

	if(multiRouteWanFlag == '1')
	{
		initValueDMZWan();
		setDisplay('dmz_wan', '');
		setDisplay('div_dmz', 'none');
	}
	else
	{
		initValueDMZ();
		setDisplay('dmz_wan', 'none');
		setDisplay('div_dmz', '');
	}	
}

function CheckValue()
{	
	var dmz_hostip = document.getElementById("dmz_ip");
    var dmzEnable = document.getElementsByName("DMZEnable");

	if(dmzEnable[0].checked == true)
	{
		if (!CheckNotNull(dmz_hostip.value)) 
		{					
			//alert(_("请输入主机IP!"));
			alert(_("dmz_noipalert"));
			dmz_hostip.value = dmz_hostip.defaultValue;
			dmz_hostip.focus();
			return false;
		}

		if(!validateIP(dmz_hostip.value))
		{
			//alert(_("您输入的主机IP不合法!"));
			alert(_("dmz_ipillegalalert"));
			dmz_hostip.value = dmz_hostip.defaultValue;
			dmz_hostip.focus();
			return false;
	    }
	}
	return true;
}
	
function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 4 + 1)
	{		
  		alert(_("dmz_most4rulealert"));
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
	document.getElementById("dmz_host_ip").focus();
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
			//document.getElementById("url_port").value = "";
			document.getElementById("dmz_host_ip").value = "";							
			setLineHighLight(previousTR, objTR);
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("dmz_host_ip").value = html_decode(document.getElementById("dmz_hostip_" + temp).innerHTML);
			document.getElementById("dmz_wanname").value = html_decode(document.getElementById("dmz_wanname_" + temp).innerHTML);
			setLineHighLight(previousTR, objTR);	
			previousTR = objTR;
		}	

		//标志当前编辑规则的id
		document.getElementById("fw_curIndex").value = temp;		
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
	var checkNodes = getElement('dmz_removeFlag');
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
	var checkNodes = getElement('dmz_removeFlag');
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
	document.location = "/goform/dmz_wan_cfgdelete_all" + "?csrftoken=" + getCsrftoken();
}

function CheckValueDMZWan()
{
	var dmz_host_ip = document.getElementById("dmz_host_ip");
	var dmz_wanname = document.getElementById("dmz_wanname");

	if(!validateIP(dmz_host_ip.value))
	{
		alert(_("fw_ipIllegalAlert"));
		dmz_host_ip.value = dmz_host_ip.defaultValue;
		dmz_host_ip.focus();
		return false;
	}

	var i = 0;
	for(i = 0; i < pf_ruleSum; i++)
	{
		if(currentline == 'new') /*修改wan*/
		{
			if(dmz_host_ip.value == document.getElementById("dmz_hostip_" + i).innerHTML)
			{
				alert(_("dmz_iprepeat"));
				return false;
			}

			if(dmz_wanname .value == document.getElementById("dmz_wanname_" + i).innerHTML)
			{
				alert(_("dmz_wannamerepeat"));
				return false;
			}
		}
		else /*新增 与所有规则比较*/
		{
			if(currentline != i) /* 不与自身比较*/
			{
				if(dmz_host_ip.value == document.getElementById("dmz_hostip_" + i).innerHTML)
				{
					alert(_("dmz_iprepeat"));
					return false;
				}

				if(dmz_wanname.value == document.getElementById("dmz_wanname_" + i).innerHTML)
				{
					alert(_("dmz_wannamerepeat"));
					return false;
				}
			}
		}
	}
	return true;	
}