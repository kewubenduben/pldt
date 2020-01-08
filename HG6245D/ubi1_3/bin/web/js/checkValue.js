/***********************************************************************************
checkValue.js
wuxj
2011.5.3
validate whether the input is legal
***********************************************************************************/

/*****************************************************************************
validateMask
wuxj
2011.5.3
validate whether mask is legal
*****************************************************************************/
function validateMask(MaskStr)
{
	/* check format */
	var IPPattern = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
	if(!IPPattern.test(MaskStr))
	{
		return false;
	}	

	/* check value range*/
	var IPArray = MaskStr.split(".");
	var ip1 = parseInt(IPArray[0]);
	var ip2 = parseInt(IPArray[1]);
	var ip3 = parseInt(IPArray[2]);
	var ip4 = parseInt(IPArray[3]);

	/* value range 0-255 */
	if ( ip1<0 || ip1>255 		
		|| ip2<0 || ip2>255
		|| ip3<0 || ip3>255
		|| ip4<0 || ip4>255 )
	{
	   return false;
	}

	/* check binary value*/
	/* split binary value*/
	var ip_binary = _checkIput_fomartIP(ip1) + _checkIput_fomartIP(ip2) + _checkIput_fomartIP(ip3) + _checkIput_fomartIP(ip4);

	if(-1 != ip_binary.indexOf("01"))
	{
		return false;
	}
	
	return true;
}


/*****************************************************************************
checkIput_fomartIP
wuxj
2011.5.3
 return binary value of parameter.
*****************************************************************************/
function _checkIput_fomartIP(ip)
{
	return (ip+256).toString(2).substring(1);	//formatting output
}


/*****************************************************************************
validateURL
wuxj
2011.5.3
check whether url is legal
*****************************************************************************/
function validateURL(url)
{
	 var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
/* modify by wuxj, 20110617, URL must start with:// */
//				+ "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" 	//ftp user@
  				+ "(([0-9a-zA-Z_!~*'().&=+$%-]+: )?[0-9a-zA-Z_!~*'().&=+$%-]+@)?" 	//ftp user@
				+ "(([0-9]{1,3}.){3}[0-9]{1,3}" 	// IP kind of URL- 199.194.52.184
				+ "|" 	// 允许IP和DOMAIN
				+ "([0-9a-zA-Z_!~*'()-]+.)*" 	// domain - www.
				+ "([0-9a-zA-Z][0-9a-zA-Z-]{0,61})?[0-9a-zA-Z]." 	// second level domain
				+ "[a-zA-Z]{2,6})" 	// first level domain- .com or .museum
				+ "(:[0-9]{1,5})?" 	// port  :80
				+ "((/?)|" 	// a slash isn't required if there is no file name
				+ "(/[0-9a-zA-Z_!~*'().;?:@&=+$,%#-]+)+/?)$";
	var re=new RegExp(strRegex);

	if (re.test(url))
	{
		 return true;
	}else
	{
		return false;
	}
}


/*****************************************************************************
CheckNotNull
wuxj
2011.5.3
check whether input is NULL
*****************************************************************************/
function CheckNotNull(fieldValue)
{
	if(fieldValue.length == 0)
	{
		return false;		
	}else
	{
		return true;
	}
}

/*****************************************************************************
isAllNumOrDot
wuxj
2011.5.3
check whether string is all numbers and .
*****************************************************************************/
function isAllNumOrDot(str)
{
	for (var i=0; i<str.length; i++) {
		if ((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '.' ))
			continue;
		return false;
	}
	return true;
}

/*****************************************************************************
isAllNum
wuxj
2012.3.8
check whether string is all numbers
*****************************************************************************/
function isAllNum(str)
{
	var exp=/^\d+$/;
	
	if(!exp.test(str))
	{ 
		return false;
	} 
	else 
	{ 
		return true;
	} 
}

/*****************************************************************************
compareIP
wuxj
2016.11.23
compare two IP whith is bigger:
> return 1; = return 0; < return -1
*****************************************************************************/
function compareIP(ipBegin, ipEnd)
{
    var temp1;
    var temp2;
    temp1 = ipBegin.split(".");
    temp2 = ipEnd.split(".");
    for (var i = 0; i < 4; i++)
    {
        if(parseInt(temp1[i]) > parseInt(temp2[i]))  
        {
            return 1;
        }
        else if(parseInt(temp1[i]) < parseInt(temp2[i]))  
        {  
            return -1;
        }
    }
    return 0;
}

/*****************************************************************************
isEqualIPAddress
wuxj
2016.11.22
check whether two IP is in the same net
*****************************************************************************/
function isEqualIPAddress (addr1, addr2, mask)
{
	if(!addr1 || !addr2 || !mask)
	{
		return -1;
	}
	var res1 = [];
	var res2 = [];
	addr1 = addr1.split(".");
	addr2 = addr2.split(".");
	mask  = mask.split(".");
	for(var i = 0, ilen = addr1.length; i < ilen ; i += 1)
	{
		res1.push(parseInt(addr1[i]) & parseInt(mask[i]));
		res2.push(parseInt(addr2[i]) & parseInt(mask[i]));
	}
	if(res1.join(".") == res2.join("."))
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*****************************************************************************
validateIP
wuxj
2011.5.3
check whether IP is legal
*****************************************************************************/
function validateIP(ip) 
{ 
	var obj=ip;
	var exp=/^([1-9]|[1-9]\d|1\d{2}|2[0-1]\d|22[0-3])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}$/; 

	var reg = obj.match(exp); 
	if(reg==null) 
	{ 
		return false;
	} 
	else 
	{ 
		return true;
	} 
} 

/*****************************************************************************
checkIpv6LastLen
gxy
2017.01.20
校验ipv6地址最后一段是否长度小于等于4
*****************************************************************************/
function checkIpv6LastLen(ipv6)
{
	var obj=ipv6;
	var str = obj.substring(obj.lastIndexOf(":") + 1,obj.length);
	if(str.length > 4)
	{
		return false;
	}
	else
	{
		return true;
	}
}

/*****************************************************************************
checkIpv6
gxy
2016.12.15
check whether IPv6 IP is legal
ipv6地址标准格式是：(x表示0-9，a-f,A-F,首位必须为2或者3)
例如：xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx
但其中也可以有且仅有一个“::”,表示多个零
*****************************************************************************/
function checkIpv6(ipv6)
{
	var obj=ipv6;						
	var exp=/^(([2-3][0-9 a-f]{1,3}:)(([0-9 a-f]{1,4}:){6})([0-9 a-f]{1,4}))|(([2-3][0-9a-f]{1,3}:)([0-9 a-f]{1,4}:){0,5}:)$/i; /*2001:1:1:1:1:1:1:1或2001:F:10F::*/
	var exp2=/^([2-3][0-9a-f]{1,3}:)(([0-9a-f]{1,4}:){0,6})((:[0-9a-f]{1,4}){0,6})$/i;/*2001:F:F::1:1 2001:F:F:F:F::1 2001::F:F:F:F:1格式*/
	var ret = obj.match(exp);
	var ret2=obj.match(exp2);
	var exp_len = 0;
	if(!checkIpv6LastLen(obj))
	{
		return false;
	}
	if( (ret != null) || (ret2 != null)) 
	{
		exp_len = obj.match(/:/g).length;
		if(exp_len <=7 && exp_len > 0)/*不超过7个":"*/
		{
			if(ret != null)/*2001:1:1:1:1:1:1:1或2001:F:10F::*/
			{		
				return true;				
			}
			else if(ret2 != null && exp_len <=6)/*2001:F:F::1:1 2001:F:F:F:F::1 2001::F:F:F:F:1格式,排除2001:1:2:3:4:5::6情况*/
			{
				var sub = obj.split("");	
				if(sub[obj.length - 2] != ":" && sub[obj.length - 1] == ":")/*排除2001:1:的情况*/
				{		
					return false;
				}
				else
				{
					return true;
				}
			}
			else
			{
				return false;
			}	
		}	
		else/*超过7个":"*/
		{
			 return false;
		}
	}
	else
	{
		 return false;
	}
}

/*****************************************************************************
checkIpv6Prefix
gxy
2016.12.15
check whether IPv6 prefix is legal
ipv6前缀标准格式为：(x表示0-9，a-f,A-F，首位必须为2或者3）
DD表示前缀长度，为数字，一般可为48，56，64等8的倍数，建议配置时检验是否48～64)
例如:xxxx:xxxx:xxxx:xxxx::/DD
*****************************************************************************/
function checkIpv6Prefix(ipv6pre)
{
	var obj=ipv6pre;
	var ipv6_info = obj.split("/");
	var ipaddr, prefix;
	ipaddr = ipv6_info[0];
	prefix = ipv6_info[1];	
	var rst_ip = 0;/*ipaddr 校验结果*/
	var rst_prefix = 0;/*prefix 校验结果*/
	
	if(checkIpv6(ipaddr))/*校验前缀*/
	{
		rst_ip = 1;
	}

	/*校验前缀长度，配置时检验是否48～64)*/
	if((parseInt(prefix) >= 48) && (parseInt(prefix) <= 64))
	{
		rst_prefix = 1;	
	}

	if(parseInt(rst_ip) == 1 && parseInt(rst_prefix) == 1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*****************************************************************************
checkIpv6GatewayDNS
gxy
2016.12.15
check whether IPv6 gateway or dns is legal
默认网关，DNS同ipv6地址要求，只是首位可以为2或3或F
*****************************************************************************/
function checkIpv6GatewayDNS(ipv6)
{
	var obj=ipv6;						
	var exp=/^((f[0-9 a-f]{1,3}:)(([0-9 a-f]{1,4}:){6})([0-9 a-f]{1,4}))|((f[0-9a-f]{1,3}:)([0-9 a-f]{1,4}:){0,5}:)$/i; /*F001:1:1:1:1:1:1:1或F:F:10F::*/
	var exp2=/^(f[0-9a-f]{1,3}:)(([0-9a-f]{1,4}:){0,6})((:[0-9a-f]{1,4}){0,6})$/i;/*F:F:F::1:1 F:F:F:F:F::1 F::F:F:F:F:1格式*/	
	var ret = obj.match(exp);
	var ret2=obj.match(exp2);
	var exp_len = 0;
	var rst = 0; /*存放校验结果*/
	if(!checkIpv6LastLen(obj))
	{
		return false;
	}
	if( (ret != null) || (ret2 != null)) 
	{
		exp_len = obj.match(/:/g).length;
		if(exp_len <=7 && exp_len > 0)/*不超过7个":"*/
		{
			if(ret != null)/*F:1:1:1:1:1:1:1或F:F:10F::*/
			{		
				rst = 1;				
			}
			if(ret2 != null && exp_len <=6)/*F:F:F::1:1 F:F:F:F:F::1 F::F:F:F:F:1格式,排除F:1:2:3:4:5::6情况*/
			{
				var sub = obj.split("");	
				if(sub[obj.length - 2] != ":" && sub[obj.length - 1] == ":")/*排除F:1:的情况*/
				{		
					rst = 0;
				}
				else
				{
					rst = 1;
				}
			}		 
		}
	}
		
	if(checkIpv6(obj))
	{
		rst = 1;
	}

	if(parseInt(rst) == 1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*****************************************************************************
checkV6PrefixLength
wuxj
2017.2.14
check whether IPv6 Prefix Length is legal. exmple : 1-maxLen
*****************************************************************************/
function checkV6PrefixLength(maxLen, curPreLen)
{
	var exp = /^\d+$/;	
	if(exp.test(curPreLen))
	{
		if(1 <= curPreLen && curPreLen <= maxLen)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		return false;
	}
}

/*****************************************************************************
validateMAC
wuxj
2012.3.6
check whether mac is legal. exmple : 00:24:21:19:BD:E4
*****************************************************************************/
function validateMAC(mac) 
{ 
	var exp=/^([A-Fa-f\d]{2})(:[0-9A-Fa-f]{2}){5}$/; //00:24:21:19:BD:E4
	if(!exp.test(mac))/*不符合*/
	{
		return false;
	}
	else/*符合*/
	{
		/*排除全0*/
		var exp_zero=/^(00)(:00){5}$/; 
		if(exp_zero.test(mac))
		{
			return false;
		}
		
		/*排除组播；首字节末位是1，16进制表示首字节，合法情况；第二个数字只能是0 2 4 6 8 A C E*/
		var exp_muticast=/^([A-Fa-f\d][0 2 4 6 8 A C E])(:[0-9A-Fa-f]{2}){5}$/i;
		if(!exp_muticast.test(mac))
		{
			return false;
		}
	}	
	return true;
} 

/*****************************************************************************
checkASCIIChar
wuxj
2012.3.15
check whether string is all ASCII
*****************************************************************************/
function checkASCIIChar(str)
{
	for(var i = 0; i < str.length; i++)
	{
	    if(str.charAt(i) < '\u0000' || str.charAt(i) > '\u007f')
	    {
			return false;
	    }
	}
	return true;
}

/*****************************************************************************
checkSpecialChar
wuxj
2012.3.20
check whether string include the SpecialChar
*****************************************************************************/
function checkSpecialChar(speChar, str)
{
	for(var i = 0; i < str.length; i++)
	{
	    if(str.charAt(i) == speChar)
	    {
			return true;
	    }
	}
	return false;
}

function checkNumberLegal(dom, min, max)
{
	var exp = /^\d+$/;
	dom.value = parseInt(dom.value);
	if(exp.test(dom.value))
	{
		if(min <= dom.value && dom.value <= max)
		{
			return true;
		}
		else
		{
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}
	
function checkYearLegal(dom)
{
	return checkNumberLegal(dom, 0, 9999);
}	
function checkMonthLegal(dom)
{
	if(checkNumberLegal(dom, 1, 12))
	{
		if(dom.value < 10)
			dom.value = '0' + dom.value;
		return true;
	}
	else
		return false;
}		
function checkDateLegal(dom, month)
{
	var max;
	var m = parseInt(month);
	if(m == 1 || m == 3 || m == 5 
		|| m == 7 || m == 8 || m == 10 || m == 12)
		max = 31;
	else if(m == 2)
		max = 28;
	else
		max = 30;
	
	if(checkNumberLegal(dom, 1, max))
	{
		if(dom.value < 10)
			dom.value = '0' + dom.value;
		return true;
	}
	else
		return false;
}	
function checkHourLegal(dom)
{
	if(checkNumberLegal(dom, 0, 24))
	{
		if(dom.value == 0)
			dom.value = '00';
		else if(dom.value < 10)
			dom.value = '0' + dom.value;
		return true;
	}
	else
		return false;
}
function checkMinLegal(dom)
{
	if(checkNumberLegal(dom, 0, 60))
	{
		if(dom.value == 0)
			dom.value = '00';
		else if(dom.value < 10)
			dom.value = '0' + dom.value;
		return true;
	}
	else
		return false;
}

function checkWebPortLegal(dom)
{
	var exp = /^\d+$/;	
	if(exp.test(dom.value))
	{
		if(dom.value != 80)
		{
			if(1024 <= dom.value && dom.value <= 65535)
			{
				return true;
			}
			else
			{
				dom.value = dom.defaultValue;
				dom.focus();
				return false;
			}
		}
		else
		{
			return true;
		}
	}
	else
	{
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

function checkCommDescription(dom)
{	
	if(dom.style.display == "none")
	{
		return true;
	}
	dom.value = trim(dom.value);
	var reg = /^[\w-]{0,31}$/;	//number letter _ -
	if (!reg.test(dom.value))
	{
		alert(_("descripIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false; 
	}
	return true;
}

function checkDiagnosisAddr(addr)
{
	if(validateIP(addr))	//v4 ip
	{
		return true;
	}
	else if(checkIpv6(addr))	//v6 ip
	{
		return true;
	}
	else
	{
		var reg = /^[\w-.:\/]+$/;	//number letter _ -.:/
		if (!reg.test(addr))
		{
			return false; 
		}
		else
			return true;
	}
}

function checkManAdmPwd(str)
{
	var reg = /^[\w./-]{1,32}$/;	//数字 英文字母 _ . / -
    if (!reg.test(str))
	{ 
     	return false; 
    }
	else
	{
		return true;
	}
}
