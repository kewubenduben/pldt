<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>PPPOE Settings</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var GetWANsizeSync = '<% GetPppoeSync(); %>';	
var wan_p_p ='<% getCfgGeneral(1, "wan_pppoe_password"); %>';

var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
var login_error = '<% getCfgGeneral(1, "login_error");%>';
var no_error = '<% clearLoginError(); %>';

function onlogin() {
	with ( document.forms[0] ) {
		if(User == null || User.value.length <= 0) {
		  alert(_("uernameNotNull"));
			return false;
		}
		if(Passwd == null || Passwd.value.length <= 0) {
			alert(_("passwordNotNull"));
			return false;
		}
		if(jiaoyanma.value.toUpperCase() != checkCode.innerHTML)
		{
			alert(_("validationError"));
			createCode();
			return false;
		}
	}
	document.all("submit").disabled = true;
	
	return true;	
}

function CheckValue()
{


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

function formLoad()
{     
	/* 由于 path =/goform  的cookie 不是我们需要的，所以在前台login 前清除*/
	removeCookie("loginName",  "/goform" );
	
	//仅当隐私设置为“阻止所有Cookie”级别时为false
	var cookieEnabled=(navigator.cookieEnabled)? true : false;
	////navigator is not ie4+ or ns6+
    if (typeof navigator.cookieEnabled=="undefined" && !cookieEnabled){ 
        document.cookie="testcookie";
        cookieEnabled=(document.cookie=="testcookie")? true : false;
        document.cookie=""; //erase dummy value
    }
    if(cookieEnabled == false)
	    alert("COOKIES need to be enabled!");

	//清空原cookie数据
	//foreach();
	
	window.document.forms[0].User.focus();

	if ( login_error != '0')
	{
		document.getElementById("submit").disabled = 0;
		document.getElementById("td_error").disabled = 1;
	}
	if ( login_error== '1')
	{
		document.getElementById("span_error").innerHTML = _("namePwdError");
	}
	else if ( login_error== '2')
	{
		document.getElementById("span_error").innerHTML = _("adminUnavailable");
	}
	else if ( login_error== '3')
	{
		document.getElementById("span_error").innerHTML = _("serverError");
	}
	else if ( login_error== '4')
	{
		document.getElementById("span_error").innerHTML = _("logoutError");
	}
	else if ( login_error== '5')
	{
		document.getElementById("span_error").innerHTML = _("haveuserLogin");
	}
	else if ( login_error== '6')
	{
		document.getElementById("span_error").innerHTML = _("3timeError");
	}
	createCode();
		
}
</script>

<STYLE type="text/css">

.STYLE1 {
	color: #FF0000;
	text-align: left;	
	font-size: 13px;
}

.STYLE4 {
	color: #FF0000;
	text-align: center;	
	font-size: 20px;
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
<body class="mainbody" onLoad="formLoad()">
<form method="post" name="pppoecfg" id="pppoecfg" action="/goform/tr069_login" onSubmit="return onlogin()">
 <table border="0" cellpadding="0" cellspacing="0"  width="100%">
    <tbody>
       <tr valign="middle" height="100%">
    	 <td align="center" valign="middle" bgcolor="#FFFFFF">
     	 <table width="747" height="591" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
     	 	<tbody><tr>
     			<td valign="top" background="images/bg_rmnt.gif">
 				    <table width="747" border="0" cellpadding="0" cellspacing="0">
 					       <tbody><tr><td height="231" valign="top">
 				                  <table width="747" border="0" cellpadding="0" cellspacing="0">
 				                         <tbody><tr><td width="663">&nbsp;</td>
 				                                <td width="78">
 				                                    <!--a href="http://192.168.1.1/" target="_parent">
 				                                     <img src="images/help.gif" border="0" width="84" height="75">
 				                                   </a-->
 				                                  </td>
 				                                  </tr>
 				                          </tbody>
 				                   </table></td></tr>
 				               
 				                      <table width="747" height="24" border="0" cellpadding="0" cellspacing="0">
 				                        <tbody><tr><tr><td width="200"></td>
                                                    <td width="400" align="center" class="text">
                                                       <font size="3" style="FONT-SIZE:15pt;FONT-FAMILY:Arial, Helvetica, sans-serif">TR069 Management</font></td>
                                                     <td width="147"></td>
                                                      </tr>
 				                          </tbody>
 				                     </table>
 				                 
 				                  
 				                  <table width="747" height="75" border="0" cellpadding="0" cellspacing="0">
 										<tbody><tr><td width="350" height="25" align ="right">Username&nbsp;&nbsp;</td>
 				                             <td width="121"  align="left" valign="bottom">
 				                                  <input type="TEXT" name="User" id="User"  maxlength="31" class="text">
 				                              </td><td width="276"></td></tr>
 				                              <tr><td width="350" height="25" align ="right">Passowrd&nbsp;&nbsp;</td>
	 				                              <td width="121" align="left" valign="bottom"><input type="password"  name="Passwd" id="Passwd"   maxlength="31" value="" class="text">
	 				                              </td><td width="276"></td></tr>
											  <tr> <td width="350" height="25" align ="right">Validate Code&nbsp;&nbsp;</td>
												 	<td width="121"  align="left"><input name="jiaoyanma" id="jiaoyanma" onpaste="return false;" oncontextmenu="return false;" value="" type="text"></td>
													<td width="276"></td></tr>
											  <tr><td width="350" align="right"> </td>
 				                         				 <td width="121" height="25" align="right" id="checkCode" name="checkCode" oncopy="return false;" oncontextmenu="return false;" onmousedown="return false;" onmouseup="return false;" class="STYLE7" ></td>
														 <td width="276">&nbsp;&nbsp;<input type="button" align="left"  value="Refresh" class="button" onClick="createCode();"></td>
												</tr>
												
		 				                   <table width="747" height="36" border="0" cellpadding="0" cellspacing="0">
		 				                     <tbody><tr><td width="350" align="right"> </td>
		 				                     <td  width="121" align="center"><input type="submit" name="submit" id="submit" value="Submit" class="button"  ></td>
		 				                     	<td width="276"> </td>
		 				                         </tr>
		 				                         </tbody></table>

		 				                     <table width="747" height="45" border="0" cellpadding="0" cellspacing="0">
		 				                     <tbody><tr><td width="226" align="right"> </td>
		 				                     <td  width="360" align="center" id="td_error" ><span class="STYLE4" id="span_error"></span></td>
		 				                     	<td width="169"> </td>
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

