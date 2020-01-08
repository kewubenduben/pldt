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
<title>help</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("help", lang);


function initTranslation()
{

}

function initValue()
{
	initTranslation();

}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="igmp_form">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="30"></td>
      </tr>
    </tbody>
 </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         允许针对任意一个领域的静态主机名别名动态IP地址。允许路由器从不同地区更加容易地访问在互联网。
         若您拥有动态 DNS 帐号，可以在路由器设定此项功能。</td>         
      </tr>
	      <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         DDNS供应商： 选择下表中 DDNS 可使用服务器。</td>         
      </tr>
      	<tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         主机名： 请输入您的 DDNS 帐户的主机名称。</td>         
      </tr>
          <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         用户名: 请输入您的 DDNS 帐户的使用者名称。</td>         
      </tr>
          <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         密码: 请输入您的 DDNS 帐户的密码。</td>         
      </tr>
      
    </tbody>
  </table>
</form>
</body>
</html>