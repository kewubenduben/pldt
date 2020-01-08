
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

/*
var http_request = false;
function makeRequest(url, content, handler) {
	http_request = false;
	if (window.XMLHttpRequest) { // Mozilla, Safari,...
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			http_request.overrideMimeType('text/xml');
		}
	} else if (window.ActiveXObject) { // IE
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
			http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}
	if (!http_request) {
		alert('Giving up :( Cannot create an XMLHTTP instance');
		return false;
	}
	http_request.onreadystatechange = handler;
	http_request.open('POST', url, true);
	var contentTmp, tokenTmp;
	if (token) {
		tokenTmp = token; 
	} else {
		tokenTmp = ""; 
	}
	var contentTmp = content + "&csrftoken=" + tokenTmp;
	http_request.send(contentTmp);
}
*/
	
function securityHandler(http_request) {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
//			console.info(http_request.responseText);
			parseAllData(http_request.responseText);
			UpdateMBSSIDList();
			LoadFields(defaultShownMBSSID);

			// load Access Policy for MBSSID[selected]
			LoadAP();
			showSSIDEnable();
//	console.info("handler   "+document.security_form.ssidIndex.options.selectedIndex);
			//ShowAP(defaultShownMBSSID);
		} else {
			//alert('There was a problem with the request.');
			alert(_("secure problem with request"));
		}
	}
}

function deleteAccessPolicyListHandler()
{
	window.location.reload(false);
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
//	console.info("parseAllData defaultShownMBSSID = ", defaultShownMBSSID);

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

/* add begin by 吴小娟, 20111018, 原因: 增加多SSID支持 */
		ssidName[i] = fields_str[24];
		ssidHide[i] = fields_str[25];
/* add end by 吴小娟, 20111018 */

		/* add by 吴小娟, 20160811, 原因: 增加支持WMM */
		wmmList[i] = fields_str[26];
		if(ispNameCode == '26')//巴西TIM
			guestList[i] = fields_str[27];//add by wuxj, 20180319

		/* !!!! IMPORTANT !!!!*/
		if(IEEE8021X[i] == "1")
			AuthMode[i] = "IEEE8021X";

/*			
		if(AuthMode[i] == "OPEN" && EncrypType[i] == "NONE" && IEEE8021X[i] == "0")
			AuthMode[i] = "Disable";
*/
	
	//alert(AuthMode[i]);
	
	}
}

function checkData()
{
	var securitymode;
	var encrypttype;
//	var ssid = document.security_form.Ssid.value;	
	securitymode = document.security_form.security_mode.value;
	encrypttype = document.security_form.security_shared_mode.value;
/* modify begin by 吴小娟, 20110920, 
	原因: 修正当选择securitymode == "SHARED"而之前为"OPEN"和"None"时，不会调用check_Wep的BUG */
/*	
	if (securitymode == "OPEN" || securitymode == "SHARED" ||securitymode == "WEPAUTO")
	{
		if(encrypttype != "None")
		{
			if(! check_Wep(securitymode) )
				return false;
		}
	}
*/
	if((securitymode == "OPEN" && encrypttype == "WEP") || securitymode == "SHARED" || securitymode == "WEPAUTO")
	{
		if(! check_Wep(securitymode) )
			return false;
	}
/* modify end by 吴小娟, 20110920 */
	else if (securitymode == "WPAPSK" || securitymode == "WPA2PSK" || securitymode == "WPAPSKWPA2PSK" /* || security_mode == 5 */){
		var keyvalue = document.security_form.passphrase.value;

		if (keyvalue.length == 0){
			//alert('Please input wpapsk key!');
			alert(_("secure no wpapsk key"));
			document.security_form.passphrase.focus();
			return false;
		}

		if (keyvalue.length < 8){
			//alert('Please input at least 8 character of wpapsk key!');
			alert(_("secure wpapsk key length"));
			document.security_form.passphrase.focus();
			return false;
		}
		
		if(checkInjection(document.security_form.passphrase.value) == false){
			//alert('Invalid characters in Pass Phrase.');
			alert(_("secure invalid character in pass"));
			document.security_form.passphrase.focus();
			return false;
		}

/* delete begin by 吴小娟, 20110505, 原因: check_wpa()已包含以下四个校验*/
/*
		if(document.security_form.cipher[0].checked != true && 
		   document.security_form.cipher[1].checked != true &&
   		   document.security_form.cipher[2].checked != true){
   		   alert('Please choose a WPA Algorithms.');
   		   return false;
		}

		if(checkAllNum(document.security_form.keyRenewalInterval.value) == false){
			alert('Please input a valid key renewal interval');
			return false;
		}

		if(document.security_form.keyRenewalInterval.value < 60){
			alert('Warning: A short key renewal interval.');
			return false; 
		}

		if(document.security_form.keyRenewalInterval.value > 4000000){
			alert('Warning: A big key renewal interval.');
		  return false;
		}
*/
/* delete end by 吴小娟, 20110505 */
		
		if(check_wpa() == false)
			return false;
	}
	//802.1x
	else if (securitymode == "IEEE8021X") // 802.1x
	{
		if( document.security_form.ieee8021x_wep[0].checked == false &&
			document.security_form.ieee8021x_wep[1].checked == false){
			//alert('Please choose the 802.1x WEP option.');
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
			//alert('Please choose the Pre-Authentication options.');
			alert(_("secure choose Pre-Auth option"));
			return false;
		}

		/*if(!document.security_form.PMKCachePeriod.value.length){
			//alert('Please input the PMK Cache Period.');
			alert(_("secure no PMK Cache Period"));
			return false;
		}*/
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
	

	/* check Access Policy
	for(i=0; i<MBSSID_MAX; i++){


		if( document.getElementById("newap_text_" + i).value != ""){
			if(!checkMac(document.getElementById("newap_text_" + i).value)){
				alert("The mac address in Access Policy form is invalid.\n");
				return false;
			}
		}
	}
	*/

	return true;
}

function check_wpa()
{
		if(document.security_form.cipher[0].checked != true && 
		   document.security_form.cipher[1].checked != true &&
   		   document.security_form.cipher[2].checked != true){
   		   //alert('Please choose a WPA Algorithms.');
		   alert(_("secure no WPA Algorithm"));
   		   return false;
		}

		// delete by wuxj, 20151214, delete keyRenewalInterval
/*		if(checkAllNum(document.security_form.keyRenewalInterval.value) == false){
			//alert('Please input a valid key renewal interval');
			alert(_("secure valid key renew"));
			return false;
		}
		
		// modify by 吴小娟, 20110505, 原因: RekeyInterval为0时设置rekey去使能
//		if(document.security_form.keyRenewalInterval.value < 60){
		if(0 < document.security_form.keyRenewalInterval.value && document.security_form.keyRenewalInterval.value< 60)
		{
// modify by 吴小娟, 20111118, 原因:修改使提示信息更明确
//			alert('Warning: A short key renewal interval.');
			//alert("Warning: The key renewal interval should be 0 or greater than 60.");
			alert(_("secure renewal interval invalid"));
			return false;
		}
		//jianglei add
		if(document.security_form.keyRenewalInterval.value > 4000000){
			//alert('Warning: A big key renewal interval.');
			alert(_("secure renewal interval too big"));
			return false;
		}
*/		
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
	//var encrypt_type;

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

	// delete by wuxj, 20151214, delete keyRenewalInterval
//	document.getElementById("wpa_key_renewal_interval").style.visibility = "hidden";
//	document.getElementById("wpa_key_renewal_interval").style.display = "none";
	document.getElementById("wpa_PMK_Cache_Period").style.visibility = "hidden";
	document.getElementById("wpa_PMK_Cache_Period").style.display = "none";
	document.getElementById("wpa_preAuthentication").style.visibility = "hidden";
	document.getElementById("wpa_preAuthentication").style.display = "none";
	document.security_form.cipher[0].disabled = true;
	document.security_form.cipher[1].disabled = true;
	document.security_form.cipher[2].disabled = true;
	document.security_form.passphrase.disabled = true;

	// delete by wuxj, 20151214, delete keyRenewalInterval
//	document.security_form.keyRenewalInterval.disabled = true;
	document.security_form.PMKCachePeriod.disabled = true;
	document.security_form.PreAuthentication.disabled = true;

	// 802.1x
	document.getElementById("div_radius_server").style.visibility = "hidden";
	document.getElementById("div_radius_server").style.display = "none";
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
	}else if (security_mode == "WPAPSK" || security_mode == "WPA2PSK" || security_mode == "WPAPSKWPA2PSK")
	{
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
		{
			document.security_form.cipher[2].disabled = false;
		}

		document.getElementById("wpa_passphrase").style.visibility = "visible";
		document.getElementById("wpa_passphrase").style.display = style_display_on();
		document.security_form.passphrase.disabled = false;

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		document.getElementById("wpa_key_renewal_interval").style.visibility = "visible";
//		document.getElementById("wpa_key_renewal_interval").style.display = style_display_on();

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		document.security_form.keyRenewalInterval.disabled = false;
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

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		document.getElementById("wpa_key_renewal_interval").style.visibility = "visible";
//		document.getElementById("wpa_key_renewal_interval").style.display = style_display_on();

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		document.security_form.keyRenewalInterval.disabled = false;
	
		<!-- 802.1x -->
		document.getElementById("div_radius_server").style.visibility = "visible";
		document.getElementById("div_radius_server").style.display = style_display_on();
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
			//document.getElementById("wpa_preAuthentication").style.display = style_display_on();
			document.security_form.PreAuthentication.disabled = false;
			document.getElementById("wpa_PMK_Cache_Period").style.visibility = "visible";
			//document.getElementById("wpa_PMK_Cache_Period").style.display = style_display_on();
			document.security_form.PMKCachePeriod.disabled = false;
		}

		if(security_mode == "WPA1WPA2"){
			document.security_form.cipher[2].disabled = false;
		}

	}else if (security_mode == "IEEE8021X"){ // 802.1X-WEP
		document.getElementById("div_8021x_wep").style.visibility = "visible";
		document.getElementById("div_8021x_wep").style.display = style_display_on();

		document.getElementById("div_radius_server").style.visibility = "visible";
		document.getElementById("div_radius_server").style.display = style_display_on();
		document.security_form.ieee8021x_wep.disable = false;
		document.security_form.RadiusServerIP.disable = false;
		document.security_form.RadiusServerPort.disable = false;
		document.security_form.RadiusServerSecret.disable = false;	
		document.security_form.RadiusServerSessionTimeout.disable = false;
		//document.security_form.RadiusServerIdleTimeout.disable = false;
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
	
  /*jianglei add */
	encrypt_type = document.security_form.security_shared_mode.value;
	
	if((mode == "OPEN" && encrypt_type == "WEP") || (mode == "SHARED") || (mode == "WEPAUTO"))
	{
	  document.getElementById("div_wep").style.visibility = "visible";
	}
	
	<!-- WEP -->
	//document.getElementById("div_wep").style.visibility = "visible";

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
	//document.security_form.wep_auth_type.disabled = false;
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

/* modify begin by 吴小娟, 20111226, 原因: 需求修改为web key可以为空，为空时不调用接口 */
/*	if (keyvalue.length == 0 &&  (securitymode == "SHARED" || securitymode == "OPEN" || securitymode == "WEPAUTO")){ // shared wep  || md5
		alert('Please input wep key' + defaultid + ' !');
		return false;
	} */
/* modify end by 吴小娟, 20111226 */

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
	
function submit_apply()
{

	if (checkData() == true){
		changed = 0;

		load_waiting();
		document.security_form.submit();
//		opener.location.reload();
	}
}

function LoadFields(MBSSID)
{
	ispNameCode = parseInt(ispNameCode);
	if(ispNameCode == 13 || ispNameCode == 12)/*印尼电信版本/厄瓜多尔HGU*/
	{
		Have_RADIUS = 1
	}
	
//	console.info("LoadFields   MBSSID = " + MBSSID);
	var result;
	// Security Policy
	var sp_select = document.getElementById("security_mode");

/* add by 吴小娟, 20111214, 原因: 底层配置为小写，页面配置为大写，统一转成大写用于判断。同步修改下面的判断语句 */
	var curAuthMode = AuthMode[MBSSID].toUpperCase();
	var curEncrypType = EncrypType[MBSSID].toUpperCase();

	sp_select.options.length = 0;

    //sp_select.options[sp_select.length] = new Option("Disable",	"Disable",	false, AuthMode[MBSSID] == "Disable");
    sp_select.options[sp_select.length] = new Option("OPEN",	"OPEN",		false, curAuthMode == "OPEN");
	if(ispNameCode != 9) /*罗马尼亚版本不需要这些认证模式*/
	{
    	sp_select.options[sp_select.length] = new Option("SHARED",	"SHARED", 	false, curAuthMode == "SHARED");
    	sp_select.options[sp_select.length] = new Option("WEPAUTO", "WEPAUTO",	false, AuthMode[MBSSID] == "WEPAUTO");
	}
	if(Have_RADIUS == 1)
	{
    	sp_select.options[sp_select.length] = new Option("WPA",		"WPA",		false, AuthMode[MBSSID] == "WPA");
	}
		
	if(WEB_WIFI_CERTIFIED_OPTION != '1')//WIFI联盟测试不需WPA-PSK
	{
		sp_select.options[sp_select.length] = new Option("WPA-PSK", "WPAPSK",	false, curAuthMode == "WPAPSK");
	}

	if(Have_RADIUS == 1)
	{
		sp_select.options[sp_select.length] = new Option("WPA2",	"WPA2",		false, AuthMode[MBSSID] == "WPA2");
	}
	sp_select.options[sp_select.length] = new Option("WPA2-PSK","WPA2PSK",	false, curAuthMode == "WPA2PSK");
	if(ispNameCode != 9)/*罗马尼亚版本不需要这些认证模式*/
	{
		sp_select.options[sp_select.length] = new Option("WPAPSKWPA2PSK","WPAPSKWPA2PSK",	false, curAuthMode == "WPAPSKWPA2PSK");
	}
	if(Have_RADIUS == 1)
	{
		sp_select.options[sp_select.length] = new Option("WPA1WPA2","WPA1WPA2",	false, AuthMode[MBSSID] == "WPA1WPA2");
	}
	/* 
	 * until now we only support 8021X WEP for MBSSID[0]
	 */
/*
	if(MBSSID == 0)
		sp_select.options[sp_select.length] = new Option("802.1X",	"IEEE8021X",false, AuthMode[MBSSID] == "IEEE8021X");
*/
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

	var security_shared_mode = getElement("security_shared_mode");	

	// SHARED && NONE	
	/* modify by 吴小娟, 2011-04-25, 原因: 解决设备刚烧录新image还未从页面设置时,设备里值为open，
			而此页面总是显示为WEP的BUG.问题原因:烧录后登录WEB网管，底层设置为:AuthMode=open EncrypType=none;
			而从页面设置时，写设备为AuthMode=OPEN EncrypType=NONE,原代码用大写作判断，
			所以未从页面设置时有问题而设置后显示正确*/
/*	if(AuthMode[MBSSID] == "OPEN" && EncrypType[MBSSID] == "NONE")*/
	/* modify by 吴小娟, 20110530, 
	   原因: AuthMode读取失败EncrypType读取成功时，页面也可以显示为NONE。
	         AuthMode为非OPEN时，该下拉框是隐藏的，所以不影响*/
/*	if(AuthMode[MBSSID].toString().toUpperCase() == "OPEN" && EncrypType[MBSSID].toString().toUpperCase() == "NONE")*/
	if(curEncrypType.toString().toUpperCase() == "NONE")		
		security_shared_mode.selectedIndex = 1;
	else
		security_shared_mode.selectedIndex = 0;
	
	// WPA
	if(curEncrypType == "TKIP")
		document.security_form.cipher[0].checked = true;
	else if(curEncrypType == "AES")
		document.security_form.cipher[1].checked = true;
	else if(curEncrypType == "TKIPAES")
		document.security_form.cipher[2].checked = true;
	
	if(WEB_WIFI_CERTIFIED_OPTION == '1')	//WIFI联盟测试不需要tkip
	{
    	setDisplay("cipher_tkip", "none");
    	setDisplay("tkip_title", "none");		
	}
	
	getElement("passphrase").value = WPAPSK[MBSSID];

	// delete by wuxj, 20151214, delete keyRenewalInterval
//	document.getElementById("keyRenewalInterval").value = RekeyInterval[MBSSID];
	document.getElementById("PMKCachePeriod").value = PMKCachePeriod[MBSSID];
	//document.getElementById("PreAuthentication").value = PreAuth[MBSSID];
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

/* add by 吴小娟, 20111019, 原因: 支持多SSID */
	document.getElementById("ssidName").value = ssidName[MBSSID];
	if(ssidHide[MBSSID] == 1)
	{
		document.getElementById("hssid").checked = true;
	}
	else
	{
		document.getElementById("hssid").checked = false;
	}
	
	/* add begin by 吴小娟, 20160811, 原因: 增加参数WMM */
	if(wmmList[MBSSID] == 1)
	{
		getElement("secure_WMM").checked = true;
	}
	else
	{
		getElement("secure_WMM").checked = false;
	}

	/* add begin by 吴小娟, 20180319, 原因: 增加参数Guest */
	if(guestList[MBSSID] == 1)
	{
		getElement("secure_guest").checked = true;
	}
	else
	{
		getElement("secure_guest").checked = false;
	}
}


function ShowAP(MBSSID)
{
	var i;
	for(i=0; i<MBSSID_MAX; i++){
		document.getElementById("apselect_"+i).selectedIndex	= AccessPolicy[i];
		document.getElementById("AccessPolicy_"+i).style.visibility = "hidden";
		document.getElementById("AccessPolicy_"+i).style.display = "none";
	}

	document.getElementById("AccessPolicy_"+MBSSID).style.visibility = "visible";
	if (window.ActiveXObject) {			// IE
		document.getElementById("AccessPolicy_"+MBSSID).style.display = "block";
	}else if (window.XMLHttpRequest) {	// Mozilla, Safari,...
		document.getElementById("AccessPolicy_"+MBSSID).style.display = "table";
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

		// hide <tr> left
		/*
		for(; j<ACCESSPOLICYLIST_MAX; j+=2){
			document.getElementById("id_"+i+"_"+j).style.visibility = "hidden";
			document.getElementById("id_"+i+"_"+j).style.display = "none";
		}
		*/
	}
}

function selectMBSSIDChanged()
{
	// check if any security settings changed
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

	/* add by 吴小娟, 20150618, 原因:定制化显示SSID内容 */

	/* 安徽移动普通用户对SSID2-4可见不可配 */
	if(ispMinorNameCode == 201 && curUserType == 1 && selected != 0)	/* X_CMCC_ANHUI */
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

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		getElement("keyRenewalInterval").disabled = 1;
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

		// delete by wuxj, 20151214, delete keyRenewalInterval
//		getElement("keyRenewalInterval").disabled = 0;
	}

	// backup for user cancel action
	old_MBSSID = selected;
//console.info("selectMBSSIDChanged*********");
	MBSSIDChange(selected);
    showSSIDEnable();
}

/*
 * When user select the different SSID, this function would be called.
 */ 
function MBSSIDChange(selected)
{
//console.info("MBSSIDChange selected = ", selected);
	// load wep/wpa/802.1x table for MBSSID[selected]
	LoadFields(selected);

	// update Access Policy for MBSSID[selected]
	//ShowAP(selected);

	// radio button special case
	WPAAlgorithms = EncrypType[selected];
	IEEE8021XWEP = IEEE8021X[selected];
	PreAuthentication = PreAuth[selected];

	changeSecurityPolicyTableTitle(SSID[selected]);

	// clear all new access policy list field
	
/* delete by 吴小娟, 20111019, 原因: 未使用 */
//	for(i=0; i<MBSSID_MAX; i++)
//		document.getElementById("newap_text_"+i).value = "";

	return true;
}

function changeSecurityPolicyTableTitle(t)
{
/*xuli modify
	var title = document.getElementById("sp_title");
	title.innerHTML = "\"" + t + "\"";
*/
}

function delap(mbssid, num)
{
	makeRequest("/goform/APDeleteAccessPolicyList", mbssid+ "," +num, deleteAccessPolicyListHandler);
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
	
	e = document.getElementById("secreWPA");
	e.innerHTML = _("secure wpa");
	e = document.getElementById("secureWPAAlgorithm");
	e.innerHTML = _("secure wpa algorithm");
	e = document.getElementById("secureWPAPassPhrase");
	e.innerHTML = _("secure wpa pass phrase");
	e = document.getElementById("wpa_passphraseTips");
	e.innerHTML = _("wpa_passphraseTips");
	
//	e = document.getElementById("secureWPAKeyRenewInterval");
//	e.innerHTML = _("secure wpa key renew interval");
//	e = document.getElementById("secureWPAKeyRenewIntervaltips");
//	e.innerHTML = _("secure wpa key renew interval tips");
	e = document.getElementById("secureWPAPMKCachePeriod");
	e.innerHTML = _("secure wpa pmk cache period");
	e = document.getElementById("secureWPAPreAuth");
	e.innerHTML = _("secure wpa preauth");
	e = document.getElementById("secureWPAPreAuthDisable");
	e.innerHTML = _("wireless disable");
	e = document.getElementById("secureWPAPreAuthEnable");
	e.innerHTML = _("wireless enable");
	
	e = document.getElementById("secure8021XWEP");
	e.innerHTML = _("secure 8021x wep");
	e = document.getElementById("secure1XWEP");
	e.innerHTML = _("secure 1x wep");
	e = document.getElementById("secure1XWEPDisable");
	e.innerHTML = _("wireless disable");
	e = document.getElementById("secure1XWEPEnable");
	e.innerHTML = _("wireless enable");
	
	e = document.getElementById("secureRadius");
	e.innerHTML = _("secure radius");
	e = document.getElementById("secureRadiusIPAddr");
	e.innerHTML = _("secure radius ipaddr");
	e = document.getElementById("secureRadiusPort");
	e.innerHTML = _("secure radius port");
	e = document.getElementById("secureRadiusSharedSecret");
	e.innerHTML = _("secure radius shared secret");
	e = document.getElementById("secureRadiusSessionTimeout");
	e.innerHTML = _("secure radius session timeout");
	e = document.getElementById("secureRadiusIdleTimeout");
	e.innerHTML = _("secure radius idle timeout");
	e = document.getElementById("ssid_enable");
	e.innerHTML = _("ssid_enable");
	e = document.getElementById("ssid_disable");
	e.innerHTML = _("ssid_disable");
	
	e = document.getElementById("guestTitle");
	e.innerHTML = _("guestTitle");
	
	e = document.getElementById("secureApply");
	e.value = _("wireless apply");
	e = document.getElementById("secureCancel");
	e.value = _("wireless cancel");
}

function initAll()
{
	initTranslation();
	
	//add by wuxj, 20161205, ECUADOR要求密码显示为密文
	var passphraseNode;
	var WEPNode;
	if(ispNameCode == '12' || ispNameCode == '4')//厄瓜多尔/3BB
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
	
	/*本页面的显示方式:定义goform过程wirelessGetSecurity，从请求的响应文本中解析各参数值*/
	makeRequest("/goform/wirelessGetSecurityEx", "n/a", securityHandler);

//	document.getElementById("secureSelectSSID").style.visibility = "hidden";
//	document.getElementById("secureSelectSSID").style.display = "none";
//	document.getElementById("MBSSID").style.visibility = "hidden";
//	document.getElementById("MBSSID").style.display = "none";
	
	//add by wuxj, 20160811, for ECUADOR
	if(ispNameCode == 12)//厄瓜多尔
	{
		setDisplay("tr_wmm", "");
	}
	//add by wuxj, 20180319, for TIM
	if(ispNameCode == '26')//巴西TIM
	{
		setDisplay("tr_guest", "");
	}
	
	var ssidIndexNode = document.getElementById("ssidIndex");//目前5G支持4个SSID
	for(var i = 1; i <= wifi_dual_ssid_num; i++)
	{
		ssidIndexNode.options[ssidIndexNode.length] = new Option(i, i);//new Option(text, value)
	}
	
	document.getElementById("sp_title_x").style.visibility = "hidden";
	document.getElementById("sp_title_x").style.display = "none";
	document.getElementById("div_access_infra_mode").style.visibility = "hidden";
	document.getElementById("div_access_infra_mode").style.display = "none";
	document.getElementById("basicSSID").style.visibility = "hidden";
	document.getElementById("basicSSID").style.display = "none";
	
	document.getElementById("AddMacTable").style.visibility = "hidden";
	document.getElementById("AddMacTable").style.display = "none";
	document.getElementById("AddMacAddr").style.visibility = "hidden";
	document.getElementById("AddMacAddr").style.display = "none";
	
	document.getElementById("secureRadiusSessionTimeout").style.visibility = "hidden";
	document.getElementById("secureRadiusSessionTimeout").style.display = "none";
	document.getElementById("RadiusServerSessionTimeout").style.visibility = "hidden";
	document.getElementById("RadiusServerSessionTimeout").style.display = "none";

	document.getElementById("secureRadiusIdleTimeout").style.visibility = "hidden";
	document.getElementById("secureRadiusIdleTimeout").style.display = "none";
	document.getElementById("RadiusServerIdleTimeout").style.visibility = "hidden";
	document.getElementById("RadiusServerIdleTimeout").style.display = "none";
	
	//读写设备数据失败时结果提示
	dealSecurityFailedHandle();
	
}

function showSSIDEnable()
{
	var ssidenable = document.getElementsByName("SSIDEnable");	
	var ssidNO = document.getElementById("ssidIndex");	
	var ssidnoValue = parseInt(ssidNO.value);
//	alert("ssidNO.value = "+ ssidNO.value);
//	alert("ssidnoValue = "+ ssidnoValue);
	
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
//目前SSID总数固定，未使用"SSID"这个参数，页面上不自动生成SSID下拉列表
/*
	document.security_form.ssidIndex.length = 0;

	for(var i=0; i<SSID.length; i++){
		var j = document.security_form.ssidIndex.options.length;
		document.security_form.ssidIndex.options[j] = new Option(SSID[i], i, false, false);
	}
*/	
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
		/*获取处理失败的参数节点*/
		var dom = document.getElementById(securitySetFailedID);

		/*提示处理失败，获取焦点后显示正常*/
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

