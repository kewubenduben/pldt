/***********************************************************************************
utils.js
wuxj
2011.5.17
 common JS functions
***********************************************************************************/


/*****************************************************************************
createMsgArea
wuxj
2011.5.17
add msg after dom node
*****************************************************************************/
function createMsgArea(dom) 
{
	var p = getPosition(dom);
	var spanNode = document.createElement('span');
	var leftAdjust = 15;
	
	spanNode.style.color= 'red';
	spanNode.style.position= 'absolute';
	spanNode.style.left= p.left + dom.clientWidth + leftAdjust;
	spanNode.style.top= p.top;
	document.body.appendChild(spanNode);
	return spanNode;
}

/*****************************************************************************
getPosition
wuxj
2011.5.17
get location of the dom node
*****************************************************************************/
function getPosition(dom) 
{
	var x = 0;
	var y = 0;
	while ( dom.offsetParent ) 
	{
        	x += dom.offsetLeft;
		y += dom.offsetTop;
        	dom = dom.offsetParent;
	}
	return {left: x, top: y};
}

/*****************************************************************************
setFailedDom
wuxj
2011.5.26
page show when read/write device failed.
*****************************************************************************/
function setFailedDom(dom, flag)
{
	dom.style.borderColor = "RED";
	if(flag == 0)
	{
		dom.title = "read failed";
	}
	else
	{
		dom.title = "set failed";
	}	
	dom.onfocus = function()
					{
						dom.style.borderColor = "#7F9DB9";
						dom.title = "";
					}	
}

/*****************************************************************************
parseGetFailedIDs
wuxj
2011.5.26
parse the node's ID string which fail to read device
*****************************************************************************/
function parseGetFailedIDs(getFailedIDs)
{
	var idArray = new Array();
	idArray = getFailedIDs.split(";");

	return idArray;
}

/*****************************************************************************
style_display_on
wuxj
2011.5.31
 get style display value in different browsers
*****************************************************************************/
function style_display_on()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Safari,...
		return "table-row";
	}
}

/*****************************************************************************
makeRequest
wuxj
2011.7.30
create a AJAX object and start request
*****************************************************************************/
function makeRequest(url, content, handler)
{
/* modify begin by wuxj, 20120406,  code reuse */
	var http_request = getRequest();
/*
	var http_request = false;
	if (window.XMLHttpRequest) { 				// code for IE7+, Firefox, Chrome, Opera, Safari
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			http_request.overrideMimeType('text/xml');
		}
	} else if (window.ActiveXObject) { 			// IE
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
			http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}
*/	
/* modify end by wuxj, 20120406 */

	if (!http_request) {
		alert("Giving up :( \nCannot create an XMLHTTP instance!");
		return false;
	}
	http_request.onreadystatechange = function(){
		handler(http_request);
	}
	http_request.open('POST', url, true);
	http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var contentTmp;
	contentTmp = content + "&x-csrftoken=" + getCsrftoken();
	http_request.send(contentTmp);
	
}

/*****************************************************************************
getRequest
wuxj
2011.9.4
create AJAX request object
*****************************************************************************/
function getRequest()
{
	var http_request = false;
	if (window.XMLHttpRequest) { 				// code for IE7+, Firefox, Chrome, Opera, Safari
		http_request = new XMLHttpRequest();
//		if (http_request.overrideMimeType)
//			http_request.overrideMimeType('text/xml');	//修正firefox报'XML解析错误:语法错误'的问题
		
	} else if (window.ActiveXObject) { 			// IE
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
			http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}

	return http_request;
	
}

function display_on()
{
	if (window.ActiveXObject) { // IE
		return "block";
	}
	else if (window.XMLHttpRequest) { // Mozilla, Firefox, Safari,...
		return "table-row";
	}
}

/*****************************************************************************
setDisplay
wuxj
2011.7.30
set node showing state
*****************************************************************************/
function setDisplay(elementId, status)
{
    document.getElementById(elementId).style.display = status;
}

function getElementById(sId)
{
	if (document.getElementById)
	{
		return document.getElementById(sId);	
	}
	else if (document.all)
	{
		// old IE
		return document.all(sId);
	}
	else if (document.layers)
	{
		// Netscape 4
		return document.layers[sId];
	}
	else
	{
		return null;
	}
}

/*getElByName*/
function getElementByName(sId)
{    // standard
	if (document.getElementsByName)
	{
		var element = document.getElementsByName(sId);
		
		if (element.length == 0)
		{
			return null;
		}
		else if (element.length == 1)
		{
			return 	element[0];
		}
		
		return element;		
	}
}

function getElement(sId)
{
	 var ele = getElementByName(sId); 
	 if (ele == null)
	 {
		 return getElementById(sId);
	 }
	 return ele;
}

/*  delete space of a line */
function trim(str)
{ 
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

/* delete left space of a line */
function ltrim(str)
{
	return str.replace(/(^\s*)/g,"");
}

/* delete right space of a line */
function rtrim(str)
{
	return str.replace(/(\s*$)/g,"");
}


function IpAddress2DecNum(address)
{
    if (validateIP(address) == false)
    {
        return -1;
    }
    var addrParts = address.split('.');
    var num = 0;
    for (i = 0; i < 4; i++)
    {
        num += parseInt(addrParts[i]) * Math.pow(256, 3 - i);
    }
    return num;
}

function showSelectNodeByValue(curNode, curValue)
{
	for(var i = 0; i < curNode.length; i++)
	{
		if(curNode.options[i].value == curValue)
		{
			curNode.options[i].selected = true;
			break;
		}
	}
}

function showSelectNodeByText(curNode, curText)
{
	for(var i = 0; i < curNode.length; i++)
	{
		if(curNode.options[i].text == curText)
		{
			curNode.options[i].selected = true;
			break;
		}
	}
}
function showRadioNodeByValue(curNode, curValue)
{
	for(var i = 0; i < curNode.length; i++)
	{
		if(curNode[i].value == curValue)
		{
			curNode[i].checked = true;
			break;
		}
	}
}
function showCheckboxNodeByValue(curNode, curValue)
{
	if(curNode.length > 0)
	{
		for(var i = 0; i < curNode.length; i++)
		{
			curNode[i].checked = false;
		}
		for(var i = 0; i < curNode.length; i++)
		{
			if(curNode[i].value == curValue)
			{
				curNode[i].checked = true;
				break;
			}
		}
	}
	else
	{
		if(curNode.value == curValue)
			curNode.checked = true;
		else
			curNode.checked = false;
	}
}
function web_access_check(checkResult) 
{
	load_finish();
	if(parseInt(checkResult) == 1 )			//NO_LOGIN
	{
		alert("Time out, Please login again!");
		parent.location="/goform/webLogout";
	}
	else if(parseInt(checkResult) == 3)		//LOGIN_BUT_TIMEOUT
	{
		alert("Time out, Please login again!");
		parent.location="/goform/webLogout";
	}
	else if(parseInt(checkResult) == 4 )	//NO_LOGIN_ADMIN
	{
		alert("Time out, Please login again!");
		parent.location="/goform/webLogout";
	}
	else if(parseInt(checkResult) == 6)		//LOGIN_BUT_TIMEOUT_ADMIN
	{
		alert("Time out, Please login again!");
		parent.location="/goform/webLogout";
	}
	else if(parseInt(checkResult) == 11)	//FREE_MEM_REBOOT:free mem user timeout, onu reboot
	{
		alert("Time out! Please login again after onu reboot!");
		parent.location="/goform/reboot";
	}
}

function web_accesstr069lgoin_check(checkResult)
{
	if(parseInt(checkResult) == 1 )
	{
		parent.location="/tr069_login.asp";
	}
	else if(parseInt(checkResult) == 3)
	{
		parent.location="/tr069_login.asp";
	}
	else if(parseInt(checkResult) == 4 )
	{
		parent.location="/tr069_login.asp";
	}
	else if(parseInt(checkResult) == 6)
	{
		parent.location="/tr069_login.asp";
	}
}

function web_access_check_admin(ispName, checkResult) 
{
	if(parseInt(checkResult) == 2 )/*普通用户*/
	{
		if(parseInt(ispName) == 15)	//PH GLOBE
		{
			alert("You have no authorization visit this page!");
			parent.location="/login.html";
		}
	}
}

/* 
 * user can't access other login subpage except the page that matches the version
 * 
 */
function loginPageAccessCheck(ispName, ispMinorNameCode, page_style, curLoginPage)
{
	ispName = parseInt(ispName);
	ispMinorNameCode = parseInt(ispMinorNameCode);
	
	switch(ispName)
	{
		case 1:				/* X_CT */
			if(curLoginPage != "login_ct.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 2:				/* X_CMCC */
			if(curLoginPage != "login_common.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 3:				/* X_CU */
			if(ispMinorNameCode == 998)  /*HGU通用版本 ISP NAME 为X_CU, 无标版本*/
			{
				if(curLoginPage != "login_common.asp")
				{
					parent.location="/login.html";
				}
			}
			else if(ispMinorNameCode == 304)	/* HGU X_CU_LIAONING */
			{
				if(curLoginPage != "login_lncu.asp" && curLoginPage != "lncu.asp")
				{
					parent.location="/login.html";
				}
			}
			else
			{
				if(curLoginPage != "login_cu.asp" && curLoginPage != "cu.asp")
				{
					parent.location="/login.html";
				}
			}
			break;
		case 4:				/* TAILAND_3BB */
			if(curLoginPage != "login_3bb.asp" && curLoginPage != "tr069.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 5:				/* X_AIS */
			if(curLoginPage != "login_inter.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 7:				/* BRAZIL */
			if(curLoginPage != "login_inter.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 8:				/* PLDT */
			if(curLoginPage != "login_pldt.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 15:			/* PH X_GLOBE */
			if(curLoginPage != "login_common.asp")
			{
				parent.location="/login.html";
			}
			break;
		case 16:			/* 越南 HGU */
			if(curLoginPage != "login_viettel.asp")
			{
				parent.location="/login.html";
			}
			break;
		default:
			if(page_style == "inter")	/* inter */
			{
				if(curLoginPage != "login_inter.asp")
				{
					parent.location="/login.html";
				}
			}
			else if(curLoginPage != "login_common.asp")
			{
				parent.location="/login.html";
			}
			break;
	}
}

function getAccessMenuPage(checkResult, ispName, ispMinorNameCode, page_style)
{
	ispName = parseInt(ispName);
	ispMinorNameCode = parseInt(ispMinorNameCode);
	checkResult = parseInt(checkResult);
	
	if(checkResult == 1 || checkResult == 3
		|| checkResult == 4 || checkResult == 6)	/* login failed */
	{
		parent.location = "./login.html";
	}
	else						/* login success */
	{
		switch(ispName)
		{
			case 1:				/* X_CT */
				if(ispMinorNameCode == 105)	/* X_CT_HEBEI */
					parent.document.getElementById("loginPage").src = "./menu_inter.asp";
				else if(ispMinorNameCode == 109)/* X_CT_CQYT */
					parent.document.getElementById("loginPage").src = "./menu_ct.asp";
				else
					parent.document.getElementById("loginPage").src = "./menu.asp";
				break;
			case 2:				/* X_CMCC */
				parent.document.getElementById("loginPage").src = "./menu.asp";
				break;
			case 3:				/* X_CU */
				if(ispMinorNameCode == 998)	//X_GENERAL
				{
					parent.document.getElementById("loginPage").src = "./menu.asp";
				}
				else if(ispMinorNameCode == 304)		/* HGU 辽宁联通 */
				{
					parent.document.getElementById("loginPage").src = "./menu_lncu.asp";
				}
				else
				{
					parent.document.getElementById("loginPage").src = "./menu_cu.asp";
				}
				break;
			case 4:				/* TAILAND_3BB */
				parent.document.getElementById("loginPage").src = "./menu_3bb.asp";
				break;
			case 5:				/* X_AIS */
				parent.document.getElementById("loginPage").src = "./menu_inter.asp";
				break;
			case 7:				/* BRAZIL */
				parent.document.getElementById("loginPage").src = "./menu_inter.asp";
				break;
			case 8:				/* PLDT */
				parent.document.getElementById("loginPage").src = "./menu_pldt.asp";
				break;
			case 9:				/*romania*/
				parent.document.getElementById("loginPage").src = "./menu_romania.asp";
				break;
			case 15:			/* PH X_GLOBE */
				parent.document.getElementById("loginPage").src = "./menu_ph_globe.asp";
				break;
			default:
				if(page_style == "inter")	/* inter */
				{
					parent.document.getElementById("loginPage").src = "./menu_inter.asp";
				}
				else
				{
					parent.document.getElementById("loginPage").src = "./menu.asp";
				}
				break;
		} 
	}	
}

function getAccessLoginPage(checkResult, ispName, ispMinorNameCode, page_style)
{
	ispName = parseInt(ispName);
	ispMinorNameCode = parseInt(ispMinorNameCode);
	checkResult = parseInt(checkResult);
	
	switch(ispName)
	{
		case 1:				/* X_CT */
//				parent.loginPage.location.href = "./login_ct.asp";	//there's a problem when displaying on ie9 
			if(ispMinorNameCode == 105)	/* X_CT_HEBEI */
				parent.document.getElementById("loginPage").src = "./login_inter.asp";
			else
				parent.document.getElementById("loginPage").src = "./login_ct.asp";	// It's work
			break;
		case 2:				/* X_CMCC */
			parent.document.getElementById("loginPage").src = "./login_common.asp";
			break;
		case 3:				/* X_CU */
			if(ispMinorNameCode == 998)	//X_GENERAL
			{
				parent.document.getElementById("loginPage").src = "./login_common.asp";
			}
			else if(ispMinorNameCode == 304)	/* HGU X_CU_LIAONING */
			{
				parent.document.getElementById("loginPage").src = "./login_lncu.asp";
			}
			else
			{
				parent.document.getElementById("loginPage").src = "./login_cu.asp";
			}
			break;
		case 4:				/* TAILAND_3BB */
			parent.document.getElementById("loginPage").src = "./login_3bb.asp";
			break;
		case 5:				/* X_AIS */
			parent.document.getElementById("loginPage").src = "./login_inter.asp";
			break;
		case 7:				/* BRAZIL */
			parent.document.getElementById("loginPage").src = "./login_inter.asp";
			break;
		case 8:				/* PLDT */
			parent.document.getElementById("loginPage").src = "./login_pldt.asp";
			break;
		case 9:                       /*romania*/
			parent.document.getElementById("loginPage").src = "./login_romania.asp";
			break;				
		case 15:				/* PH X_GLOBE */
			parent.document.getElementById("loginPage").src = "./login_common.asp";
			break;
		case 16:				/* 越南 HGU */
			parent.document.getElementById("loginPage").src = "./login_viettel.asp";
			break;
		default:
			if(page_style == "inter")	/* inter */
			{
				parent.document.getElementById("loginPage").src = "./login_inter.asp";
			}
			else
			{
				parent.document.getElementById("loginPage").src = "./login_common.asp";
			}
			break;
	}
}

function getAccessLoginPageForCUAdmin(checkResult, ispMinorNameCode)
{
	ispMinorNameCode = parseInt(ispMinorNameCode);
	checkResult = parseInt(checkResult);
	
	if(checkResult == 1 || checkResult == 3
		|| checkResult == 4 || checkResult == 6)
	{
		if(ispMinorNameCode == 304)		/* HGU 辽宁联通 */
		{
			parent.document.getElementById("loginPage").src = "./lncu.asp";
		}
		else
		{
			parent.document.getElementById("loginPage").src = "./cu.asp";
		}
	}
	else
	{
		if(ispMinorNameCode == 304)		/* HGU 辽宁联通 */
		{
			parent.document.getElementById("loginPage").src = "./menu_lncu.asp";
		}
		else
		{
			parent.document.getElementById("loginPage").src = "./menu_cu.asp";
		}
	}
}

function setLineHighLight(previousTR, objTR)
{
    if (previousTR != null)
	{
	    previousTR.style.backgroundColor = '#f4f4f4';
		for (var i = 0; i < previousTR.cells.length; i++)
		{
			previousTR.cells[i].style.color = '#000000';
		}
	}
	
	objTR.style.backgroundColor = '#B7E3E3';//c7e7fe
	for (var i = 0; i < objTR.cells.length; i++)
	{
		objTR.cells[i].style.color = '#000000';
	}
}

function clearInputValue(id)
{
	var node = getElement(id);
	node.value = "";
}

function resetInputValue(id)
{
	var node = getElement(id);
	if(node.value == "")
		node.value = node.defaultValue;
}

function clearZeroInputValue(id)
{
	var node = getElement(id);
	if(node.value == "0" || node.value == "0.0.0.0")
		node.value = "";
}

function waitToLogin(ispName, curUserType)
{
	setTimeout(function(){toLogin(ispName,curUserType)}, 180000);
}

function toLogin(ispName, curUserType) 
{
	var loc = '/login.html';
	if(ispName == '3' && curUserType == '2')	//X_CU管理员
		loc = '/cu.html';

//	var code = 'window.parent.location="' + loc + '"';
//	eval(code);
	top.location = loc;
}

/*****************************************************************************
 * 函 数 名  :     setCookie
 * 负 责 人  : 
 * 创建日期   : 2016年4月25日
 * 函数功能  : 通过JS 设置BROWSER的cookie
 * 输入参数  : 
                              name :  cookie name
				  value:   cookie  value
                              iDay 表示过期时间  ( 分< 0 , =0  >0 三种情况) , =0  表示删除 

			         path :   cookie  所适用的访问路径
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function setCookie(name, value, iDay,path)
{   
    /* iDay 表示过期时间   : cookie中 = 号表示添加，不是赋值 */   
    var oDate=new Date();   

    oDate.setDate(oDate.getDate()+iDay);      
	
    document.cookie = name+'='+value+';expires='+oDate+';path='+path;

}

/*****************************************************************************
 * 函 数 名  :     removeCookie
 * 负 责 人  : 
 * 创建日期   : 2016年4月25日
 * 函数功能  : 通过JS 删除BROWSER  的某个cookie
 * 输入参数  : 
                              name :  cookie name
				
			         path :   cookie  所适用的访问路径
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function removeCookie(name, path)
{   
    /* -1 天后过期即删除 */     
    setCookie(name, "", -1, path);//modify by wuxj, 20160510, 解决IE上该COOKIE未正常过期误提交到后台，导致forms过程校验为未登录的问题
//    setCookie(name, 1, -1, path);

}

function clearOptions(colls)
{
	var length = colls.length;
	for(var i = length - 1; i >= 0; i--)
	{
		colls.remove(i);
	}
}

function len(s) { 
	var l = 0; 
	var a = s.split(""); 
	for (var i=0;i<a.length;i++) { 
		if (a[i].charCodeAt(0)<299) { 
			l++; 
		} else { 
			l+=2; 
		} 
	} 
	return l; 
}

function space2null(str)
{
	if(str == " ")
		return "";
	else
		return str;
}

 function updateForms() { 
    // 得到页面中所有的 form 元素
    var forms = document.getElementsByTagName('form'); 
    for(i=0; i<forms.length; i++) { 
        var url = forms[i].action; 

        // 如果这个 form 的 action 值为空，则不附加 csrftoken 
        if(url == null || url == "" ) continue; 

        // 动态生成 input 元素，加入到 form 之后
        var e = document.createElement("input"); 
        e.name = "csrftoken"; 
		e.value = getCsrftoken();
        e.type="hidden"; 
        forms[i].appendChild(e); 
    } 
 }

function getCookie(c_name)
{
	if (document.cookie.length>0)
	{
		c_start=document.cookie.indexOf(c_name + "=")
		if (c_start!=-1)
		{ 
			c_start=c_start + c_name.length+1 
			c_end=document.cookie.indexOf(";",c_start)
			if (c_end==-1) c_end=document.cookie.length
			return unescape(document.cookie.substring(c_start,c_end))
		} 
	}
	return ""
}

function getCsrftoken()
{
	var str;
	if (typeof(token) !== "undefined")
	{
		str = token;
	} else {
		str = getCookie("fhstamp");
	}
	return str;
}

function html_decode(input)
{
	var output = "";
	if(input.length == 0)
		return "";
	output = input.replace(/\&lt;/g, '<');
	output = output.replace(/\&gt;/g, '>');
	output = output.replace(/\&amp;/g, '&');
	output = output.replace(/\&#34;/g, '"');
	output = output.replace(/\&#39;/g, '\'');
	output = output.replace(/\&#32;/g, ' ');
	return output;
}

function load_waiting() {
	var node = parent.getElementById("load");
	node.style.display = "";
}

function load_finish() {
	var node;
	var str = parent.location.href;
	if(str.search("/menu.html") == -1)//not menu.html
	{
		node = parent.getElementById("load");
		if(!(null === node))
			node.style.display = "none";
	}
}
