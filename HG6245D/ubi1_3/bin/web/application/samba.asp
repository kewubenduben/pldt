<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Samba</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var SambasizeSync = '<% sambasize_sync(); %>';
var SambaEnableSync = '<% samba_enable_sync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var pf_ruleSum;
var previousTR = null;

var samba_password_all = '<% getCfgGeneral(1, "samba_password_all"); %>';
var samba_password_all_index = samba_password_all.split("|");

var usb_mnt_used = '<% getCfgGeneral(1, "usb_mnt_used"); %>';
var usb_mnt_used_index = usb_mnt_used.split("|");

var samba_dir_all = '<% getCfgGeneral(1, "samba_dir_all"); %>';
var samba_dir_index = samba_dir_all.split("|");
var dirlist_part_num = '<% getCfgGeneral(1, "dirlist_part_num"); %>';

function initTranslation()
{
	var e = document.getElementById("sambaPrompt");
	e.innerHTML = _("sambaPrompt");
	e = document.getElementById("sambaenable_title");
	e.innerHTML = _("sambaenable_title");
	e = document.getElementById("usb_pathTitle");
	e.innerHTML = _("usb_pathTitle");
	
	e = document.getElementById("enable");
	e.innerHTML = _("enable");
	e = document.getElementById("disable");
	e.innerHTML = _("disable");
	e = document.getElementById("url_apply1");
	e.value = _("firewall_apply");
	e = document.getElementById("url_cancel1");
	e.value = _("firewall_cancel");
	/*
	e = document.getElementById("fw_add");
	e.innerHTML = _("fw_add");
	e = document.getElementById("fw_delete");
	e.innerHTML = _("fw_delete");
	e = document.getElementById("fw_deleteAll");
	e.innerHTML = _("fw_deleteAll");
	e = document.getElementById("samabListHead");
	e.innerHTML = _("samabListHead");
	e = document.getElementById("samba_username");
	e.innerHTML = _("samba_username");
	e = document.getElementById("samba_directory");
	e.innerHTML = _("samba_directory");
	e = document.getElementById("samba_directoryTitle");
	e.innerHTML = _("samba_directory");
	e = document.getElementById("samba_useranmeTitle");
	e.innerHTML = _("samba_username");
	e = document.getElementById("samba_directoryTitle1");
	e.innerHTML = _("samba_directory");
	e = document.getElementById("samba_passwordTitle1");
	e.innerHTML = _("samba_passwordTitle");
	e = document.getElementById("samba_useranmeTitle1");
	e.innerHTML = _("samba_username");
	e = document.getElementById("samba_state");
	e.innerHTML = _("samba_state");
	e = document.getElementById("url_apply");
	e.value = _("firewall_apply");
	e = document.getElementById("url_cancel2");
	e.value = _("firewall_cancel");
	e = document.getElementById("url_apply1");
	e.value = _("firewall_apply");
	e = document.getElementById("url_cancel1");
	e.value = _("firewall_cancel");*/
	
}
function LoadFrame()
{ 
	initTranslation();

	var samba_enable = '<% getCfgGeneral(1, "samba_enable"); %>';	

	//modify by wuxj, 20170614, all version of pldt samba read only
//	var DEV_TYPE = '<% getCfgGeneral(1, "DEV_TYPE"); %>';
//	if(DEV_TYPE == '04F4G' && ispName == '8')	//pldt f4g
	if(ispName == '8')	//pldt f4g
	{
		setDisplay('tr_usb_path', 'none');
		setDisplay('tb_submit', 'none');
		getElement('samba_enable').disabled = true;
		samba_enable = 'disable';
	}

	var sambaenableNode = document.getElementsByName("samba_enable");	
	var sambadir = document.getElementById("samba_directory");
	for(var i = 0;i<sambaenableNode.length;i++)
	{
		if(sambaenableNode[i].value == samba_enable)
		{
			sambaenableNode[i].checked = true;
			break;
		}
	}
/*	
	pf_ruleSum  = '<% getCfgGeneral(1, "samba_size"); %>';
	var samba_ruletable = getElement("samba_ruletable");


	for(i = 0; i < dirlist_part_num; i++ )
	{
		if(samba_dir_all[i] != "")
		{
			sambadir.options[sambadir.length] = new Option(samba_dir_index[i], samba_dir_index[i]);
		}
	}

	if(pf_ruleSum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("samba_ruletable").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
    //alert("pf_ruleSum = " + pf_ruleSum);*/
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen > 7)
	{		
//   		alert("最多只能创建6条规则!");
 		alert(_("samba_mostRulesAlert"));
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
	document.getElementById("samba_username").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//新建
		{					
			document.getElementById("samba_username").value = "";
			document.getElementById("samba_password").value = "";
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			//alert("temp = " + temp);
			//var haha = "pf_privateport_" + temp;
			//alert("haha = " + haha);
			//var a = getElement("pf_publicport_0");
			//document.getElementById("url_port").value = document.getElementById("url_port_" + temp).innerHTML;	
			document.getElementById("samba_username").value = html_decode(document.getElementById("samba_username_" + temp).innerHTML);
			document.getElementById("samba_password").value = samba_password_all_index[temp];
			document.getElementById("samba_directory").value = html_decode(document.getElementById("samba_shareDir_" + temp).innerHTML);
			

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
	var checkNodes = getElement('url_removeFlag');
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

function clickRemoveAll(tabTitle)
{
	if(pf_ruleSum == 0)
	{				
//  		alert("当前没有规则，不能删除!");
   		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('url_removeFlag');
	for(var i = 0; i < checkNodes.length; i++)
	{
		checkNodes[i].checked = true;
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

	document.location = "/goform/samba_deleteall" + "?csrftoken=" + getCsrftoken();	
}

function checkValue()
{
/*	var index = 0;
	var tab = document.getElementById("fw_ruleList").getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if (lastRow.id == 'record_new')	
	{
		for(index = 0; index < pf_ruleSum; index++)
		{	
			if(usb_mnt_used_index[index] == document.getElementById("samba_directory").value)
			{
				alert(_("The directory you select had been used!"));
				return false;
			}
			
		}
	}
	var username_node = document.getElementById("samba_username");
	var pwd_node = document.getElementById("samba_password");

	if (!CheckNotNull(username_node.value)) 
	{					
		alert(_("Please enter username!"));
		username_node.value = username_node.defaultValue;
		username_node.focus();
		return false;
	}
	if (!CheckNotNull(pwd_node.value)) 
	{					
		alert(_("Please enter password!"));
		pwd_node.value = pwd_node.defaultValue;
		pwd_node.focus();
		return false;
	}*/
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
              <td id="sambaPrompt" style="padding-left: 10px;" class="title_01" width="100%"><!--您在本页面可以配置samba功能。--></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="url_enable" action="/goform/samba_enable_cfg">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="sambaenable_title" align="left" width="25%"><!--Samba使能开关--></td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="samba_enable" type="radio">
          <font id="enable">
          <!--启用-->
          </font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="samba_enable" type="radio">
          <font id="disable">
          <!--禁用-->
          </font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
      <tr id='tr_usb_path'>
        <td class="tabal_left" width="25%" id="usb_pathTitle"><!--USB Partition:--></td>
        <td class="tabal_right"><% getCfgGeneral(1, "usb_path"); %>
        </td>
      </tr>
  </table>
  <table id='tb_submit' class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="url_apply1">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Cancel" id="url_cancel1" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<!--table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
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
                      <td><input type="button" value="Delete ALL" id="fw_deleteAll" class="submit" onClick="clickRemoveAll('fw_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/samba_delete">
          <table class="tabal_bg" id = "samba_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="samabListHead"></td>
              </tr>
              <tr class="tabal_title">
				<td width="10%" align="center" id="sambaid">ID</td>
		        <td width="25%" align="center" id="samba_useranmeTitle">Username</td>
		        <td width="25%" align="center" id="samba_directoryTitle">Directory</td>
		        <td width="35%" align="center" id="samba_state">State</td>
		        <td width="2%" align="center" ></td>  
              </tr>

				<% samba_sync(  ) ; %>
              
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/samba_cfg" onSubmit="return checkValue()">
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
                                    <td id="samba_useranmeTitle1" class="tabal_left" width="25%">Username:</td>
                                    <td class="tabal_right" width="75%"><input name="samba_username" id="samba_username" size="32" maxlength=32 style="width: 150px;" type="text">
                                      <span ></span></td> 
                                  </tr>
                                     <tr style="">
                                    <td id="samba_passwordTitle1" class="tabal_left" width="25%">Password</td>
                                    <td class="tabal_right" width="75%"><input name="samba_password" id="samba_password" size="32"  maxlength=32 style="width: 150px;" type="text">
                                      </td>
                                  </tr>
                                  <tr style="">
                                    <td id="samba_directoryTitle1" class="tabal_left" width="25%">Directory</td>
                                    <td class="tabal_right" width="75%"><select id="samba_directory" name="samba_directory" size="1" style="width:35%" value=3>
         																</select>
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
                  <td class="tabal_submit"><input type="submit" value="应用" name="url_apply" id="url_apply" class="submit">
                    <input type="reset" value="取消" name="url_cancel2" id="url_cancel2" class="submit" onClick="window.location.reload();">
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
</table-->
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
