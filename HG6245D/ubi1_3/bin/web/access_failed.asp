<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="./style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<title>Access Device Failed</title>
<style type="text/css"> 
div#footer
{
	height: 24px;
	width: 735px;
}
div#footer #blank
{
	float: left;
	height: 24px;
	width: 550px;
	text-align: left;
}
div#footer #back
{
	float: left;
	height: 24px;
	width: 100px;
	text-align: right;
}
</style>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("errorpage", lang);
function initTranslation()
{
	var e = document.getElementById("accessHead");
	e.innerHTML = _("accessHead");
    e = document.getElementById("backPage");
	e.innerHTML = _("backPage");

	var errorCode = '<% getCfgGeneral("1", "errorCode");%>';
    e = document.getElementById("accessNotice");
	e.innerHTML = _(errorCode);

	if(errorCode == "0000")
	{
		setDisplay("errorCode", "none");
	}
	else
	{	
	    e = document.getElementById("errorCode");
		e.innerHTML = _("errorCode") + errorCode;
	}
}

function initValue()
{
	initTranslation();
	load_finish();
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<h1 class="tabal_head" id="accessHead">Access Device Notice</h1>
<hr/>
<p id="accessNotice" ></p>
<p id="errorCode"></p>
<p id="interfaceInfo"></p>
<br>
<div id="footer">
  <div id="blank"></div>
  <div id="back"> <a id="backPage" href="<% getCfgGeneral('1', 'backPage');%>">Back</a> </div>
</div>
</body>
</html>
