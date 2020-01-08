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
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         UPNP</td>         
      </tr>
	      <tr>
	        <td height="10"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         一般短的接头和网络联机的内部结构提供网络联机协调性的配备、软件和周边设备。
         路由器是 UPnP 激活的路由器和工作于其它 UPnP 装置/软件。如果您想使用 UPnP 的功能，
         要使 UPnP 无效可以设定"关闭"。</td>         
      </tr>
      
    </tbody>
  </table>
</form>
</body>
</html>