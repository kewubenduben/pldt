
function WifiRead()
{
	document.wireless_basic.wifiConfHiddenButton.value=0;
	
}

function WifiSave()
{
	document.wireless_basic.wifiConfHiddenButton.value=1;
}

function WifiShow()
{
	document.wireless_basic.wifiConfHiddenButton.value=2;
}

function insertChannelOption(vChannel, band)
{
	var y = document.createElement('option');

	if (1*band == 24)
	{
		y.text = ChannelList_24G[1*vChannel - 1];
		y.value = 1*vChannel;
	}
	else if (1*band == 5)
	{
		y.value = 1*vChannel;
		if (1*vChannel <= 140)
			y.text = ChannelList_5G[((1*vChannel) - 36) / 4];
		else
			y.text = ChannelList_5G[((1*vChannel) - 36 - 1) / 4];
	}

	if (1*band == 24)
		var x=document.getElementById("sz11gChannel");
	else if (1*band == 5)
		var x=document.getElementById("sz11aChannel");

	try
	{
		x.add(y,null); // standards compliant
	}
	catch(ex)
	{
		x.add(y); // IE only
	}
}

function CreateExtChannelOption(vChannel)
{
	var y = document.createElement('option');

	y.text = ChannelList_24G[1*vChannel - 1];
//	y.value = 1*vChannel;
	y.value = 1;

	var x = document.getElementById("n_extcha");

	try
	{
		x.add(y,null); // standards compliant
	}
	catch(ex)
	{
		x.add(y); // IE only
	}
}

function insertExtChannelOption()
{
	var wmode = document.wireless_basic.wirelessmode.options.selectedIndex;
	var option_length; 
	var CurrentCh;

	if ((1*wmode == 6) || (1*wmode == 3) || (1*wmode == 4) || (1*wmode == 7))
	{
		var x = document.getElementById("n_extcha");

		/* delete by 吴小娟, 20110621, 原因: n_extcha未定义*/
		/*		
		var length = document.wireless_basic.n_extcha.options.length;

		if (length > 1)
		{
			x.selectedIndex = 1;
			x.remove(x.selectedIndex);
		}
		*/
			
		if ((1*wmode == 6) || (1*wmode == 7))
		{
			CurrentCh = document.wireless_basic.sz11aChannel.value;

			if ((1*CurrentCh >= 36) && (1*CurrentCh <= 64))
			{
				CurrentCh = 1*CurrentCh;
				CurrentCh /= 4;
				CurrentCh -= 9;

				x.options[0].text = HT5GExtCh[CurrentCh][1];
				x.options[0].value = HT5GExtCh[CurrentCh][0];
			}
			else if ((1*CurrentCh >= 100) && (1*CurrentCh <= 136))
			{
				CurrentCh = 1*CurrentCh;
				CurrentCh /= 4;
				CurrentCh -= 17;

				x.options[0].text = HT5GExtCh[CurrentCh][1];
				x.options[0].value = HT5GExtCh[CurrentCh][0];
			}
			else if ((1*CurrentCh >= 149) && (1*CurrentCh <= 161))
			{
				CurrentCh = 1*CurrentCh;
				CurrentCh -= 1;
				CurrentCh /= 4;
				CurrentCh -= 19;

				x.options[0].text = HT5GExtCh[CurrentCh][1];
				x.options[0].value = HT5GExtCh[CurrentCh][0];
			}
			else
			{
				x.options[0].text = "Auto Select";
				x.options[0].value = 0;
			}
		}
		else if ((1*wmode == 3) || (1*wmode == 4))
		{
			CurrentCh = document.wireless_basic.sz11gChannel.value;
			option_length = document.wireless_basic.sz11gChannel.options.length;

			if ((CurrentCh >=1) && (CurrentCh <= 4))
			{
				x.options[0].text = ChannelList_24G[1*CurrentCh + 4 - 1];
				x.options[0].value = 1*CurrentCh + 4;
			}
			else if ((CurrentCh >= 5) && (CurrentCh <= 7))
			{
				x.options[0].text = ChannelList_24G[1*CurrentCh - 4 - 1];
				x.options[0].value = 0; //1*CurrentCh - 4;
				CurrentCh = 1*CurrentCh;
				CurrentCh += 4;
				CreateExtChannelOption(CurrentCh);
			}
			else if ((CurrentCh >= 8) && (CurrentCh <= 9))
			{
				x.options[0].text = ChannelList_24G[1*CurrentCh - 4 - 1];
				x.options[0].value = 0; //1*CurrentCh - 4;

				if (option_length >=14)
				{
					CurrentCh = 1*CurrentCh;
					CurrentCh += 4;
					CreateExtChannelOption(CurrentCh);
				}
			}
			else if (CurrentCh == 10)
			{
				x.options[0].text = ChannelList_24G[1*CurrentCh - 4 - 1];
				x.options[0].value = 0; //1*CurrentCh - 4;

				if (option_length > 14)
				{
					CurrentCh = 1*CurrentCh;
					CurrentCh += 4;
					CreateExtChannelOption(CurrentCh);
				}
			}
			else if (CurrentCh >= 11)
			{
				x.options[0].text = ChannelList_24G[1*CurrentCh - 4 - 1];
				x.options[0].value = 0; //1*CurrentCh - 4;
			}
			else
			{
				x.options[0].text = "Auto Select";
				x.options[0].value = 0;
			}
		}
	}
}

function ChannelOnChange()
{
/* delete by 吴小娟, 20110601, 原因: n_bandwidth已注释，以下处理不再需要*/
/*
	if (document.wireless_basic.n_bandwidth[1].checked == true)
	{
		var w_mode = document.wireless_basic.wirelessmode.options.selectedIndex;

		if ((1*w_mode == 6) || (1*w_mode == 7))
		{
			if (document.wireless_basic.n_bandwidth[1].checked == true)
			{
				document.getElementById("extension_channel").style.visibility = "visible";
				document.getElementById("extension_channel").style.display = style_display_on();
				document.wireless_basic.n_extcha.disabled = false;
			}

			if (document.wireless_basic.sz11aChannel.options.selectedIndex == 0)
			{
				document.getElementById("extension_channel").style.visibility = "hidden";
				document.getElementById("extension_channel").style.display = "none";
				document.wireless_basic.n_extcha.disabled = true;
			}
		}
		else if ((1*w_mode == 3) || (1*w_mode == 4))
		{
			if (document.wireless_basic.n_bandwidth[1].checked == true)
			{
				document.getElementById("extension_channel").style.visibility = "visible";
				document.getElementById("extension_channel").style.display = style_display_on();
				document.wireless_basic.n_extcha.disabled = false;
			}

			if (document.wireless_basic.sz11gChannel.options.selectedIndex == 0)
			{
				document.getElementById("extension_channel").style.visibility = "hidden";
				document.getElementById("extension_channel").style.display = "none";
				document.wireless_basic.n_extcha.disabled = true;
			}
		}
	}
*/
	/* delete by 吴小娟, 20110718, 原因: 节点n_extcha已删除，以下处理不需要*/
//	insertExtChannelOption();
}

function Channel_BandWidth_onClick()
{
	var w_mode = document.wireless_basic.wirelessmode.options.selectedIndex;

	if (document.wireless_basic.n_bandwidth[0].checked == true)
	{
		document.getElementById("extension_channel").style.visibility = "hidden";
		document.getElementById("extension_channel").style.display = "none";
		document.wireless_basic.n_extcha.disabled = true;
		if ((1*w_mode == 6) || (1*w_mode == 7))
			Check5GBandChannelException();
	}
	else
	{
		document.getElementById("extension_channel").style.visibility = "visible";
		document.getElementById("extension_channel").style.display = style_display_on();
		document.wireless_basic.n_extcha.disabled = false;

		if ((1*w_mode == 6) || (1*w_mode == 7))
		{
			Check5GBandChannelException();

			if (document.wireless_basic.sz11aChannel.options.selectedIndex == 0)
			{
				document.getElementById("extension_channel").style.visibility = "hidden";
				document.getElementById("extension_channel").style.display = "none";
				document.wireless_basic.n_extcha.disabled = true;
			}
		}
	}
}

function Check5GBandChannelException()
{
	var w_mode = document.wireless_basic.wirelessmode.options.selectedIndex;

	if ((1*w_mode == 6) || (1*w_mode == 7))
	{
		var x = document.getElementById("sz11aChannel");
		var current_length = document.wireless_basic.sz11aChannel.options.length;
		var current_index = document.wireless_basic.sz11aChannel.options.selectedIndex;
		var current_channel = document.wireless_basic.sz11aChannel.value;
		 
		if (1*current_index == 0)
		{
			if (1*channel_index != 0)
				current_index = 1;
		}

		for (ch_idx = current_length - 1; ch_idx > 0; ch_idx--)
		{
			x.remove(ch_idx);
		}

		if (document.wireless_basic.n_bandwidth[1].checked == true)
		{
			if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
				(countrycode == 'IE') || (countrycode == 'JP') || (countrycode == 'HK'))
			{
				for(ch = 36; ch <= 48; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
				(countrycode == 'IE') || (countrycode == 'TW') || (countrycode == 'HK'))
			{
				for(ch = 52; ch <= 64; ch+=4)
					insertChannelOption(ch, 5);
			}

			if (countrycode == 'NONE')
			{
				for(ch = 100; ch <= 136; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((countrycode == 'NONE') || (countrycode == 'US') || (countrycode == 'TW') ||
				(countrycode == 'CN') || (countrycode == 'HK'))
			{
				for(ch = 149; ch <= 161; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((1*current_channel == 140) || (1*current_channel == 165))
			{
				document.wireless_basic.sz11aChannel.options.selectedIndex = (1*current_index) -1;
			}
			else
			{
				document.wireless_basic.sz11aChannel.options.selectedIndex = (1*current_index);
			}
		}
		else
		{
			if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
				(countrycode == 'IE') || (countrycode == 'JP') || (countrycode == 'HK'))
			{
				for(ch = 36; ch <= 48; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
				(countrycode == 'IE') || (countrycode == 'TW') || (countrycode == 'HK'))
			{
				for(ch = 52; ch <= 64; ch+=4)
					insertChannelOption(ch, 5);
			}

			if (countrycode == 'NONE')
			{
				for(ch = 100; ch <= 140; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((countrycode == 'NONE') || (countrycode == 'US') || (countrycode == 'TW') ||
				(countrycode == 'CN') || (countrycode == 'HK'))
			{
				for(ch = 149; ch <= 161; ch+=4)
					insertChannelOption(ch, 5);
			}

			if ((countrycode == 'NONE') || (countrycode == 'US') ||
				(countrycode == 'CN') || (countrycode == 'HK'))
			{
					insertChannelOption(165, 5);
			}

			document.wireless_basic.sz11aChannel.options.selectedIndex = (1*current_index);
		}
	}
	else if (1*w_mode == 5)
	{
		var x = document.getElementById("sz11aChannel")
		var current_length = document.wireless_basic.sz11aChannel.options.length;
		var current_index = document.wireless_basic.sz11aChannel.options.selectedIndex;

		for (ch_idx = current_length - 1; ch_idx > 0; ch_idx--)
		{
			x.remove(ch_idx);
		}

		if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
			(countrycode == 'IE') || (countrycode == 'JP') || (countrycode == 'HK'))
		{
			for(ch = 36; ch <= 48; ch+=4)
				insertChannelOption(ch, 5);
		}

		if ((countrycode == 'NONE') || (countrycode == 'FR') || (countrycode == 'US') ||
			(countrycode == 'IE') || (countrycode == 'TW') || (countrycode == 'HK'))
		{
			for(ch = 52; ch <= 64; ch+=4)
				insertChannelOption(ch, 5);
		}

		if (countrycode == 'NONE')
		{
			for(ch = 100; ch <= 140; ch+=4)
				insertChannelOption(ch, 5);
		}

		if ((countrycode == 'NONE') || (countrycode == 'US') || (countrycode == 'TW') ||
			(countrycode == 'CN') || (countrycode == 'HK'))
		{
			for(ch = 149; ch <= 161; ch+=4)
				insertChannelOption(ch, 5);
		}

		if ((countrycode == 'NONE') || (countrycode == 'US') ||
			(countrycode == 'CN') || (countrycode == 'HK'))
		{
				insertChannelOption(165, 5);
		}

		document.wireless_basic.sz11aChannel.options.selectedIndex = (1*current_index);
	}
}

function NetModeSwitch()
{
	var modeIndex = document.getElementById("wirelessmode").options.selectedIndex;	
		
	if((modeIndex == 0) || (modeIndex == 1) || (modeIndex == 2))//802.11 b 802.11 g 802.11 b/g
	{
		document.getElementById("Fre_band").value = 1;//20MHZ
		document.getElementById("Fre_band").disabled = 1;
	}
	else															//802.11 n 802.11 b/g/n
	{
		document.getElementById("Fre_band").value = 0;//20MHz/40MHz
		document.getElementById("Fre_band").disabled = 0;
	}
}

function initTranslation()
{
	var e = document.getElementById("basic_prompt");
	e.innerHTML = _("basic_prompt");

	e = document.getElementById("basicWirelessNet");
	e.innerHTML = _("basic wireless network");
	e = document.getElementById("basicRadioButton");
	e.innerHTML = _("basic radio button");
	e = document.getElementById("basicNetMode");
	e.innerHTML = _("basic network mode");
	/*
	e = document.getElementById("basicSSID_title");
	e.innerHTML = _("basic ssid");
	e = document.getElementById("basicHSSID0");
	e.innerHTML = _("basic hssid");
	*/
	e = document.getElementById("basicFreqA");
	e.innerHTML = _("basic frequency");
	e = document.getElementById("basicFreqAAuto");
	e.innerHTML = _("basic frequency auto");
	e = document.getElementById("fre_band_title");
	e.innerHTML = _("fre_band_title");
	e = document.getElementById("guard_inter_title");
	e.innerHTML = _("guard_inter_title");

	e = document.getElementById("basicApply");
	e.value = _("wireless apply");
	e = document.getElementById("basicCancel");
	e.value = _("wireless cancel");

	e = document.getElementById("channel1");
	e.innerHTML =_("channel") + " 1";
	e = document.getElementById("channel2");
	e.innerHTML = _("channel") + " 2";
	e = document.getElementById("channel3");
	e.innerHTML = _("channel") + " 3";
	e = document.getElementById("channel4");
	e.innerHTML =_("channel") + " 4";
	e = document.getElementById("channel5");
	e.innerHTML = _("channel") + " 5";
	e = document.getElementById("channel6");
	e.innerHTML = _("channel") + " 6";
	e = document.getElementById("channel7");
	e.innerHTML = _("channel") + " 7";
	e = document.getElementById("channel8");
	e.innerHTML = _("channel") + " 8";
	e = document.getElementById("channel9");
	e.innerHTML = _("channel") + " 9";
	e = document.getElementById("channel10");
	e.innerHTML = _("channel") + " 10";
	e = document.getElementById("channel11");
	e.innerHTML = _("channel") + " 11";
	e = document.getElementById("channel12");
	e.innerHTML = _("channel") + " 12";
	e = document.getElementById("channel13");
	e.innerHTML = _("channel") + " 13";

	e = document.getElementById("basicDomain");
	e.innerHTML = _("basicDomain");
	e = document.getElementById("domain0");
	e.innerHTML = _("domain0");
	e = document.getElementById("domain1");
	e.innerHTML = _("domain1");
	e = document.getElementById("domain2");
	e.innerHTML = _("domain2");
	e = document.getElementById("domain3");
	e.innerHTML = _("domain3");
	e = document.getElementById("domain4");
	e.innerHTML = _("domain4");
	e = document.getElementById("domain5");
	e.innerHTML = _("domain5");
	e = document.getElementById("domain6");
	e.innerHTML = _("domain6");
	e = document.getElementById("domain7");
	e.innerHTML = _("domain7");
	e = document.getElementById("domain8");
	e.innerHTML = _("domain8");
	e = document.getElementById("domain9");
	e.innerHTML = _("domain9");
	e = document.getElementById("domain10");
	e.innerHTML = _("domain10");
	e = document.getElementById("domain11");
	e.innerHTML = _("domain11");
	e = document.getElementById("domain12");
	e.innerHTML = _("domain12");
	e = document.getElementById("domain13");
	e.innerHTML = _("domain13");
	e = document.getElementById("domain14");
	e.innerHTML = _("domain14");
	e = document.getElementById("domain15");
	e.innerHTML = _("domain15");
	e = document.getElementById("domain16");
	e.innerHTML = _("domain16");
	e = document.getElementById("domain17");
	e.innerHTML = _("domain17");
	e = document.getElementById("domain18");
	e.innerHTML = _("domain18");
	e = document.getElementById("domain19");
	e.innerHTML = _("domain19");
	e = document.getElementById("domain20");
	e.innerHTML = _("domain20");
	e = document.getElementById("domain21");
	e.innerHTML = _("domain21");
	e = document.getElementById("domain22");
	e.innerHTML = _("domain22");
	e = document.getElementById("domain23");
	e.innerHTML = _("domain23");
	e = document.getElementById("domain24");
	e.innerHTML = _("domain24");

	e = document.getElementById("td_isolation_title");
	e.innerHTML = _("td_isolation_title");
	e = document.getElementById("isolation_enable");
	e.innerHTML = _("isolation_enable");
	e = document.getElementById("isolation_disable");
	e.innerHTML = _("isolation_disable");
	e = document.getElementById("td_isolation_enable");
	e.innerHTML = _("td_isolation_enable");

}

function initValue()
{
	initTranslation();
	
	if (1*radio_off == 1)
		document.wireless_basic.radioButton.value = "RADIO ON";
	else
		document.wireless_basic.radioButton.value = "RADIO OFF";

	/*选择了为0,不选择为空*/
	/*if (HiddenSSID.indexOf("1") >= 0)
	{
		document.wireless_basic.hssid.checked = true;
	}
	else
	{
		document.wireless_basic.hssid.checked = false;
	}*/

	document.wireless_basic.wirelessmode.options.selectedIndex = PhyMode;
	NetModeSwitch();

	if(ispNameCode == 99)	//add by wuxj, 20180723, 通用版本均隐藏区域
	{
		setDisplay("tr_basicDomain", "none");
	}

	var Fre_band_node  = document.getElementById("Fre_band");
	for(var i = 0; i< Fre_band_node.length; i++)
	{
		if(Fre_band_node.options[i].value == Fre_band )
		{
			Fre_band_node.options[i].selected = true;
			break;
		}
	}
	
	//add by wuxj,20171019
	var regDomainNode = document.wireless_basic.select_regDomain;
	if(ispNameCode == 25)	//GEORGIA
	{
		regDomainNode.options[regDomainNode.length] = new Option("GEORGIA", "25");
	}
	document.wireless_basic.select_regDomain.options.selectedIndex = regDomain;
	document.wireless_basic.select_regDomain.disabled = 1;//addy by wuxj, 20180605, 所有设备修改为regDomain不可配
	showChannel(regDomain);
	
	//add by wuxj, 20151214, 双频增加保护间隔参数
	setDisplay("tr_guard_inter","");
	var guard_inter_node  = document.getElementById("guard_inter");
	showSelectNodeByValue(guard_inter_node, guard_inter);

	//add by guoxy,20170118,厄瓜多尔国家不可配
	if(ispNameCode == 12)
	{
		document.getElementById("select_regDomain").value = 15;
		document.getElementById("select_regDomain").disabled = 1;
	}
	
	document.wireless_basic.sz11aChannel.options.selectedIndex = channel_index;

	//读写设备数据失败时结果提示
	dealBasicFailedHandle();

	/*add begin by yclv, 20160927, 罗马尼亚 wifi开关使用下拉菜单形式，普通用户regDomain只读*/
	if(ispNameCode == 9)
	{	
		var radio_on_node = document.getElementById("radio_on");
		setDisplay("TrRadioOn", "none");
		setDisplay("radio_enable_tr", "");
		showSelectNodeByValue(radio_on_node, radio_off);
		if(curUserType == 1) /*普通用户*/
		{
			document.wireless_basic.select_regDomain.disabled = 1;
			//modify by wuxj, 20170413, 普通用户修改为可配WIFI开关 
//			document.wireless_basic.radio_on.disabled = 1;
		}
	}
	
	if((ispNameCode == 17) || (ispNameCode == 18))/*COLUMBIA_TELEBU与COLUMBIA_METRO*/
	{
		var isolation_enable_state = document.getElementsByName("ISOLATIONEnable");	
		for(var i = 0;i<isolation_enable_state.length;i++)
		{
			if(isolation_enable_state[i].value == ISOLATIONEnable)
			{
				isolation_enable_state[i].checked = true;
				break;
			}
		}
		setDisplay("tb_ssid_isolation", "");
	}
}

function CheckValue()
{
	load_waiting();
	return true;
}

function RadioStatusChange(rs)
{
	if (rs == 1) {
		document.wireless_basic.radioButton.value = "RADIO OFF";
		document.wireless_basic.radiohiddenButton.value = 0;
	}
	else {
		document.wireless_basic.radioButton.value = "RADIO ON";
		document.wireless_basic.radiohiddenButton.value = 1;
	}
}

function showChannel(curRegDomain)
{
	var channelNode = document.wireless_basic.sz11aChannel;

	/* 北美、美国、哥伦比亚、格鲁吉亚、菲律宾GLOBE、印尼 */
	if(curRegDomain == 1 || curRegDomain == 13 || curRegDomain == 16 || curRegDomain == 25 
		 || (curRegDomain == 3 && ispNameCode == '15') || curRegDomain == 4)
	{
		if((channelNode.options.length - 1) > 11)
		{
			channelNode.options.remove(13);
			channelNode.options.remove(12);
		}
	}
	else
	{
		if((channelNode.options.length - 1) == 11)
		{
			channelNode.options.add(new Option("channel 12","12"));
			channelNode.options[12].text = _("channel") + " 12";
			channelNode.options.add(new Option("channel 13","13"));
			channelNode.options[13].text = _("channel") + " 13";
		}
	}

}

function regDomainOnChange()
{
	var curRegDomain = document.wireless_basic.select_regDomain.options.selectedIndex;
	showChannel(curRegDomain);
}

/*****************************************************************************
 * 函 数 名  : dealBasicFailedHandle
 * 负 责 人  : 吴小娟
 * 创建日期  : 2011年5月27日
 * 函数功能  : 用于读写设备数据失败时结果提示
 * 输入参数  : 无
 * 输出参数  : 无
 * 返 回 值  : 
 * 调用关系  : 
 * 其    它  : 

*****************************************************************************/
function dealBasicFailedHandle()
{
	if(basicSetFailedID != "" && basicSetFailedID !="dataFormatError")
	{
		/*获取处理失败的参数节点*/
		var dom = document.getElementById(basicSetFailedID);

		/*提示处理失败，获取焦点后显示正常*/
		setFailedDom(dom, 1);				/*1:写*/
	}
	else
	{
		if(basicGetFailedIDs != "")
		{
			var idArray = new Array();
			idArray = parseGetFailedIDs(basicGetFailedIDs);
			for(var i = 0; i<idArray.length; i++)
			{
				var dom = document.getElementById(idArray[i]);
				setFailedDom(dom, 0);		/*0:读*/
			}
		}
	}
}

