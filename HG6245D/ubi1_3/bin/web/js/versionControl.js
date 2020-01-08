/***********************************************************************************
 * �� �� ��   : versionControl.js
 * �� �� ��   : ��С��
 * ��������   : 2011��5��25��
 * �ļ�����   : ����ҳ��İ汾���ִ���
 * ��Ȩ˵��   : Copyright (c) 2000-2011   ���ͨ�ſƼ��ɷ����޹�˾
 * ��    ��   : 
 * �޸���־   : 
***********************************************************************************/
/* add by ��С��, 20110727, ԭ��: ˵��JS��汾�ŵ���Դ*/
/* ˵��: ҳ���ϻ�ȡ�İ汾����WEB��������ʱ�����-V n ͨ��ASP���̴���ҳ��*/

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
 * �� �� ��  : getLogoVerCtrl
 * �� �� ��  : ��С��
 * ��������  : 2011��9��19��
 * ��������  : ��ȡLOGO URL
 * �������  : ispName  �汾��־
 * �������  : ��
 * �� �� ֵ  : 
 * ���ù�ϵ  : 
 * ��    ��  : 

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
		case 15:			/* ���ɱ�GLOBE HGU */
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
 * �� �� ��  : getRegistBgImg
 * �� �� ��  : ��С��
 * ��������  : 2011��9��19��
 * ��������  : ��ȡע��ҳ�汳��ͼƬURL
 * �������  : ispName  �汾��־
 * �������  : ��
 * �� �� ֵ  : 
 * ���ù�ϵ  : 
 * ��    ��  : 

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
 * �� �� ��  : hasPwdCfg
 * �� �� ��  : ��С��
 * ��������  : 2011��6��14��
 * ��������  : ��ȡ�ð汾�Ƿ����������֤����
 * �������  : version  �汾��־
 * �������  : ��
 * �� �� ֵ  : 
 * ���ù�ϵ  : 
 * ��    ��  : 

*****************************************************************************/
function hasPwdCfg(version)
{
	return 1;
}

/*****************************************************************************
 * �� �� ��  : hasRestore
 * �� �� ��  : ��С��
 * ��������  : 2011��6��14��
 * ��������  : ��ȡ�ð汾�Ƿ���лָ��������ù���
 * �������  : version  �汾��־
 * �������  : ��
 * �� �� ֵ  : 
 * ���ù�ϵ  : 
 * ��    ��  : 

*****************************************************************************/
function hasRestore(version)
{
	return 0;
}
