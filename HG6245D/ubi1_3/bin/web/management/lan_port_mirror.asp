<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>UPNP</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';

function initTranslation()
{
	var e = document.getElementById("lan_port_mirror_prompt");
	e.innerHTML = _("lan_port_mirror_prompt");

	e = document.getElementById("lan_mirror_up_title");
	e.innerHTML = _("lan_mirror_up_title");
	e = document.getElementById("lan_mirror_down_title");
	e.innerHTML = _("lan_mirror_down_title");

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
	var lan_mirror_port ='<% getCfgGeneral(1, "lan_port_mirror"); %>';
	var mirror_port_up = document.getElementById("up_mirror");
	var mirror_port_down = document.getElementById("down_mirror");

	if(parseInt(lan_port_num) == 1)
	{
		mirror_port_up.options[mirror_port_up.length] = new Option("lan1", "1");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan1", "1");
	}
	if(parseInt(lan_port_num) == 2)
	{
		mirror_port_up.options[mirror_port_up.length] = new Option("lan1", "1");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan2", "2");

		mirror_port_down.options[mirror_port_down.length] = new Option("lan1", "1");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan2", "2");
	}
	if(parseInt(lan_port_num) == 3)
	{
		mirror_port_up.options[mirror_port_up.length] = new Option("lan1", "1");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan2", "2");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan3", "3");

		mirror_port_down.options[mirror_port_down.length] = new Option("lan1", "1");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan2", "2");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan3", "3");
	}
	if(parseInt(lan_port_num) == 4)
	{
		mirror_port_up.options[mirror_port_up.length] = new Option("lan1", "1");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan2", "2");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan3", "3");
		mirror_port_up.options[mirror_port_up.length] = new Option("lan4", "4");

		mirror_port_down.options[mirror_port_down.length] = new Option("lan1", "1");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan2", "2");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan3", "3");
		mirror_port_down.options[mirror_port_down.length] = new Option("lan4", "4");
	}
	

	var mirror_port_up_value ='<% getCfgGeneral(1, "up_mirror"); %>';
	for(var i = 0; i< mirror_port_up.length; i++)
	{	
		if(mirror_port_up.options[i].value == mirror_port_up_value)
		{
			mirror_port_up.options[i].selected = true;
			break;
		}
	}

	var mirror_port_down_value ='<% getCfgGeneral(1, "down_mirror"); %>';
	for(var i = 0; i< mirror_port_down.length; i++)
	{	
		if(mirror_port_down.options[i].value == mirror_port_down_value)
		{
			mirror_port_down.options[i].selected = true;
			break;
		}
	}


}



</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="fm_mirror" action="/goform/set_lan_portmirror" onSubmit="return CheckForm()">
  <table border="0" cellpadding="0" cellspacing="0" height="10%" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td class="title_01" id="lan_port_mirror_prompt" style="padding-left: 10px;" width="100%"> 在本页面上，您可以进行端口镜像配置。 </td>
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
        <td class="tabal_left" width="15%" id="lan_mirror_up_title">Up</td>
        <td class="tabal_right" align="left"><select name="up_mirror" id="up_mirror" size="1" style="width:200px;">
            <option value="-1" selected="selected">Disable</option>
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" width="15%" id="lan_mirror_down_title">Down</td>
        <td class="tabal_right" align="left"><select name="down_mirror" id="down_mirror" size="1" style="width:200px;" >
            <option value="-1" selected="selected">Disable</option>
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
</body>
</html>
