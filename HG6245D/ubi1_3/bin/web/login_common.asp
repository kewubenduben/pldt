<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=UTF-8>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode"); %>';
var page_style = '<% getCfgGeneral(1, "page_style"); %>';
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_common.asp");

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
var login_error = '<% getCfgGeneral(1, "login_error");%>';
var no_error = '<% clearLoginError(); %>';

var getRegisterButton = '<% getRegisterButton(); %>';

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

function gotoRegisterPage()
{
	if(parseInt(ispMinorNameCode) == 101 || parseInt(ispMinorNameCode) == 108)//X_CT_JS X_CT_JILIN
	{
		document.location='./devregist/register_jiangsu.asp';
	}
	else
	{
		switch(parseInt(ispName))
		{
			case 2:			//cmcc
				document.location='./devregist/register_pwd.asp';
				break;
			case 5:			//X_AIS
				document.location='./devregist/register_pwd.asp';
				break;
			default:
				document.location='./devregist/register.asp';
				break;
		}
	}
	
}

function initTranslation()
{
	var e;
	e = document.getElementById("accounttitle");
	e.innerHTML = _("accounttitle");
	e = document.getElementById("pwdtitle");
	e.innerHTML = _("pwdtitle");
	e = document.getElementById("submit");
	e.value = _("login_submit");
	e = document.getElementById("reset");
	e.value = _("login_reset");
	e = document.getElementById("user_login");
	if(ispMinorNameCode == '204')			//X_SHANXI_CMCC
	{
		e.innerHTML = _("login_user_cmcc");
	}
	else
	{
		e.innerHTML = _("login_user");
	}
	e = document.getElementById("devReg");
	e.value = _("login_devReg");	
}

function formLoad(){   

	initTranslation();

	/* 由于   path =/goform  的cookie 不是我们需要的，  所以   在前台  login  前清除*/
	removeCookie("loginName",  "/goform" );

	if(ispName == '15')			//PH X_GLOBE
	{
		setDisplay("upLoginImg", "");
		getElement("upLoginImg").src = "./images/ph_globe.png";
		getRegisterButton = 0;	//PH X_GLOBE don't need register
	}

	if(ispMinorNameCode == '204')			//X_SHANXI_CMCC
	{
		setDisplay("upLoginImg", "");
		getElement("upLoginImg").src = "./images/cmcc_logo.png";
	}
	
	if(getRegisterButton == '1')
	{
		var devRegisterSync = '<% devRegisterSync(); %>';
		var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
		var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';

		setDisplay("td_regist", "");
		getElement("td_submit").width = "20%";
		getElement("td_reset").width = "20%";

		if(parseInt(oltAuthRst) == 0)/*OLT注册成功*/
		{
			if(parseInt(authResult) == 1)/*itms平台注册成功*/
			{
				document.getElementById("devReg").disabled = true;
			}
			else
			{
				document.getElementById("devReg").disabled = false;
			}
		}
		else
		{
			document.getElementById("devReg").disabled = false;
		}

	}

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
		document.getElementById("td_error").innerHTML = _("namePwdError");
	}
	else if ( login_error== '2')
	{
		document.getElementById("td_error").innerHTML = _("adminUnavailable");
	}
	else if ( login_error== '3')
	{
		document.getElementById("td_error").innerHTML = _("serverError");
	}
	else if ( login_error== '4')
	{
		document.getElementById("td_error").innerHTML = _("logoutError");
	}
	else if ( login_error== '5')
	{
		document.getElementById("td_error").innerHTML = _("haveuserLogin");
	}
	else if ( login_error== '6')
	{
		document.getElementById("td_error").innerHTML = _("3timeError");
	}
	else if ( login_error== '8')
	{
		document.getElementById("td_error").innerHTML = _("userInUsing");
	}	
}

</script>
<STYLE type="text/css">
.STYLE1 {
	font-size: 36px;
	font-family: "新宋体";
	font-style: italic;
	color:#2C5EA4;
	font-weight: bold;
}
.STYLE2 {color: #FF0000}
.STYLE3 {color: #FFFFFF}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin();" action="/goform/webLogin">
  <table valign="middle" height="100%" width="100%">
    <tbody>
      <tr valign="middle">
        <td><table valign="middle" align="center" bgcolor="#2C5EA4" border="0" bordercolor="#2C5EA4" width="404" height="250">
            <tbody>
              <tr bordercolor="#2C5EA4"> </tr>
              <tr>
                <td bordercolor="#2C5EA4" bgcolor="#2C5EA4" height="28" ><span> &nbsp;&nbsp;<span class="STYLE3" id="user_login">User Login</span></span></td>
              </tr>
              <tr bordercolor="#2C5EA4" bgcolor="#FFFFFF">
                <td height="211"><table align="center" border="0" height="164" width="233">
                    <tbody>
                      <tr>
                        <td width="233" height="90" align="center"><img id="upLoginImg" style="display:none"><span class="STYLE1"><font></font></span></td>
                      </tr>
                      <tr>
                        <td height="66"><table border="0" height="74" width="220">
                            <tbody>
                              <tr>
                                <td id="accounttitle">Username</td>
                                <td ><input name="User" id="User" value="" type="text" class="logininput"></td>
                              </tr>
                              <tr>
                                <td id="pwdtitle">Password</td>
                                <td ><input name="Passwd" id="Passwd" value="" type="password" class="logininput"></td>
                              </tr>
                              <tr>
                                <td height="30" colspan="2" align="center" bgcolor="#FFFFFF" id="td_error"><span class="STYLE2"></span></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
              <tr>
                <td bordercolor="#2C5EA4" bgcolor="#2C5EA4" height="30"><table align="center" border="0" width="250">
                    <tbody>
                      <tr>
                        <td width="15%"></td>
                        <td width="25%" id="td_submit" align="center"><input type="submit" class="but" value="Login" id="submit" ></td>
                        <td width="5%"></td>
                        <td width="25%" id="td_reset" align="center"><input type="reset" class="but" value="Cancel" id="reset"></td>
                        <td width="5%"></td>
                        <td width="30%" id="td_regist" align="center" style="display: none"><input id="devReg" type="button" class="but" value="Regist" onClick="gotoRegisterPage()">
                        </td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
