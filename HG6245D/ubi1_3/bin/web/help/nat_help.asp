<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
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
         DMZ</td>         
      </tr>
      	      <tr>
	        <td height="10"></td>
	      </tr>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
        您可以将内网中的一台主机设置为DMZ主机，使通过外网可以访问该主机。
       </td>         
      </tr>
	      <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         NAT -- 虚拟服务器设置</td>         
      </tr>
      	<tr>
	        <td height="10"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         将一台主机的假IP地址映射成一个真的IP地址，当用户访问提供端口映射功能的主机的某个端口时，服务器将请求转到内部提供这种服务的主机。</td>         
      </tr>
          <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
           ALG</td>         
      </tr>
          <tr>
	        <td height="10"></td>
	      </tr>
        <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
          启用/关闭 H.323/RTSP/L2TP/IPSEC/SIP/FTP/PPTP</td>         
      </tr>
      
    </tbody>
  </table>
</form>
</body>
</html>