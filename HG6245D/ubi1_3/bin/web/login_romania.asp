<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset="gbk">
<script type="text/javascript" src="./js/jquery.js"></script>
<script type="text/javascript" src="./js/jquery.validate.js"></script>
<script type="text/javascript" src="./lang/b28n.js"></script>
<script type="text/javascript" src="./js/checkValue.js"></script>
<script type="text/javascript" src="./js/login.js"></script>
<script type="text/javascript" src="./js/utils.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<link rel="stylesheet" href="./style/login.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

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
	document.getElementById("btn_login_step_1").disabled = 1;
	
	return true;	
}

function initTranslation()
{
}

function formLoad(){   

	initTranslation();

	/* 由于 path =/goform  的cookie 不是我们需要的，所以在前台login 前清除*/
	removeCookie("loginName",  "/goform" );
	window.document.forms[0].User.focus();

	if ( login_error != '0')
	{
		document.getElementById("btn_login_step_1").disabled = 0;
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
</head>
<body onLoad="formLoad()">
<div class="login_bg">
  <div class="logo"><img src="./images/fiberhome_logo.png" alt="logo"></div>
  <div class="line" id="line">
    <table align=left cellpadding=0 cellspace=0 border=0>
      <tr>
        <td id="line1" valign="top"><img src="./images/line.png" style="opacity:0.2;"> </td>
        <td id="line2" valign="top"><img src="./images/line.png" style="margin-left:-3px;opacity:0.2;"> </td>
      </tr>
    </table>
  </div>
</div>
</div>
<div class="container-fluid login_block">
  <!--++++++++++++++++++++++++++++ Login step 1 +++++++++++++++++++++++++++++++++-->
  <div class="row" id="login_setup_1_div" >
    <div class="content-left" id="login_tip" style="display:none"> <img src="./images/login/bg_image.png" width="365" height="325" alt=""/> </div>
    <div class="content-right content-offset"> <br/>
      <br/>
      <font face="Arial" style="font-size: 14px;"></font>
      <form id="login_form1" method="post" onSubmit="return onlogin()" action="/goform/webLogin">
        <div class="login-input">
          <div class="step-block"></div>
          <div class="login-block" style="background:white url(./images/login/login_user-1.png) no-repeat left;">
            <input type="text" placeholder="USERADMIN" class="form-control" id="login_username" name='User' >
          </div>
          <div class="login-block password_block" style="background:white url(./images/login/login_password-1.png) no-repeat left;">
            <input id="login_password" name="Passwd" type="password" placeholder="PASSWORD" class="form-control login-password"  autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" AutoCompleteType="Disabled">
            <span class="pwd-show-switch" id="login_password_show"></span> </div>
        </div>
        <input value="LOGIN" type="submit" class="btn" id="btn_login_step_1" disabled="disabled">
		<span class="error span_error" id="span_error"></span>
      </form>
    </div>
  </div>
</div>
<div id="copyright_div">Copyright &copy; 2018 Fiberhome All Rights Reserved.&nbsp;&nbsp; </div>
</body>
</html>
