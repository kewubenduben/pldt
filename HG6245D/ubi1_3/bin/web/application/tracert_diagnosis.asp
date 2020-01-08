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

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var wanNameSync = '<% wanNameSync(); %>';	
var pingRst = 1;//running
var pingTxt = 0;
var intervalId;
var request = getRequest();
var requestNum;
function fw_checkIP(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	if(!validateIP(dom.value))
	{
//		alert("«Î ‰»Î∫œ∑®ip!");
		alert(_("diagnosis_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function checkForm()
{
	var diagnosis_ip = document.getElementById("diagnosis_ip");	

	if(!CheckNotNull(diagnosis_ip.value))
	{
		alert(_("Plesae input address!"));
		diagnosis_ip.value = diagnosis_ip.defaultValue;
		diagnosis_ip.focus();
		return false;
	}
	if(checkSpecialChar("|", diagnosis_ip.value))
	{
		alert(_("The address you input is illegal."));
		diagnosis_ip.value = diagnosis_ip.defaultValue;
		diagnosis_ip.focus();
		return false;
	}
	if(!checkDiagnosisAddr(diagnosis_ip.value))
	{
		alert(_("The address you input is illegal."));
		diagnosis_ip.value = diagnosis_ip.defaultValue;
		diagnosis_ip.focus();
		return false;
	}
	return true;
}
function submitForm()
{
	var tracert_text = document.getElementById("tracert_text");
	var diagnosis_apply = document.getElementById("diagnosis_apply");

	//first ping, init var
	requestNum = 0;
	tracert_text.value = "";
	diagnosis_apply.disabled = true;

	if(checkForm())
	{
		sendRequest();
		intervalId = setInterval("requestHandler();", 100);//0.1s
		
		return true;
	}
}

function sendRequest()
{
	var diagnosis_ip = document.getElementById("diagnosis_ip");
	var tracert_interface = document.getElementById("tracert_interface");
	
	requestNum++;	
	
	request.onreadystatechange = requestHandler;          // set request handler
	request.open('GET','/goform/tracert?diagnosis_ip=' + diagnosis_ip.value + 
		'&diagnosis_interface=' + tracert_interface.value + 
		'&requestNum=' + requestNum + '&' + Math.random(), true); // open asynchronus request  
	request.send(null);                                   // send request
}

function requestHandler()
{
	var tracert_text = document.getElementById("tracert_text");
	
	if (request.readyState == 4)
	{// if state = 4 (the operation is completed)
		if (request.status == 200 || request.status == 0)
		{// and the HTTP status is OK
			//get progress from the XML node and set progress bar width and innerHTML  
			var array = request.responseText.split("|");
			pingRst = array[0];
			pingTxt = array[1];
			
			if (array[1] && array[1] !="")
				tracert_text.value += array[1];

			if (pingRst == 2 || pingRst == 0)//error or finished
			{
				var diagnosis_apply = document.getElementById("diagnosis_apply");
				diagnosis_apply.disabled = false;
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
	var e = document.getElementById("tracert_prompt");
	e.innerHTML = _("tracert_prompt");
    e = document.getElementById("diagnosis_ip_title");
	e.innerHTML = _("ping_ip_title");
    e = document.getElementById("diagnosis_interface_title");
	e.innerHTML = _("diagnosis_interface_title");
	
    e = document.getElementById("diagnosis_apply");
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

	var tracertInterfaceNode = getElement("tracert_interface");
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	for(i = 0; i < wan_size; i++ )
	{
		if(wannameArray[i].search("_R_") >= 0)//route
		{
			tracertInterfaceNode.options[tracertInterfaceNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
		else if(ispNameCode == 5 && (wannameTextArray[i].search('<% getCfgGeneral(1, "aisTr069InternetWanName");%>') >= 0))	//HGU X_AIS
		{
			tracertInterfaceNode.options[tracertInterfaceNode.length] = new Option(wannameTextArray[i], wannameArray[i]);
		}
	}
	var curTracertInterface = '<% getCfgGeneral(1, "curTracertInterface");%>';
	for(var i = 0; i < tracertInterfaceNode.length; i++)
	{
		if(tracertInterfaceNode.options[i].value == curTracertInterface)
		{
			tracertInterfaceNode.options[i].selected = true;
			break;
		}
	}
}
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="tracert_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    <tr>
      <td height="5px"></td>
    </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" width="10%" id="diagnosis_ip_title">Destination Address</td>
        <td class="tabal_right" width="30%" ><input type="text" name="diagnosis_ip" id="diagnosis_ip" style="width:34%" value="<% getCfgGeneral(1, 'diagnosis_ip'); %>">
          &nbsp; &nbsp; <strong style="color:#FF0033">*</strong> </td>
      </tr>
      <tr>
        <td class="tabal_left" width="10%" id="diagnosis_interface_title">Interface</td>
        <td class="tabal_right" width="30%"><select id="tracert_interface" name="tracert_interface" size="1" style="width:35%">
          </select></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="button" value="Diagnosis" id="diagnosis_apply" onClick="submitForm()">
        </td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <textarea rows="20" cols="112" readonly="readonly" id="tracert_text"></textarea>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
