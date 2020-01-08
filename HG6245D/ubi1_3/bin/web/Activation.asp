<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html" charset=gbk>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<title>Redirected</title>
<script language="JavaScript" type="text/javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("menu", lang);

var login_user = '<% getCfgGeneral(1, "login_user");%>';
var userrelog = '<% getCfgGeneral(1, "userrelog");%>';
var login_error = '<% getCfgGeneral(1, "login_error");%>';
var no_error = '<% clearLoginError(); %>';
var activation_state_get = '<% activation_state_get(); %>';
var activation_state = '<% getCfgGeneral(1, "activation_state");%>';

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

	if ( login_error != '0')
	{
		document.getElementById("submit_act").disabled = 0;
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
	else if ( login_error== '7')
	{
		document.getElementById("span_error").innerHTML = _("ipNotAllowError");
	}

	if(activation_state == 1)/*设备已激活，灰显输入框*/
	{
		document.getElementById("User").disabled = true;
		document.getElementById("Passwd").disabled = true;
		document.getElementById("act_id").disabled = true;
		document.getElementById("submit_act").disabled = true;
		document.getElementById("span_error").innerHTML = _("Device has been activated!");
	}
	else
	{
		document.getElementById("User").disabled = false;
		document.getElementById("Passwd").disabled = false;
		document.getElementById("act_id").disabled = false;
		document.getElementById("submit_act").disabled = false;
	}

}

</script>
<STYLE type="text/css">
.STYLE1 {
	color: #FF0000;
	text-align: center;	
	font-size: 14px;
}

</style>
</head>
<body   onLoad="formLoad()">
<form name="login" method="post" onSubmit="return onlogin()" action="/goform/dev_activation">
  <table align="center" border="0" cellpadding="0" cellspacing="0" height="400" width="808">
    <tbody>
      <tr height="77" width="808">
        <td></td>
      </tr>
      <tr>
        <td><table align="middle" border="0" cellpadding="0" cellspacing="0" width="808">
            <tbody>
              <tr>
                <td rowspan="3" width="77"></td>
                <td id="registBgimg" align="center"  background="images/reg_inter.jpg" height="323" width="653"><table id="tb_register" border="0" cellpadding="0" cellspacing="0" height="200" width="350" >
                    <tbody>
                      <tr>
                        <td colspan="2" height="20"></td>
                      </tr>
                      <tr>
                        <td  align="right" height="25" valign="bottom" width="100">Username</td>
                        <td align="center" valign="bottom" width="250"><input name="User" id="User" style="width:180px; height:22px;" size="32" maxlength="32" type="text"></td>
                      </tr>
                      <tr>
                        <td  align="right" height="25" valign="bottom" width="100">Passowrd</td>
                        <td align="center" valign="bottom" width="250"><input name="Passwd" id="Passwd" style="width:180px; height:22px;"value="" type="password" size="32" maxlength="32" ></td>
                      </tr>
                      <tr>
                        <td  align="right" height="25" valign="bottom" width="100">Activation ID</td>
                        <td align="center" valign="bottom" width="250"><input name="act_id" id="act_id" style="width:180; height:22px;" size="24" maxlength="24" type="text"></td>
                      </tr>
                      <tr height="8">
                        <td colspan="2"></td>
                      </tr>
                      <tr>
                        <td  align="right" height="25" valign="bottom" width="100"></td>
                        <td colspan="2" align="center" width="250" height="35"><input id="submit_act" class="submit" type="submit" value="Activation" name="submit_act" >
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <input id="reset" class="submit" type="reset" value="&nbsp;&nbsp;Cancel&nbsp;&nbsp;">
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="20" width="100%"><font size="2"> </font></td>
                      </tr>
                      <tr>
                        <td  width="100"></td>
                        <td  width="250" align="center" id="td_error" ><span class="STYLE1" id="span_error"></span></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td rowspan="3" width="78"></td>
              </tr>
            </tbody>
          </table>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
