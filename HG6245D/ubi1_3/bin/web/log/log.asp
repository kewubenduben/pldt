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
<title>LOG</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("log", lang);

//get init value from driver
function initTranslation()
{
	var e = document.getElementById("log_prompt");
	e.innerHTML = _("log_prompt");
//    e = getElement("pic1");
//	e.innerHTML = _("log_download");
	e = document.getElementById("log_listHead");
	e.innerHTML = _("log_listHead");
}

function initValue()
{
	initTranslation();
}

function savepic()
{
	var pic1 = getElement("pic1");
	var re;
	if(document.all.a1==null)
	{   
		var objIframe=document.createElement("IFRAME");   
		document.body.insertBefore(objIframe, pic1);   
		objIframe.outerHTML = "<iframe name=a1 style='width:0;hieght:0' src="+pic1.href+"></iframe>";   
		re=setTimeout("savepic()",1)   ;
	}   
	else
	{   
		clearTimeout(re)   ;
		var pic = window.open(pic1.href,"a1")  ; 
		pic.document.execCommand("SaveAs");
		document.all.a1.removeNode(true);
	}
}

function downLogFile()
{
	//window.open('/haha.txt')	//新开窗口显示了内容
//	Response.Redirect("/haha.txt");		//Response未定义
//	DownURL();
//	savepic();
}
function   DownURL(strRemoteURL,strLocalURL) 
{ 
  try 
  { 
    var   xmlHTTP=new   ActiveXObject( "Microsoft.XMLHTTP "); 
    xmlHTTP.open( "Get ",strRemoteURL,false); 
    xmlHTTP.send(); 
    var   adodbStream=new   ActiveXObject( "ADODB.Stream "); 
    adodbStream.Type=1;//1=adTypeBinary 
    adodbStream.Open(); 
    adodbStream.write(xmlHTTP.responseBody); 
    adodbStream.SaveToFile(strLocalURL,2); 
    adodbStream.Close(); 
    adodbStream=null; 
    xmlHTTP=null; 
  } 
  catch(e) 
  { 
    //window.confirm( "下载URL出错! "); 
	window.confirm(_("log_downloaderroralert")); 
  } 
  //window.confirm( "下载完成. "); 
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
                <td id="log_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
    </tbody>
  </table>
  <!--a href="/cu_log.txt" id=pic1 onclick="downLogFile()" style="cursor:hand">下载</a-->
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="5" id="log_listHead"></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td><textarea rows="20" cols="116" readonly="readonly"><% writeloghead_sync(); %><% LogSync(); %>
</textarea></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
