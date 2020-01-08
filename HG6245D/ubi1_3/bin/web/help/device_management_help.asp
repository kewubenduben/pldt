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
        <td class="title_01" style="padding-left: 10px;" width="100%">
         设备重启</td>         
        </tr>
	      <tr>
	        <td height="10"></td>
	      </tr>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         使ONU重新启动，一些配置需要重启才能生效。</td>         
      </tr>
      	    <tr>
	        <td height="30"></td>
	      </tr>

	    <tr>
        <td class="title_01" style="padding-left: 10px;" width="100%">
         配置备份配置</td>         
        </tr>
	      <tr>
	        <td height="10"></td>
	      </tr>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
         可以将设备当前配置文件备份到本地电脑， 同时可以用保存的配置文件更新您的设备。</td>         
      </tr>
       <tr>
	        <td height="30"></td>
	      </tr>

	    <tr>
        <td class="title_01" style="padding-left: 10px;" width="100%">
         恢复出厂设置 </td>         
        </tr>
	      <tr>
	        <td height="10"></td>
	      </tr>
      <tr>
        <td id="device_info_prompt"  class="title_01" style="padding-left: 10px;" width="100%">
        点击 "恢复默认配置" 按钮，使ONU的配置恢复出厂默认值。</td>         
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>