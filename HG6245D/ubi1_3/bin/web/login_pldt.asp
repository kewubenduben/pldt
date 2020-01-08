<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var login_error = '<% getCfgGeneral(1, "login_error");%>';
var no_error = '<% clearLoginError(); %>';
var loginUrlType = '<% getCfgGeneral(1, "loginUrlType"); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_pldt.asp");

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
	}
	document.all("submit").disabled = true;
	
	return true;	
}
	
function onkey(){
		if(window.event.keyCode==13){
       document.getElementById('submit').click();
    }
}

function initTranslation()
{
	var e = document.getElementById("accounttitle");
	if(loginUrlType == "2")
	{
		e.innerHTML = _("admintitle");
	}
	else
	{
		e.innerHTML = _("accounttitle");
	}
	e = document.getElementById("pwdtitle");
	e.innerHTML = _("pwdtitle");
	e = document.getElementById("submit");
	e.value = _("login_submit");
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
	background-image: url(images/loginbutton.png);
}
.STYLE3 {
	color: #FFFFFF;
	text-align: center;	
	font-size: 16px;
}
.STYLE4 {
	color: #FFFFFF;
	text-align: center;	
	font-size: 18px;
}
.STYLE5 {
	color: #FF0000;
	text-align: center;	
	font-size: 20px;
}
</style>
</head>
<body class="STYLE1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin();" action="/goform/webLogin">
  <table valign="middle" height="100%" width="100%"  >
    <tbody>
      <tr valign="middle" height="80%">
        <td width="33%"></td>
        <td width="33%"><table valign="middle" align="center" background="images/login_pldt.jpg" border="0" width="935" height="415">
            <tbody>
              <tr>
                <td width="54%"><table valign="middle" height="415" width="100%">
                    <tbody>
                      <tr>
                        <td width="33%" height="80%"></td>
                      </tr>
                      <tr>
                        <td width="33%" height="30%"><span class="STYLE3"></span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="32%"><table valign="middle" height="415" width="100%" >
                    <tbody>
                      <tr >
                        <td width="28%" height="30%" class="STYLE3">Welcome! Please enter username and password to login.</td>
                      </tr>
                      <tr >
                        <td width="28%" height="35%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="30%"width="100%"><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="30%" align="right"><font id="accounttitle" class="STYLE4">Username</font>
                                        <td width="70%" align="center"><input name="User" id="User" type="text" style="height:28px;">
                                        </td>
                                      </tr>
                                      <tr>
                                        <td width="25%" align="right"><font id="pwdtitle" class="STYLE4">Password</font>
                                        <td width="75%" align="center"><input name="Passwd" id="Passwd" type="password" style="height:28px;"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr >
                                <td height="30%"width="100%"><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr >
                                        <td width="10%"></td>
                                        <td width="40%"></td>
                                        <td width="10%"></td>
                                        <td width="40%"><input type="submit" class="STYLE2" value="Login" name="submit" id="submit"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                      <tr >
                        <td width="28%" height="35%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr>
                                <td height="30%"align="center" id="td_error"><span class="STYLE5" id="span_error"></span></td>
                              </tr>
                              <tr>
                                <td height="40%"width="100%"></td>
                              </tr>
                              <tr>
                                <td height="30%"width="100%"></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="26%" height="15%"></td>
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
