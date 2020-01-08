<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>NAT Session</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

function initTranslation()
{
	var e = document.getElementById("natsession_prompt");
	e.innerHTML = _("natsession_prompt");
	e = document.getElementById("nat_listHead");
	e.innerHTML = _("nat_listHead");
}

function initValue()
{
	initTranslation();
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="show_log">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="natsession_prompt"  class="title_01" style="padding-left: 10px;" width="100%"> </td>
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
     <tr class="tabal_head">
       <td colspan="5" id="nat_listHead">NAT Session</td> 
     </tr>
     </tbody>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
   <tbody>
     <tr>
      <textarea rows="20" cols="112" readonly="readonly"> <% read_nf_conntrack(); %> </textarea>
     </tr>
     </tbody>
  </table>
</form>
</body>
</html>