<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<script type="text/javascript" src="../js/acl.js"></script>
<title>IP Filter</title>
<script language="JavaScript" type="text/javascript">

/*  asp 页面中加入用户是否LOGIN的检查begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;
/*  加入用户是否LOGIN的检查end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("acl", lang);

var ACLModeSync = '<% ACLModeSync(); %>';
	
var acl_rulesSum = '<% getCfgGeneral(1, "acl_rulesSum"); %>';

var acl_mode = '<% getCfgGeneral(1, "acl_mode"); %>';

var acl_type = '<% getCfgGeneral(1, "acl_type"); %>';

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="acl_funcPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
            <tr>
              <td id="acl_usePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="acl_ruleForm" action="/goform/ACLCfg" >
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr id="tr_submitButton">
        <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr height="22">
                <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                    <tbody>
                      <tr>
                        <td><input type="reset" value="Refresh" id="acl_refresh" class="submit" onClick="window.location.reload();"/></td>
                        <td><input type="submit" value="Submit" id="acl_submit" class="submit" onClick="clickSubmit();"/></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr id="tr_basicData">
        <td><table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td class="tabal_left" align="left" width="15%" id="acl_switchTitle">ACL Enable</td>
                <td class="tabal_right" width="15%"><input name="acl_switch" id="acl_disable" value="0" checked="checked" onclick="onClickSwitch(this.value)" type="radio"/>
                  <span id="acl_disableTitle">Disable</span></td>
                <td class="tabal_right"><input name="acl_switch" id="acl_enable" value="1" onclick="onClickSwitch(this.value)" type="radio"/>
                  <span id="acl_enableTitle">Enable</span></td>
              </tr>
            <div id="div_aclEnable">
              <tr id="tr_aclMode">
                <td class="tabal_left" align="left" width="15%" id="acl_modeTitle">ACL Mode</td>
                <td class="tabal_right"><input name="acl_mode" id="acl_modeBlack" value="2" checked="checked" type="radio"/>
                  <span id="acl_modeBlackTitle">Blacklist</span></td>
                <td class="tabal_right"><input name="acl_mode" id="acl_modeWhite" value="1" type="radio"/>
                  <span id="aacl_modeWhiteTitle">Whitelist</span></td>
              </tr>
              <tr>
                <td class="tabal_left" align="left" width="15%" id="acl_typeTitle0">ACL Type</td>
                <td colspan="2" class="tabal_right"><select name="acl_type" id="acl_type" size="1" style="width:150px" onchange="changeType(this.value, 'acl_ruleList')">
                    <option value="0" selected="selected">IP</option>
                    <option value="1">IP + Mac</option>
                    <option value="2">IP + Mac + Vid</option>
                  </select></td>
              </tr>
            </div>
          </table></td>
      </tr>
      <tr id="tr_editButton">
        <td><table id="acl_ruleEditTable" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr width="7">
                <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                    <tbody>
                      <tr>
                        <td><input type="button" value="Add" id="acl_add" class="submit" onClick="clickAdd('acl_ruleList');"/></td>
                        <td><input type="button" value="Delete" id="acl_delete" class="submit" onClick="clickRemove('acl_ruleList');"/></td>
                        <td><input type="button" value="Delete All" id="acl_deleteAll" class="submit" onClick="clickRemoveAll('acl_ruleList');"/></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr id="tr_rulesData">
        <td id="acl_ruleList"><table class="tabal_bg" id="acl_ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head" id="0">
                <td colspan="6" id="acl_listHead">ACL Rules List</td>
              </tr>
              <tr class="tabal_title" id="title" align="center">
                <th width="6%" 	id="acl_portTitle">Port</th>
                <th width="22%" id="acl_typeTitle">ACL Type</th>
                <th width="26%" id="acl_ipTitle">IP</th>
                <th width="26%" id="acl_macTitle">Mac</th>
                <th width="15%" id="acl_vidTitle">Vlan ID</th>
                <th width="5%"  id="acl_removeFlagTitle"></th>
              </tr>
              <!--output detail data from server-->
              <% ACLSync(); %>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="22"><input type="hidden" name="acl_lastRowNo" id="acl_lastRowNo" value="0"/></td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><div id="ConfigForm1">
          <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr>
                        <td ><div id="div_acl_rule">
                            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                              <tbody>
                                <tr>
                                  <td id="acl_portTitle2" class="tabal_left" width="25%">Port</td>
                                  <td class="tabal_right"><select name="acl_port" id="acl_port" size="1" style="width:150px">
                                      <option value="0">ALL</option>
                                      <option value="1">1</option>
                                      <option value="2">2</option>
                                      <option value="3">3</option>
                                      <option value="4">4</option>
                                    </select>
                                    <span class="gray" id="acl_portTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_typeTitle2" class="tabal_left" width="25%">ACL Type</td>
                                  <td class="tabal_right"><select name="acl_type2" id="acl_type2" size="1" style="width:150px">
                                      <option value="0" selected="selected">IP</option>
                                      <option value="1">IP + Mac</option>
                                      <option value="2">IP + Mac + Vid</option>
                                    </select></td>
                                </tr>
                                <tr>
                                  <td id="acl_ipTitle2" class="tabal_left" width="25%">IP</td>
                                  <td class="tabal_right"><input name="acl_ip" id="acl_ip" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_ipTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_macTitle2" class="tabal_left" width="25%">Mac</td>
                                  <td class="tabal_right"><input name="acl_mac" id="acl_mac" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_macTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_vidTitle2" class="tabal_left" width="25%">Vlan ID</td>
                                  <td class="tabal_right"><input name="acl_vid" id="acl_vid" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_vidTips"></span></td>
                                </tr>
                              </tbody>
                            </table>
                          </div></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
          <table class="tabal_button" width="100%">
            <tbody>
              <tr>
                <td width="25%"></td>
                <td class="tabal_submit"><input type="submit" value="Apply" name="acl_apply" id="acl_apply" class="submit" onClick="clickApply('acl_ruleList');" />
                  <input type="reset" value="Cancel" name="acl_cancel" id="acl_cancel" class="submit" onClick="cancelRuleEdit();" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <input type="hidden" name="acl_curIndex" id="acl_curIndex" value="0">
      </td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
