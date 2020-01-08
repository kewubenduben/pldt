<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/ajaxupload.3.2.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Diagnosis</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var pingRst = 1;//running
var pingTxt = 0;
var intervalId;
var request;
var diagtype;

function fw_checkIP(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
//		alert("请输入合法ip!");
		alert(_("diagnosis_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function CheckForm(temp)
{
	var ping_ip = document.getElementById("ping_ip");
	
	var ping_apply = document.getElementById("ping_apply");
	var ping_text = document.getElementById("ping_text");
	var trace_apply = document.getElementById("trace_apply");
	
	diagtype = temp;
	
	if(!CheckNotNull(ping_ip.value))
	{
		alert(_("Plesae input address!"));
		ping_ip.value = ping_ip.defaultValue;
		ping_ip.focus();
		return false;
	}
	if(checkSpecialChar("|",ping_ip.value))
	{
		alert(_("The address you input is illegal."));
		ping_ip.value = ping_ip.defaultValue;
		ping_ip.focus();
		return false;
	}
	if(!checkDiagnosisAddr(ping_ip.value))
	{
		alert(_("The address you input is illegal."));
		ping_ip.value = ping_ip.defaultValue;
		ping_ip.focus();
		return false;
	}

	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		request=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		request=new ActiveXObject("Microsoft.XMLHTTP");
	}

	//first ping, init var
	requestNum = "0";
	ping_text.value = "";
	ping_apply.disabled = true;
	trace_apply.disabled = true;

	sendRequest();
	intervalId = setInterval("requestHandler();", 100);//0.1s
	
	return true;
}

function sendRequest()
{
	var ping_ip = document.getElementById("ping_ip");
	
	requestNum++;	
	
	request.onreadystatechange = requestHandler;          // set request handler
	request.open('GET','/goform/setPing?ping_ip=' + ping_ip.value + '&requestNum=' + requestNum + '&diagtype=' + diagtype + '&' + Math.random(), true); // open asynchronus request  
	request.send(null);                                   // send request
}

function requestHandler()
{
	var ping_text = document.getElementById("ping_text");
	
	if (request.readyState == 4)
	{// if state = 4 (the operation is completed)
		if (request.status == 200 || request.status == 0)
		{// and the HTTP status is OK
			//get progress from the XML node and set progress bar width and innerHTML  
			var array = request.responseText.split("|");
			pingRst = array[0];
			pingTxt = array[1];
			
			if (array[1] && array[1] !="")
				ping_text.value += array[1];

			if (pingRst == 2 || pingRst == 0)//error or finished
			{
				var ping_apply = document.getElementById("ping_apply");
				var trace_apply = document.getElementById("trace_apply");
				ping_apply.disabled = false;
				trace_apply.disabled = false;
				clearInterval(intervalId);
				return;
			}
			if (pingRst == 1)//running
			{
				sendRequest();
			}	
		}  
		else
		{// if request status is different then 200
			pingRst = 2;//error
		}
	}
}

function initTranslation()
{
	var e = document.getElementById("diagnosis_prompt");
	e.innerHTML = _("diagnosis_prompt");
    e = document.getElementById("ping_ip_title");
	e.innerHTML = _("ping_ip_title");	
}

function initValue()
{
	initTranslation();
}


</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_ping">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="diagnosis_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr>
        <td></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
     <tr>
        <td class="tabal_left" width="10%" id="ping_ip_title">Destination Address</td>
        <td class="tabal_right" width="30%" ><input type="text" name="ping_ip" id="ping_ip" value="<% getCfgGeneral(1, "ping_ip"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong>
        </td>
      </tr> 

     </tbody>
   </table>


   <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="button" value="Ping" id="ping_apply" onClick="CheckForm(1)">
		&nbsp; <input class="submit" type="button" value="Traceroute" id="trace_apply" onClick="CheckForm(2)">
        </td>
      </tr>
    </tbody>
  </table>

   <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
     <tr>
      <textarea rows="20" cols="112" readonly="readonly" id="ping_text"></textarea>
     </tr>
     </tbody>
   </table>     

</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>

