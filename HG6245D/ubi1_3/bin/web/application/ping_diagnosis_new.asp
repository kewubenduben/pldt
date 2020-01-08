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
var GetWANsizeSync = '<% wanNameSync(); %>';	

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

	var ping_times = getElement("ping_times");
	if(!CheckNotNull(ping_times.value))
	{
			alert(_("diagnosisTimesNullAlert"));
			ping_times.value = ping_times.defaultValue;
			ping_times.focus();
			return false;
	}
	else				//数字
	{
		var reg = /^[\d]{1,}$/;	//数字
		if (!reg.test(ping_times.value))
		{
			alert(_("diagnosisTimesIllegalAlert"));
			ping_times.value = ping_times.defaultValue;
			ping_times.focus();
			return false; 
		}
		else
		{
			ping_times.value = parseInt(ping_times.value);
			if(ping_times.value < 1 || ping_times.value > 10)//[1, 10]
			{
				alert(_("diagnosisTimesIllegalAlert"));
				ping_times.value = ping_times.defaultValue;
				ping_times.focus();
				return false; 
			}
		}
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
	

	sendRequest();
	intervalId = setInterval("requestHandler();", 100);//0.1s
	
	return true;
}

function sendRequest()
{
	var ping_ip = document.getElementById("ping_ip");
	var ping_wan = document.getElementById("ping_wan");
	var ping_times = document.getElementById("ping_times");
	
	requestNum++;	
	
	request.onreadystatechange = requestHandler;          // set request handler
	//request.open('GET','/goform/setPing?ping_ip=' + ping_ip.value + '&requestNum=' + ping_times.value + '&ping_times=' + ping_times.value + '&ping_wan=' + ping_wan.value + '&diagtype=' + diagtype + '&' + Math.random(), true); // open asynchronus request  
	request.open('GET','/goform/ping_diagnosis?ping_ip=' + ping_ip.value + '&ping_times=' + ping_times.value + '&ping_wan=' + ping_wan.value + '&requestNum=' + requestNum + '&diagtype=' + diagtype + '&' + Math.random(), true); // open asynchronus request  
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
			
				ping_apply.disabled = false;
				
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
	var e = document.getElementById("diagnosis_ping_prompt");
	e.innerHTML = _("diagnosis_ping_prompt");
    e = document.getElementById("ping_ip_title");
	e.innerHTML = _("ping_ip_title");	
    e = document.getElementById("ping_wan_title");
	e.innerHTML = _("diagnosis_interface_title");		
    e = document.getElementById("ping_times_title");
	e.innerHTML = _("diagnosis_times_title");
	
    e = document.getElementById("ping_apply");
	e.value = _("diagnosis_apply");
}

function initValue()
{
	initTranslation();
	
	var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
	var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
	var wannameArray = wanname_all.split("|");
	var device_type = '<% getCfgGeneral(1, "device_type");%>';
	var wannameText_all;
	if(device_type == 0)	/* SFU */
	{
		wannameText_all = wanname_all;
	}
	else		
	{
		wannameText_all = '<% getCfgGeneral(1, "tr069_wan_name_all"); %>';
	}
	var wannameTextArray = wannameText_all.split("|");
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	var ping_wan = document.getElementById("ping_wan");	
	for(var i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R_") >= 0)//route
		{
			ping_wan.options[ping_wan.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			ping_wan.options[ping_wan.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}

	ping_wan.options[ping_wan.length] = new Option("LAN", "LAN");
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
                <td id="diagnosis_ping_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" width="10%" id="ping_wan_title">Interface</td>
        <td class="tabal_right" width="30%"><select id="ping_wan" name="ping_wan" size="1" style="width:35%" >
          </select>
        </td>
        </td>
      </tr> 
         <tr>
        <td class="tabal_left" width="10%" id="ping_times_title">Repeated Times</td>
        <td class="tabal_right"  ><input type="text" style="width:34%" name="ping_times" id="ping_times" value="4">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong><span class="gray">&nbsp;(1-10)</span>
        </td>
      </tr> 
     <tr>
        <td class="tabal_left" width="10%" id="ping_ip_title"></td>
        <td class="tabal_right"  ><input type="text" style="width:34%" name="ping_ip" id="ping_ip" value="<% getCfgGeneral(1, "ping_ip"); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong>
        </td>
      </tr> 

     </tbody>
   </table>


   <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="button" value="Diagnosis" id="ping_apply" onClick="CheckForm(1)">
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
</body>
</html>

