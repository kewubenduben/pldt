<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Redirect</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("redirect", lang);

//get init value from driver
var RedirectSync = '<% RedirectSync(); %>';

function initTranslation()
{
	var e = document.getElementById("redirect_prompt");
	e.innerHTML = _("redirect_prompt");
    e = document.getElementById("redirect_title");
	e.innerHTML = _("redirect_title");
	e = document.getElementById("re_enable");
	e.innerHTML = _("re_enable");
	e = document.getElementById("re_disable");
	e.innerHTML = _("re_disable");
	e = document.getElementById("redirectApply");
	e.value = _("redirectApply");
	e = document.getElementById("redirectCancel");
	e.value = _("redirectCancel");
}

function checkURL(str)
{
	if (str.length > 0) 
	{
		//var reg = /^[\S]{1,32}$/;
		var reg = /^[A-Za-z0-9./]{1,140}$/;
		if (!reg.test(str))
		{ 
			return false; 
		}
		else
		{
			return true;
		}
	}
	return true;
}

function CheckValue()
{

	var url_value = document.getElementById("redirect_url");
	var redirectEnable = document.getElementsByName("redirectEnable");
	if(redirectEnable[0].checked == true )
	{
		if (!CheckNotNull(url_value.value)) 
		{					
			//alert(_("Please enter host domain!"));
			//alert(_("请输入需要过滤的URL!"));
			alert(_("redirect_nourlalert"));
			url_value.value = url_value.defaultValue;
			url_value.focus();
			return false;
		}
/*
		if(! checkURL(url_value.value))
		{
			//alert(_("Host Domain Name is illegal!"));
			alert(_("您输入URL非法!"));
			url_value.value = url_value.defaultValue;
			url_value.focus();
			return false;
		}
*/
	}
	return true;
}

function initValue()
{
	initTranslation();
	var redirectEnable = document.getElementsByName("redirectEnable");	
	for(var i = 0;i<redirectEnable.length;i++)
	{
		if(redirectEnable[i].value == '<% getCfgGeneral(1, "redirectEnable"); %>')
		{
			redirectEnable[i].checked = true;
			break;
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">

<form method="post" name="fm_redirect_enable" action="/goform/setRedirect" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="redirect_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="redirect_title" align="left" width="25%">Redirect</td>
        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="enable" name="redirectEnable" type="radio">
          <font id="re_enable"></font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="redirectEnable" type="radio">
          <font id="re_disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>

       <tr>
        <td class="tabal_left" id="vpnEnable_title" align="left" width="25%">URL</td>
        <td class="tabal_right" width="75%"><input name="redirect_url" id="redirect_url" size="32" type="text" value="<% getCfgGeneral(1, "redirect_url"); %>"></td>
        </tr>
      
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="Apply" id="redirectApply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="Apply" id="redirectCancel" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>

