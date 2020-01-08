<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Voip Diagnosis</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
web_access_check( checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("voip", lang);

function initTranslation()
{
}
function LoadFrame()
{ 
	initTranslation();
	var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>';
	var portNode1 = getElement("voip_portloop");
	var portNode2 = getElement("voip_portcir");
	for(var i = 0; i < voip_port_num; i++ )
	{
		portNode1.options[portNode1.length] = new Option(i + 1, i + 1);
		portNode2.options[portNode2.length] = new Option(i + 1, i + 1);
	}
	getElement("cirTestGetRst").disabled = true;
	getElement("loopTestGetRst").disabled = true;
}
var curTestType;
var intervalId;
var testRequest = getRequest();

function voipTest(type)
{
	curTestType = type;
	
	getElement("cirTest").disabled = true;
	getElement("loopTest").disabled = true;
	getElement("cirTestGetRst").disabled = true;
	getElement("loopTestGetRst").disabled = true;

	getElement('voip_result' + curTestType).innerHTML = "Testing......Please wait.";

	if(curTestType == 'loop')
		initLoopRst();
	else
		initCirRst();

	sendVoipTestRequest();
}
function sendVoipTestRequest()
{
	var voip_port = getElement("voip_port" + curTestType);
	var voip_forst = getElement("voip_forst" + curTestType);
	
	var content = "type=" + curTestType;
	content += "&voip_port=" + voip_port.value
			+ "&voip_forst=" + voip_forst.value;
	content = content + "&x-csrftoken=" + getCsrftoken();
	
	if (!testRequest) {
		alert("Giving up :( \nCannot create an XMLHTTP instance!");
		return false;
	}
	
	testRequest.onreadystatechange = sendVoipTestHandler;

	testRequest.open('POST', "/goform/voipTest", true);
	testRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	testRequest.send(content);
}
function voipTestError()
{
	getElement("cirTest").disabled = false;
	getElement("loopTest").disabled = false;
}
function voipTestFinish()
{
	getElement("cirTest").disabled = false;
	getElement("loopTest").disabled = false;
	
	if(curTestType == 'loop')
		getElement("loopTestGetRst").disabled = false;
	else
		getElement("cirTestGetRst").disabled = false;
	clearInterval(intervalId);
	getElement('voip_result' + curTestType).innerHTML = "Test completed. You could get the result.";
}
function sendVoipTestHandler()
{
	if (testRequest.readyState == 4)									//the operation is completed
	{
		if (testRequest.status == 200)// and the HTTP status is OK 
		{ 
			var voipTestRst = testRequest.responseText;
			if(voipTestRst == "1")
			{	
				intervalId = setInterval("voipTestFinish();", 35000);//35s
				return;
			}
			else
			{
				voipTestError();
				getElement('voip_result' + curTestType).innerHTML = '<% getCfgGeneral(1, "voip_result"); %>';
				return ;				
			}
		}  
		else													// if request status is different then 200  
		{
			getElement('voip_result' + curTestType).innerHTML = "Server error! Please try again!";
		}
	}
}

function getVoipTestRst()
{
	var voip_port = getElement("voip_port" + curTestType);
	
	if(curTestType == 'loop')
	{
		makeRequest("/goform/get_voip_looptestrst", "port=" + voip_port.value, loopRstHandler);
	}
	else
		makeRequest("/goform/get_voip_cirtestrst", "port=" + voip_port.value, cirRstHandler);

}
function loopRstHandler(http_request)
{
	if (http_request.readyState == 4)		//the operation is completed
	{
		if (http_request.status == 200)		// and the HTTP status is OK 
		{
			showLoopRst(http_request.responseText);
		}  
		else									// if request status is different then 200  
		{
			getElement('voip_result' + curTestType).innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}
function cirRstHandler(http_request)
{
	if (http_request.readyState == 4)		//the operation is completed
	{
		if (http_request.status == 200)		// and the HTTP status is OK 
		{
			showCirRst(http_request.responseText);
		}  
		else									// if request status is different then 200  
		{
			getElement('voip_result' + curTestType).innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}
function initLoopRst()
{
	getElement('voip_AG_ACVol').innerHTML = '';
	getElement('voip_BG_ACVol').innerHTML = '';
	getElement('voip_AB_ACVol').innerHTML = '';
	getElement('voip_AG_DCVol').innerHTML = '';
	getElement('voip_BG_DCVol').innerHTML = '';
	getElement('voip_AB_DCVol').innerHTML = '';
	getElement('voip_AG_Res').innerHTML = '';
	getElement('voip_BG_Res').innerHTML = '';
	getElement('voip_AB_Res').innerHTML = '';
	getElement('voip_AG_Cap').innerHTML = '';
	getElement('voip_BG_Cap').innerHTML = '';
	getElement('voip_AB_Cap').innerHTML = '';
}
function showLoopRst(rst)
{
	var array = rst.split("\r");
	getElement('voip_AG_ACVol').innerHTML = array[0];
	getElement('voip_BG_ACVol').innerHTML = array[1];
	getElement('voip_AB_ACVol').innerHTML = array[2];
	getElement('voip_AG_DCVol').innerHTML = array[3];
	getElement('voip_BG_DCVol').innerHTML = array[4];
	getElement('voip_AB_DCVol').innerHTML = array[5];
	getElement('voip_AG_Res').innerHTML = array[6];
	getElement('voip_BG_Res').innerHTML = array[7];
	getElement('voip_AB_Res').innerHTML = array[8];
	getElement('voip_AG_Cap').innerHTML = array[9];
	getElement('voip_BG_Cap').innerHTML = array[10];
	getElement('voip_AB_Cap').innerHTML = array[11];
}
function initCirRst()
{
	getElement('voip_loopCurr').innerHTML = '';
	getElement('voip_feedVol').innerHTML = '';
	getElement('voip_ringVol').innerHTML = '';
	getElement('voip_loopCurrRst').innerHTML = '';
	getElement('voip_feedVolRst').innerHTML = '';
	getElement('voip_ringRst').innerHTML = '';
}
function showCirRst(rst)
{
	var array = rst.split("\r");
	var voip_loopCurr = array[0];
	var voip_feedVol = array[1];
	var voip_ringVol = array[2];
	
	getElement('voip_loopCurr').innerHTML = voip_loopCurr;
	getElement('voip_feedVol').innerHTML = voip_feedVol;
	getElement('voip_ringVol').innerHTML = voip_ringVol;

	voip_loopCurr = parseInt(voip_loopCurr);
	if((0 <= voip_loopCurr && voip_loopCurr <= 3) 
			|| (18 <= voip_loopCurr && voip_loopCurr <= 80))
		getElement('voip_loopCurrRst').innerHTML = 'Normal';
	else
		getElement('voip_loopCurrRst').innerHTML = 'Abnormal';

	voip_feedVol = parseInt(voip_feedVol);
	if((30 <= voip_feedVol && voip_feedVol <= 60) 
			|| (5 <= voip_feedVol && voip_feedVol <= 15))
		getElement('voip_feedVolRst').innerHTML = 'Normal';
	else
		getElement('voip_feedVolRst').innerHTML = 'Abnormal';

	voip_ringVol = parseInt(voip_ringVol);
	if(11 <= voip_ringVol && voip_ringVol <= 13)
		getElement('voip_ringRst').innerHTML = 'Normal';
	else
		getElement('voip_ringRst').innerHTML = 'Abnormal';

}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="voip_diagnosisPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can diagnose VoIP services by performing loop and curcuit tests. Before performing a circuit test, disconnect the phone from the ONT.</td>
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
    <tr class="tabal_head">
      <td colspan="2" id="voip_loopTestTitle">Loop Test</td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_portTitle1" width="25%">POTS Port</td>
      <td class="tabal_right"><select name="voip_portloop" size="1" style="width:100px;">
        </select></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_loopForstTitle">Forst Test On Busy</td>
      <td class="tabal_right"><input type="checkbox" name="voip_forstloop" value="1"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="tabal_submit" width="25%"></td>
      <td class="tabal_submit" align="left"><input class="submit" onClick="voipTest('loop')" id="loopTest" value="Start Test" type="button"/>
        <input class="submit" onClick="getVoipTestRst('loop')" id="loopTestGetRst" value="Obtain Result" type="button"/>
      </td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="tabal_left" id="voip_resultTitle1" width="25%">Test Result</td>
      <td class="tabal_right" id="voip_resultloop"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AG_ACVolTitle">A->Ground AC Voltage(V)</td>
      <td class="tabal_right" id="voip_AG_ACVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_BG_ACVolTitle">B->Ground AC Voltage(V)</td>
      <td class="tabal_right" id="voip_BG_ACVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AB_ACVolTitle">A->B AC Voltage(V)</td>
      <td class="tabal_right" id="voip_AB_ACVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AG_DCVolTitle">A->Ground DC Voltage(V)</td>
      <td class="tabal_right" id="voip_AG_DCVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_BG_DCVolTitle">B->Ground DC Voltage(V)</td>
      <td class="tabal_right" id="voip_BG_DCVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AB_DCVolTitle">A->B DC Voltage(V)</td>
      <td class="tabal_right" id="voip_AB_DCVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AG_ResTitle">A->Ground Resistance(ohm)</td>
      <td class="tabal_right" id="voip_AG_Res"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_BG_ResTitle">B->Ground Resistance(ohm)</td>
      <td class="tabal_right" id="voip_BG_Res"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AB_ResTitle">A->B Resistance(ohm)</td>
      <td class="tabal_right" id="voip_AB_Res"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AG_CapTitle">A->Ground Capacitance(nF)</td>
      <td class="tabal_right" id="voip_AG_Cap"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_BG_CapTitle">B->Ground Capacitance(nF)</td>
      <td class="tabal_right" id="voip_BG_Cap"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_AB_CapTitle">A->B Capacitance(nF)</td>
      <td class="tabal_right" id="voip_AB_Cap"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="voip_cirTestTitle">Circuit Test</td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_portTitle2" width="25%">POTS Port</td>
      <td class="tabal_right"><select name="voip_portcir" size="1" style="width:100px;">
        </select></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_cirForstTitle">Forst Test On Busy</td>
      <td class="tabal_right"><input type="checkbox" name="voip_forstcir" value="1"></td>
    </tr>
  </tbody>
</table>
<table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="tabal_submit" width="25%"></td>
      <td class="tabal_submit" align="left"><input class="submit" onClick="voipTest('cir')" id="cirTest" value="Start Test" type="button"/>
        <input class="submit" onClick="getVoipTestRst('cir')" id="cirTestGetRst" value="Obtain Result" type="button"/>
      </td>
    </tr>
  </tbody>
</table>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td class="tabal_left" id="voip_resultTitle2" width="25%">Test Result</td>
      <td class="tabal_right" id="voip_resultcir"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_loopCurrRstTitle" width="25%">Loop Current Test Result</td>
      <td class="tabal_right" id="voip_loopCurrRst"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_feedVolRstTitle">Feed Voltage Test Result</td>
      <td class="tabal_right" id="voip_feedVolRst"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_ringRstTitle">Ringing Test Result</td>
      <td class="tabal_right" id="voip_ringRst"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_loopCurrTitle">Loop Current(mA)</td>
      <td class="tabal_right" id="voip_loopCurr"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_feedVolTitle">Feed Voltage(mV)</td>
      <td class="tabal_right" id="voip_feedVol"></td>
    </tr>
    <tr>
      <td class="tabal_left" id="voip_ringVolTitle">Ringing Voltage(mV)</td>
      <td class="tabal_right" id="voip_ringVol"></td>
    </tr>
  </tbody>
</table>
<br>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
