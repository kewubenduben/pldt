<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan.js"></script>
<title>Parental Control</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check(checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var parent_control = '<% parental_control_sync( ); %>';

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var lan_port_num_10g = '<% getCfgGeneral(1, "lan_port_num_10g"); %>';
var G10_LAN_FLAG = '<% getCfgGeneral(1, "G10_LAN_FLAG"); %>';
var lanSum;

function showFESSID(wanIndex)
{
	var checkedFEValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	var checkedSSIDValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	
	var feData = "<% getCfgGeneral(1, 'pc_fe_port'); %>";
	var feArr = feData.split(",");
	var ssidData = "<% getCfgGeneral(1, 'pc_ssid_port'); %>";
	var ssidArr = ssidData.split(",");
	
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	
	/*lan band 勾选*/
	for(var i = 0; i < lanSum; i++)
	{
		if(feArr[i] == checkedFEValue[i])
		{
			wanFEBoxNode[i].checked = true;			
		}
		else
		{
	        wanFEBoxNode[i].checked =  false;	
		}		
	}
	/*ssid band 勾选*/
	for(var i = 0; i < 8; i++)
	{
		if(ssidArr[i] == checkedSSIDValue[i])
		{
			wanSsidBoxNode[i].checked = true;			
		}
		else
		{
	        wanSsidBoxNode[i].checked =  false;	
		}
	}
}
function LoadFrame()
{
	var controlCheckNode = getElement("enable_parental_control_check");
	var controlCheck = "<% getCfgGeneral(1, 'pc_ctl'); %>";
	showCheckboxNodeByValue(controlCheckNode, controlCheck);
	
	if(parseInt(G10_LAN_FLAG) == 1)
	{
		lanSum = parseInt(lan_port_num) + parseInt(lan_port_num_10g);
		setDisplay("wan_10GEBox_title", "");
		setDisplay("wan_10GEBox", "");
	}
	else
	{
		lanSum = parseInt(lan_port_num);
		setDisplay("wan_10GEBox_title", "none");
		setDisplay("wan_10GEBox", "none");
	}

	var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num");%>';
	if(parseInt(wifi_chip_num) > 1)
		setDisplay("tr_5gssidBind", "");
	else
		setDisplay("tr_5gssidBind", "none");
	showFESSID();
}

function checkValue()
{
	var startHourNode = getElement("pc_s_hour");
	if(!checkHourLegal(startHourNode))
	{
		alert("Please enter valid time!");
		return false;
	}
	var endHourNode = getElement("pc_e_hour");
	if(!checkHourLegal(endHourNode))
	{
		alert("Please enter valid time!");
		return false;
	}
	if(parseInt(startHourNode.value) > parseInt(endHourNode.value))
	{
		alert("Start time couldn't be greater than end time!");
		startHourNode.value = startHourNode.defaultValue;
		startHourNode.focus();
		return false;
	}
	var startMinNode = getElement("pc_s_min");
	if(!checkMinLegal(startMinNode))
	{
		alert("Please enter valid time!");
		return false;
	}
	var endMinNode = getElement("pc_e_min");
	if(!checkMinLegal(endMinNode))
	{
		alert("Please enter valid time!");
		return false;
	}
	
	/*add begin by郭心悦,20161129,
		当hour为24时，min只能为0；当hour相同时，pc_s_min需小于等于pc_e_min*/
	if(startHourNode.value == "24" && startMinNode.value != "0" && startMinNode.value != "00")
	{
		alert("Start hour is 24, minute must be zero!");
		startMinNode.value = startMinNode.defaultValue;
		startMinNode.focus();
		return false;		
	}
	if(endHourNode.value == "24" && endMinNode.value != "0" && endMinNode.value != "00")
	{
		alert("End hour is 24, minute must be zero!");
		endMinNode.value = endMinNode.defaultValue;
		endMinNode.focus();
		return false;		
	}	
	if(startHourNode.value == endHourNode.value)
	{
		if(parseInt(startMinNode.value)> parseInt(endMinNode.value))
		{
			alert("Start time couldn't be greater than end time!");
			startMinNode.value = startMinNode.defaultValue;
			startMinNode.focus();
			return false;
		}	
	}
	/*add end by郭心悦,20161129*/
	
	var wanFEBoxNode = getElement("wan_feBox");
	var wanSsidBoxNode = getElement("wan_ssidBox");
	var wifi_ssid_sum = "<% getCfgGeneral(1, 'wifi_ssid_sum'); %>";
	var portBindNum = getPortBindNum(wanFEBoxNode, wanSsidBoxNode, wifi_ssid_sum);
	if(portBindNum == 0)
	{
		alert("Please bind port!");
		return false;
	}
	return true;	
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<form method="post" name="parental control" action="/goform/set_parental_control" onSubmit="return checkValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="wan_prompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure parental control with time management for LAN and WLAN. <br>Note：Enable or disable any SSID on the configuration web may lead to reconnecion of all the SSIDs.</td>
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
        <td class="tabal_right" width="25%" ><input type="checkbox" name="enable_parental_control_check" id="enable_parental_control_check" checked="CheckSwitch();" value="1">
          <span class="tabal_right" id="checkboxTips">Enable Parental Control</span></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_right" width="25%" id="startTime_Title">Start Time</td>
        <td class="tabal_right"><input name="pc_s_hour" maxlength="2" style="width: 50px;" type="text" value="<% getCfgGeneral(1, 'pc_s_hour'); %>">
          &nbsp;hour
          &nbsp;&nbsp;:&nbsp;&nbsp;
          <input name="pc_s_min" maxlength="2" style="width: 50px;" type="text" value="<% getCfgGeneral(1, 'pc_s_min'); %>">
          &nbsp;min</td>
      </tr>
      <tr>
        <td class="tabal_right" id="endTime_Title">End Time</td>
        <td class="tabal_right"><input name="pc_e_hour" maxlength="2" style="width: 50px;" type="text" value="<% getCfgGeneral(1, 'pc_e_hour'); %>">
          &nbsp;hour
          &nbsp;&nbsp;:&nbsp;&nbsp;
          <input name="pc_e_min" maxlength="2" style="width: 50px;" type="text" value="<% getCfgGeneral(1, 'pc_e_min'); %>">
          &nbsp;min</td>
      </tr>
    </tbody>
  </table>
  <table id="port_bang" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr id="tr_feBind">
        <td width="25%" class="tabal_left" id="wan_FE_title">LAN Binding</td>
        <td class="tabal_right" ><span>LAN 1</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox1" value="1">
          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox2" value="2">
          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox3" value="4">
          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
          <input type="checkbox" name="wan_feBox" id="wan_feBox4" value="8">
		  &nbsp;&nbsp; &nbsp; <span id='wan_10GEBox_title'>10G LAN</span>
		  <input type="checkbox" name="wan_feBox" id="wan_10GEBox" value="16">
        <td>
      </tr>
      <tr id="tr_ssidBind">
        <td width="25%" class="tabal_left" id="wan_SSID_24g_title">2.4G SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="wan_ssidBox" value="1">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="wan_ssidBox" value="2">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="wan_ssidBox" value="4">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="wan_ssidBox" value="8">
        </td>
      </tr>
      <tr id="tr_5gssidBind">
        <td width="25%" class="tabal_left" id="wan_SSID_5g_title">5G SSID Binding</td>
        <td class="tabal_right"><span>SSID 1</span>
          <input type="checkbox" name="wan_ssidBox" value="16">
          &nbsp;&nbsp; <span>SSID 2</span>
          <input type="checkbox" name="wan_ssidBox" value="32">
          &nbsp;&nbsp; <span>SSID 3</span>
          <input type="checkbox" name="wan_ssidBox" value="64">
          &nbsp;&nbsp; <span>SSID 4</span>
          <input type="checkbox" name="wan_ssidBox" value="128">
        </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="accountSelf_Apply" class="submit">
          &nbsp; &nbsp;
          <input type="reset" name="Cancel" value="Cancel" id="accountSelf_Cancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
