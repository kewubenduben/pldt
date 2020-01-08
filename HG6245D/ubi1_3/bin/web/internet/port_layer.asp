<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>LAN Port Band</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var port_layer_sync = '<% port_layer_sync(); %>';
var wan_portbind_sync = '<% wan_portbind_sync(); %>';
var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
function initTranslation()
{
}

function showPortFELayer()
{
	var checkedFEValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	
	var portfe_layerData = "<% getCfgGeneral(1, 'portfe_layer'); %>";
	var portfe_layerArr = portfe_layerData.split(",");
	
	var wanFEBoxNode = getElement("wan_feBox");
	
	/*lan band 勾选*/
	for(var i = 0; i < 4; i++)
	{
		if(portfe_layerArr[i] == checkedFEValue[i])
		{
			wanFEBoxNode[i].checked = true;			
		}
		else
		{
	        wanFEBoxNode[i].checked =  false;
		}		
	}
}

function setPortDisable()
{	
	var checkedFEValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);
	
	var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
	var wan_fe_bindData = "<% getCfgGeneral(1, 'wan_fe_bind'); %>";
	var wan_fe_bindArray = wan_fe_bindData.split("|");
	
	var wanFEBoxNode = getElement("wan_feBox");
	for(var i = 0; i < wan_size; i++)
	{
		var curFEArr = wan_fe_bindArray[i].split(",");
		
		for(var j = 0; j < lan_port_num; j++)/*lan band 勾选*/
		{
			if(curFEArr[j] == checkedFEValue[j])
			{
				wanFEBoxNode[j].disabled = 1;
			}
		}
	}
}
function initValue()
{
//	initTranslation();
	
	var portfe_layer_config = '<% getCfgGeneral(1, "portfe_layer_config"); %>';
	if(portfe_layer_config == '1')
	{
		makeRequest("/goform/reboot", "n/a", portLayerHandler);
	}
	
	setDisplay("wan_feBox2", "none");
	setDisplay("wan_feBox3", "none");
	setDisplay("wan_feBox4", "none");
	if(parseInt(lan_port_num) >= 1)
	{
		setDisplay("wan_feBox1", "");
	}
	if(parseInt(lan_port_num) >= 2)
	{
		setDisplay("wan_feBox2", "");
	}
	if(parseInt(lan_port_num) >= 3)
	{
		setDisplay("wan_feBox3", "");
	}
	if(parseInt(lan_port_num) >= 4)
	{
		setDisplay("wan_feBox4", "");
	}

	showPortFELayer();
	setPortDisable();
	
}
function portLayerHandler(http_request)
{
	var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';
	var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
	if (http_request.readyState == 4)									//the operation is completed
	{
		setDisplay("div_apply", "none");
		if (http_request.status == 200)// and the HTTP status is OK 
		{ 
			var errorCode = http_request.responseText;
			if(errorCode == "0")
			{
				getElement("div_info").innerHTML = _("rebooting");
				waitToLogin(ispName, curUserType);
			}
			else
			{
				getElement("div_info").innerHTML = errorCode;
			}
		 }  
		else													// if request status is different then 200  
		{
			getElement("div_info").innerHTML = 'Error: ['+http_request.status+'] ' + http_request.statusText;  			
		}
	}
}
function CheckValue()
{
	if(!confirm(_("portLayerConfig_confirm")))
	{
		return false;
	}
	
	var wanFEBoxNode = getElement("wan_feBox");		
	for(var j = 0; j < lan_port_num; j++)
	{
		wanFEBoxNode[j].disabled = 0;
	}
	return true;
}
	
</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="portLayer_form" action="/goform/set_portlayer" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="port_layer_prompt" class="title_01" style="padding-left: 10px;" width="100%">On this page, you can configure LAN ports as Layer 3 ports by selecting the corresponding check boxes. The Layer 3 ports will be assigned as HG ports.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <div id="div_apply">
    <table id="tb_portLayer" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_right"><div id="div_lan1"> <span>LAN 1</span>
              <input type="checkbox" name="wan_feBox" id="wan_feBox1" value="1">
            </div></td>
          <td class="tabal_right" ><div id="div_lan2"> <span>LAN 2</span>
              <input type="checkbox" name="wan_feBox" id="wan_feBox2" value="2">
            </div></td>
          <td class="tabal_right" ><div id="div_lan3"> <span>LAN 3</span>
              <input type="checkbox" name="wan_feBox" id="wan_feBox3" value="4">
            </div></td>
          <td class="tabal_right" ><div id="div_lan4"> <span>LAN 4</span>
              <input type="checkbox" name="wan_feBox" id="wan_feBox4" value="8">
            </div>
          <td>
        </tr>
      </tbody>
    </table>
    <input type="hidden" name="curIndex" id="curIndex" value="0">
    <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
      <tbody>
        <tr>
          <td class="tabal_submit" width="25%"></td>
          <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="portLayer_apply">
            <input class="submit" type="reset" value="Cancel" id="portLayer_cancel"onclick="window.location.reload();" >
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <div id="div_info"></div>
</form>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
