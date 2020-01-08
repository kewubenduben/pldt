<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<script type="text/javascript" src="/js/wan.js"></script>
<script type="text/javascript" src="/js/wan_romania.js"></script>
<title>WAN</title>
<script language="JavaScript" type="text/javascript">

var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
var token = <%  get_random_str(); %>;
web_access_check( checkResult);
web_access_check_admin(ispName, checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("internet", lang);

var GetWANsizeSync = '<% GetWANsizeTr069Sync(); %>';	
var wan_size = '<% getCfgGeneral(1, "wan_size"); %>';
var WifiFlag = '<% getCfgGeneral(1, "WifiFlag"); %>'; 
var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>'; 

var wan_enable_all = '<% getCfgGeneral(1, "wan_enable_all"); %>';
var wan_pp_n ='<% getCfgGeneral(1, "pppoe_name"); %>';
var feData = "<% getCfgGeneral(1, 'wan_fe_bind'); %>";
var ssidData = "<% getCfgGeneral(1, 'wan_ssid_bind'); %>";
var wanmodeDate = "<% getCfgGeneral(1, 'wan_service_type_all'); %>";
var wanTypeDate = "<% getCfgGeneral(1, 'wan_wan_type_all'); %>";
var wanVIDDate = "<% getCfgGeneral(1, 'wan_vid_all'); %>";
var wanPriorityDate = "<% getCfgGeneral(1, 'wan_priority_all'); %>";
var wan_pp_p ='<% getCfgGeneral(1, "pppoe_pwd"); %>';
var wanaddress_modeDate = "<% getCfgGeneral(1, 'wan_address_mode_all'); %>";
var wanNatDate = "<% getCfgGeneral(1, 'wan_nat_all'); %>";
var wanRelayDate = "<% getCfgGeneral(1, 'wan_relay_all'); %>";
var MTUArrayDate = "<% getCfgGeneral(1, 'wan_mtu_all'); %>";
var ipv6_enable_s = '<% getCfgGeneral(1, "ipv6_enable"); %>';
var dslite_enable = '<% getCfgGeneral(1, "dslite_enable"); %>';
var aftr_mode = '<% getCfgGeneral(1, "aftr_mode"); %>';

var wan_staticip = '<% getCfgGeneral(1, "wan_static_ip"); %>';
var wan_staticmask = '<% getCfgGeneral(1, "wan_static_mask"); %>';
var wan_staticgw = '<% getCfgGeneral(1, "wan_static_gw"); %>';
var wan_staticdns1 = '<% getCfgGeneral(1, "wan_static_dns1"); %>';
var wan_staticdns2 = '<% getCfgGeneral(1, "wan_static_dns2"); %>';

var wan_pppoe_mode ='<% getCfgGeneral(1, "pppoe_mode"); %>';
var wan_pppoe_interval ='<% getCfgGeneral(1, "pppoe_interval"); %>';
var wan_pppoe_state ='<% getCfgGeneral(1, "pppoe_state"); %>';
var wan_pppoe_outtime = '<% getCfgGeneral(1, "ppp_outtime"); %>';
var wan_Index ='<% getCfgGeneral(1, "wan_index_all"); %>';
var ipv6_state = '<% getCfgGeneral(1, "ipv6_state"); %>';
var all_option43_en = '<% getCfgGeneral(1, "all_option43_str"); %>';
var all_option60_en = '<% getCfgGeneral(1, "all_option60_str"); %>';
var all_option60_value = '<% getCfgGeneral(1, "all_option60_value_str"); %>';
var route_brige_all = '<% getCfgGeneral(1, "route_brige_all"); %>';
var wan_line = '<% getCfgGeneral(1, "wan_line"); %>';

var vlan_enable = '<% getCfgGeneral(1, "vlan_enable"); %>';
var ppp_auth_type = '<% getCfgGeneral(1, "ppp_auth_type"); %>';
var ppp_conn_trigger = '<% getCfgGeneral(1, "ppp_conn_trigger"); %>';
var brige_wan_only = '<% getCfgGeneral(1, "brige_wan_only"); %>'; /*01A9G只支持internet 桥接wan*/

var vlan_all_trans_mark = '<% getCfgGeneral(1, "vlan_all_trans_mark"); %>';	//add by wuxj, 20160419, vlan全透传标志
var vlan_mode_all = '<% getCfgGeneral(1, "vlan_mode_all"); %>';

var all_ipv6_enable = '<% getCfgGeneral(1, "all_ipv6_enable"); %>';
var all_ip6addr_buff = '<% getCfgGeneral(1, "all_ip6addr_buff"); %>';
var all_ipv6_prelength = '<% getCfgGeneral(1, "all_ipv6_prelength"); %>';
var all_ipv6_gateway = '<% getCfgGeneral(1, "all_ipv6_gateway"); %>';
var all_ipv6_pridns = '<% getCfgGeneral(1, "all_ipv6_pridns"); %>';
var all_ipv6_secdns = '<% getCfgGeneral(1, "all_ipv6_secdns"); %>';
var all_ipv6_prefix = '<% getCfgGeneral(1, "all_ipv6_prefix"); %>';
var all_prefix_v6_dhcp = '<% getCfgGeneral(1, "all_prefix_v6_dhcp"); %>';
var all_prefix_v6_pppoe = '<% getCfgGeneral(1, "all_prefix_v6_pppoe"); %>';
var wifi_ssid_sum = '<% getCfgGeneral(1, "wifi_ssid_sum"); %>';
var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
var WEB_DSLITE = '<% getCfgGeneral(1, "WEB_DSLITE"); %>';
var prefix_v6_dhcp = '<% getCfgGeneral(1, "prefix_v6_dhcp"); %>';
var prefix_v6_pppoe = '<% getCfgGeneral(1, "prefix_v6_pppoe"); %>';
var ipv6_l3_flag = '<% getCfgGeneral(1, "ipv6_l3_flag"); %>';
var tr069_v6_v4_mode = '<% getCfgGeneral(1, "tr069_v6_v4_mode"); %>';

var ipv6_enable_arr = all_ipv6_enable.split("|");
var ip6addr_arr = all_ip6addr_buff.split("|"); 
var ipv6_prelength_arr = all_ipv6_prelength.split("|"); 
var ipv6_gateway_arr = all_ipv6_gateway.split("|");
var ipv6_pridns_arr = all_ipv6_pridns.split("|");
var ipv6_secdns_arr = all_ipv6_secdns.split("|");
var ipv6_prefix_arr = all_ipv6_prefix.split("|");
var prefix_v6_dhcp_arr = all_prefix_v6_dhcp.split("|");
var prefix_v6_pppoe_arr = all_prefix_v6_pppoe.split("|");
var current_prefix_v6_dhcp;
var current_prefix_v6_pppoe;

var route_brige_arr = route_brige_all.split("|");

var option43_arr = all_option43_en.split("|");
var option60_arr = all_option60_en.split("|");

var wan_enable_arr = wan_enable_all.split("|");

var option60_value_arr = all_option60_value.split("|");

var wanIndex = wan_Index.split("|");
var Wanindex0Array, Wanindex1Array, Wanindex2Array, Wanindex3Array,Wanindex4Array;
var curWANIndex;

var feArray = feData.split("|");
var ssidArray = ssidData.split("|");

var modeArray = wanmodeDate.split("|");
var modeWan0Array, modeWan1Array, modeWan2Array, modeWan3Array, modeWan4Array;

var typeArray = wanTypeDate.split("|");
var typeWan0Array, typeWan1Array, typeWan2Array, typeWan3Array, typeWan4Array;

var VIDArray = wanVIDDate.split("|");
var PriorityArray = wanPriorityDate.split("|");

var addressArray = wanaddress_modeDate.split("|");
var addressWan0Array, addressWan1Array, addressWan2Array, addressWan3Array, addressWan4Array;

var NatArray = wanNatDate.split("|");
var RelayArray = wanRelayDate.split("|");
var MTUArray = MTUArrayDate.split("|");

var WanStaticIp = wan_staticip.split("|");
var Wan0StaticIp,Wan1StaticIp,Wan2StaticIp,Wan3StaticIp, Wan4StaticIp ;

var WanStaticMask = wan_staticmask.split("|");
var Wan0StaticMask,Wan1StaticMask,Wan2StaticMask,Wan3StaticMask, Wan4StaticMask;

var WanStaticGW = wan_staticgw.split("|");
var Wan0StaticGW,Wan1StaticGW,Wan2StaticGW,Wan3StaticGW, Wan4StaticGW;

var WanStaticDNS1 = wan_staticdns1.split("|");
var Wan0StaticDNS1,Wan1StaticDNS1,Wan2StaticDNS1,Wan3StaticDNS1, Wan4StaticDNS1;

var WanStaticDNS2 = wan_staticdns2.split("|");
var Wan0StaticDNS2,Wan1StaticDNS2,Wan2StaticDNS2,Wan3StaticDNS2, Wan4StaticDNS2;

var WanpppoeName = wan_pp_n.split("|");
var WanpppoePwd = wan_pp_p.split("|");
var WanpppoeMode = wan_pppoe_mode.split("|");
var WanpppoeInterval = wan_pppoe_interval.split("|");
var WanpppoeState = wan_pppoe_state.split("|");
var pppOutTimeArray = wan_pppoe_outtime.split("|");

var vlanEnableArray = vlan_enable.split("|");
var pppAuthTypeArray = ppp_auth_type.split("|");
var pppConnTriggerArray = ppp_conn_trigger.split("|");

var vlanModeArray = vlan_mode_all.split("|");

var Have_RADIUS = 0;

var currentline;
var previousTR = null;
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="wan_prompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<!--ok-->
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
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
                      <td><input type="button" value="" id="wan_add" class="submit" onClick="clickAdd('fw_ruleList');"></td>
                      <td><input type="button" value="" id="wan_delete" class="submit" onClick="clickRemove('fw_ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="fw_ruleList"><form method="post" id="fw_ruleForm" action="/goform/WanTr069Delete">
          <table class="tabal_bg" id = "fw_ruletable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="5" id="WANListHead">WAN List</td>
              </tr>
              <tr class="tabal_title">
                <td width="40%" align="center" id="WAN_nameTitle">WAN Name</td>
                <td width="20%" align="center" id="WAN_VIDtitle">VID/Priority</td>
                <td width="20%" align="center" id="WAN_ipmode">WAN IP Mode</td>
                <td width="7%" align="center" ></td>
                <td width="2%" align="center" ></td>
              </tr>
              <% WanTr069Sync(); %>
            </tbody>
          </table>
        </form></td>
    </tr>
    <!--ok-->
    <tr>
      <td height="10"><span id="fw_userResetPrompt"></span></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" name="ConfigForm" method="post" action="/goform/WanTr069Cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                      <tbody>
                        <tr>
                          <td >
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                <tr>
									<td id="wan_enableTitle" class="tabal_left" width="25%">WAN Enable</td>
									<td class="tabal_right" ><select name="wan_enable" id="wan_enable" size="1" style="width:200px;">
										<option value="1" id="wan_enable_tip">Enable</option>
										<option value="0" id="wan_disable_tip">Disable</option>
									  </select>
									</td>									
								</tr>
                                <tr id="tr_vlan_enable" style="display:none">
									<td id="vlan_enableTitle" class="tabal_left" width="25%">VLAN Enable</td>
									<td class="tabal_right" ><select name="vlan_enable" id="vlan_enable" size="1" style="width:200px;">
										<option value="1" id="vlan_enable_tip">Enable</option>
										<option value="0" id="vlan_disable_tip">Disable</option>
									  </select>
									</td>									        
								</tr>
							  	<tr>
									<td id="wan_servicetypeTitle" class="tabal_left" width="25%">Service Type</td>
									<td class="tabal_right" ><select name="wan_connectionmode" id="wan_connectionmode" size="1" style="width:200px;" onChange="WanIndexSwitch(this.value, currentline);">
										<option value="0" selected="selected">TR069</option>
										<option value="1">INTERNET</option>
										<option value="2">TR069_INTERNET</option>
										<option value="3">Other</option>
										<option value="4">VOIP</option>
										<option value="5">VOIP_INTERNET</option>
									  </select></td>
							   	</tr>
								<tr>
									<td width="25%" class="tabal_left" id="wan_connectionTypeTitle">Connection Type</td>
									<td class="tabal_right"><select name="wan_connectionType" id="wan_connectionType" size="1" style="width:200px;"  onChange="ConnectTypeSwitch(this.value);" >
										<option value="0" id="wConnType_bridge" >Bridge</option>
										<option value="1" id="wConnType_route" selected="selected" >Route</option>
									  </select>
									</td>
								</tr>
                                <tr id="tr_vlan_mode" style="display:none">
							        <td id="vlan_modeTitle" class="tabal_left" width="25%">VLAN Mode</td>
							        <td class="tabal_right" ><select name="vlan_mode" id="vlan_mode" size="1" style="width:200px;" onChange="vlanModeSwitch(this.value);">
							            <option value="1" id="vlan_tag_tip">Tag</option>
							            <option value="2" id="vlan_vlan_trans_tip">VLAN Transparent</option>
							            <option value="3" id="vlan_all_trans_tip">All Transparent</option>
							          </select>
							        </td>									        
								</tr>
							  	<tr id="tr_vlan">
									<td id="wan_vid_title" class="tabal_left" width="25%">VLAN ID</td>
									<td class="tabal_right" width="75%"><input name="wan_vid" id="wan_vid" size="15"  style="width: 200px;" type="text">
									<strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (1-4094)</span></td>
							  	</tr>                                                                  
							  	<tr id="tr_priority">
									<td id="wan_priorityTitle" class="tabal_left" width="25%">Priority</td>
									<td class="tabal_right" width="75%"><input name="wan_priority" id="wan_priority" size="15"  style="width: 200px;" type="text">   
									<strong style="color:#FF0033">*</strong><span class="gray">&nbsp; (0-7)</span></td>
							  	</tr>
                                 <table id="tb_nat_dns" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
                                  <tr>
                                    <td class="tabal_left" width="25%">NAT</td>
                                    <td class="tabal_right" width="75%"><select name="nat_enable" id="nat_enable" size="1" style="width: 200px;" >
                                        <option value="1" id="nat_enabletitle" selected="selected">Enable</option>
                                        <option value="0" id="nat_disabletitle" >Disable</option>
                                      </select></td>
                                  </tr>
                                  <tr id="tr_natType" style="display:none">
                                    <td class="tabal_left" id="nat_typetitle">NAT Type</td>
                                    <td class="tabal_right"><select name="nat_type" size="1" style="width: 200px;" >
                                        <option value="0" id="nat_title" selected="selected">Port-Restricted cone NAT</option>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td id="lan_dns_relay" class="tabal_left" width="25%">DNS Relay</td>
                                    <td class="tabal_right" width="75%"><select name="dns_enable" id="dns_enable" size="1" style="width: 200px;" >
                                        <option value="1" id="dns_enabletitle" selected="selected">Enable</option>
                                        <option value="0" id="dns_disabletitle" >Disable</option>
                                      </select></td>
                                  </tr>
                                      <tr>
                                    <td id="wan_MTUTitle" class="tabal_left" width="25%">MTU</td>
                                    <td class="tabal_right" width="75%"><input name="wan_mtu" id="wan_mtu" size="15"  style="width: 200px;" type="text">  
                                    <strong style="color:#FF0033">*</strong><span id='span_mtu' class="gray">&nbsp; (1280-1500)</span></td>
                                  </tr>
                                        </tbody>
                                 </table>
                                </tbody>
                              </table>
                               <table id="port_bang" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
								      <tr id="tr_feBind">
								        <td width="25%" class="tabal_left" id="wan_FE_title">LAN Binding</td>
								        <td class="tabal_right" ><span>LAN 1</span>
								          <input type="checkbox" name="wan_feBox" id="wan_feBox1" value="1">
								          &nbsp;&nbsp; &nbsp; <span>LAN 2</span>
								          <input type="checkbox" name="wan_feBox" id="wan_feBox2" value="2">
								          &nbsp;&nbsp; &nbsp; <span>LAN 3</span>
								          <input type="checkbox" name="wan_feBox" id="wan_feBox3" value="4">
								          &nbsp;&nbsp; &nbsp; <span>LAN 4</span>
								          <input type="checkbox" name="wan_feBox" id="wan_feBox4" value="8">
								        <td>
								      </tr>
								      <tr id="tr_ssidBind">
								        <td width="25%" class="tabal_left" id="wan_SSID_title">SSID Binding</td>
								        <td class="tabal_right"><span>SSID 1</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox1" value="1">
								          &nbsp;&nbsp; <span>SSID 2</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox2" value="2">
								          &nbsp;&nbsp; <span>SSID 3</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox3" value="4">
								          &nbsp;&nbsp; <span>SSID 4</span>
								          <input type="checkbox" name="wan_ssidBox" id="wan_ssidBox4" value="8">
								        </td>
								      </tr>
								    </tbody>
								  </table>
								    </table>
									  <table id="wan_ipv6enable" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;">
									    <tbody>
									      <tr style="">
									        <td width="25%" class="tabal_left" id="wIP_mode_title">IP Mode</td>
									        <td class="tabal_right"><select name="ipv6_enable" id="ipv6_enable" size="1" style="width:200px;" onChange="ipv6_enableSwitch();">
									            <option value="1" selected="selected">IPv4</option>
									            <option value="2" >IPv6</option>
									            <option value="3" >IPv4&IPv6</option>
									          </select>
									        </td>
									        
									      </tr>
									    </tbody>
									  </table>
								    <table id="tb_wanIPModel" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								    <tbody>
								      <tr style="">
								        <td width="25%" class="tabal_left" id="wConnectionType">WAN IP Mode </td>
								        <td class="tabal_right"><select name="ipModel" id="ipModel" size="1" style="width:200px;" onChange="ipModelSwitch();">
 											<option value="0" id="wConnTypeDhcp" selected="selected">DHCP</option>
								            <option value="1" id="wConnTypeStatic">Static</option>  
								            <option value="2" id="wConnTypePppoe">PPPoE</option>
								          </select>
								        </td>
								      </tr>
												 <table id="dsline_ipv6_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" >DS-Lite</td>
											        <td class="tabal_right"><select name="DS_Lite_enable" id="DS_Lite_enable" size="1" style="width:200px;" onChange="DsliteSwitch();">
											            <option value="0"  selected="selected" id="dslite_disable"></option>
											            <option value="1" id="dslite_enable"></option>   
											          </select>
											        </td>
											      </tr>
											      </tbody>
												</table>
													<table id="AFTR_ipv6_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" id="AFTRType1">AFTR Manual</td>
											        <td class="tabal_right"><select name="AFTR_enable" id="AFTR_enable" size="1" style="width:200px;" onChange="AFTRSwitch();">
												         <option value="0"  selected="selected" id="AFTR_disable_title">Disable</option>
											            <option value="1" id="AFTR_enable_title" >Enable</option>   
											          </select>
											        </td>
											      </tr>
											      </tbody>
												</table>
													<table id="AFTR_value_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								           			<tr style="">
											        <td width="25%" class="tabal_left" >AFTR </td>
											        <td class="tabal_right" width="75%"><input name="AFTR_value" id="AFTR_value" size="15"  maxlength=40 style="width: 150px;" type="text" value="<% getCfgGeneral(1, "aftr_value"); %>"> </td>  
											      </tr>
											      </tbody>
												</table>
								    </tbody>
								  </table>
								  <br>
								  <!-- ================= STATIC Mode ================= -->
								  <table id="static" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wStaticMode">Static Mode</td>
								      </tr>
								      <table id="static_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
								      <tr>
								        <td class="tabal_left" width="25%" id="wStaticIp">IP Address</td>
								        <td class="tabal_right"><input name="staticIp" id="staticIp" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_ipaddr"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticNetmask">Subnet Mask</td>
								        <td class="tabal_right"><input name="staticNetmask" id="staticNetmask" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_netmask"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticGateway">Default Gateway</td>
								        <td class="tabal_right"><input name="staticGateway" id="staticGateway" maxlength=15 size=32
								  		value="<% getCfgGeneral(1, "wan_gateway"); %>">
								        </td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticPriDns">Primary DNS Server</td>
								        <td class="tabal_right"><input name="staticPriDns" id="staticPriDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_primary_dns"); %>"></td>
								      </tr>
								      <tr>
								        <td class="tabal_left" id="wStaticSecDns">Secondary DNS Server</td>
								        <td class="tabal_right"><input name="staticSecDns" id="staticSecDns" maxlength=15 size=32 value="<% getCfgGeneral(1, "wan_secondary_dns"); %>"></td>
								      </tr>  
										  </tbody>
										  </table>

										<table id="static_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
										      <tr>
										        <td class="tabal_left" width="25%" id="wStaticIpv6">IPv6 Address</td>
										        <td class="tabal_right"><input name="staticIp_ipv6" id="staticIp_ipv6" maxlength=128 size=32 value="<% getCfgGeneral(1, "staticIp_ipv6"); %>">
										        </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="Prefix_Length_title">IPv6 Prefix Length</td>
										        <td class="tabal_right"><input name="Prefix_Length" id="Prefix_Length" maxlength=128 size=32 value="<% getCfgGeneral(1, "Prefix_Length"); %>">
										         </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticGateway_ipv6">Default Gateway</td>
										        <td class="tabal_right"><input name="IPv6_Gateway" id="IPv6_Gateway" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Gateway"); %>">
										        </td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticPriDns_ipv6">Primary DNS Server</td>
										        <td class="tabal_right"><input name="IPv6_Pri_DNS" id="IPv6_Pri_DNS" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Pri_DNS"); %>"></td>
										      </tr>
										      <tr>
										        <td class="tabal_left" id="wStaticSecDns_ipv6">Secondary DNS Server</td>
										        <td class="tabal_right"><input name="IPv6_Sec_DNS" id="IPv6_Sec_DNS" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_Sec_DNS"); %>"></td>
										      </tr>   
										      <tr>
										        <td class="tabal_left" width="25%" id="Address/Prefix_title1">IPv6 Address Mode</td>
										        <td class="tabal_right"><select name="Address/Prefix_static" id="Address/Prefix_static" size="1">
										            <option value="2" id="wV6_Address/Prefix_static">Static</option>
										          </select>
										        </td>
										      </tr> 
										      	<tr>
										        <td class="tabal_left" width="25%" id="Prefix_title">IPv6 Prefix Mode</td>
										        <td class="tabal_right"><select name="Prefix_static" id="Prefix_static" size="1">
										            <option value="2" id="wV6_prefixMode_static">Static</option>		        
										          </select>
										        </td>
										      </tr> 
										      <tr>
										        <td class="tabal_left" id="Prefix_value_title" >IPv6 Prefix</td>
										        <td class="tabal_right"><input name="IPv6_prefix" id="IPv6_prefix" maxlength=128 size=32 value="<% getCfgGeneral(1, "IPv6_prefix"); %>"></td>
										      </tr> 
										    </tbody>
										  </table>
								      
								    </tbody>
								  </table>
								  <!-- ================= DHCP Mode ================= -->
								  <table id="dhcp" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wDhcpMode">DHCP Mode</td>
								      </tr>
								      <!--add begin by 吴小娟, 20110601, 原因: 新增DHCP连接IP等-->
									 <table id="dhcp_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
								      <tr id="wDhcpCon_ip_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_ip_title">IP Address</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_ip"  disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_mask_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_mask_title">Subnet Mask</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_mask"  disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_gateway_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_gateway_title">Default Gateway</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_gateway"  disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_priDNS_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_priDNS_title">Primary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_priDNS"  disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wDhcpCon_secDNS_tr">
								        <td class="tabal_left" width="25%" id="wDhcpCon_secDNS_title">Secondary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wDhcpCon_secDNS"  disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								        </tbody>
										  </table>
									   <!--tr>
									        <td class="tabal_left" id="Option43Enable_title" align="left" width="25%">Option43:</td>
									        <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1"  name="option43_enable" type="radio">
									          <font id="option43_enable_tip">Enable</font>
									          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									          <input value="0" name="option43_enable" type="radio">
									          <font id="option43_disable_tip">Disable</font> </td>
									    </tr>
									     <tr>
									         <td class="tabal_left" id="Option60Enable_title" align="left" width="25%">Option60:</td>
									         <td class="tabal_right" colspan="6" align="left" width="75%"><input checked="checked" value="1" id="option60_enable" name="option60_enable" type="radio">
									          <font id="option60_enable_tip">Enable</font>
									          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									          <input value="0" name="option60_enable" type="radio">
									          <font id="option60_disable_tip">Disable</font> </td>
									     </tr>
									     <tr id="wDhcpCon_secDNS_tr">
										        <td class="tabal_left" width="25%" id="Option60value_title">Option60 Value:</td>
										        <td class="tabal_right"><input type="text"   name="option60_value" id="option60_value" style="width:320px;" value="<% getCfgGeneral(1, "option60_value"); %>">
										        </td>
								         </tr-->
									
								      <table id="dhcp_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
										    <tbody>
										      <tr>
										        <td class="tabal_left" width="25%" id="Address/Prefix_title">IPv6 Address Mode</td>
										        <td class="tabal_right"><select name="Address/Prefix_dhcp" id="Address/Prefix_dhcp" size="1">
								        			<option value="DHCPv6" >DHCPv6</option>
								          			<option value="AutoConfigured" selected="selected">SLAAC</option>
										          </select>
										        </td>
										      </tr> 
										      	<tr>
										        <td class="tabal_left" width="25%" id="Prefix_title_dhcp">IPv6 Prefix Mode</td>
										        <td class="tabal_right"><select name="Prefix_dhcp" id="Prefix_dhcp" size="1">
										            <option value="PrefixDelegation" id="Prefix_mode">Prefix Delegate</option>
										          </select>
										        </td>
										      </tr> 
										    </tbody>
										  </table>																		     
								    </tbody>
								  </table>
								  <!-- ================= PPPOE Mode ================= -->
								  <table id="pppoe" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								    <tbody>
								      <tr class="tabal_head">
								        <td colspan="2" id="wPppoeMode">PPPoE Mode</td>
								      </tr>
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoeUser">User Name</td>
								        <td class="tabal_right"><input name="pppoeUser" id="pppoeUser" maxlength=31 style="width:200px;">
								          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_userTips">(You can input 1-31 characters)</span></td>
								      </tr>
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoePassword">Password</td>
								        <td class="tabal_right"><input type="password" name="pppoePass" id="pppoePass" maxlength=31 style="width:200px;" onfocus="clearInputValue(this.id)" onblur="resetInputValue(this.id)">
								          <strong style="color:#FF0033">*</strong><span class="gray" id="wPppoeCon_pwdTips">(You can input 1-31 characters)</span></td>
								      </tr>
								      <!--tr>
								        <td class="tabal_left" width="25%" id="wPppoePass2">Verify Password</td>
								        <td class="tabal_right"><input type="password" name="pppoePass2" id="pppoePass2" maxlength=31 style="width:320px;"
								             value="<% getCfgGeneral(1, "wan_pppoe_pass"); %>"></td>
								      </tr-->
								      <tr id='tr_operationMode'>
								        <td class="tabal_left" width="25%" rowspan="2" id="wPppoeOPMode">Operation Mode</td>
								        <td class="tabal_right"><select name="pppoeOPMode" id="pppoeOPMode" size="1" style="width:200px;">
								            <option value="0" id="wPppoeKeepAlive" selected="selected">Keep Alive</option>
								            <!--option value="1" id="wPppoepasv">有流量时连接</option>
								            <option value="2" id="wPppoeManual">Manual</option-->
								          </select>
								        </td>
								      </tr>
								      <tr id='tr_retryPeriod'>
								        <td class="tabal_right" id="wPppoeCon_retryPeriod_td"> <span id="wPppoeCon_retryPeriod_title">Keep Alive Mode: Retry Period</span>
								          <input type="text" name="pppoeRetryPeriod" id="pppoeRetryPeriod" onfocus="this.blur()" style="background-color:#ECE9D8;border:1px solid #7F9DB9;" maxlength="5" size="3">
								        </td>
								      </tr>
								      <tr id="tr_pppAuthType" style="display:none">
								        <td class="tabal_left" width="25%" id="wPppoeAuthTypeTitle">Authentication Type</td>
								        <td class="tabal_right"><select name="pppAuthType" id="pppAuthType" size="1" style="width:200px;">
								            <option value="0" selected="selected">PAP</option>
								            <option value="1">CHAP</option>
								            <option value="2">MS-CHAP</option>
								            <option value="3">Auto</option>
								          </select>
								        </td>
								      </tr>
								      <tr id="tr_pppConnTrigger" style="display:none">
								        <td class="tabal_left" width="25%" id="wPppoeConnTriggerTitle">Connection Trigger</td>
								        <td class="tabal_right"><select name="pppConnTrigger" id="pppConnTrigger" size="1" style="width:200px;" onChange="pppoeOPModeSwitch()">
								            <option value="0" selected="selected">OnDemand</option>
								            <option value="1">AlwaysOn</option>
								            <option value="2">Manual</option>
								          </select>
								        </td>
								      </tr>
								        <tr id="tr_manual_connect" style="display:none">
								        <td class="tabal_left" width="25%" id="manual_connectButton"></td>
								        <td><table id="pppoe_connect_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
								       		<tbody>
								       		<tr>
									        <td class="tabal_right" width="25%"><input type="button" name="manual_connect" id="manual_connect" style="{width:120px;}" value="Connect"
									     		 onClick="pppoemanual_connect(1);">
									      
									        <td class="tabal_right" width="25%"><input type="button" name="manual_disconnect" id="manual_disconnect" style="{width:120px;}" value="Disconnect"
									     		 onClick=" pppoemanual_connect(0);">
									     
									        <td class="tabal_right"><input type=hidden id="ppphiddenButton" name="ppphiddenButton" value="0"></td>
											</tr>
									      </tbody>
									      </table>
									    </td>
									  </tr>
								      <tr id="tr_ppp_outtime" style="display:none">
								        <td class="tabal_left" width="25%" id="wppp_outtimeTitle">OutTime</td>
								        <td class="tabal_right"><input type="text" name="ppp_outtime" id="ppp_outtime" maxlength="5" size="5">
								          <span id="wPppoeCon_retryPeriod_tips">Seconds (30-60000)</span>
								        </td>
								      </tr>
								      <!--add begin by 吴小娟, 20110427, 原因: 新增PPPOE连接状态及IP;20110510, 原因:新增PPPOE连接DNS等-->
								         <table id="pppoe_ipv4_table" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								       <tbody>
								      <tr>
								        <td class="tabal_left" width="25%" id="wPppoeCon_status_title">State</td>
								        <td class="tabal_right" id="wPppoeCon_status">&nbsp;</td>
								      </tr>
								      <tr id="wPppoeCon_ip_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_ip_title">IP Address</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_ip" disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_mask_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_mask_title">Subnet Mask</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_mask" disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_gateway_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_gateway_title">Default Gateway</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_gateway" disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_priDNS_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_priDNS_title">Primary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_priDNS" disabled="disabled" style="width:200px;">
								        </td>
								      </tr>
								      <tr id="wPppoeCon_secDNS_tr">
								        <td class="tabal_left" width="25%" id="wPppoeCon_secDNS_title">Secondary DNS Server</td>
								        <td class="tabal_right"><input type="text" id="wPppoeCon_secDNS" disabled="disabled" style="width:200px;">
								        </td>
								      </tr>								       
								      </tbody>
								     </table>

								      
								          <table id="pppoe_ipv6" class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%" style="display: none;" >
								       <tbody>
								       <tr>
								        <td class="tabal_left" width="25%" id="Address/Prefix_title_pppoe">IPv6 Address Mode</td>
								        <td class="tabal_right"><select name="Address/Prefix_pppoe" id="Address/Prefix_pppoe" size="1">
								        	<option value="DHCPv6" >DHCPv6</option>
								            <option value="AutoConfigured" selected="selected">SLAAC</option>
								          </select>
								        </td>
								      </tr>
								      	<tr>
								        <td class="tabal_left" width="25%" id="Prefix_title_pppoe">IPv6 Prefix Mode</td>
								        <td class="tabal_right"><select name="Prefix_pppoe" id="Prefix_pppoe" size="1">
								        	<option value="PrefixDelegation" id="wV6_prefixMode_pppoe">Prefix Delegate</option>
								          </select>
								        </td>
								      </tr>
								        </tbody>
								     </table>
								    </tbody>
								    <!--add end by 吴小娟, 20110427 -->
								  </table>
                            </div></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
    		<tbody>
    		  <tr>
    		    <td height="5"></td>
    		  </tr>
   			 </tbody>
 			 </table>
            <table id="apply_table" class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="wApply" id="wApply" class="submit">
                    <input type="reset" value="Cancel" name="wCancel" id="wCancel" class="submit" onClick="window.location.reload()">
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