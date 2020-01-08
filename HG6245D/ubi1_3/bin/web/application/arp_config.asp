<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>ARP Config</title>
<script language="JavaScript" type="text/javascript">

var ispNameCode = '<% getCfgGeneral(1, "ispNameCode");%>';
var checkResult = '<% cu_web_access_control();%>';
web_access_check( checkResult);
web_access_check_admin(ispNameCode, checkResult);
var token = <%  get_random_str(); %>;

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("firewall", lang);

var arp_rulenum;
var currentline;
var previousTR = null;

function initTranslation()
{	
}
function LoadFrame()
{ 
	initTranslation();
	
	arp_rulenum  = '<% getCfgGeneral(1, "arp_rulenum"); %>';

	if(arp_rulenum == 0)
	{	
		setDisplay("ConfigForm1", "none");
	}	
	else
	{	
		var row0 = getElement("tb_arpConfig").rows[0];
		selectLine("record_0");	
		setDisplay("ConfigForm1", "");
	}
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row, col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(rowLen - 2 >= 8)
	{		
 		alert(_("fw_most8RulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//�½�
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//ԭ���û�
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
		setDisplay("ConfigForm1", "");
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'trTabContent';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
	}
	
	for (var i = 0; i < firstRow.cells.length - 1; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	}
	col = row.insertCell(i);
	
	selectLine("record_new");
	document.getElementById("arp_ip").focus();
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		currentline = temp;
		if (temp == 'new')		//�½�
		{					
			document.getElementById("arp_mac").value = "";
			document.getElementById("arp_ip").value = "";

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}
        else if (temp == 'no')	//ԭ���û�
        {
        }
		else
		{
			document.getElementById("arp_mac").value = document.getElementById("arp_mac_" + temp).innerHTML;
			document.getElementById("arp_ip").value = document.getElementById("arp_ip_" + temp).innerHTML.split('-')[0].split(':')[0];

			setLineHighLight(previousTR, objTR); 
			previousTR = objTR;
		}	

		//��־��ǰ�༭�����id
		document.getElementById("curIndex").value = temp;
	}	 
}

function clickRemove(tabTitle)
{
	if(arp_rulenum  == 0)
	{			
//   		alert("��ǰû�й��򣬲���ɾ��!");
 		alert(_("fw_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('arp_removeFlag');
    var noChooseFlag = true;
//	var value = checkNodes.getValue();		//�ж��Ƿ�ȫѡ�ˣ����ȫѡ�ˣ�����ipFilterDeleteAll
//	console.info("value.length = " + value.length);
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				noChooseFlag = false;
				break;
			}
		}
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
//		alert('����ѡ��һ������');
		alert(_("fw_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("��ȷ��ɾ����ѡ����?") == false)
	if(confirm(_("fw_deleteRuleConfirm")) == false)
    	return;
//	document.location = "/goform/URL_filterDelete";
	getElement("ruleForm").submit();
	
}
/*У��mac��ַ���ظ���*/
function isMacRepeat(k)
{
	var current_mac = document.getElementById("arp_mac");
	var current_mac_lowercast = current_mac.value.toLowerCase();
	var arp_mac = document.getElementById("arp_mac_" + k).innerHTML;

	if(arp_mac == current_mac_lowercast)  /*�ǵ�ǰ�����д����뵱ǰmac��ͬ�Ĺ��� */
	{
		//alert("MAC ��ַ�Ѱ� ������������!");
		alert(_("macAddr_RepeatAlert"));
		current_mac.value = current_mac.defaultValue;
		current_mac.focus();
		return true;
	}		
	return false;
}

/*У��ip��ַ���ظ���*/
function isIpRepeat(k)
{
	var current_ip = document.getElementById("arp_ip");
	var arp_ip = document.getElementById("arp_ip_" + k).innerHTML.split('-')[0].split(':')[0];

	if(current_ip.value == arp_ip)  /*�ǵ�ǰ�����д����뵱ǰip��ͬ�Ĺ��� */
	{
		//alert("IP��ַ�Ѱ� ������������!");
		alert(_("ip_RepeatAlert"));
		current_ip.value = current_ip.defaultValue;
		current_ip.focus();
		return true;
	}		
	return false;
}

function checkRepeat(temp)
{
	var k = 0;

	if(arp_rulenum > 0)
	{
		for(k = 0; k < arp_rulenum; k++)
		{
			if(temp != 'new') /*�޸Ĺ���*/
			{
				if(temp != k) /*temp Ϊ��ǰ�޸Ĺ����кţ������Լ����бȽ�*/
				{
					if(isMacRepeat(k))
					{
						return false;
					}
					if(isIpRepeat(k))
					{
						return false;
					}
				}
			}
			else /*��������*/
			{	
				if(isMacRepeat(k))
				{
					return false;
				}
				if(isIpRepeat(k))
				{
					return false;
				}
			}
		}
	}
	return true;

}
function checkValue()
{
	var macaddr_value = getElement("arp_mac");
	var ip_value = document.getElementById("arp_ip");
	
	if (!CheckNotNull(macaddr_value.value)) 
	{
		//alert(_("��������Ҫ���˵�MAC��ַ!"));
		alert(_("fw_nomacalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	if(!checkRepeat(currentline))
	{
		return false;
	}

	if(!validateMAC(macaddr_value.value))
	{
		alert(_("fw_macillegalalert"));
		macaddr_value.value = macaddr_value.defaultValue;
		macaddr_value.focus();
		return false;
	}
	
	if(!validateIP(ip_value.value))
	{	
		alert(_("fw_ipIllegalAlert"));
		ip_value.value = ip_value.defaultValue;
		ip_value.focus();
		return false;
	}
	return true;
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="arp_configPrompt" style="padding-left: 10px;" class="title_01" width="100%">On this page, you can configure static ARP parameters, including the IP address and MAC address.</td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
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
                      <td><input type="button" value="Add" id="fw_add" class="submit" onClick="clickAdd('ruleList');"></td>
                      <td><input type="button" value="Delete" id="fw_delete" class="submit" onClick="clickRemove('ruleList');"></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td id="ruleList"><form method="post" id="ruleForm" action="/goform/arp_delete">
          <table class="tabal_bg" id = "tb_arpConfig" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head">
                <td colspan="4" id="arp_bandListHead">ARP Configuration List</td>
              </tr>
              <tr class="tabal_title">
                <td width="15%" align="center">ID</td>
                <td width="43%" align="center" id="ipTitle">IP Address</td>
                <td width="40%" align="center" id="macTitle">MAC Address</td>
                <td width="2%" align="center" ></td>
              </tr>
              <TR id='record_no' class='tabal_01' >
              <TD align='center'>--</TD>
              <TD align='center'>--</TD>
              <TD align='center'>--</TD>
              <TD align='center'></TD>
              </tr>
            </tbody>
          </table>
        </form></td>
    </tr>
    <tr>
      <td height="22"></td>
    </tr>
    <tr>
      <td><form id="ConfigForm" method="post" action="/goform/arp_cfg" onSubmit="return checkValue()">
          <div id="ConfigForm1">
            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
              <tbody>
                <tr>
                  <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                        <tr>
                          <td ><div id="div_rule">
                              <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                                <tbody>
                                  <tr style="">
                                    <td class="tabal_left" width="25%">IP Address</td>
                                    <td class="tabal_right" width="75%"><input name="arp_ip" id="arp_ip" size="17" style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong><span id="fw_curWanIP"></span></td>
                                  </tr>
                                  <tr style="">
                                    <td  class="tabal_left" width="25%">MAC Address</td>
                                    <td class="tabal_right" width="75%"><input name="arp_mac" id="arp_mac" size="17" style="width: 150px;" type="text">
                                      <strong style="color:#FF0033">*</strong><span>(eg. 00:11:22:33:44:55)</span></td>
                                  </tr>
                                </tbody>
                              </table>
                            </div></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
              </tbody>
            </table>
            <table class="tabal_button" width="100%">
              <tbody>
                <tr>
                  <td width="25%"></td>
                  <td class="tabal_submit"><input type="submit" value="Apply" name="apply" class="submit">
                    <input type="reset" value="Cancel" name="cancel" class="submit" onClick="window.location.reload();">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="curIndex" id="curIndex" value="0">
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
