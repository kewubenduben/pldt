<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- Copyright (c), Ralink Technology Corporation All Rights Reserved. -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/wifisecurity.js"></script>
<title>Ralink Wireless Security Settings</title>
<script language="JavaScript" type="text/javascript">

var checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);

var MBSSID_MAX 				= 1;
var ACCESSPOLICYLIST_MAX	= 32;

var changed = 0;
var old_MBSSID;

//xuli add for get init value from driver
var xl2 = '<% SecuritySync(); %>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';
var wifi_chip_num = '<% getCfgGeneral(1, "wifi_chip_num");%>';

var defaultShownMBSSID = 0;

/* add begin by 吴小娟, 20111018, 原因: 增加多SSID支持 */
var ssidName = new Array();
var ssidHide = new Array();
/* add end by 吴小娟, 20111018 */

/* add by 吴小娟, 20160811, 原因: 增加支持WMM */
var wmmList = new Array();
var guestList = new Array();//add by wuxj, 20180319

var SSID = new Array();
var PreAuth = new Array();
var AuthMode = new Array();
var EncrypType = new Array();
var DefaultKeyID = new Array();
var Key1Type = new Array();
var Key1Str = new Array();
var Key2Type = new Array();
var Key2Str = new Array();
var Key3Type = new Array();
var Key3Str = new Array();
var Key4Type = new Array();
var Key4Str = new Array();
var WPAPSK = new Array();
var RekeyMethod = new Array();
var RekeyInterval = new Array();
var PMKCachePeriod = new Array();
var IEEE8021X = new Array();
var RADIUS_Server = new Array();
var RADIUS_Port = new Array();
var RADIUS_Key = new Array();
var session_timeout_interval = new Array();
var AccessPolicy = new Array();
var AccessControlList = new Array();
var Have_RADIUS = 0;

var WEB_WIFI_CERTIFIED_OPTION = '<% getCfgGeneral(1, "WEB_WIFI_CERTIFIED_OPTION");%>';
var SSIDEnable1 = '<% getCfgGeneral(1, "SSIDEnable1"); %>';
var SSIDEnable2 = '<% getCfgGeneral(1, "SSIDEnable2"); %>';
var SSIDEnable3 = '<% getCfgGeneral(1, "SSIDEnable3"); %>';
var SSIDEnable4 = '<% getCfgGeneral(1, "SSIDEnable4"); %>';

var securitySetFailedID = '<% getCfgGeneral(1, "securitySetFailedID"); %>';
var securityGetFailedIDs = '<% getCfgGeneral(1, "securityGetFailedIDs"); %>';
</script>
</head>
<body class="mainbody" onLoad="initAll()">
<form method="post" name="security_form" id="security_form" action="/goform/APSecurity">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="security_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <!-- ---------------------  MBSSID Selection  --------------------- -->
  <table id="MBSSID" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="3" id="secureSelectSSID">Select SSID</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="secureSSIDChoice">SSID Choice</td>
        <td class="tabal_right"><select name="ssidIndex"  id="ssidIndex" size="1" style="width:27%" onChange="selectMBSSIDChanged()">
          </select>
        </td>
        <td class="tabal_right" align="left" width="35%"><input checked="checked" value="enable" name="SSIDEnable" type="radio">
          <font id="ssid_enable"></font> &nbsp; &nbsp; &nbsp;
          <input value="disable" name="SSIDEnable" type="radio">
          <font id="ssid_disable"></font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
    </tbody>
  </table>
  <br>
  <!-- ---------------------  SSID Name  --------------------- -->
  <table id="MBSSID" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="3" id="secureNetworkName">Network Name(SSID)</td>
      </tr>
    <input type="hidden" name="bssid_num" value="1">
    <tr>
      <td class="tabal_left" width="25%" id="basicSSID_title">Network Name(SSID)</td>
      <td class="tabal_right" width="55%"><input type="text" name="ssidName" id="ssidName" maxlength="32" size="32" >
        &nbsp;&nbsp;<strong style="color:#FF0033">*</strong><span class="gray" id="ssidNameTips"></span> </td>
      <td class="tabal_right"><span id="basicHSSID_title">Hidden</span>
        <input type="checkbox" name="hssid" id="hssid" value="1">
        <!--  如果打勾则hssid=1，如果不打勾则hssid=空  -->
      </td>
    </tr>
    <tr id="tr_wmm" style="display: none;">
      <td class="tabal_left" id="secure_WMMtitle">WMM</td>
      <td class="tabal_right" colspan="2"><input type="checkbox" name="secure_WMM" value="1">
      </td>
    </tr>
    <tr id="tr_guest" style="display: none;">
      <td class="tabal_left" width="25%" id="guestTitle">Guest</td>
      <td class="tabal_right" colspan="2"><input type="checkbox" name="secure_guest" value="1"></td>
    </tr>
    </tbody>
    
  </table>
  <br>
  <!-- ---------------------  Security Policy  --------------------- -->
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="sp_title">Security Policy</td>
      </tr>
      <tr id="div_security_infra_mode" name="div_security_infra_mode">
        <td class="tabal_left" width="25%" id="secureSecureMode">Security Mode</td>
        <td class="tabal_right"><select name="security_mode" id="security_mode" size="1" onChange="securityMode(1)">
          </select>
        </td>
      </tr>
      <tr id="div_security_shared_mode" name="div_security_shared_mode" style="visibility: hidden;">
        <td class="tabal_left" width="25%" id="secureEncrypType">Encrypt Type</td>
        <td class="tabal_right"><select name="security_shared_mode" id="security_shared_mode" size="1" onChange="securityMode(1)">
            <option value=WEP>WEP</option>
            <option value=None id="secureEncrypTypeNone">None</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
  <br>
  <!-- ---------------------  Wire Equivalence Protection (WEP)  --------------------- -->
  <table id="div_wep" name="div_wep" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="visibility: hidden;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="4" id="secureWEP">WEP(Wired Equivalent Privacy)</td>
      </tr>
      <tr>
        <td colspan="2" class="tabal_left" id="secureWEPDefaultKey">Default Key</td>
        <td colspan="2" class="tabal_right"><select name="wep_default_key" id="wep_default_key" size="1" onChange="setChange(1)">
            <option value="1" id="secureWEPDefaultKey1">Key 1</option>
            <option value="2" id="secureWEPDefaultKey2">Key 2</option>
            <option value="3" id="secureWEPDefaultKey3">Key 3</option>
            <option value="4" id="secureWEPDefaultKey4">Key 4</option>
          </select>
        </td>
      </tr>
      <tr>
        <td rowspan="4" class="tabal_left" width="12%" id="secureWEPKey">WEP Keys</td>
        <td width="13%" class="tabal_left" id="secureWEPKey1">WEP Key 1</td>
        <td width="25%" class="tabal_right"><input name="WEP1" id="WEP1Text" type="text" maxlength="26" value="" onKeyUp="setChange(1)">
          <input name="WEP1" id="WEP1Pwd" type="password" maxlength="26" value="" onKeyUp="setChange(1)"></td>
        <td width="50%" class="tabal_right"><select id="WEP1Select" name="WEP1Select" onChange="setChange(1)">
            <option value="1">ASCII</option>
            <option value="0">Hex</option>
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" id="secureWEPKey2">WEP Key 2</td>
        <td class="tabal_right"><input name="WEP2" id="WEP2Text" type="text" maxlength="26" value="" onKeyUp="setChange(1)">
          <input name="WEP2" id="WEP2Pwd" type="password" maxlength="26" value="" onKeyUp="setChange(1)"></td>
        <td class="tabal_right"><select id="WEP2Select" name="WEP2Select" onChange="setChange(1)">
            <option value="1">ASCII</option>
            <option value="0">Hex</option>
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" id="secureWEPKey3">WEP Key 3</td>
        <td class="tabal_right"><input name="WEP3" id="WEP3Text" type="text" maxlength="26" value="" onKeyUp="setChange(1)">
          <input name="WEP3" id="WEP3Pwd" type="password" maxlength="26" value="" onKeyUp="setChange(1)"></td>
        <td class="tabal_right"><select id="WEP3Select" name="WEP3Select" onChange="setChange(1)">
            <option value="1">ASCII</option>
            <option value="0">Hex</option>
          </select></td>
      </tr>
      <tr>
        <td class="tabal_left" id="secureWEPKey4">WEP Key 4</td>
        <td class="tabal_right"><input name="WEP4" id="WEP4Text" type="text" maxlength="26" value="" onKeyUp="setChange(1)">
          <input name="WEP4" id="WEP4Pwd" type="password" maxlength="26" value="" onKeyUp="setChange(1)"></td>
        <td class="tabal_right"><select id="WEP4Select" name="WEP4Select" onChange="setChange(1)">
            <option value="1">ASCII</option>
            <option value="0">Hex</option>
          </select></td>
      </tr>
    </tbody>
  </table>
  <!-- ---------------------  WPA  --------------------- -->
  <table id="div_wpa" name="div_wpa" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="visibility: hidden;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="secreWPA">WPA</td>
      </tr>
      <tr id="div_wpa_algorithms" name="div_wpa_algorithms" style="visibility: hidden;">
        <td class="tabal_left" width="25%" id="secureWPAAlgorithm">WPA Algorithms</td>
        <td class="tabal_right"><input name="cipher" id="cipher_tkip" value="0" type="radio" onClick="onWPAAlgorithmsClick(0)">
          <span id="tkip_title">TKIP &nbsp;</span>
          <input name="cipher" id="cipher_aes" value="1" type="radio" onClick="onWPAAlgorithmsClick(1)">
          <span id="aes_title">AES &nbsp;</span>
          <input name="cipher" id="cipher_tkipaes" value="2" type="radio" onClick="onWPAAlgorithmsClick(2)">
          <span id="tkipaes_title">TKIPAES &nbsp; </span></td>
      </tr>
      <tr id="wpa_passphrase" name="wpa_passphrase" style="visibility: hidden;">
        <td class="tabal_left" width="25%" id="secureWPAPassPhrase">Pass Phrase</td>
        <td class="tabal_right"><input name="passphrase" id="passphraseText" type="text" size="28" maxlength="64" value="" onKeyUp="setChange(1)">
          <input name="passphrase" id="passphrasePwd" type="password" size="28" maxlength="64" value="" onKeyUp="setChange(1)">
          <strong style="color:#FF0033">*</strong><span class="gray" id="wpa_passphraseTips">(You can input 8-64 characters)</span></td>
        </td>
      </tr>
      <!--tr id="wpa_key_renewal_interval" name="wpa_key_renewal_interval" style="visibility: hidden;">
        <td class="tabal_left" id="secureWPAKeyRenewInterval">Key Renewal Interval</td>
        <td class="tabal_right"><input name="keyRenewalInterval" id="keyRenewalInterval" size="4" maxlength="4" value="3600" onKeyUp="setChange(1)">
          <span id="secureWPAKeyRenewIntervaltips">seconds</span> </td>
      </tr-->
      <tr id="wpa_PMK_Cache_Period" name="wpa_PMK_Cache_Period" style="visibility: hidden;">
        <td class="tabal_left" id="secureWPAPMKCachePeriod">PMK Cache Period</td>
        <td class="tabal_right"><input name="PMKCachePeriod" id="PMKCachePeriod" size="4" maxlength="4" value="" onKeyUp="setChange(1)">
          minute </td>
      </tr>
      <tr id="wpa_preAuthentication" name="wpa_preAuthentication" style="visibility: hidden;">
        <td class="tabal_left" id="secureWPAPreAuth">Pre-Authentication</td>
        <td class="tabal_right"><input name="PreAuthentication" id="PreAuthentication_disable" value="0" type="radio" onClick="onPreAuthenticationClick(0)">
          <font id="secureWPAPreAuthDisable">Disable &nbsp;</font>
          <input name="PreAuthentication" id="PreAuthentication_enable" value="1" type="radio" onClick="onPreAuthenticationClick(1)">
          <font id="secureWPAPreAuthEnable">Enable &nbsp;</font> </td>
      </tr>
    </tbody>
  </table>
  <!-- ---------------------  802.1x WEP  --------------------- -->
  <table id="div_8021x_wep" name="div_8021x_wep" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="visibility: hidden;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="secure8021XWEP">802.1x WEP</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="secure1XWEP"> WEP </td>
        <td class="tabal_right"><input name="ieee8021x_wep" id="ieee8021x_wep_disable" value="0" type="radio" onClick="onIEEE8021XWEPClick(0)">
          <font id="secure1XWEPDisable">Disable &nbsp;</font>
          <input name="ieee8021x_wep" id="ieee8021x_wep_enable" value="1" type="radio" onClick="onIEEE8021XWEPClick(1)">
          <font id="secure1XWEPEnable">Enable</font> </td>
      </tr>
    </tbody>
  </table>
  <!-- ---------------------  Radius Server  --------------------- -->
  <table id="div_radius_server" name="div_radius_server" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display:none">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="secureRadius">Radius Server</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="secureRadiusIPAddr"> IP Address </td>
        <td class="tabal_right"><input name="RadiusServerIP" id="RadiusServerIP" size="16" maxlength="32" value="" onKeyUp="setChange(1)">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="secureRadiusPort"> Port </td>
        <td class="tabal_right"><input name="RadiusServerPort" id="RadiusServerPort" size="5" maxlength="5" value="" onKeyUp="setChange(1)">
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="secureRadiusSharedSecret"> Shared Secret </td>
        <td class="tabal_right"><input name="RadiusServerSecret" id="RadiusServerSecret" size="16" maxlength="64" value="" onKeyUp="setChange(1)">
        </td>
      </tr>
      <tr style="display:none">
        <td class="tabal_left" width="25%" id="secureRadiusSessionTimeout" > Session Timeout </td>
        <td class="tabal_right"><input name="RadiusServerSessionTimeout" id="RadiusServerSessionTimeout" size="3" maxlength="4" value="0" onKeyUp="setChange(1)"  >
        </td>
      </tr>
      <tr style="display:none">
        <td class="tabal_left" width="25%" id="secureRadiusIdleTimeout"> Idle Timeout </td>
        <td class="tabal_right"><input name="RadiusServerIdleTimeout" id="RadiusServerIdleTimeout" size="3" maxlength="4" value="" onKeyUp="setChange(1)" readonly>
        </td>
      </tr>
    </tbody>
  </table>
  <!-- ---------------------  Access Policy  --------------------- -->
  <table id="AddMacTable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="visibility: hidden;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="accessPolicyHead"><span id="sp_title_x">Access Policy</span></td>
      </tr>
      <tr id="div_access_infra_mode" name="div_access_infra_mode">
        <td class="tabal_left" width="25%" id="secureAccessMode">Access Mode</td>
        <td class="tabal_right"><select name="access_mode" id="access_mode" size="1" >
            <option value=0>Disable</option>
            <option value=1>Allow</option>
            <option value=2>Reject</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="basicSSID">Add a station Mac:</td>
        <td class="tabal_right"><input type="text" name="addmac" id="AddMacAddr" size=20 maxlength=32 value="">
          &nbsp;&nbsp;
          <input style="width: 120px;" value="Add" id="AddMacButton" onClick="window.location.reload()" type="button">
        </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="button" value="Apply" id="secureApply" class="submit" onClick="submit_apply()">
          <input type="reset" name="Cancel" value="Cancel" id="secureCancel" class="submit" onClick="window.location.reload()">
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
