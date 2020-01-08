<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>Super Admin Access List</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var accessList  = '<% getCfgZero(1, "access_list"); %>';
function initTranslation()
{
	var e = document.getElementById("super_admin_access_list_prompt");
	e.innerHTML = _("super_admin_access_list_prompt");
	e = document.getElementById("access_list_title");
	e.innerHTML = _("access_list_title");
}

function checkValue()
{
	return ture;
}
function initValue()
{	
	initTranslation();	
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="super_admin_access_list" id="super_admin_access_list">
 <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="super_admin_access_list_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="super_admin_access_list_table" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
	  <tr>
        <td class="tabal_left" width="25%" id="access_list_title">Super Admin Access List</td>
        <td class="tabal_right" align="left" width="75%" ><textarea name="access_list" id="access_list" rows="5" cols="60"><% get_super_admin_access_list(); %></textarea></td>
        </tr>
    </tbody>
  </table>   
  </form>
</body>
</html>

