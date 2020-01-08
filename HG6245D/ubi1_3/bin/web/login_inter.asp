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
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_inter.asp");

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
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';

	if(parseInt(ispMinorNameCode) == 101)
	{
		document.location='./devregist/register_jiangsu.asp';
	}
	else
	{
		switch(parseInt(ispNameCode))
		{
			case 2:			//cmcc
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
	e = document.getElementById("devReg");
	e.value = _("login_devReg");
}

function formLoad(){   

	initTranslation();

	/* 由于 path =/goform  的cookie 不是我们需要的，所以在前台login 前清除*/
	removeCookie("loginName",  "/goform" );

	if(ispName == '22')/* 泰国TRUE */
	{
		setDisplay('tr_verifi', '');
		getElement("verifiCode").innerHTML = '<% getVerifiCode(); %>';
	}
	if (getRegisterButton == '1')
	{
		setDisplay("td_regist", "");
		getElement("td_submit").width = "30%";
		getElement("td_reset").width = "30%";
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
		if(ispName == 22)	//泰国TRUE锁定30分钟
			document.getElementById("span_error").innerHTML = _("3timeError_30");
		else
			document.getElementById("span_error").innerHTML = _("3timeError");
	}
	else if ( login_error== '7')
	{
		document.getElementById("span_error").innerHTML = _("ipNotAllowError");
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
	width: 70px; 
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
.label-verification {
    font-style: 微软雅黑;
    background: url(images/yanzhengma.jpg) no-repeat center top;
    font-size: 20px;
    display: inline-block;
    text-align: right;
    color: #000;
    cursor:pointer;
    line-height: 30px;
    letter-spacing: 6px;
    background-size: 100% 100%;
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
                <td width="54%"><table valign="middle" height="415" width="100%">
                    <tbody>
                      <tr>
                        <td height="80%"></td>
                      </tr>
                      <tr>
                        <td height="20%"><span class="STYLE5"></span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td width="32%"><table valign="middle" height="415" width="100%" >
                    <tbody>
                      <tr height="30%">
                        <td width="28%"></td>
                      </tr>
                      <tr height="42%">
                        <td width="28%"><table border="0" valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr height="25%">
                                <td width="35%" ><font id="accounttitle" class="STYLE6">Username</font></td>
                                <td width="65%" ><input name="User" id="User" value="" maxlength="32" type="text" style="width:130px; height:28px;" >
                                </td>
                              </tr>
                              <tr height="25%">
                                <td width="35%"><font id="pwdtitle" class="STYLE6">Password</font></td>
                                <td width="65%" ><input name="Passwd" id="Passwd" value="" maxlength="32" type="password" style="width:130px; height:28px;" ></td>
                              </tr>
                              <tr height="18%" id="tr_verifi" style="display: none">
                                <td></td>
                                <td><label id='verifiCode' class="label-verification"></label></td>
                              </tr>
                              <tr>
                                <td width="100%" colspan="2"><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="40%" id="td_submit"><input type="submit" class="STYLE2" value="Login" id="submit" ></td>
                                        <td width="5%"></td>
                                        <td width="40%" id="td_reset"><input type="reset"  class="STYLE2" value="Cancel" id="reset" ></td>
                                        <td width="5%"></td>
                                        <td id="td_regist" align="center" style="display: none"><input id="devReg" type="button" class="STYLE2" value="Regist" onClick="gotoRegisterPage()">
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                      <tr height="28%">
                        <td width="28%"><table valign="middle" height="100%" width="100%">
                            <tbody>
                              <tr height="30%">
                                <td width="100%" ><table align="center" border="0" height="100%" width="100%">
                                    <tbody>
                                      <tr>
                                        <td width="5%"></td>
                                        <td width="90%" align="center" id="td_error" ><span class="STYLE4" id="span_error"></span></td>
                                        <td width="5%"></td>
                                      </tr>
                                    </tbody>
                                  </table></td>
                              </tr>
                              <tr height="40%">
                                <td></td>
                              </tr>
                              <tr height="30%">
                                <td></td>
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
