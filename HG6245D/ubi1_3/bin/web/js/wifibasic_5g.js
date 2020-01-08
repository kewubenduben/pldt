//no use
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
//no use
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
//no use
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
//no use
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
//no use
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
/*802.11a时，频宽不可配
  802.11an时，频宽可配20MHz，40MHz
  802.11ac时，频宽可配20MHz，40MHz，80MHz
*/
function NetModeSwitchEx()
{
	var modeIndex = document.getElementById("wirelessmode").options.selectedIndex;
	var freBandNode = getElement("Fre_band");

	if(ispNameCode == 99)	//add by wuxj, 20180723, 通用版本均隐藏区域
	{
		setDisplay("tr_basicDomain", "none");
	}
	
	if(modeIndex == 0)		//5 - 802.11a 跟2.4G的802.11g保持一致
	{
		showSelectNodeByValue(freBandNode, 1);	//20M
		freBandNode.disabled = 1;
	}
	else if(modeIndex == 1)	//6 - 802.11an 可配20MHz，40MHz 20MHz/40MHz
	{
		freBandNode.disabled = 0;
		if(freBandNode.options.length == 4)
		{
			freBandNode.options.remove(3);
		}
	}
	else if(modeIndex == 2)	//7 - 802.11ac 可配20MHz/40MHz 20MHz，40MHz，80MHz
	{
		freBandNode.disabled = 0;
		if(freBandNode.options.length == 3)
		{
			freBandNode.options.add(new Option("80MHz","4"));
		}
		
		if(ispNameCode == '4')//TAILAND_3BB
		{
			freBandNode.options[3].text = "20/40/80MHz";
		}
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
}

function initValue()
{
	initTranslation();
		
	if (1*radio_off == 1)
		document.wireless_basic.radioButton.value = "RADIO ON";
	else
		document.wireless_basic.radioButton.value = "RADIO OFF";

	//add by wuxj,20171019
	var regDomainNode = document.wireless_basic.select_regDomain;
	if(ispNameCode == 25)	//GEORGIA
	{
		regDomainNode.options[regDomainNode.length] = new Option("25", "GEORGIA");
	}
	document.wireless_basic.select_regDomain.options.selectedIndex = regDomain;
	document.wireless_basic.select_regDomain.disabled = 1;
	
	var freBandNode  = document.getElementById("Fre_band");

	/* modify by 吴小娟, 20151028, 原因:5G频宽修改为可配 */
	/*
	switch(parseInt(Fre_band))
	{
		case 0: 
			getElement("fre_band_value").innerHTML = "20MHz/40MHz";
			break;
		case 1: 
			getElement("fre_band_value").innerHTML = "20MHZ";
			break;
		case 2: 
			getElement("fre_band_value").innerHTML = "40MHz";
			break;
		case 3: 
			getElement("fre_band_value").innerHTML = "20MHz/40MHz/80MHz";
			break;
		default:
			getElement("fre_band_value").innerHTML = "40MHz";
			break;			
	}
	*/
	showSelectNodeByValue(freBandNode, Fre_band);
	frebandOnChange(Fre_band);

	/* modify by 吴小娟, 20151028, 原因:5G信道参数修改为可配 */
//	document.wireless_basic.sz11aChannel.options.selectedIndex = channel_index;
/*	if(parseInt(channel_index) == 0)
	{
		getElement("sz11aChannelValue").innerHTML = _("basic frequency auto");
	}
	else
	{
		getElement("sz11aChannelValue").innerHTML = _("basic_frequency_channel") + parseInt(channel_index);	
	}
*/
	showSelectNodeByValue(document.wireless_basic.sz11aChannel, channelValue);

	/* modify by 吴小娟, 20151028, 原因:5G无线模式参数修改为可配 */
	/*
	switch(parseInt(PhyMode))
	{
		case 0: 
			getElement("basicNetModeValue").innerHTML = "802.11 b";
			break;
		case 1: 
			getElement("basicNetModeValue").innerHTML = "802.11 g";
			break;
		case 2: 
			getElement("basicNetModeValue").innerHTML = "802.11 b/g";
			break;
		case 3: 
			getElement("basicNetModeValue").innerHTML = "802.11 n";
			break;
		case 4: 
			getElement("basicNetModeValue").innerHTML = "802.11 b/g/n";
			break;
		case 5: 
			getElement("basicNetModeValue").innerHTML = "802.11 AC/AN";
			break;
		default:
			getElement("basicNetModeValue").innerHTML = "802.11 b";
			break;			
	}
	*/
	showSelectNodeByValue(document.wireless_basic.wirelessmode, PhyMode);
	NetModeSwitchEx();

	//add by wuxj, 20151214, 双频增加保护间隔参数	
	var guard_inter_node  = document.getElementById("guard_inter");
	showSelectNodeByValue(guard_inter_node, guard_inter);
	
}

function CheckValue()
{
	var wireless_mode;
	var submit_ssid_num;
	var channel_11a_index;

	//submit_ssid_num = 1;
	//document.wireless_basic.bssid_num.value = submit_ssid_num;
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
//	showChannel(curRegDomain);	//目前Domain不可配
}

function frebandOnChange(freBandValue)
{
	var channelNode = getElement("sz11aChannel");
	var current_channel = channelNode.value;
	var curChannel;
	var channelList;
	if(channelNode.length > 1)//delete all except auto
	{
		for(var i = channelNode.length; i > 1; i--)
		{
			channelNode.options.remove(i - 1);//index
		}
	}
	
	channelList = channelListArray[freBandValue].split("|");
	for(var i = 1; i <= channelList[0]; i++)//add channellist
	{
		curChannel = channelList[i];
		channelNode.options.add(new Option(_("channel") + " " + curChannel, curChannel));//new Option(text, value)
		if(current_channel == curChannel)
		{
			channelNode.options[i].selected = true;
		}
	}
}