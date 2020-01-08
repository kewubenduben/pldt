<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Refresh" content="20">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan_state.js"></script>
<title>WAN STATE</title>
<script language="JavaScript" type="text/javascript">

var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var previousTR = null;

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';

var setWAN_IPV6InfoSync = '<% setWAN_IPV6InfoSync(); %>';
//var setLanstateSync = '<--% setLanstateSync(); %>';
var get_wan_detail = '<% get_wan_detail(); %>';

var wan_num = '<% getCfgGeneral(1, "wan_num"); %>';
var wan_mac_buff = '<% getCfgGeneral(1, "wan_mac_buff"); %>';
var wan_gateway_buff = '<% getCfgGeneral(1, "wan_gateway_buff"); %>';
var uptime_buff = '<% getCfgGeneral(1, "uptime_buff"); %>';
var pppoe_state = '<% getCfgGeneral(1, "pppoe_state"); %>';

var V6_wan_num = '<% getCfgGeneral(1, "v6_wan_num"); %>';

var WEB_COMM_WAN_CFG = '<% getCfgGeneral(1, "WEB_COMM_WAN_CFG");%>';
var ip_stack_mode = '<% getCfgGeneral(1, "ip_stack_mode"); %>';
var ip_stack_mode_arr = ip_stack_mode.split("|");
var staticIp_ipv6 = '<% getCfgGeneral(1, "staticIp_ipv6");%>';
var staticIp_ipv6_arr = staticIp_ipv6.split("|");
var IPv6_Gateway = '<% getCfgGeneral(1, "IPv6_Gateway");%>';
var IPv6_Gateway_arr = IPv6_Gateway.split("|");
var IPv6_Pri_DNS = '<% getCfgGeneral(1, "IPv6_Pri_DNS");%>';
var IPv6_Pri_DNS_arr = IPv6_Pri_DNS.split("|");
var IPv6_Sec_DNS = '<% getCfgGeneral(1, "IPv6_Sec_DNS");%>';
var IPv6_Sec_DNS_arr = IPv6_Sec_DNS.split("|");
var IPv6_prefix = '<% getCfgGeneral(1, "IPv6_prefix");%>';
var IPv6_prefix_arr = IPv6_prefix.split("|");

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wan_statePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="tb_wanstate" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="wanListHead">WAN State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="wan_name">Index</td>
      <td width="9%" align="center" id="wan_state">State</td>
      <td width="10%" align="center" id="wan_mode">Mode</td>
      <td width="9%" align="center" id="ip_mode">IP Type</td>
      <td width="14%" align="center" >IP</td>
      <td width="15%" align="center" id="wan_mask">Mask</td>
      <td width="14%" align="center" >DNS</td>
      <td width="7%" align="center" id="wan_vlan">VLAN/Priority</td>
      <td width="5%" align="center" id="wan_type">Connection Type</td>
    </tr>
    <% setWANInfoSync(); %>
  </tbody>
</table>
<table  border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<table id="wan_state_table" class="tabal_bg" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" >More Information</td>
    </tr>
    <tr id="tr_ppp_state" style="display: none;">
      <td class="tabal_left" width="25%">PPPoE State</td>
      <td class="tabal_right" id="ppp_stateDetail"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">WAN Mac</td>
      <td class="tabal_right" id="wan_mac"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Connection Uptime</td>
      <td class="tabal_right" id="wan_uptime"></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%">Gateway</td>
      <td class="tabal_right" id="wan_gateway"></td>
    </tr>
  </tbody>
</table>
<table  id="ipv6_wan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
  <tbody>
    <tr class="tabal_head">
      <td colspan="2" id="v6State">IPv6 State</td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanIpv6">IPv6 Address</td>
      <td class="tabal_right" id="td_ipv6_ip"><% getCfgGeneral(1, "ipv6_ip"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wanprefix">Prefix</td>
      <td class="tabal_right" id="td_ipv6_prefix"><% getCfgGeneral(1, "ipv6Prefix"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="gateway_v6">Default Gateway</td>
      <td class="tabal_right" id="td_ipv6_gw"><% getCfgGeneral(1, "ipv6_gateway"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns">Primary DNS Server</td>
      <td class="tabal_right" id="td_ipv6_pridns"><% getCfgGeneral(1, "ipv6_pridns"); %></td>
    </tr>
    <tr>
      <td class="tabal_left" width="25%" id="wan_dns2">Secondary DNS Server</td>
      <td class="tabal_right" id="td_ipv6_secdns"><% getCfgGeneral(1, "ipv6_secdns"); %></td>
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
<table  id="ipv6_mutiwan_state" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
  <tbody>
    <tr class="tabal_head">
      <td colspan="5" id="v6State_title">IPv6 State</td>
    </tr>
    <tr class="tabal_title">
      <td width="8%" align="center" id="v6_index_title">Index</td>
      <td width="9%" align="center" id="v6_state_title">State</td>
      <td width="20%" align="center" id="v6_IPMode_title">Mode</td>
      <td width="63%"colspan="2" align="center"  id="v6_address_title">IPv6 Address</td>
    </tr>
    <% mutiwan_ipv6_sync(); %>
  <table  border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr>
        <td height="22"></td>
      </tr>
    </tbody>
  </table>
  </tbody>
</table>
</body>
</html>