<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<script type="text/javascript" src="./lang/b28n.js"></script>
<script type="text/javascript" src="./js/utils.js"></script>
<script type="text/javascript" src="./js/checkValue.js"></script>
<title>PPPOE Settings</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var GetWANsizeSync = '<% GetPppoeSync(); %>';	

function doPageclose()
{
	if (window.navigator.userAgent.indexOf("MSIE")>=1)
	{
		window.close();
		return;
	}
	if (window.navigator.userAgent.indexOf("Firefox")>=1)
	{
		alert("Please close the browser by yourself!");
	}
	if (window.navigator.userAgent.indexOf("Safari")>=1)
	{
		window.opener=self;
		window.open('','_self');
		window.close();
		return;
	}
	//others
	window.open('','_parent','');
	window.close();
}

function CheckValue()
{
		var pppoeUserNode = document.getElementById("pppoeUser");
		if (!CheckNotNull(pppoeUserNode.value)) 
		{					
			alert(_("wPppoeCon_userNullAlert"));
			pppoeUserNode.value = pppoeUserNode.defaultValue;
			pppoeUserNode.focus();
			return false;
		}
		
		var pppoePassNode = document.getElementById("pppoePass");
		if (!CheckNotNull(pppoePassNode.value)) 
		{					
			alert(_("wPppoeCon_pwdNullAlert"));
			pppoePassNode.value = pppoePassNode.defaultValue;
			pppoePassNode.focus();
			return false;
		} 

		var jiaoyanma = document.getElementById("jiaoyanma");
		var checkCode = document.getElementById("checkCode");
		if(jiaoyanma.value.toUpperCase() != checkCode.innerHTML)
		{
			alert(_("validationError"));
			createCode();
			return false;
		}
		return true;

}

var code="" ; 
function createCode(){ 
code = "";
var codeLength = 5;
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

function initValue()
{
	var wan_p_n ='<% getCfgGeneral(1, "wan_pppoe_username"); %>';
	var wan_p_p ='<% getCfgGeneral(1, "wan_pppoe_password"); %>';	
	var savemark_value = '<% getCfgGeneral(1, "save_mark"); %>';
	var savemark_id = document.getElementById("savemark");

	document.getElementById("pppoeUser").value = wan_p_n;
	document.getElementById("pppoePass").value = wan_p_p;

	if(savemark_value == 1)
	{
		savemark_id.innerHTML = "Save Complete"
	}
	else
	{
		savemark_id.innerHTML = ""
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
    border:0;  
    text-align: center;	
    letter-spacing:10px;  
    font-size: 15px;
    color:blue;
	background-color:#999999;
}

</style>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="pppoecfg" id="pppoecfg" action="/goform/PPPOECfg_3BB" onSubmit="return CheckValue()">
 <table border="0" cellpadding="0" cellspacing="0"  width="100%">
    <tbody>
       <tr valign="middle" height="100%">
    	 <td align="center" valign="middle" bgcolor="#FFFFFF">
     	 <table width="747" height="591" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
     	 	<tbody><tr>
     			<td valign="top" background="images/bg_tptwzd.gif">
 				    <table width="747" border="0" cellpadding="0" cellspacing="0">
 					       <tbody><tr><td height="231" valign="top">
 				                  <table width="747" border="0" cellpadding="0" cellspacing="0">
 				                         <tbody><tr><td width="663">&nbsp;</td>
 				                                <td width="78">
 				                                    <a href="/" target="_parent">
 				                                     <img src="images/help.gif" border="0" width="84" height="75">
 				                                   </a>
 				                                  </td>
 				                                  </tr>
 				                          </tbody>
 				                   </table></td></tr>
 				                  
 				                      <table width="747" border="0" cellpadding="0" cellspacing="0">
 				                        <tbody><tr><td width="200" height="30"></td>
 								                <td width="400"align="left" class="text"></td>
 				                               <td width="147"></td></tr>
 				                          </tbody>
 				                     </table>
 				                  
 				                 
 				                  <table width="747" height="105" border="0" cellpadding="0" cellspacing="0">
 										<tbody><tr><td width="335" align ="right">Username&nbsp;&nbsp;&nbsp;</td>
 				                             <td width="124" height="22" align="left" valign="bottom">
 				                                  <input type="TEXT" name="pppoeUser"  id="pppoeUser"size="18" maxlength="31" class="text">
 				                              </td><td width="288"></td></tr>
 				                              <tr><td width="335" align ="right">Passowrd&nbsp;&nbsp;&nbsp;</td>
	 				                              <td width="124" height="22" align="left" valign="bottom"><input type="password" name="pppoePass" id="pppoePass"  size="18" maxlength="31" value="" class="text">
	 				                              </td><td width="288"></td></tr>
											  <tr> <td width="335" align ="right">Validate Code&nbsp;&nbsp;&nbsp;</td>
												 	<td width="124" height="25" align="left"><input name="jiaoyanma" id="jiaoyanma" onpaste="return false;" oncontextmenu="return false;" size="18" value="" type="text"  ></td>
													<td width="288"></td></tr>
	 				                          <tr><td width="335" align="right"> </td>
	 				                         	 <td width="124" height="25" align="left" id="checkCode" name="checkCode" oncopy="return false;" oncontextmenu="return false;" onmousedown="return false;" onmouseup="return false;" class="STYLE7" ></td>
												 <td width="288">&nbsp;&nbsp;<input type="button" align="left"  value="Refresh" class="button" onClick="createCode();"></td></tr>

	 				                   <table width="747" height="35" border="0" cellpadding="0" cellspacing="0">
	 				                     	 <tbody><tr><td width="335" align="right"> </td>
	 				                     		<td width="62" align="left"><input type="submit"  name="wizardTPTsave" value="&nbsp;&nbsp;Save&nbsp;" class="button"  ></td>
	 				                    		<td width="62" align="right"><input type="reset"  name="wizardTPTclose" value="&nbsp;Close&nbsp;" class="button" onClick="doPageclose();"></td>
	 				                     		<td width="288"> </td>
	 				                         </tr>
	 				                         </tbody></table>

											<table width="747" height="35" border="0" cellpadding="0" cellspacing="0">
	 				                    	 <tbody><tr><td width="335" align="right"> </td>
	 				                     				<td width="124" height="37"  class="STYLE1" id ="savemark"> </td>
	 				                     				<td width="288"></td>
	 				                         </tr>
	 				                         </tbody></table>
	 				                         
 				                     </td></tr>
 				                     </tbody></table>

 				<tr><td>

 			
              
 				</td></tr></tbody></table>
 				</td></tr></tbody></table>
 				</td></tr></tbody></table>
</form>
</body>
</html>

