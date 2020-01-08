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
loginPageAccessCheck(ispName, ispMinorNameCode, page_style, "login_viettel.asp");

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

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
	}
	document.all("submit").disabled = true;
	
	return true;	
}

function initTranslation()
{
}

function formLoad(){   

	initTranslation();

	/* 由于path =/goform的cookie 不是我们需要的，所以在前台login前清除 */
	removeCookie("loginName", "/goform");	

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
	border: #FFA500 1px solid;
}
.STYLE2 {color: #FF0000}
.STYLE3 {
	background-image: url('./images/viettel_logo.png');
	background-repeat: no-repeat;
	background-position: center
}
</style>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin();" action="/goform/webLogin">
  <table valign="middle" bgcolor="#FFFFFF" height="100%" width="100%">
    <tbody>
      <tr>
        <td><table valign="middle" align="center" border="0" class="STYLE1" width="549" height="150">
            <tbody>
              <tr>
                <td><table align="center" border="0" height="100%" width="100%">
                    <tbody>
                      <tr height="20">
                        <td width="40%" rowspan='4' class="STYLE3"></td>
                        <td colspan="3"></td>
                      </tr>
                      <tr height="30">
                        <td width="10%" align="right" id="accounttitle">Username</td>
                        <td width="25%"><input name="User" id="User" value="" type="text" class="logininput"></td>
                        <td></td>
                      </tr>
                      <tr height="30">
                        <td align="right" id="pwdtitle">Password</td>
                        <td ><input name="Passwd" id="Passwd" value="" type="password" class="logininput"></td>
                        <td></td>
                      </tr>
                      <tr height="20">
                        <td colspan="2" align="center" id="td_error" class="STYLE2">&nbsp;</td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
              <tr height="50">
                <td><table align="center" bgcolor="#00918E" border="0" width="100%" height="100%">
                    <tbody>
                      <tr>
                        <td width="40%"></td>
                        <td width="10%" id="td_submit" align="center"><input type="submit" class="but" value="LOGIN" id="submit" ></td>
                        <td width="5%"></td>
                        <td width="10%" id="td_reset" align="center"><input type="reset" class="but" value="CLEAR" id="reset"></td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
