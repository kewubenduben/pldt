<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>Port Multicast Vlan Band</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult);

var multi_vlan_band_sync = '<% multi_vlan_band_sync(); %>';
var vlanArray;

function portSwitch(curPort)
{
	getElement("vlan").value = vlanArray[curPort - 1];
}

function onClickSwitch(switchValue)
{
	if(switchValue == 0)	//disable
	{
		getElement("port").disabled = 1;
		getElement("vlan").disabled = 1;
	}
	else
	{
		getElement("port").disabled = 0;
		getElement("vlan").disabled = 0;
	}
}

function LoadFrame()
{
	initTranslation();

	var bindVlanAll = "<% getCfgGeneral(1, 'bindVlanAll'); %>";
	vlanArray = bindVlanAll.split("|");
	
	var portNode = getElement("port");
	var lan_port_num = "<% getCfgGeneral(1, 'lan_port_num'); %>";
	lan_port_num = parseInt(lan_port_num);	
	if(lan_port_num >= 1)
	{
		portNode.options[portNode.length] = new Option("Lan 1", "1");
	}
	if(lan_port_num >= 2)
	{
		portNode.options[portNode.length] = new Option("Lan 2", "2");
	}
	if(lan_port_num >= 3)
	{
		portNode.options[portNode.length] = new Option("Lan 3", "3");
	}
	if(lan_port_num >= 4)
	{
		portNode.options[portNode.length] = new Option("Lan 4", "4");
	}
	
	var enableNode = getElement("enable");
	var bindVlanEnable = "<% getCfgGeneral(1, 'bindVlanEnable'); %>";
	showRadioNodeByValue(enableNode, bindVlanEnable);
	onClickSwitch(bindVlanEnable);

	var lastCfgPort = '<% getCfgGeneral(1, "lastCfgPort");%>';
	showSelectNodeByValue(portNode, lastCfgPort);
	if(lastCfgPort == '')
		lastCfgPort = 1;
	portSwitch(parseInt(lastCfgPort));
}

function initTranslation()
{
}

</script>
</head>
<body class="mainbody" onload="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="portMulticastVlanBandPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configuration port multicast vlan banding.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" action="/goform/port_multi_vlan_band">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="portMulticastVlanBandTitle" align="left" width="25%">Bind Enable</td>
        <td class="tabal_right" align="left"><input checked="checked" value="1" name="enable" onclick="onClickSwitch(this.value)" type="radio">
          <font id="enable">Enable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="0" name="enable" onclick="onClickSwitch(this.value)" type="radio">
          <font id="disable">Disable</font></td>
      </tr>
      <tr>
        <td id="portbandTitle" class="tabal_left">Port</td>
        <td class="tabal_right"><select name="port" size="1" style="width:200px;" onChange="portSwitch(this.value);">
          </select>
        </td>
      </tr>
      <tr>
        <td id="multicastVlanTitle" class="tabal_left">VLAN</td>
        <td class="tabal_right"><input name="vlan" maxlength="160" size="15" style="width: 200px;" type="text">
          &nbsp;<span>(Such as: m1/n1;m2/n2;....)</span></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit"  id="apply" type="submit" value="Apply">
          <input class="submit" id="cancel" onclick="window.location.reload();" type="reset" value="Cancel">
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
