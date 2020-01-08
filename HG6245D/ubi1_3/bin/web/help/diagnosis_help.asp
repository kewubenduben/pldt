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
<form method="post" name="diagnosis_form">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
	  <tr>
        <td height="30"></td>
      </tr>
      <tr>
        <td   class="title_01" style="padding-left: 10px;" width="100%"> PING诊断</td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td   class="title_01" style="padding-left: 10px;" width="100%"> 可以选择远端端口、目的地址、以及发包次数ping远程地址,诊断网络的联通性。</td>
      </tr>
      <tr>
        <td height="30"></td>
      </tr>
      <tr>
        <td class="title_01" style="padding-left: 10px;" width="100%"> Traceroute</td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
      <tr>
        <td  class="title_01" style="padding-left: 10px;" width="100%"> 可以选择源端口和目的地址进行Traceroute，诊断网络联通性。</td>
      </tr>
      <tr>
        <td height="30"></td>
      </tr>
      <tr>
        <td class="title_01" style="padding-left: 10px;" width="100%"> 手动Inform</td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
      <tr>
        <td  class="title_01" style="padding-left: 10px;" width="100%"> 可以手工触发ONU向ACS服务器发送Inform消息，诊断网络联通性。</td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
