<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>CPU Port Mirror</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;
web_access_check_admin(ispName, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';

function initTranslation()
{
	var e = document.getElementById("cpu_port_mirror_prompt");
	e.innerHTML = _("cpu_port_mirror_prompt");

	e = document.getElementById("mirror_title");
	e.innerHTML = _("mirror_title");
	e = document.getElementById("mirror_d_title");
	e.innerHTML = _("mirror_d_title");

	e = document.getElementById("mirror_enable1");
	e.innerHTML = _("inet enable");
	e = document.getElementById("mirror_disable1");
	e.innerHTML = _("inet disable");
	e = document.getElementById("mirror_Enable_title");
	e.innerHTML = _("inet enable");
	e = document.getElementById("direction_title");
	e.innerHTML = _("direction_title");
	e = document.getElementById("up_title");
	e.innerHTML = _("up_title");
	e = document.getElementById("down_title");
	e.innerHTML = _("down_title");	
	e = document.getElementById("both_title");
	e.innerHTML = _("both_title");	
	

	e = document.getElementById("apply_title");
	e.value = _("inet apply");
	e = document.getElementById("cannel_title");
	e.value = _("inet cancel");
}

function CheckForm()
{
	
}

function initValue()
{
	initTranslation();

	var eth3mirrorEnable = document.getElementsByName("mirrorport_enable");
	var mirror_port_str = document.getElementById("port_mirror");
	var port_mirror_d_str = document.getElementById("port_mirror_d");
	var port_mirror_direcion_str = document.getElementById("port_mirror_direction");

	if(parseInt(lan_port_num) == 1)
	{
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan1", "1");
	}
	if(parseInt(lan_port_num) == 2)
	{
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan1", "1");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan2", "2");
	}
	if(parseInt(lan_port_num) == 3)
	{
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan1", "1");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan2", "2");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan3", "3");
	}
	if(parseInt(lan_port_num) == 4)
	{
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan1", "1");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan2", "2");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan3", "3");
		port_mirror_d_str.options[port_mirror_d_str.length] = new Option("Lan4", "4");
	}

	//delete by wuxj, 20180521, 所有版本均删除VOIP.需求来源:钱凯
	//add by wuxj, 20171228, for TIM
//	if(ispName == '26' || ispName == '28')//TIM/墨西哥TOTALPLAY
	{
		mirror_port_str.options.remove(1);	//delete voip
	}
	
	var mirror_port ='<% getCfgGeneral(1, "port_mirror"); %>';
	showSelectNodeByValue(mirror_port_str, mirror_port);

	var port_mirror_d ='<% getCfgGeneral(1, "port_mirror_d"); %>';
	showSelectNodeByValue(port_mirror_d_str, port_mirror_d);

	var mirrorport_port ='<% getCfgGeneral(1, "mirrorport_enable"); %>';
	showRadioNodeByValue(eth3mirrorEnable, mirrorport_port)
	
	var port_mirror_direction_value ='<% getCfgGeneral(1, "port_mirror_direction"); %>';
	showSelectNodeByValue(port_mirror_direcion_str, port_mirror_direction_value)

}

/*function selectPortChanged()
{ 
	var port_mirror = document.getElementById("port_mirror").options.selectedIndex;
	var eth3mirrorEnable = document.getElementsByName("eth3mirrorEnable");
	
	if(port_mirror == 0)
	for(var i = 0;i<eth3mirrorEnable.length;i++)
	{
		if(eth3mirrorEnable[i].value == '<% getCfgGeneral(1, "mirror_enable3"); %>')
		{
			eth3mirrorEnable[i].checked = true;
			break;
		}
	}
	else if(port_mirror == 1)
	for(var i = 0;i<eth3mirrorEnable.length;i++)
	{
		if(eth3mirrorEnable[i].value == '<% getCfgGeneral(1, "mirror_enable4"); %>')
		{
			eth3mirrorEnable[i].checked = true;
			break;
		}
	}   
	else if(port_mirror == 2)
	for(var i = 0;i<eth3mirrorEnable.length;i++)
	{
		if(eth3mirrorEnable[i].value == '<% getCfgGeneral(1, "mirror_enable5"); %>')
		{
			eth3mirrorEnable[i].checked = true;
			break;
		}
	}

}*/


</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_mirror" action="/goform/set_cpu_portmirror" onSubmit="return CheckForm()">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="title_01" id="cpu_port_mirror_prompt" style="padding-left: 10px;" width="100%"> 在本页面上，您可以进行端口镜像配置。 </td>
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
        <td class="tabal_left" width="15%" id="mirror_Enable_title">Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="80%"><input checked="checked" value="0" name="mirrorport_enable" type="radio">
          <font id="mirror_disable1">Disable</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="1" name="mirrorport_enable" type="radio">
          <font id="mirror_enable1" >Enable</font></td>
      </tr>
      <tr>
        <td class="tabal_left" width="15%" id="mirror_title">Source port</td>
        <td class="tabal_right" align="left"><select name="port_mirror" id="port_mirror" size="1" style="width:200px;">
            <option value="1" selected="selected">Pon</option>
            <option value="2">Voip</option>
            <!--option value="3">wan0</option>
            <option value="4">wan1</option>
            <option value="5">wan2</option>
            <option value="6">wan3</option-->
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" width="15%" id="mirror_d_title">Destination  port</td>
        <td class="tabal_right" align="left"><select name="port_mirror_d" id="port_mirror_d" size="1" style="width:200px;" >
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" width="15%" id="direction_title">Direction</td>
        <td class="tabal_right" align="left"><select name="port_mirror_direction" id="port_mirror_direction" size="1" style="width:200px;">
            <option value="0" selected="selected" id="up_title">Up</option>
            <option value="1" id="down_title">Down</option>
            <option value="2" id="both_title">Both</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" id="apply_title" name="apply_title" value="Apply" type="submit">
          <input class="submit" id="cannel_title" name="cannel_title" onClick="window.location.reload();" value="Cancel" type="reset">
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
