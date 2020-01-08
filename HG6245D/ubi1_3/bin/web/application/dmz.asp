<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/dmz.js"></script>
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<title>DMZ</title>
<script language="JavaScript" type="text/javascript">
/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("dmz", lang);

var multiRouteWanFlag = '<% getCfgGeneral(1, "WEB_MULTI_ROUTE_WAN"); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

var dmzSync = '<% dmzSync(); %>';

var dmz_enable = '<% getCfgGeneral(1, "dmz_enable"); %>';

var wanNameSync = '<% wanNameSync(); %>';
var wanname_all = '<% getCfgGeneral(1, "wan_name_all"); %>';
var wan_ruleSum = '<% getCfgGeneral(1, "wan_size"); %>';

var wannameArray = wanname_all.split("|");
var pf_ruleSum  = '<% getCfgGeneral(1, "dmz_size"); %>';
var currentline;
var previousTR = null;

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="dmz_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<div id='div_dmz'>
<form method="post" name="dmz_form" action="/goform/dmzCfg" onSubmit="return CheckValue()">
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_left" id="dmzEnable_title" align="left" width="20%">DMZ Enable</td>
        <td class="tabal_right" colspan="6" align="left" width="80%"><input checked="checked" value="enable" name="DMZEnable" type="radio">
          <font id="dmz_enable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <input value="disable" name="DMZEnable" type="radio">
          <font id="dmz_disable"></font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <div id='div_auto' style="display: none">
            <input value="auto" name="DMZEnable" id="DMZ_auto_radio" type="radio">
            <font id="dmz_auto"></font></div></td>
      </tr>
      <tr>
        <td class="tabal_left" width="20%" id="dmz_hostTips">DMZ Host IP</td>
        <td class="tabal_right" width="80%"><input name="dmz_ip" id="dmz_ip" size="20" type="text" value="<% getCfgGeneral(1, "dmzhost_ip"); %>">
      </tr>
    </tbody>
  </table>
  <table class="tabal_button" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit" align="left"><input class="submit" value="Apply" type="submit" id="dmz_apply">
          <input class="submit" type="reset" value="Cancel" id="dmz_cancel"onclick="window.location.reload();" >
        </td>
      </tr>
    </tbody>
  </table>
</form>
</div>
<table id='dmz_wan' style="display: none" border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td height="22" width="7"></td>
              <td align="center" valign="bottom" width="120"></td>
              <td width="7"></td>
              <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                  <tbody>
                    <tr>
                      <td><input type="button" value="Add" id="dmz_add" class="submit" onClick="clickAdd('mf_ruleList');"></td>
                      <td><input type="button" value="Delete" id="dmz_delete" class="submit" onClick="clickRemove('mf_ruleList');"></td>
                      <td><input type="button" value="Delete All" id="dmz_deleteAll" class="submit" onClick="clickRemoveAll('mf_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="mf_ruleList"><form method="post" id="mf_ruleForm" action="/goform/dmz_wan_cfgdelete">
          <table class="tabal_bg" id = "dmz_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="dmzRuleListHead"></td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center" >ID</td>
                <td width="35%" align="center" id="ip_title">DMZ Host IP</td>
                <td width="35%" align="center" id="wanname_title">WAN Name</td>
                <td width="15%" align="center" ></td>
              </tr>
              <% dmz_wan_Sync(  ) ; %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/dmz_wan_Cfg" onSubmit="return CheckValueDMZWan()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
              <tbody>
                <tr>
                  <td ><div id="div_pf_rule">
                      <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                        <tbody>
                          <tr style="">
                            <td id="ip_title2" class="tabal_left" width="25%">DMZ Host IP</td>
                            <td class="tabal_right" width="75%"><input name="dmz_host_ip" id="dmz_host_ip" size="16"  style="width: 150px;" type="text">
                            </td>
                          </tr>
                          <tr style="">
                            <td id="wanname_title2" class="tabal_left" width="25%">WAN Name</td>
                            <td class="tabal_right" width="75%"><select name="dmz_wanname" id="dmz_wanname" size="1" style="width:40%" >
                              </select></td>
                          </tr>
                        </tbody>
                      </table>
                    </div></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="dmz_apply_wan" id="dmz_apply_wan" class="submit">
                    <input type="reset" value="Cancel" name="dmz_cancel_wan" id="dmz_cancel_wan" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="fw_curIndex" id="fw_curIndex" value="0">
          <script language="JavaScript" type="text/javascript">
			//writeTabTail();
			</script>
        </form></td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
