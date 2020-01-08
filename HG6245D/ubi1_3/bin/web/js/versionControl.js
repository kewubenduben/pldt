/***********************************************************************************
 * 文 件 名   : versionControl.js
 * 负 责 人   : 吴小娟
 * 创建日期   : 2011年5月25日
 * 文件描述   : 用于页面的版本区分处理
 * 版权说明   : Copyright (c) 2000-2011   烽火通信科技股份有限公司
 * 其    他   : 
 * 修改日志   : 
***********************************************************************************/
/* add by 吴小娟, 20110727, 原因: 说明JS里版本号的来源*/
/* 说明: 页面上获取的版本号是WEB服务启动时的入参-V n 通过ASP过程传入页面*/

var vc_logoFiberhome = "images/fiberhome_white.jpg";
var vc_logo3BB = "images/3bb.png";
var vc_telelogo = "../images/tele_logo.JPG";
var vc_logoNone = "";
var vc_logoBLUE = "../images/logo_bg.jpg";
var vc_logoPLDT = "../images/pldt_fibr.png";
var vc_logoROMANIA = "../images/romania_logo.png";
var vc_logoPLDT_globe = "../images/ph_globe.png";
var vc_logoCMCC = "../images/cmcc_logo.png";
var vc_logoECUADOR = "../images/cnt_logo.png";
var vc_logoViettel = "../images/viettel_logo.png";
var vc_logoE4 = "../images/iran_net.png";

var vc_regist = "../images/register_content.gif";
var vc_registInter = "../images/reg_inter.jpg";

/*****************************************************************************
 * 函 数 名  : getLogoVerCtrl
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年9月19日
 * 函数功能  : 获取LOGO URL
 * 输入参数  : ispName  版本标志
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function getLogoVerCtrl(ispName, ispMinorNameCode, page_style)
{
	ispName = parseInt(ispName);
	ispMinorNameCode = parseInt(ispMinorNameCode);
	
	switch(ispName)
	{
		case 1:				/* X_CT */
			if(ispMinorNameCode == 105)	/* X_CT_HEBEI */
				return vc_logoNone;
			else
				return vc_logoBLUE;
			break;
		case 2:				/* X_CMCC */
			return vc_logoCMCC;
			break;
		case 4:				/* TAILAND_3BB */
			return vc_logo3BB;
			break;
		case 5:				/* X_AIS */
			return vc_logoNone;
			break;
		case 7:				/* BRAZIL */
			return vc_logoNone;
			break;
		case 8:				/* PLDT */
			return vc_logoPLDT;
			break;
		case 9:				/* romania */
			return vc_logoROMANIA;
			break;
		case 15:			/* 菲律宾GLOBE HGU */
			return vc_logoPLDT_globe;
			break;
		case 12:			/* ECUADOR CNT HGU */
			return vc_logoECUADOR;
			break;
		case 16:			/* Viettel HGU */
			return vc_logoViettel;
			break;
		case 27:			/* IRAN_NET SFU */
			return vc_logoE4;
			break;
		default:
			if(page_style == "inter")	/* inter */
			{
				return vc_logoNone;
			}
			else
			{
				return vc_logoBLUE;
			}			
			break;
	}
}

/*****************************************************************************
 * 函 数 名  : getRegistBgImg
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年9月19日
 * 函数功能  : 获取注册页面背景图片URL
 * 输入参数  : ispName  版本标志
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function getRegistBgImg(ispName, ispMinorNameCode, page_style)
{
	ispName = parseInt(ispName);
	ispMinorNameCode = parseInt(ispMinorNameCode);
	
	switch(ispName)
	{
		case 1:				/* X_CT */
			if(ispMinorNameCode == 105)	/* X_CT_HEBEI */
				return vc_registInter;
			else
				return vc_regist;
			break;
		case 5:				/* X_AIS */
			return vc_registInter;
			break;
		default:
			if(page_style == "inter")	/* inter */
			{
				return vc_registInter;
			}
			else
			{
				return vc_regist;
			}
			
			break;
	}
}
/*****************************************************************************
 * 函 数 名  : hasPwdCfg
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年6月14日
 * 函数功能  : 获取该版本是否具有密码认证功能
 * 输入参数  : version  版本标志
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function hasPwdCfg(version)
{
	return 1;
}

/*****************************************************************************
 * 函 数 名  : hasRestore
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年6月14日
 * 函数功能  : 获取该版本是否具有恢复出厂设置功能
 * 输入参数  : version  版本标志
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function hasRestore(version)
{
	return 0;
}
