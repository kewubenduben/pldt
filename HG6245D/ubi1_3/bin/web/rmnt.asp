<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="./lang/b28n.js"></script>
<script type="text/javascript" src="./js/utils.js"></script>
<script type="text/javascript" src="./js/checkValue.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<title>RMNT Setting</title>
<style type="text/css">
.text {font-family: "Arial";font-size: 12px;color: #333333;}
</style>
<script language="JavaScript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);
var RemoteControlSync = '<% RemoteControlSync(); %>';
function onClickConBtn()
{
	var thisForm = document.forms[0];
	thisForm.recontrol_check.value = 1;
	if(CheckValue() == 1)
	{
		thisForm.submit();
	}
	
}

function onClickDisBtn()
{
	var thisForm = document.forms[0];
	thisForm.recontrol_check.value = 0;
	if(CheckValue() == 1)
	{
		thisForm.submit();
	}
}

var code="" ; //在全局 定义验证码
function createCode(){ 
code = "";
var codeLength = 5;//验证码的长度
var checkCode = document.getElementById("checkCode");
checkCode.value = "";
var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');

for(var i=0;i<codeLength;i++) {
   var charIndex = Math.floor(Math.random()*32);
   code +=selectChar[charIndex];
}
if(code.length != codeLength){
   createCode();
}
document.getElementById("checkCode").innerHTML = code;
}

function CheckValue()
{
	var jiaoyanma = document.getElementById("jiaoyanma");
	var checkCode = document.getElementById("checkCode");
	if(jiaoyanma.value.toUpperCase() != checkCode.innerHTML)
	{
		alert(_("validationError"));
		createCode();
		jiaoyanma.focus();
		return 0;
	}
	else
	{
		return 1;
	}
}
function initValue()
{
	var rmnt_set_complete = '<% getCfgGeneral(1, "rmnt_set_complete"); %>';
	var set_complete = document.getElementById("set_complete");
	if(rmnt_set_complete == '1')
	{
		set_complete.innerHTML = "Enable Complete";
	}
	else if(rmnt_set_complete == '0')
	{
		set_complete.innerHTML = "Disable Complete";
	}
	else
	{
		set_complete.innerHTML = "";
	}	
	createCode();
}

</script>
<STYLE type="text/css">
.STYLE1 {
	color: #FF0000;
	text-align: center;	
	font-size: 13px;
}

.STYLE7 {
    font-family:Arial;  
    font-style:italic;  
    font-weight:bold;  
    text-align: center;
    border:0;  
    letter-spacing:10px;  
    font-size: 15px;
    color:blue;
	background-color:#999999;
}
</style>
</head>
<body onload="initValue()">
<form method="POST" action="/goform/setRemoteControl_3BB" name="TripleTWizardRmntSaveForm" onSubmit="return CheckValue()">
   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
         <tbody><tr><td align="center" valign="middle" bgcolor="#FFFFFF">
                 <table width="747" height="591" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                      <tbody><tr><td valign="top" background="images/bg_rmnt.gif">
                          <table width="747" border="0" cellpadding="0" cellspacing="0">
                                 <tbody><tr><td height="221" valign="top">
                                        <table width="747" border="0" cellpadding="0" cellspacing="0">
                                              <tbody><tr><td width="663">&nbsp;</td>
                                                   <td width="84"><!--a href="http://192.168.1.1/" target="_parent">
                                                       <img src="images/help.gif" border="0" width="84" height="75">
                                                    </a--></td></tr>
                                               </tbody>
                                       </table></td></tr>
                                       <tr><td>
                                       <table width="747" height="30" border="0" cellpadding="0" cellspacing="0">
                                               <tbody><tr><td width="300"></td>
                                                    <td width="189" align="center" class="text">
                                                       <font size="3" style="FONT-SIZE:15pt;FONT-FAMILY:Arial, Helvetica, sans-serif">Remote Management</font></td>
                                                     <td width="258"></td>
                                                      </tr>
                                                 </tbody>
                                        </table></td></tr>

										<table width="747" height="40" border="0" cellpadding="0" cellspacing="0">
			                             <tbody>
											  <tr> <td width="335" align ="right">Validate Code:&nbsp;&nbsp;&nbsp;</td>
												 	<td width="134" height="25" align="left"><input name="jiaoyanma" id="jiaoyanma" onpaste="return false;" oncontextmenu="return false;" value="" type="text"></td>
													<td width="278"></td></tr>
	 				                          <tr><td width="335" align="right"> </td>
	 				                         	 <td width="134" height="25" align="center" id="checkCode" name="checkCode" oncopy="return false;" oncontextmenu="return false;" onmousedown="return false;" onmouseup="return false;" class="STYLE7"></td>
												 <td width="278">&nbsp;&nbsp;<input type="button" align="left"  value="Refresh" class="button" onClick="createCode();"></td></tr>
			                             </tbody>
			                             </table>
 
                                        <table width="747" height="35" border="0" cellpadding="0" cellspacing="0">
                                                 <tbody><tr><td width="335"></td>
                                                 <td width="67" align="left">
                                                       <input type="BUTTON" name="wizardRmntDisable" value="Disable" class="text" onclick="onClickDisBtn();"></td>
                                                 <td width="67" align="right" valign="middle">
                                                       <input type="BUTTON" name="wizardRmntEnable" value="&nbsp;Enable" class="text" onclick="onClickConBtn();">
                                                       <input type="HIDDEN" name="recontrol_check" value="0"></td>
                                                
                                                  <td width="278" align="center" valign="middle"> </td></tr>
                                                 
                                                 </tbody>
                                        </table>
                                        
                                        <table width="747" height="30" border="0" cellpadding="0" cellspacing="0">
			                             <tbody><tr><td width="300"></td>
			                             </tbody>
			                             </table>

			                             <table width="747" height="30" border="0" cellpadding="0" cellspacing="0">
			                             <tbody><tr><td width="300"></td>
			                             </tbody>
			                             </table>
                                        
                                         <table width="747" height="45" border="0" cellpadding="0" cellspacing="0">
			                             <tbody><tr><td width="300"></td>
			                                    <td width="189" align="center" id="set_complete" class="STYLE1" valign="middle"></td>
			                                    <td width="258" height="30"></td></tr>
			                             </tbody>
			                             </table>
			                             
                                   </tbody>
                             </table>

                             </td></tr>
                             </tbody></table></td></tr>
              </tbody>
        </table>
  </form>
 </body>
 </html>
       
                                    
