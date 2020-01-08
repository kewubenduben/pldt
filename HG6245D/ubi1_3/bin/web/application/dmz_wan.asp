<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css">
<title>DMZ</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("dmz", lang);

var get_dmzsizesync = '<% get_dmz_wan_sizesync(); %>';
var wanNameSync = '<% wanNameSync(); %>';	
var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
var wan_ruleSum = '<% getCfgGeneral(1, "wan_size"); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

var wannameArray = wanname_all.split("|");
var pf_ruleSum  = '<% getCfgGeneral(1, "dmz_size"); %>';
var currentline;
var previousTR = null;

function initTranslation()
{
	var e = document.getElementById("dmz_prompt");
	e.innerHTML = _("dmz_prompt");
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

	e = document.getElementById("dmz_apply");
	e.value = _("dmz_apply");
	e = document.getElementById("dmz_cancel");
	e.value = _("dmz_cancel");
}

function LoadFrame()
{ 
	initTranslation();

	var dmz_ruletable = getElement("dmz_ruletable");
	var i;
	var dmz_wannamenode  = document.getElementById("dmz_wanname");

	for(i = 0; i < wan_ruleSum; i++ )
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
    //alert("pf_ruleSum = " + pf_ruleSum);
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
			document.getElementById("dmz_host_ip").value = document.getElementById("dmz_hostip_" + temp).innerHTML;
			document.getElementById("dmz_wanname").value = document.getElementById("dmz_wanname_" + temp).innerHTML;
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
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('dmz_removeFlag');
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
	getElement("mf_ruleForm").submit();
	
}

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{				
//  		alert("当前没有规则，不能删除!");
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
//	if(confirm("你确认删除所选规则?") == false)
	if(confirm(_("fw_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}

	document.location = "/goform/dmz_wan_cfgdelete_all";
	
}

function checkValue()
{
	var dmz_host_ip = document.getElementById("dmz_host_ip");
	var dmz_wanname = document.getElementById("dmz_wanname");

	if(!validateIP(dmz_host_ip.value))
	{
//		alert("请输入合法ip!");
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



</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dmz_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
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
                      <td><input type="button" value="Add" id="dmz_add" class="submit" onClick="clickAdd('mf_ruleList');"></td>
                      <td><input type="button" value="Delete" id="dmz_delete" class="submit" onClick="clickRemove('mf_ruleList');"></td>
                      <td><input type="button" value="Delete All" id="dmz_deleteAll" class="submit" onClick="clickRemoveAll('mf_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="mf_ruleList"><form method="post" id="mf_ruleForm" action="/goform/dmz_wan_cfgdelete">
          <table class="tabal_bg" id = "dmz_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="dmzRuleListHead"></td>
              </tr>
              <tr class="tabal_title">
				<td width="15%" align="center" >ID</td>
		        <td width="35%" align="center" id="ip_title">Host IP</td>
		        <td width="35%" align="center" id="wanname_title">WAN Name</td>
		        <td width="15%" align="center" ></td>  
              </tr>

				<% dmz_wan_Sync(  ) ; %>
              
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/dmz_wan_Cfg" onSubmit="return checkValue()">
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
                                    <td id="ip_title2" class="tabal_left" width="25%">Host IP</td>
                                    <td class="tabal_right" width="75%"><input name="dmz_host_ip" id="dmz_host_ip" size="16"  style="width: 150px;" type="text">
                                      </td>
                                  </tr>
                                  <tr style="">
                                    <td id="wanname_title2" class="tabal_left" width="25%">WAN Name</td>
                                    <td class="tabal_right" width="75%"><select name="dmz_wanname" id="dmz_wanname" size="1" style="width:40%" >
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
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dmz_apply" id="dmz_apply" class="submit">
                    <input type="reset" value="Cancel" name="dmz_cancel" id="dmz_cancel" class="submit" onClick="window.location.reload();">
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
</body>


