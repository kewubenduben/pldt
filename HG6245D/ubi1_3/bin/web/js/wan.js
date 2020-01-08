/***********************************************************************************
wan.js
wuxj
2015.5.22
wan JS functions
***********************************************************************************/

function checkPortBind(curPortNode, curComparedWanPortBindArr, portSum)
{
	var checkedPortValue = new Array(1, 2, 4, 8, 16, 32, 64, 128);//目前最多支持8个端口
	
	if(portSum > 8)
		portSum = 8;
	for(var i = 0; i < portSum; i++)
	{
		if(curPortNode[i].checked == true)
		{
			if(curComparedWanPortBindArr[i] == checkedPortValue[i])
			{
				return false;
			}
		}
	}
	return true;
}

function getPortBindNum(feDom, ssidDom, wifi_ssid_sum)
{
	var bindNum = 0;
	
	for(var i = 0; i < 4; i++)
	{
		if(feDom[i].checked == true)
		{
			bindNum++;			
		}
	}	
	for(var i = 0; i < parseInt(wifi_ssid_sum); i++)
	{
		if(ssidDom[i].checked == true)
		{
			bindNum++;			
		}
	}
	return bindNum;
}

