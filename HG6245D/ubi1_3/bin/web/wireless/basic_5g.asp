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
<script type="text/javascript" src="/js/wifibasic_5g.js"></script>
<title>5G Basic Wireless Settings</title>
<script language="JavaScript" type="text/javascript">
var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("wireless", lang);

var checkResult = '<% cu_web_access_control(  ) ;%>'
var token = <%  get_random_str(); %>
web_access_check( checkResult) ;

//get init value from driver
var xl1 = '<% wirelessBasicSyncEx(); %>';
var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';

var HiddenSSID  = '<% getCfgZero(1, "HideSSID"); %>';
var countrycode = '<% getCfgGeneral(1, "CountryCode"); %>';

var PhyMode  = '<% getCfgZero(1, "WirelessMode"); %>';
var channelValue  = '<% getCfgZero(1, "Channel"); %>';
var regDomain = '<% getCfgZero(1, "regDomain"); %>';
var channelListArray = new Array();
channelListArray[1] = '<% get_freband_channellist(1); %>';
channelListArray[2] = '<% get_freband_channellist(2); %>';
channelListArray[0] = channelListArray[2];//0(20M/40M)和2(40M)显示的结果保持一致
channelListArray[3] = '<% get_freband_channellist(3); %>';

var radio_off = '<% getCfgZero(1, "RadioOff"); %>';
var Fre_band = '<% getCfgZero(1, "Fre_band"); %>';
var guard_inter = '<% getCfgZero(1, "guard_inter"); %>';

/*
var ChannelList_24G = new Array(14);
ChannelList_24G[0] = "2412MHz (Channel 1)";
ChannelList_24G[1] = "2417MHz (Channel 2)";
ChannelList_24G[2] = "2422MHz (Channel 3)";
ChannelList_24G[3] = "2427MHz (Channel 4)";
ChannelList_24G[4] = "2432MHz (Channel 5)";
ChannelList_24G[5] = "2437MHz (Channel 6)";
ChannelList_24G[6] = "2442MHz (Channel 7)";
ChannelList_24G[7] = "2447MHz (Channel 8)";
ChannelList_24G[8] = "2452MHz (Channel 9)";
ChannelList_24G[9] = "2457MHz (Channel 10)";
ChannelList_24G[10] = "2462MHz (Channel 11)";
ChannelList_24G[11] = "2467MHz (Channel 12)";
ChannelList_24G[12] = "2472MHz (Channel 13)";
ChannelList_24G[13] = "2484MHz (Channel 14)";

var ChannelList_5G = new Array(33);
ChannelList_5G[0] = "5180MHz (Channel 36)";
ChannelList_5G[1] = "5200MHz (Channel 40)";
ChannelList_5G[2] = "5220MHz (Channel 44)";
ChannelList_5G[3] = "5240MHz (Channel 48)";
ChannelList_5G[4] = "5260MHz (Channel 52)";
ChannelList_5G[5] = "5280MHz (Channel 56)";
ChannelList_5G[6] = "5300MHz (Channel 60)";
ChannelList_5G[7] = "5320MHz (Channel 64)";
ChannelList_5G[16] = "5500MHz (Channel 100)";
ChannelList_5G[17] = "5520MHz (Channel 104)";
ChannelList_5G[18] = "5540MHz (Channel 108)";
ChannelList_5G[19] = "5560MHz (Channel 112)";
ChannelList_5G[20] = "5580MHz (Channel 116)";
ChannelList_5G[21] = "5600MHz (Channel 120)";
ChannelList_5G[22] = "5620MHz (Channel 124)";
ChannelList_5G[23] = "5640MHz (Channel 128)";
ChannelList_5G[24] = "5660MHz (Channel 132)";
ChannelList_5G[25] = "5680MHz (Channel 136)";
ChannelList_5G[26] = "5700MHz (Channel 140)";
ChannelList_5G[28] = "5745MHz (Channel 149)";
ChannelList_5G[29] = "5765MHz (Channel 153)";
ChannelList_5G[30] = "5785MHz (Channel 157)";
ChannelList_5G[31] = "5805MHz (Channel 161)";
ChannelList_5G[32] = "5825MHz (Channel 165)";

var HT5GExtCh = new Array(22);
HT5GExtCh[0] = new Array(1, "5200MHz (Channel 40)"); // channel 36's extension channel
HT5GExtCh[1] = new Array(0, "5180MHz (Channel 36)"); // channel 40's extension channel
HT5GExtCh[2] = new Array(1, "5240MHz (Channel 48)"); // channel 44's extension channel
HT5GExtCh[3] = new Array(0, "5220MHz (Channel 44)"); // channel 48's extension channel
HT5GExtCh[4] = new Array(1, "5280MHz (Channel 56)"); // channel 52's extension channel
HT5GExtCh[5] = new Array(0, "5260MHz (Channel 52)"); // channel 56's extension channel
HT5GExtCh[6] = new Array(1, "5320MHz (Channel 64)"); // channel 60's extension channel
HT5GExtCh[7] = new Array(0, "5300MHz (Channel 60)"); // channel 64's extension channel
HT5GExtCh[8] = new Array(1, "5520MHz (Channel 104)"); // channel 100's extension channel
HT5GExtCh[9] = new Array(0, "5500MHz (Channel 100)"); // channel 104's extension channel
HT5GExtCh[10] = new Array(1, "5560MHz (Channel 112)"); // channel 108's extension channel
HT5GExtCh[11] = new Array(0, "5540MHz (Channel 108)"); // channel 112's extension channel
HT5GExtCh[12] = new Array(1, "5600MHz (Channel 120)"); // channel 116's extension channel
HT5GExtCh[13] = new Array(0, "5580MHz (Channel 116)"); // channel 120's extension channel
HT5GExtCh[14] = new Array(1, "5640MHz (Channel 128)"); // channel 124's extension channel
HT5GExtCh[15] = new Array(0, "5620MHz (Channel 124)"); // channel 128's extension channel
HT5GExtCh[16] = new Array(1, "5680MHz (Channel 136)"); // channel 132's extension channel
HT5GExtCh[17] = new Array(0, "5660MHz (Channel 132)"); // channel 136's extension channel
HT5GExtCh[18] = new Array(1, "5765MHz (Channel 153)"); // channel 149's extension channel
HT5GExtCh[19] = new Array(0, "5745MHz (Channel 149)"); // channel 153's extension channel
HT5GExtCh[20] = new Array(1, "5805MHz (Channel 161)"); // channel 157's extension channel
HT5GExtCh[21] = new Array(0, "5785MHz (Channel 157)"); // channel 161's extension channel
*/

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="wireless_basic" id="wireless_basic" action="/goform/wirelessBasicEx" onSubmit="return CheckValue()">
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
      <tr id="TrNetMode">
        <td class="tabal_left" width="25%" id="basicNetMode">Network Mode</td>
        <td class="tabal_right" id="basicNetModeValue"><select name="wirelessmode" id="wirelessmode" size="1" value=4 onChange="NetModeSwitchEx();">
            <option value=5>802.11 a</option>
            <option value=6>802.11 a/n</option>
            <option value=7 selected="selected">802.11 a/n/ac</option>
          </select></td>
      </tr>
      <tr id="tr_basicDomain" name="tr_basicDomain">
        <td class="tabal_left" width="25%"><font id="basicDomain">Domain</font></td>
        <td class="tabal_right"><select id="select_regDomain" name="select_regDomain" size="1">
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
        <td class="tabal_right" id="fre_band_value"><select name="Fre_band" id="Fre_band" size="1" onChange="frebandOnChange(this.value)">
            <option value=0>20/40MHz</option>
            <option value=1>20MHz</option>
            <option value=2>40MHz</option>
            <option value=3 selected="selected">80MHz</option>
          </select></td>
      </tr>
      <tr id="div_11a_channel" name="div_11a_channel">
        <td class="tabal_left" width="25%"><font id="basicFreqA">Frequency (Channel)</font></td>
        <td class="tabal_right" id="sz11aChannelValue"><select id="sz11aChannel" name="sz11aChannel" size="1">
            <option value=0 id="basicFreqAAuto">AutoSelect</option>
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
