<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Refresh" content="20">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>DHCP Clients List</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);
var size = '<% dhcpUserListSync(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("dhcp_userListPrompt");
	e.innerHTML = _("dhcp_userListPrompt");
	
	e = document.getElementById("dhcp_userListHead");
	e.innerHTML = _("dhcp_userListHead");
	
	e = document.getElementById("dhcp_hostnameTitle");
	e.innerHTML = _("dhcp_hostnameTitle");
	e = document.getElementById("dhcp_macTitle");
	e.innerHTML = _("dhcp_macTitle");
	e = document.getElementById("dhcp_ipTitle");
	e.innerHTML = _("dhcp_ipTitle");
	e = document.getElementById("dhcp_hiredTimeTitle");
	e.innerHTML = _("dhcp_hiredTimeTitle");
	e = document.getElementById("dhcp_typeTitle");
	e.innerHTML = _("dhcp_typeTitle");
	e = document.getElementById("dhcp_StatusTitle");
	e.innerHTML = _("dhcp_StatusTitle");
}

function initValue()
{	
	initTranslation();
	if(ispNameCode != 12)
	{
		setDisplay("dhcp_StatusTitle", "none");
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="dhcpUserList" id="dhcpUserList">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="dhcp_userListPrompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="5" id="dhcp_userListHead">DHCP Clients List</td>
      </tr>
      <tr class="tabal_title">
        <td width="5%">ID</td>
        <td width="21%"id="dhcp_hostnameTitle">Hostname</td>
        <td width="18%"id="dhcp_macTitle">MAC</td>
        <td width="18%"id="dhcp_ipTitle">IP</td>
        <td width="15%"id="dhcp_hiredTimeTitle">Hired Time</td>
        <td width="15%"id="dhcp_typeTitle">Type</td>
        <div>
        <td width="8%" id="dhcp_StatusTitle">Status</td>
        </div>
      </tr>
	  <% getDhcpUserListParam(); %>
    </tbody>
  </table>
  <br>
  <strong style="color:#FF0033"><span id="dhcp_getRstPrompt"></span></strong>
</form>
</td>
</tr>
</table>
</body>
</html>
