<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Local Area Network (LAN) Settings</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var GetWANsizeSync = '<% wanNameSync(); %>';	


function initValue()
{
	var wan_p_n ='<% getCfgGeneral(1, "wan_pppoe_username"); %>';	
	document.getElementById("pppoeUser").value = wan_p_n;
	var wan_p_p ='<% getCfgGeneral(1, "wan_pppoe_password"); %>';
	document.getElementById("pppoePass").value = wan_p_p;
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
		return true;

}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="pppoecfg" id="pppoecfg" action="/goform/PPPOECfg" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="lan_prompt" class="title_01" style="padding-left: 10px;" width="100%">You may enable/disable networking functions and configure their parameters as your wish.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="lSetup">PPPoE Setup</td>
      </tr>
      
      <tr>
        <td class="tabal_left" width="25%" id="wPppoeUser">User Name</td>
        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=31 style="width:320px;" >
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips"></span></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="wPppoePassword">Password</td>
        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=31 style="width:320px;">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips"></span></td>
      </tr>

    </tbody>
  </table>

  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="lApply" class="submit" onClick="TimeoutReload(20)">
          <input type="reset" name="Cancel" value="Cancel" id="lCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</td>
</tr>
</table>
</body>
</html>

