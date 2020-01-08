<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
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
	var portNode = getElement("voip_port");
	for(var i = 0; i < voip_port_num; i++ )
	{
		portNode.options[portNode.length] = new Option(i + 1, i + 1);
	}
}
function resetStatis()
{
	var tab = getElement("tb_statis");
	var rowLen = tab.rows.length;

	for(var i = rowLen - 1; i > 0; i--)
	{
		tab.deleteRow(i);
	}	
}
function updateStatis()
{
	var voip_port = getElement("voip_port");
	
	makeRequest("/goform/get_voip_statis", "port=" + voip_port.value, updateVoipStatisHandler);

}
function updateVoipStatisHandler(http_request)
{
	if(http_request.readyState == 4)		//the operation is completed
	{
		if(http_request.status == 200)		// and the HTTP status is OK 
		{
			var str = http_request.responseText;
			var array = str.split("\n");
			if(array[0] != '0')
			{
				getElement('updateError').innerHTML = 'Something went wrong with the server.';
			}
			else
			{
				getElement('updateError').innerHTML = '';
			}
			
			var newData = array[1].split("\r");
			var tab = getElement("tb_statis");
			addNewStatisRow(tab);
			addNewStatisData(tab, newData);
		}  
		else									// if request status is different then 200  
		{
			getElement('updateError').innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}
function addNewStatisRow(tab)
{
	var row;
	var rowLen = tab.rows.length;	
	
	row = tab.insertRow(rowLen);
	
	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'tabal_01';
		row.id = 'record_' + rowLen;
		row.align = 'center';
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','tabal_01');
		row.setAttribute('id','record_' + rowLen);
		row.setAttribute('align','center');
	}
	
	row.insertCell(0).innerHTML = '<input readonly="readonly" style="width:36px">';
	row.insertCell(1).innerHTML = '<input readonly="readonly" style="width:146px">';
	row.insertCell(2).innerHTML = '<input readonly="readonly" style="width:77px">';
	row.insertCell(3).innerHTML = '<input readonly="readonly" style="width:77px">';
	row.insertCell(4).innerHTML = '<input readonly="readonly" style="width:77px">';
	row.insertCell(5).innerHTML = '<input readonly="readonly" style="width:77px">';
	row.insertCell(6).innerHTML = '<input readonly="readonly" style="width:77px">';
	row.insertCell(7).innerHTML = '<input readonly="readonly" style="width:146px">';

}
function addNewStatisData(tab, newData)
{
	var curRow;
	var rowLen = tab.rows.length;

	if(rowLen > 0)
		curRow = tab.rows[rowLen - 1];
	else
		return ;
	
	var newRowID = rowLen - 1;
	
	curRow.cells[0].getElementsByTagName("input")[0].value = newRowID;

	for(var i = 1; i < 8; i++)
	{
		curRow.cells[i].getElementsByTagName("input")[0].value = newData[i - 1];
	}
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
              <td id="voip_diagnosisPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can query the statistics on the worst voice quality. The following network peformance counters are for your information only. Ideal network: packet loss rate = 0, mean jitter < 10 ms, mean delay < 10 ms.</td>
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
      <td class="tabal_left" id="voip_portTitle" width="25%">POTS Port</td>
      <td class="tabal_right" width="25%"><select name="voip_port" size="1" style="width:100px;">
        </select></td>
      <td class="tabal_right"><input class="submit" onClick="updateStatis()" id="update" value="Update Statistics" type="button"/>
        <input class="submit" onClick="resetStatis()" id="reset" value="Reset Statistics" type="button"/>
        <span id="updateError"></span></td>
    </tr>
  </tbody>
</table>
<table id="tb_statis" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_title" align="center">
      <td width="5%"  id="statis_noTitle">No.</td>
      <td width="20%" id="statis_timeTitle">Generation Time</td>
      <td width="11%" id="statis_sentTitle">Number of Sent Packets</td>
      <td width="11%" id="statis_receTitle">Number of Received Packets</td>
      <td width="11%" id="statis_delayTitle">Mean Delay(ms)</td>
      <td width="11%" id="statis_jitterTitle">Mean Jitter(ms)</td>
      <td width="11%" id="statis_lossRateTitle">Packet Loss Rate(%)</td>
      <td width="20%" id="statis_ipTitle">Remote IP Address</td>
    </tr>
  </tbody>
</table>
<br>
<table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td id="voip_cirTestTitle">Voice Service Abnormality Record </td>
    </tr>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="voip_diagnosisPrompt" style="padding-left: 10px;" class="title_01" width="100%">You can query voice service abnormality records, including registration abnormality and call abnormality records..</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
  </tbody>
</table>
<table border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td><textarea rows="20" cols="113" readonly="readonly"><% voip_error_record_sync(); %></textarea></td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
