<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/wifibasic.js"></script>
<title>Basic Wireless Settings</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);

var checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;

//xuli add for get init value from driver
var xl1 = '<% wirelessBasicSync(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var curUserType = '<% getCfgGeneral(1, "curUserType");%>';

var PhyMode  = '<% getCfgZero(1, "WirelessMode"); %>';
var HiddenSSID  = '<% getCfgZero(1, "HideSSID"); %>';
var APIsolated = '<% getCfgZero(1, "NoForwarding"); %>';
var mbssidapisolated = '<% getCfgZero(1, "NoForwardingBTNBSSID"); %>';
var channel_index  = '<% getWlanChannel(); %>';
var fxtxmode = '<% getCfgGeneral(1, "FixedTxMode"); %>';
var countrycode = '<% getCfgGeneral(1, "CountryCode"); %>';
var ht_mode = '<% getCfgZero(1, "HT_OpMode"); %>';
var ht_bw = '<% getCfgZero(1, "HT_BW"); %>';
var ht_gi = '<% getCfgZero(1, "HT_GI"); %>';
var ht_stbc = '<% getCfgZero(1, "HT_STBC"); %>';
var ht_mcs = '<% getCfgZero(1, "HT_MCS"); %>';
var ht_htc = '<% getCfgZero(1, "HT_HTC"); %>';
var ht_rdg = '<% getCfgZero(1, "HT_RDG"); %>';
var ht_extcha = '<% getCfgZero(1, "HT_EXTCHA"); %>';
var ht_amsdu = '<% getCfgZero(1, "HT_AMSDU"); %>';
var ht_autoba = '<% getCfgZero(1, "HT_AutoBA"); %>';
var ht_badecline = '<% getCfgZero(1, "HT_BADecline"); %>';
var ht_f_40mhz = '<% getCfgZero(1, "HT_40MHZ_INTOLERANT"); %>';

var tx_stream_idx = '<% getCfgZero(1, "HT_TxStream"); %>';
var rx_stream_idx = '<% getCfgZero(1, "HT_RxStream"); %>';

var regDomain = '<% getCfgZero(1, "regDomain"); %>';
var radio_off = '<% getCfgZero(1, "RadioOff"); %>';
var Fre_band = '<% getCfgZero(1, "Fre_band"); %>';
var guard_inter = '<% getCfgZero(1, "guard_inter"); %>';
var ISOLATIONEnable = '<% getCfgZero(1, "ISOLATIONEnable"); %>';

var basicSetFailedID = '<% getCfgGeneral(1, "basicSetFailedID"); %>';
var basicGetFailedIDs = '<% getCfgGeneral(1, "basicGetFailedIDs"); %>';

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="wireless_basic" id="wireless_basic" action="/goform/wirelessBasic" onSubmit="return CheckValue()">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="basic_prompt" class="title_01" style="padding-left: 10px;" width="100%"></td>
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
      <tr class="tabal_head">
        <td colspan="2" id="basicWirelessNet">Wireless Network</td>
      </tr>
      <tr id="TrRadioOn">
        <td class="tabal_left" width="25%" id="basicRadioButton">Radio On/Off</td>
        <td class="tabal_right"><input type="button" name="radioButton" id="radioButton" style="{width:120px;}" value="RADIO ON"
      onClick="if (this.value.indexOf('OFF') >= 0) RadioStatusChange(1); else RadioStatusChange(0); load_waiting();document.wireless_basic.submit();">
          &nbsp; &nbsp;
          <input type=hidden name=radiohiddenButton value="2"></td>
      </tr>
      <tr id="radio_enable_tr" style="display: none">
        <td class="tabal_left" width="25%" id="basicRadioButton_1">Radio On/Off</td>
        <td class="tabal_right"><select name="radio_on" id="radio_on" size="1" value=1 >
            <option value=1>On</option>
            <option value=0>Off</option>
          </select></td>
      </tr>
      <tr id="TrNetMode">
        <td class="tabal_left" width="25%" id="basicNetMode">Network Mode</td>
        <td class="tabal_right"><select name="wirelessmode" id="wirelessmode" size="1" value=4 onChange="NetModeSwitch();">
            <option value=0>802.11 b</option>
            <option value=1>802.11 g</option>
            <option value=2>802.11 b/g</option>
            <option value=3>802.11 n</option>
            <option value=4 selected="selected">802.11 b/g/n</option>
          </select></td>
      </tr>
      <tr id="tr_basicDomain" name="tr_basicDomain">
        <td class="tabal_left" width="25%"><font id="basicDomain">Domain</font></td>
        <td class="tabal_right"><select id="select_regDomain" name="select_regDomain" size="1" onChange="regDomainOnChange()">
            <option value=0 id="domain0">ETSI</option>
            <option value=1 id="domain1">FCC</option>
            <option value=2 id="domain2">THAILAND</option>
            <option value=3 id="domain3">PHILIPPINES</option>
            <option value=4 id="domain4">INDONESIA</option>
            <option value=5 id="domain5">BRAZIL</option>
            <option value=6 id="domain6">INDIA</option>
            <option value=7 id="domain7">ARMENIA</option>
            <option value=8 id="domain8">MALAYSIA</option>
            <option value=9 id="domain9">PAKISTAN</option>
            <option value=10 id="domain10">RUSSIAN FEDERATION</option>
            <option value=11 id="domain11">CHINA</option>
            <option value=12 id="domain12">CHILE</option>
            <option value=13 id="domain13">UNITED STATES</option>
            <option value=14 id="domain14">MYANMAR</option>
            <option value=15 id="domain15">ECUADOR</option>
            <option value=16 id="domain16">COLOMBIA</option>
            <option value=17 id="domain17">ARGENTINA</option>
            <option value=18 id="domain18">SRI LANKA</option>
            <option value=19 id="domain19">THE ISLAMIC REPUBLIC OF IRAN</option>
            <option value=20 id="domain20">YEMEN</option>
            <option value=21 id="domain21">SAUDI ARABIA</option>
            <option value=22 id="domain22">KUWAIT</option>
            <option value=23 id="domain23">IRAQ</option>
            <option value=24 id="domain24">VIETNAM</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="fre_band_title">Frequency Bandwidth</td>
        <td class="tabal_right"><select name="Fre_band" id="Fre_band" size="1">
            <option value=0 selected="selected">20/40MHz</option>
            <option value=1>20MHz</option>
            <option value=2>40MHz</option>
          </select></td>
      </tr>
      <tr id="div_11a_channel" name="div_11a_channel">
        <td class="tabal_left" width="25%"><font id="basicFreqA">Frequency (Channel)</font></td>
        <td class="tabal_right"><select id="sz11aChannel" name="sz11aChannel" size="1" onChange="ChannelOnChange()">
            <option value=0 id="basicFreqAAuto">AutoSelect</option>
            <option value=1 id="channel1">channel 1</option>
            <option value=2 id="channel2">channel 2</option>
            <option value=3 id="channel3">channel 3</option>
            <option value=4 id="channel4">channel 4</option>
            <option value=5 id="channel5">channel 5</option>
            <option value=6 id="channel6">channel 6</option>
            <option value=7 id="channel7">channel 7</option>
            <option value=8 id="channel8">channel 8</option>
            <option value=9 id="channel9">channel 9</option>
            <option value=10 id="channel10">channel 10</option>
            <option value=11 id="channel11">channel 11</option>
            <option value=12 id="channel12">channel 12</option>
            <option value=13 id="channel13">channel 13</option>
          </select>
        </td>
      </tr>
      <tr id="tr_guard_inter">
        <td class="tabal_left" width="25%" id="guard_inter_title">Guard Interval</td>
        <td class="tabal_right"><select name="guard_inter" id="guard_inter" size="1">
            <option value=0 selected="selected">Long</option>
            <option value=1>Short</option>
          </select></td>
      </tr>
    </tbody>
  </table>
    <!-- ---------------------  Isolation Enable  --------------------- -->
  <table id="tb_ssid_isolation" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%"  style="display: none;">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="td_isolation_title">Isolation Enable</td>
      </tr>
      <tr>
         <td class="tabal_left" width="25%"><font id="td_isolation_enable"></font></td>
         <td class="tabal_right" align="left"><input checked="checked"value="1" name="ISOLATIONEnable" type="radio">
          <font id="isolation_enable">Enable</font>
          &nbsp; &nbsp; &nbsp; 
          <input value="0" name="ISOLATIONEnable" type="radio">
          <font id="isolation_disable">Disable</font><strong style="color:#FF0033">&nbsp; &nbsp; &nbsp;*</strong> </td>
      </tr>
    </tbody>
  </table>
  <table id="tb_submit" class="tabal_button" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="tabal_submit" width="25%"></td>
        <td class="tabal_submit"><input type="submit" value="Apply" id="basicApply" class="submit">
          <input type="reset" name="Cancel" value="Cancel" id="basicCancel" class="submit" onClick="window.location.reload()">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<span id="span_info" style="display: none;"></span>
<script type="text/javascript">
  updateForms(); 
</script>
</body>
</html>
