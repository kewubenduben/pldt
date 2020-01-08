<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="/style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_3bb.asp");

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);
/*
var readerr = '';
var userrelog = '';
var passwderror = '';
var usererror = '';
var pleasewait = '';
var ur = '';
*/
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

function foreach()
{
	var strCookie = document.cookie;
  
	var arrCookie=strCookie.split("; "); // 将多cookie切割为多个名/值对
      
      for(var i=0; i < arrCookie.length; i++)
     { 
     	// 遍历cookie数组，处理每个cookie对
		var arr=arrCookie[i].split("=");

		if(arr.length>0)
		{
			DelCookie(arr[0]);
		}
  }
}
	
  function onkey(){
		if(window.event.keyCode==13){
       document.getElementById('submit').click();
    }
  }

function initTranslation()
{
	var e = document.getElementById("accounttitle");
	e.innerHTML = _("accounttitle");
	e = document.getElementById("pwdtitle");
	e.innerHTML = _("pwdtitle");
	e = document.getElementById("jiaoyanmatitle");
	e.innerHTML = _("jiaoyanmatitle");
	
	e = document.getElementById("submit");
	e.value = _("login_submit");
	e = document.getElementById("reset");
	e.value = _("login_reset");
}

function formLoad(){     
	initTranslation();

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
	else if ( login_error== '8')
	{
		document.getElementById("span_error").innerHTML = _("userInUsing");
	}
	createCode();
		
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



</script>
<STYLE type="text/css">
.STYLE1 {
	background-image: url(images/background.png);
	background-repeat: repeat-x;
	
}
.STYLE2 {	
	height: 35px;
	width: 90px; 
}
.STYLE3 {
	border: none;
	background-image: url(images/unicom_s.png);
	background-repeat: no-repeat;	
	background-position: center center;	
}
.STYLE4 {
	color: #FF0000;
	text-align: center;	
	font-size: 20px;
}
.STYLE5 {
	color: #FFFFFF;
	text-align: center;	
	font-size: 10px;
}
.STYLE6 {
	color: #000000;
	text-align: center;	
	font-size: 18px;
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
    width:140px; 
    height:28px;
	background-color:#999999;
}

</style>
</head>
<body class="STYLE1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin()" action="/goform/webLogin">
  <table valign="middle" height="100%" width="100%"  >
    <tbody>
      <tr valign="middle" height="80%">
        <td width="33%"></td>
        <td width="33%"><table valign="middle" align="center" background="images/login.png" border="0" width="935" height="415">
            <tbody>
              <tr>
                <td width="45%"><table valign="middle" height="415" width="100%">
                    <tbody>
                      <tr>
                        <td height="80%"></td>
                      </tr>
                      <tr>
                        <td height="20%"><span class="STYLE5">&nbsp &nbsp</span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="40%"><table valign="middle" height="415" width="100%" >
                    <tbody>
                      <tr>
                        <td height="20%"></td>
                      </tr>
                      <tr>
                        <td height="45%"><table valign="middle" height="100%" width="100%" border="0" >
                            <tbody>
                              <tr>
                                <td width="130" align="right"><font id="accounttitle" class="STYLE6">Username</font></td>
                                <td ><input name="User" id="User" value="" type="text" style="width:140px; height:28px;"></td>
                                <td width="97" align="right"></td>
                              </tr>
                              <tr>
                                <td align="right" width="130" height="30%"><font id="pwdtitle" class="STYLE6">Password</font></td>
                                <td><input name="Passwd" id="Passwd" value="" type="password" style="width:140px; height:28px;"></td>
								<td width="97" align="right"></td>
                              </tr>
                              <tr>
                                <td align="right" width="130"><font id="jiaoyanmatitle" class="STYLE6">Validate Code</font></td>
                                <td><input name="jiaoyanma" id="jiaoyanma" onpaste="return false;" oncontextmenu="return false;" value="" type="text" style="width:140px; height:28px;"></td>
								<td width="97" align="right"></td>
                              </tr>
                              <tr>
                                <td align="right" width="130"></td>
                                <td id="checkCode" name="checkCode" oncopy="return false;" oncontextmenu="return false;" onmousedown="return false;" onmouseup="return false;" class="STYLE7"></td>
								<td width="97" align="right"><input type="button" align="left" value="Refresh" class="button" onClick="createCode();"></td>
                              </tr>
                              <tr>
                                <td width="130"></td>
                                <td><table align="right" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                      
                                        <td align="left" width="70"><input type="submit" name="submit" id="submit" ></td>
		                                <td align="right" width="70"><input type="reset" name="reset" id="reset" ></td>
		                              
				                       </tr>
                                    </tbody>
                                    </table>
                                </td>
                                <td width="97" align="right"></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                      <tr>
                        <td height="35%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="70%"width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="90%" align="center" id="td_error" ><span class="STYLE4" id="span_error"></span></td>
                                        <td width="5%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr>
                                <td height="30%"width="100%" ></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="15%" height="15%"></td>
              </tr>
            </tbody>
          </table></td>
        <td width="34%"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
