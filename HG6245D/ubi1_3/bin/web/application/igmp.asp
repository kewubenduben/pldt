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
<title>UPnP</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("upnp", lang);

//get init value from driver
var igmp_sync = '<% igmp_sync(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

function initTranslation()
{
	var e = document.getElementById("igmp_prompt");
	e.innerHTML = _("igmp_prompt");
	var e = document.getElementById("upnpEnable_title");
	e.innerHTML = _("upnpEnable_title");
	var e = document.getElementById("upnpEnable_title2");
	e.innerHTML = _("upnpEnable_title2");
	e = document.getElementById("igmp_apply");
	e.value = _("igmp_apply");
	e = document.getElementById("igmp_Cancel");
	e.value = _("upnpEnableCancel");
}

function initValue()
{
	initTranslation();

	var MulticastModenode  = document.getElementById("MulticastMode");
	var MulticastMode_value  = '<% getCfgZero(1, "MulticastMode"); %>';
	for(var i = 0; i< MulticastModenode.length; i++)
	{
		if(MulticastModenode.options[i].value == MulticastMode_value )
		{
			MulticastModenode.options[i].selected = true;
			break;
		}
	}
	
	if (ispNameCode == 5)		/*add by 郭心悦，20161228，泰国AIS新增组播模式MLD*/
	{
		setDisplay("tb_MLD", "");
		var MulticastModenode_mld  = document.getElementById("mldMode");
		var MulticastMode_value_mld  = '<% getCfgZero(1, "mldMode"); %>';
		for(var i = 0; i< MulticastModenode_mld.length; i++)
		{
			if(MulticastModenode_mld.options[i].value == MulticastMode_value_mld )
			{
				MulticastModenode_mld.options[i].selected = true;
				break;
			}
		}
	}
}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="igmp_form" action="/goform/igmpcfg">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="igmp_prompt"  class="title_01" style="padding-left: 10px;" width="100%"></td>
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
        <td class="tabal_left" id="upnpEnable_title" align="left" width="20%">IGMP Mode</td>
        <td class="tabal_right"><select id="MulticastMode" name="MulticastMode" size="1" style="width:27%" value=3>
            <option value="0" selected="selected" >Snooping </option>
            <option value="100">Proxy</option>
          </select>
        </td>
      </tr>
  </table>
    <table class="tabal_bg" id="tb_MLD"  style="display: none;" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="upnpEnable_title2" align="left" width="20%">MLD Mode</td>
        <td class="tabal_right"><select id="mldMode" name="mldMode" size="1" style="width:27%" value=3>
            <option value="0" selected="selected" >Snooping </option>
            <option value="100">Proxy</option>
          </select>
        </td>
      </tr>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" type="submit" value="应用" id="igmp_apply">
          &nbsp; &nbsp;
          <input class="submit" type="reset" value="取消" id="igmp_Cancel" onClick="window.location.reload();">
        </td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
