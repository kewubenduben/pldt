/***********************************************************************************
utils.js
yclv
2016.10.9
 common JS functions
***********************************************************************************/

var changed = 0;
var old_MBSSID;

var defaultShownMBSSID = 0;

var ssidName = new Array();
var ssidHide = new Array();
var wmmList = new Array();
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

function check_wpa()
{
		if(document.security_form.cipher[0].checked != true && 
		   document.security_form.cipher[1].checked != true &&
   		   document.security_form.cipher[2].checked != true){
		   alert(_("secure no WPA Algorithm"));
   		   return false;
		}

		return true;
}

function check_radius()
{
	if(!document.security_form.RadiusServerIP.value.length){
		alert('Please input the radius server ip address.');
		return false;		
	}
	if(!document.security_form.RadiusServerPort.value.length){
		alert('Please input the radius server port number.');
		return false;		
	}
	if(!document.security_form.RadiusServerSecret.value.length){
		alert('Please input the radius server shared secret.');
		return false;		
	}

	if(checkIpAddr(document.security_form.RadiusServerIP) == false){
		alert('Please input a valid radius server ip address.');
		return false;		
	}
	if( (checkRange(document.security_form.RadiusServerPort.value, 1, 1, 65535)==false) ||
		(checkAllNum(document.security_form.RadiusServerPort.value)==false)){
		alert('Please input a valid radius server port number.');
		return false;		
	}
	if(checkStrictInjection(document.security_form.RadiusServerSecret.value)==false){
		alert('The shared secret contains invalid characters.');
		return false;		
	}

	if(document.security_form.RadiusServerSessionTimeout.value.length){
		if(checkAllNum(document.security_form.RadiusServerSessionTimeout.value)==false){
			alert('Please input a valid session timeout number or u may left it empty.');
			return false;	
		}	
	}

	return true;
}

function securityMode(c_f)
{
	var security_mode;
	changed = c_f;
	hideWep();

	document.getElementById("div_security_shared_mode").style.visibility = "hidden";
	document.getElementById("div_security_shared_mode").style.display = "none";
	document.getElementById("div_wpa").style.visibility = "hidden";
	document.getElementById("div_wpa").style.display = "none";
	document.getElementById("div_wpa_algorithms").style.visibility = "hidden";
	document.getElementById("div_wpa_algorithms").style.display = "none";
	document.getElementById("wpa_passphrase").style.visibility = "hidden";
	document.getElementById("wpa_passphrase").style.display = "none";

	document.getElementById("wpa_PMK_Cache_Period").style.visibility = "hidden";
	document.getElementById("wpa_PMK_Cache_Period").style.display = "none";
	document.getElementById("wpa_preAuthentication").style.visibility = "hidden";
	document.getElementById("wpa_preAuthentication").style.display = "none";
	document.security_form.cipher[0].disabled = true;
	document.security_form.cipher[1].disabled = true;
	document.security_form.cipher[2].disabled = true;
	document.security_form.passphrase.disabled = true;

	document.security_form.PMKCachePeriod.disabled = true;
	document.security_form.PreAuthentication.disabled = true;

	setDisplay("div_radius_server", "none");
	document.getElementById("div_8021x_wep").style.visibility = "hidden";
	document.getElementById("div_8021x_wep").style.display = "none";
	document.security_form.ieee8021x_wep.disable = true;
	document.security_form.RadiusServerIP.disable = true;
	document.security_form.RadiusServerPort.disable = true;
	document.security_form.RadiusServerSecret.disable = true;	
	document.security_form.RadiusServerSessionTimeout.disable = true;
	document.security_form.RadiusServerIdleTimeout.disable = true;	

	security_mode = document.security_form.security_mode.value;

	if (security_mode == "OPEN" || security_mode == "SHARED" || security_mode == "WEPAUTO"){
		showWep(security_mode);
	}else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK"){
		<!-- WPA -->
		document.getElementById("div_wpa").style.visibility = "visible";
		if (window.ActiveXObject) { // IE
			document.getElementById("div_wpa").style.display = "block";
		}
		else if (window.XMLHttpRequest) { // Mozilla, Safari,...
			document.getElementById("div_wpa").style.display = "table";
		}

		document.getElementById("div_wpa_algorithms").style.visibility = "visible";
		document.getElementById("div_wpa_algorithms").style.display = style_display_on();
		document.security_form.cipher[0].disabled = false;
		document.security_form.cipher[1].disabled = false;

		// deal with TKIP-AES mixed mode
		if(security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK")
			document.security_form.cipher[2].disabled = false;

		document.getElementById("wpa_passphrase").style.visibility = "visible";
		document.getElementById("wpa_passphrase").style.display = style_display_on();
		document.security_form.passphrase.disabled = false;

	}else if (security_mode == "WPA" || security_mode == "WPA2" || security_mode == "WPA1WPA2") //wpa enterprise
	{
		document.getElementById("div_wpa").style.visibility = "visible";
		if (window.ActiveXObject) { // IE
			document.getElementById("div_wpa").style.display = "block";
		}else if (window.XMLHttpRequest) { // Mozilla, Safari,...
			document.getElementById("div_wpa").style.display = "table";
		}

		document.getElementById("div_wpa_algorithms").style.visibility = "visible";
		document.getElementById("div_wpa_algorithms").style.display = style_display_on();
		document.security_form.cipher[0].disabled = false;
		document.security_form.cipher[1].disabled = false;

		<!-- 802.1x -->	
		setDisplay("div_radius_server", "");
		document.security_form.RadiusServerIP.disable = false;
		document.security_form.RadiusServerPort.disable = false;
		document.security_form.RadiusServerSecret.disable = false;	
		document.security_form.RadiusServerSessionTimeout.disable = false;
		document.security_form.RadiusServerIdleTimeout.disable = false;	

		if(security_mode == "WPA")
			document.security_form.cipher[2].disabled = false;

		if(security_mode == "WPA2"){
			document.security_form.cipher[2].disabled = false;
			document.getElementById("wpa_preAuthentication").style.visibility = "visible";
			document.security_form.PreAuthentication.disabled = false;
			document.getElementById("wpa_PMK_Cache_Period").style.visibility = "visible";
			document.security_form.PMKCachePeriod.disabled = false;
		}

		if(security_mode == "WPA1WPA2"){
			document.security_form.cipher[2].disabled = false;
		}

	}else if (security_mode == "IEEE8021X"){ // 802.1X-WEP
		document.getElementById("div_8021x_wep").style.visibility = "visible";
		document.getElementById("div_8021x_wep").style.display = style_display_on();
		setDisplay("div_radius_server", "");
		document.security_form.ieee8021x_wep.disable = false;
		document.security_form.RadiusServerIP.disable = false;
		document.security_form.RadiusServerPort.disable = false;
		document.security_form.RadiusServerSecret.disable = false;	
		document.security_form.RadiusServerSessionTimeout.disable = false;
	}
}

function hideWep()
{
	document.getElementById("div_wep").style.visibility = "hidden";
	document.getElementById("div_wep").style.display = "none";
}
function showWep(mode)
{
	var encrypt_type;
	
	encrypt_type = document.security_form.security_shared_mode.value;
	
	if((mode == "OPEN" && encrypt_type == "WEP") || (mode == "SHARED") || (mode == "WEPAUTO"))
	{
	  document.getElementById("div_wep").style.visibility = "visible";
	}
	
	<!-- WEP -->
	if (window.ActiveXObject) { // IE 
		document.getElementById("div_wep").style.display = "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari...
		document.getElementById("div_wep").style.display = "table";
	}

	if(mode == "OPEN"){
		document.getElementById("div_security_shared_mode").style.visibility = "visible";
		document.getElementById("div_security_shared_mode").style.display = style_display_on();
	}
}
	
function submit_apply()
{

	if (checkData() == true){
		changed = 0;

		load_waiting();
		document.security_form.submit();
	}
}

function LoadAP()
{
	for(var i=0; i<SSID.length; i++){
		var j=0;
		var aplist = new Array;

		if(AccessControlList[i].length != 0){
			aplist = AccessControlList[i].split(";");
			for(j=0; j<aplist.length; j++){
				document.getElementById("newap_"+i+"_"+j).value = aplist[j];
			}

			// hide the lastest <td>
			if(j%2){
				document.getElementById("newap_td_"+i+"_"+j).style.visibility = "hidden";
				document.getElementById("newap_td_"+i+"_"+j).style.display = "none";
				j++;
			}
		}
	}
}

function selectMBSSIDChanged()
{
	if(changed){
		ret = confirm(_("Are you sure to ignore changed?"));
		if(!ret){
			document.security_form.ssidIndex.options.selectedIndex = old_MBSSID;
			return false;
		}
		else
			changed = 0;
	}

	var selected = document.security_form.ssidIndex.options.selectedIndex;
	if(selected != 0)/*SSID2-4*/
	{
		if((ispMinorNameCode == 201 && curUserType == 1) || (ispMinorNameCode == 203))
		{
			getElement("tb_submit").style.display = "none";

			getElement("SSIDEnable").disabled = 1;
			getElement("ssidName").disabled = 1;
			getElement("hssid").disabled = 1;
			getElement("security_mode").disabled = 1;
			getElement("security_shared_mode").disabled = 1;
			getElement("wep_default_key").disabled = 1;
			getElement("WEP1").disabled = 1;
			getElement("WEP1Select").disabled = 1;
			getElement("WEP2").disabled = 1;
			getElement("WEP2Select").disabled = 1;
			getElement("WEP3").disabled = 1;
			getElement("WEP3Select").disabled = 1;
			getElement("WEP4").disabled = 1;
			getElement("WEP4Select").disabled = 1;
			getElement("cipher").disabled = 1;
			getElement("passphrase").disabled = 1;
		}
		else
		{
			getElement("tb_submit").style.display = "";

			getElement("SSIDEnable").disabled = 0;
			getElement("ssidName").disabled = 0;
			getElement("hssid").disabled = 0;
			getElement("security_mode").disabled = 0;
			getElement("security_shared_mode").disabled = 0;
			getElement("wep_default_key").disabled = 0;
			getElement("WEP1").disabled = 0;
			getElement("WEP1Select").disabled = 0;
			getElement("WEP2").disabled = 0;
			getElement("WEP2Select").disabled = 0;
			getElement("WEP3").disabled = 0;
			getElement("WEP3Select").disabled = 0;
			getElement("WEP4").disabled = 0;
			getElement("WEP4Select").disabled = 0;
			getElement("cipher").disabled = 0;
			getElement("passphrase").disabled = 0;
		}
	}
	old_MBSSID = selected;
	MBSSIDChange(selected);
    showSSIDEnable();
}

/*
 * When user select the different SSID, this function would be called.
 */ 
function MBSSIDChange(selected)
{
	LoadFields(selected);
	WPAAlgorithms = EncrypType[selected];
	IEEE8021XWEP = IEEE8021X[selected];
	PreAuthentication = PreAuth[selected];
	changeSecurityPolicyTableTitle(SSID[selected]);
	return true;
}

function changeSecurityPolicyTableTitle(t)
{

}

function initAll()
{
	initTranslation();
	
	//add by wuxj, 20161205, ECUADOR要求密码显示为密文
	var passphraseNode;
	var WEPNode;
	if(ispNameCode == '12' || ispNameCode == '4' || ispNameCode == '16')//厄瓜多尔/3BB/越南
	{
		passphraseNode = getElement("passphraseText");
		passphraseNode.parentNode.removeChild(passphraseNode);
		
		for(var i = 1; i <= 4; i++)
		{
			WEPNode = getElement("WEP" + i + "Text");
			WEPNode.parentNode.removeChild(WEPNode);
		}
	}
	else
	{
		passphraseNode = getElement("passphrasePwd");
		passphraseNode.parentNode.removeChild(passphraseNode);
		
		for(var i = 1; i <= 4; i++)
		{
			WEPNode = getElement("WEP" + i + "Pwd");
			WEPNode.parentNode.removeChild(WEPNode);
		}
	}
	
	makeRequest("/goform/wirelessGetSecurity", "n/a", securityHandler);		
	if(ispNameCode == 12)//厄瓜多尔
	{
		setDisplay("tr_wmm", "");
	}

	var ssidIndex = document.getElementById("ssidIndex");
	if(ispMinorNameCode == 303)		/* X_CU_ANHUI */
	{
		ssidIndex.options[ssidIndex.length] = new Option("1", "1");
		ssidIndex.options[ssidIndex.length] = new Option("2", "2");
	}
	else
	{
		if((ispNameCode == 9) && (curUserType == 1))//罗马尼亚普通用户
		{
			ssidIndex.options[ssidIndex.length] = new Option("1", "1");
		}
		else
		{
			ssidIndex.options[ssidIndex.length] = new Option("1", "1");
			ssidIndex.options[ssidIndex.length] = new Option("2", "2");
			ssidIndex.options[ssidIndex.length] = new Option("3", "3");
			ssidIndex.options[ssidIndex.length] = new Option("4", "4");
		}
	}

	setDisplay("sp_title_x", "none"); 
	setDisplay("div_access_infra_mode", "none"); 
	setDisplay("basicSSID", "none"); 
	setDisplay("AddMacTable", "none"); 
	setDisplay("AddMacAddr", "none"); 
	setDisplay("secureRadiusSessionTimeout", "none"); 
	setDisplay("RadiusServerSessionTimeout", "none"); 
	setDisplay("secureRadiusIdleTimeout", "none"); 
	setDisplay("RadiusServerIdleTimeout", "none"); 
	dealSecurityFailedHandle();
	
}

function showSSIDEnable()
{
	var ssidenable = document.getElementsByName("SSIDEnable");	
	var ssidNO = document.getElementById("ssidIndex");	
	var ssidnoValue = parseInt(ssidNO.value);
	
    if(ssidNO.value == "1")
	for(var i = 0;i<ssidenable.length;i++)
	{
		if(ssidenable[i].value == SSIDEnable1)
		{
			ssidenable[i].checked = true;
			break;
		}
	}
	else if(ssidNO.value == "2")
	for(var i = 0;i<ssidenable.length;i++)
	{
		if(ssidenable[i].value == SSIDEnable2)
		{
			ssidenable[i].checked = true;
			break;
		}
	}   
	else if(ssidNO.value == "3")
	for(var i = 0;i<ssidenable.length;i++)
	{
		if(ssidenable[i].value == SSIDEnable3)
		{
			ssidenable[i].checked = true;
			break;
		}
	}
	else if(ssidNO.value == "4")
	for(var i = 0;i<ssidenable.length;i++)
	{
		if(ssidenable[i].value == SSIDEnable4)
		{
			ssidenable[i].checked = true;
			break;
		}
	}
}

function UpdateMBSSIDList()
{
	document.security_form.ssidIndex.options.selectedIndex = defaultShownMBSSID;
	old_MBSSID = defaultShownMBSSID;
	changeSecurityPolicyTableTitle(SSID[defaultShownMBSSID]);
}

function setChange(c){
	changed = c;
}

var WPAAlgorithms;
function onWPAAlgorithmsClick(type)
{
	if(type == 0 && WPAAlgorithms == "TKIP") return;
	if(type == 1 && WPAAlgorithms == "AES") return;
	if(type == 2 && WPAAlgorithms == "TKIPAES") return;
	setChange(1);
}

var IEEE8021XWEP;
function onIEEE8021XWEPClick(type)
{
	if(type == 0 && IEEE8021XWEP == false) return;
	if(type == 1 && IEEE8021XWEP == true) return;
	setChange(1);
}

var PreAuthentication;
function onPreAuthenticationClick(type)
{
	if(type == 0 && PreAuthentication == false) return;
	if(type == 1 && PreAuthentication == true) return;
	setChange(1);
}

function securityHandler(http_request) {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			parseAllData(http_request.responseText);
			UpdateMBSSIDList();
			LoadFields(defaultShownMBSSID);
			LoadAP();
			showSSIDEnable();
		} else {
			alert(_("secure problem with request"));
		}
	}
}

function parseAllData(str)
{
	var all_str = new Array();
	all_str = str.split("\n");
	if((ispNameCode == 9) && (curUserType == 1)) /*罗马尼亚版本普通用户,只显示ssid1*/
	{
		defaultShownMBSSID = 0;
	}
	else
	{
		defaultShownMBSSID = parseInt(all_str[0]);
	}
	for (var i=0; i<all_str.length-2; i++) {
		var fields_str = new Array();
		fields_str = all_str[i+1].split("\r");

		SSID[i] = fields_str[0];
		PreAuth[i] = fields_str[1];
		AuthMode[i] = fields_str[2];
		EncrypType[i] = fields_str[3];
		DefaultKeyID[i] = fields_str[4];
		Key1Type[i] = fields_str[5];
		Key1Str[i] = fields_str[6];
		Key2Type[i] = fields_str[7];
		Key2Str[i] = fields_str[8];
		Key3Type[i] = fields_str[9];
		Key3Str[i] = fields_str[10];
		Key4Type[i] = fields_str[11];
		Key4Str[i] = fields_str[12];
		WPAPSK[i] = fields_str[13];
		RekeyMethod[i] = fields_str[14];
		RekeyInterval[i] = fields_str[15];
		PMKCachePeriod[i] = fields_str[16];
		IEEE8021X[i] = fields_str[17];
		RADIUS_Server[i] = fields_str[18];
		RADIUS_Port[i] = fields_str[19];
		RADIUS_Key[i] = fields_str[20];
		session_timeout_interval[i] = fields_str[21];
		AccessPolicy[i] = fields_str[22];
		AccessControlList[i] = fields_str[23];
		ssidName[i] = fields_str[24];
		ssidHide[i] = fields_str[25];
		wmmList[i] = fields_str[26];

		if(IEEE8021X[i] == "1")
			AuthMode[i] = "IEEE8021X";

	
	}
}

function check_Wep(securitymode)
{
	var defaultid = document.security_form.wep_default_key.value;
	var key_input;

	if ( defaultid == 1 )
		var keyvalue = document.security_form.WEP1.value;
	else if (defaultid == 2)
		var keyvalue = document.security_form.WEP2.value;
	else if (defaultid == 3)
		var keyvalue = document.security_form.WEP3.value;
	else if (defaultid == 4)
		var keyvalue = document.security_form.WEP4.value;

	var keylength = document.security_form.WEP1.value.length;
	
		if (document.security_form.WEP1Select.options.selectedIndex == 0){
			if(keylength != 5 && keylength != 13) {
				alert(_("Please input 5 or 13 characters of") + "WEP key1 !");
				return false;
			}
			if(checkInjection(document.security_form.WEP1.value)== false){
				alert("WEP key1" + _(" contains invalid characters."));
				return false;
			}
		}
		if (document.security_form.WEP1Select.options.selectedIndex == 1){
			if(keylength != 10 && keylength != 26) {
				alert(_("Please input 10 or 26 characters of ") + "WEP key1 !");
				return false;
			}
			if(checkHex(document.security_form.WEP1.value) == false){
				alert(_("Invalid WEP key1 format!"));
				return false;
			}
		}

	keylength = document.security_form.WEP2.value.length;
		if (document.security_form.WEP2Select.options.selectedIndex == 0){
			if(keylength != 5 && keylength != 13) {
				alert(_("Please input 5 or 13 characters of") + "WEP key2 !");
				return false;
			}
			if(checkInjection(document.security_form.WEP2.value)== false){
				alert("WEP key2" + _(" contains invalid characters."));
				return false;
			}			
		}
		if (document.security_form.WEP2Select.options.selectedIndex == 1){
			if(keylength != 10 && keylength != 26) {
				alert(_("Please input 10 or 26 characters of ") + "WEP key2 !");
				return false;
			}
			if(checkHex(document.security_form.WEP2.value) == false){
				alert(_("Invalid WEP key2 format!"));
				return false;
			}
		}
	

	keylength = document.security_form.WEP3.value.length;
		if (document.security_form.WEP3Select.options.selectedIndex == 0){
			if(keylength != 5 && keylength != 13) {
				alert(_("Please input 5 or 13 characters of") + "WEP key3 !");
				return false;
			}
			if(checkInjection(document.security_form.WEP3.value)== false){
				alert("WEP key3" + _(" contains invalid characters."));
				return false;
			}
		}
		if (document.security_form.WEP3Select.options.selectedIndex == 1){
			if(keylength != 10 && keylength != 26) {
				alert(_("Please input 10 or 26 characters of ") + "WEP key3 !");
				return false;
			}
			if(checkHex(document.security_form.WEP3.value) == false){
				alert(_("Invalid WEP key3 format!"));
				return false;
			}			
		}

	keylength = document.security_form.WEP4.value.length;
		if (document.security_form.WEP4Select.options.selectedIndex == 0){
			if(keylength != 5 && keylength != 13) {
				alert(_("Please input 5 or 13 characters of") + "WEP key4 !");
				return false;
			}
			if(checkInjection(document.security_form.WEP4.value)== false){
				alert("WEP key4" + _(" contains invalid characters."));
				return false;
			}			
		}
		if (document.security_form.WEP4Select.options.selectedIndex == 1){
			if(keylength != 10 && keylength != 26) {
				alert(_("Please input 10 or 26 characters of ") + "WEP key4 !");
				return false;
			}

			if(checkHex(document.security_form.WEP4.value) == false){
				alert(_("Invalid WEP key4 format!"));
				return false;
			}			
		}

	return true;
}

function checkData()
{
	var securitymode;
	var encrypttype;
	securitymode = document.security_form.security_mode.value;
	encrypttype = document.security_form.security_shared_mode.value;

	if((securitymode == "OPEN" && encrypttype == "WEP") || securitymode == "SHARED" || securitymode == "WEPAUTO")
	{
		if(! check_Wep(securitymode) )
			return false;
	}
	else if (securitymode == "WPAPSK" || securitymode == "WPA2PSK" || securitymode == "WPAPSKWPA2PSK" /* || security_mode == 5 */){
		var keyvalue = document.security_form.passphrase.value;

		if (keyvalue.length == 0){
			alert(_("secure no wpapsk key"));
			document.security_form.passphrase.focus();
			return false;
		}

		if (keyvalue.length < 8){
			alert(_("secure wpapsk key length"));
			document.security_form.passphrase.focus();
			return false;
		}
		
		if(checkInjection(document.security_form.passphrase.value) == false){
			alert(_("secure invalid character in pass"));
			document.security_form.passphrase.focus();
			return false;
		}
		
		if(check_wpa() == false)
			return false;
	}

	else if (securitymode == "IEEE8021X") // 802.1x
	{
		if( document.security_form.ieee8021x_wep[0].checked == false &&
			document.security_form.ieee8021x_wep[1].checked == false){
			alert(_("secure choose 802.1x WEP option"));
			return false;
		}
		if(check_radius() == false)
			return false;
	}else if (securitymode == "WPA" || securitymode == "WPA1WPA2") //     WPA or WPA1WP2 mixed mode
	{
		if(check_wpa() == false)
			return false;
		if(check_radius() == false)
			return false;
	}else if (securitymode == "WPA2") //         WPA2
	{
		if(check_wpa() == false)
			return false;
		if( document.security_form.PreAuthentication[0].checked == false &&
			document.security_form.PreAuthentication[1].checked == false){
			alert(_("secure choose Pre-Auth option"));
			return false;
		}

		if(check_radius() == false)
			return false;
	}
    var ssidnameid = document.getElementById("ssidName");
	var WEP1id = getElement("WEP1");
	var WEP2id = getElement("WEP2");
	var WEP3id = getElement("WEP3");
	var WEP4id = getElement("WEP4");
    var passphraseid = getElement("passphrase");
	
	if (!CheckNotNull(ssidnameid.value)) 
	{					
		alert(_("Please enter SSID Name!"));
		ssidnameid.value = ssidnameid.defaultValue;
		ssidnameid.focus();
		return false;
	}	
	if(checkSpecialChar(";", ssidnameid.value))
	{
		alert(_("you can not input ") + "';'!");
		ssidnameid.value = ssidnameid.defaultValue;
		ssidnameid.focus();
		return false;
	}
	if(checkSpecialChar(";", WEP1id.value))
	{
		alert(_("you can not input ") + "';'");
		WEP1id.value = WEP1id.defaultValue;
		WEP1id.focus();
		return false;
	}
	if(checkSpecialChar(";", WEP2id.value))
	{
		alert(_("you can not input ") + "';'");
		WEP2id.value = WEP2id.defaultValue;
		WEP2id.focus();
		return false;
	}
	if(checkSpecialChar(";", WEP3id.value))
	{
		alert(_("you can not input ") + "';'");
		WEP3id.value = WEP3id.defaultValue;
		WEP3id.focus();
		return false;
	}
	
	if(checkSpecialChar(";", WEP4id.value))
	{
		alert(_("you can not input ") + "';'");
		WEP4id.value = WEP4id.defaultValue;
		WEP4id.focus();
		return false;
	}
	if(checkSpecialChar(";", passphraseid.value))
	{
		alert(_("you can not input ") + "';'!");
		passphraseid.value = passphraseid.defaultValue;
		passphraseid.focus();
		return false;
	}
	
	return true;
}

function initTranslation()
{
	var e = document.getElementById("secureSelectSSID");
	e.innerHTML = _("secure select ssid");
	e = document.getElementById("secureSSIDChoice");
	e.innerHTML = _("secure ssid choice");
	e = document.getElementById("ssidNameTips");
	e.innerHTML = _("ssidNameTips");
	
	e = document.getElementById("security_prompt");
	e.innerHTML = _("security_prompt");
	e = document.getElementById("secureNetworkName");
	e.innerHTML = _("security_netName");
	e = document.getElementById("basicSSID_title");
	e.innerHTML = _("security_netName");
	e = document.getElementById("basicHSSID_title");
	e.innerHTML = _("basicHSSID_title");
	e = document.getElementById("secure_WMMtitle");
	e.innerHTML = _("secure_WMMtitle");
	e = document.getElementById("sp_title");
	e.innerHTML = _("secure security policy");
	e = document.getElementById("secureSecureMode");
	e.innerHTML = _("secure security mode");
	e = document.getElementById("secureEncrypType");
	e.innerHTML = _("secure encryp type");
	e = document.getElementById("secureEncrypTypeNone");
	e.innerHTML = _("wireless none");

		e = document.getElementById("secureWEP");
	e.innerHTML = _("secure wep");
	e = document.getElementById("secureWEPDefaultKey");
	e.innerHTML = _("secure wep default key");
	e = document.getElementById("secureWEPDefaultKey1");
	e.innerHTML = _("secure wep default key1");
	e = document.getElementById("secureWEPDefaultKey2");
	e.innerHTML = _("secure wep default key2");
	e = document.getElementById("secureWEPDefaultKey3");
	e.innerHTML = _("secure wep default key3");
	e = document.getElementById("secureWEPDefaultKey4");
	e.innerHTML = _("secure wep default key4");
	e = document.getElementById("secureWEPKey");
	e.innerHTML = _("secure wep key");
	e = document.getElementById("secureWEPKey1");
	e.innerHTML = _("secure wep key1");
	e = document.getElementById("secureWEPKey2");
	e.innerHTML = _("secure wep key2");
	e = document.getElementById("secureWEPKey3");
	e.innerHTML = _("secure wep key3");
	e = document.getElementById("secureWEPKey4");
	e.innerHTML = _("secure wep key4");	
	e = document.getElementById("ssid_enable");
	e.innerHTML = _("ssid_enable");
	e = document.getElementById("ssid_disable");
	e.innerHTML = _("ssid_disable");
	

}

function LoadFields(MBSSID)
{
	if(ispNameCode == 13 || ispNameCode == 12)/*印尼电信版本/厄瓜多尔HGU*/
	{
		Have_RADIUS = 1
	}
	
	var result;
	var sp_select = document.getElementById("security_mode");

	var curAuthMode = AuthMode[MBSSID].toUpperCase();
	var curEncrypType = EncrypType[MBSSID].toUpperCase();
	sp_select.options.length = 0;

	/*modify by郭心悦，20170111，原因:越南HGU版本不需要这些认证模式：WEPAUTO,SHARED,OPEN*/
	if(ispNameCode != 16)
	{
    	sp_select.options[sp_select.length] = new Option("OPEN",	"OPEN",		false, curAuthMode == "OPEN");	
	}

	/*modify by郭心悦，20170111，原因:越南HGU版本不需要这些认证模式：WEPAUTO,SHARED,OPEN*/
	if(ispNameCode != 9 && ispNameCode != 16) /*罗马尼亚版本和越南HGU版本不需要这些认证模式*/
	{
	    	sp_select.options[sp_select.length] = new Option("SHARED",	"SHARED", 	false, curAuthMode == "SHARED");
	    	sp_select.options[sp_select.length] = new Option("WEPAUTO", "WEPAUTO",	false, AuthMode[MBSSID] == "WEPAUTO");
	}
	if(Have_RADIUS == 1)
	{
    	sp_select.options[sp_select.length] = new Option("WPA",		"WPA",		false, AuthMode[MBSSID] == "WPA");
	}
	sp_select.options[sp_select.length] = new Option("WPA-PSK", "WPAPSK",	false, curAuthMode == "WPAPSK");

	if(Have_RADIUS == 1)
	{
		sp_select.options[sp_select.length] = new Option("WPA2",	"WPA2",		false, AuthMode[MBSSID] == "WPA2");
	}
	sp_select.options[sp_select.length] = new Option("WPA2-PSK","WPA2PSK",	false, curAuthMode == "WPA2PSK");
	if(ispNameCode != 9)/*罗马尼亚版本不需要这些认证模式*/
	{
		/*modify begin by郭心悦，20170111，原因:越南HGU版本将WPAPSKWPA2PSK改为WPA-PSK/WPA2-PSK*/
		if(ispNameCode == 16)/*越南HGU*/
		{
	    		sp_select.options[sp_select.length] = new Option("WPA-PSK/WPA2-PSK",	"WPAPSKWPA2PSK", false, curAuthMode == "WPAPSKWPA2PSK");	
		}
		else
		{
			sp_select.options[sp_select.length] = new Option("WPAPSKWPA2PSK","WPAPSKWPA2PSK",	false, curAuthMode == "WPAPSKWPA2PSK");

		}
		/*modify end by郭心悦，20170111*/
	}
	if(Have_RADIUS == 1)
	{
		sp_select.options[sp_select.length] = new Option("WPA1WPA2","WPA1WPA2",	false, AuthMode[MBSSID] == "WPA1WPA2");
	}
	// WEP
	getElement("WEP1").value = Key1Str[MBSSID];
	getElement("WEP2").value = Key2Str[MBSSID];
	getElement("WEP3").value = Key3Str[MBSSID];
	getElement("WEP4").value = Key4Str[MBSSID];

	document.getElementById("WEP1Select").selectedIndex = (Key1Type[MBSSID] == "0" ? 1 : 0);
	document.getElementById("WEP2Select").selectedIndex = (Key2Type[MBSSID] == "0" ? 1 : 0);
	document.getElementById("WEP3Select").selectedIndex = (Key3Type[MBSSID] == "0" ? 1 : 0);
	document.getElementById("WEP4Select").selectedIndex = (Key4Type[MBSSID] == "0" ? 1 : 0);

	document.getElementById("wep_default_key").selectedIndex = parseInt(DefaultKeyID[MBSSID]) - 1 ;

	if(curEncrypType.toString().toUpperCase() == "NONE")		
		document.getElementById("security_shared_mode").selectedIndex = 1;
	else
		document.getElementById("security_shared_mode").selectedIndex = 0;
	if(curEncrypType == "TKIP")
		document.security_form.cipher[0].checked = true;
	else if(curEncrypType == "AES")
		document.security_form.cipher[1].checked = true;
	else if(curEncrypType == "TKIPAES")
		document.security_form.cipher[2].checked = true;

	getElement("passphrase").value = WPAPSK[MBSSID];

	document.getElementById("PMKCachePeriod").value = PMKCachePeriod[MBSSID];
	if(PreAuth[MBSSID] == "0")
		document.security_form.PreAuthentication[0].checked = true;
	else
		document.security_form.PreAuthentication[1].checked = true;

	//802.1x wep
	if(IEEE8021X[MBSSID] == "1"){
		if(curEncrypType == "WEP")
			document.security_form.ieee8021x_wep[1].checked = true;
		else
			document.security_form.ieee8021x_wep[0].checked = true;
	}
	
	document.getElementById("RadiusServerIP").value = RADIUS_Server[MBSSID];
	document.getElementById("RadiusServerPort").value = RADIUS_Port[MBSSID];
	document.getElementById("RadiusServerSecret").value = RADIUS_Key[MBSSID];			
	document.getElementById("RadiusServerSessionTimeout").value = session_timeout_interval[MBSSID];
	
	securityMode(0);

	document.getElementById("ssidName").value = ssidName[MBSSID];
	if(ssidHide[MBSSID] == 1)
	{
		document.getElementById("hssid").checked = true;
	}
	else
	{
		document.getElementById("hssid").checked = false;
	}
	
	if(wmmList[MBSSID] == 1)
	{
		getElement("secure_WMM").checked = true;
	}
	else
	{
		getElement("secure_WMM").checked = false;
	}

}


function checkMac(str){
	var len = str.length;
	if(len!=17)
		return false;

	for (var i=0; i<str.length; i++) {
		if((i%3) == 2){
			if(str.charAt(i) == ':')
				continue;
		}else{
			if (    (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
					(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
					(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;
		}
		return false;
	}
	return true;
}

function checkRange(str, num, min, max)
{
    d = atoi(str,num);
    if(d > max || d < min)
        return false;
    return true;
}

function checkIpAddr(field)
{
    if(field.value == "")
        return false;

    if ( checkAllNum(field.value) == 0)
        return false;

    if( (!checkRange(field.value,1,0,255)) ||
        (!checkRange(field.value,2,0,255)) ||
        (!checkRange(field.value,3,0,255)) ||
        (!checkRange(field.value,4,1,254)) ){
        return false;
    }
   return true;
}

function atoi(str, num)
{
    i=1;
    if(num != 1 ){
        while (i != num && str.length != 0){
            if(str.charAt(0) == '.'){
                i++;
            }
            str = str.substring(1);
        }
        if(i != num )
            return -1;
    }

    for(i=0; i<str.length; i++){
        if(str.charAt(i) == '.'){
            str = str.substring(0, i);
            break;
        }
    }
    if(str.length == 0)
        return -1;
    return parseInt(str, 10);
}

function checkHex(str){
	var len = str.length;

	for (var i=0; i<str.length; i++) {
		if ((str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') ){
				continue;
		}else
	        return false;
	}
    return true;
}

function checkInjection(str)
{
	var len = str.length;
	for (var i=0; i<str.length; i++) {
		if ( str.charAt(i) == '\r' || str.charAt(i) == '\n'){
				return false;
		}else
	        continue;
	}
    return true;
}

function checkStrictInjection(str)
{
	var len = str.length;
	for (var i=0; i<str.length; i++) {
		if ( str.charAt(i) == ';' || str.charAt(i) == ',' ||
			 str.charAt(i) == '\r' || str.charAt(i) == '\n'){
				return false;
		}else
	        continue;
	}
    return true;
}

function checkAllNum(str)
{
    for (var i=0; i<str.length; i++){
        if((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '.' ))
            continue;
        return false;
    }
    return true;
}

/*****************************************************************************
 * 函 数 名  : dealSecurityFailedHandle
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年5月29日
 * 函数功能  : 用于读写设备数据失败时结果提示
 * 输入参数  : 无
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function dealSecurityFailedHandle()
{
	if(securitySetFailedID != "" && securitySetFailedID !="dataFormatError")
	{
		var dom = document.getElementById(securitySetFailedID);
		setFailedDom(dom, 1);					/*1:写*/
	}
	else
	{
		if(securityGetFailedIDs != "")
		{
			var idArray = new Array();
			idArray = parseGetFailedIDs(securityGetFailedIDs);
			for(var i = 0; i<idArray.length; i++)
			{
				var dom = document.getElementById(idArray[i]);
				setFailedDom(dom, 0);			/*0:读*/
			}
		}
	}
}

