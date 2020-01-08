<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Account_admin</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("account", lang);

var previousTR = null;

//loadpage
var get_user_list_sync = '<% get_user_list_sync(); %>';
var userSum = '<% getCfgGeneral(1, "userSum");%>';

function initTranslation()
{
	var e = document.getElementById("account_prompt");
	e.innerHTML = _("account_prompt");
	e = document.getElementById("accountSelf_pwdTips");
	e.innerHTML = _("accountSelf_pwdTips");

	e = document.getElementById("ac_add");
	e.value = _("ac_add");
    e = document.getElementById("ac_del");
	e.value = _("ac_del");
    e = document.getElementById("name_title");
	e.innerHTML = _("name_title");
    e = document.getElementById("ac_name");
	e.innerHTML = _("name_title");
    e = document.getElementById("ac_pwd");
	e.innerHTML = _("ac_pwd");
	e = document.getElementById("ac_pwd2");
	e.innerHTML = _("ac_pwd2");
	e = document.getElementById("accountNameTips");
	e.innerHTML = _("accountNameTips");
	
    e = document.getElementById("cancelValue");
	e.value = _("cancelValue");
    e = document.getElementById("btnApply1");
	e.value = _("btnApply1");
}


function LoadFrame()
{ 
	initTranslation();
	if(ispNameCode == '5')	//AIS
	{
		setDisplay("tb_add_delete", "none");
	}
	var pwdNode;
	if(ispNameCode == '15')//GLOBE要求密文显示
	{
		pwdNode = getElement("account_pwdText");
		pwdNode.parentNode.removeChild(pwdNode);
		
		pwdNode = getElement("account_pwd2Text");
		pwdNode.parentNode.removeChild(pwdNode);
	}
	else
	{
		pwdNode = getElement("account_pwdPwd");
		pwdNode.parentNode.removeChild(pwdNode);
		
		pwdNode = getElement("account_pwd2Pwd");
		pwdNode.parentNode.removeChild(pwdNode);
	}
//	var userListLength = document.getElementById("userListTable").rows.length;
	var userListTable = document.getElementById("userListTable");
	
	if(userSum > 0)
	{	
		selectLine("record_0");
		setDisplay("ConfigForm1", "");
	}
	else
	{	
		setDisplay("ConfigForm1", "none");
	}
}
/*-----------------------adapte funcion--------------------------*/
function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');

	var row,col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];
	
	if(rowLen - 1 >= 8)	//max 8 common users
	{
 		alert(_("user_most8RulesAlert"));
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
		row.attachEvent("onclick", function(){selectLine("record_new");});
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
	document.getElementById("account_user").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')	//新建
		{
			document.getElementById("account_user").value = "";
			document.getElementById("account_user").disabled = 0;
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//原无用户
        {
        }
		else
		{
			document.getElementById("account_user").value = html_decode(getElement("user_" + temp).innerHTML);
			if(ispNameCode != '5')	//not AIS
			{
				document.getElementById("account_user").disabled = 1;
			}
			
			getElement("account_pwd").value = "";
			getElement("account_pwd2").value = "";
			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
		//标志当前编辑规则的id
		getElement("curIndex").value = temp;
	}	 
}
function clickRemove(tabTitle)
{
	if(userSum == 0)
	{			
   		//alert("当前没有普通用户，不能删除!");
		alert(_("no_count_alert"));
   		return;
	}
	var checkNodes = getElement('user_removeFlag');
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
		alert(_("selcet_alert"));
		return ;
	}
	        
	//if(confirm("确认删除所选用户?") == false)
	if(confirm(_("confirm_dele")) == false)
    	return;
	
	document.getElementById("userListForm").submit();
	
}
function checkValue()
{
	var accountUserNode = getElement("account_user");
	if(!/^[\w!@#$%\^&*()`~,.\?\+\=-]{1,32}$/.test(accountUserNode.value))
	{
		alert(_("accountSelf_userIllegalAlert"));
		accountUserNode.value = accountUserNode.defaultValue;
		accountUserNode.focus();
		return false;
	}
	
	var accountPwdNode = getElement("account_pwd");
	if(!/^[\w!@#$%\^&*()`~,.\?\+\=-]{8,32}$/.test(accountPwdNode.value))
	{
		alert(_("accountSelf_newPwdIllegalAlert"));
		accountPwdNode.value = accountPwdNode.defaultValue;
		accountPwdNode.focus();
		return false;
	}
	
	if(accountPwdNode.value != getElement("account_pwd2").value)
	{
		//alert("两次输入的密码不相同，请重新设置!");
		alert(_("unequal_alert"));
		getElement("account_pwd2").focus();
		getElement("account_pwd2").select();
		return false;
	}
	else
	{
		return true;
	}
}

function CancelConfig()
{
	getElement("account_pwd").value = "";
	getElement("account_pwd2").value = "";
}
</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td style="padding-left: 10px;" class="title_01" id="account_prompt" width="100%"></td>
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
      <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td height="22" width="7"></td>
              <td align="center" valign="bottom" width="120"></td>
              <td width="7"></td>
              <td align="right"><table id="tb_add_delete" border="0" cellpadding="1" cellspacing="0">
                  <tbody>
                    <tr>
                      <td><input class="submit" id="ac_add" value="Add" onclick="clickAdd('td_userList');" type="button"></td>
                      <td><input class="submit" id="ac_del" value="Delete" onclick="clickRemove('td_userList');" type="button"></td>
                      <td width="3"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="td_userList"><form id="userListForm" method="post" action="/goform/delUser">
          <table class="tabal_bg" id="userListTable" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_title">
                <td id="name_title" width="75%">Username</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <!--script language="JavaScript" type="text/javascript">
            if(userArray.length == 0)
        	{
				document.write('<TR id="record_no"' + ' class="tabal_01" >');
				document.write('<TD align="center">--</TD>');
				document.write('<TD align="center">--</TD>');
				document.write('</TR>');
        	}
        	else
			{
				for (var i = 0;i < userArray.length; i++)
				{
					document.write('<TR id="record_' + i + '" class="tabal_01" onclick="selectLine(this.id);">');
					document.write('<TD align="center">' + '<input type="checkbox" name="rml"' + ' value="' 
				 + userArray[i] + '" </TD>');
				 
					document.write('<TD align="center">' + userArray[i] + '</TD>');				
					document.write('</TR>');
				}
        	}
            </script-->
            <% user_list_sync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/setUser" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td ><div id="div_account_admin">
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                  <tr id="tr_user" style="">
                                    <td class="tabal_left" id="ac_name" width="25%">Username</td>
                                    <td class="tabal_right" width="75%"><input name="account_user" id="account_user" size="15" maxlength="32" style="width: 150px;" type="text">
                                    <strong style="color:#FF0033">*</strong><span class="gray" id="accountNameTips">(1-32 Characters)</span></td>
                                  </tr>
                                  <tr id="tr_pwd" style="">
                                    <td class="tabal_left" id="ac_pwd" width="25%">New Password</td>
                                    <td class="tabal_right" width="75%"><input name="account_pwd" id="account_pwdText" type="text" autocomplete="off" size="15" maxlength="32" style="width: 150px;">
                                    <input name="account_pwd" id="account_pwdPwd" type="password" autocomplete="off" size="15" maxlength="32" style="width: 150px;">
                                      <strong style="color:#FF0033">*</strong><span id="accountSelf_pwdTips" class="gray"> </span></td>
                                  </tr>
                                  <tr id="tr_pwd2" style="">
                                    <td class="tabal_left" id="ac_pwd2" width="25%">Password Confirm</td>
                                    <td class="tabal_right" width="75%"><input name="account_pwd2" id="account_pwd2Text" type="text" autocomplete="off" size="15" maxlength="32" style="width: 150px;">
                                    <input name="account_pwd2" id="account_pwd2Pwd" type="password" autocomplete="off" size="15" maxlength="32" style="width: 150px;">
                                    <strong style="color:#FF0033">*</strong></td>
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
                  <td class="tabal_submit"><input name="btnApply1" id="btnApply1" class="submit" value="Apply" type="submit">
                    <input name="cancelValue" id="cancelValue" class="submit" value="Cancel" type="button">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curIndex" id="curIndex" value="0">
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
