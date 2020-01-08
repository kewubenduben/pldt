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
        <td   class="title_01" style="padding-left: 10px;" width="100%">
         SSID： SSID (Service Set Identification) 是无线网络中共享的独一无二的名字，The SSID对于网络中的所有设备必须是一样的。</td>         
      </tr>
      <tr>
	        <td height="30"></td>
	  </tr>
      <tr>
        <td   class="title_01" style="padding-left: 10px;" width="100%">
         开启无线：RADIO ON时可以搜索到ONT的SSID,RADIO OFF时无法搜索到ONT的SSID。</td>         
      </tr>
	      <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td  class="title_01" style="padding-left: 10px;" width="100%">
         隐藏接入点：如果你想为你的路由器隐藏接入点，你必须把这个框选上。这样配置就无法通过被动扫描来获取SSID。</td>         
      </tr>
      	  <tr>
	        <td height="30"></td>
	      </tr>
        <tr>
        <td  class="title_01" style="padding-left: 10px;" width="100%">
          区域：频道会根据不同的区域来调整频率以适应不同地区的频率规定。</td>         
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>