<!-- saved from url=(0022)http://internet.e-mail -->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Device Regist</title>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/versionControl.js"></script>
<script type="text/javascript" language="javascript">

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("device_regist", lang);

var devRegisterSync = '<% devRegisterSync(); %>';
var ispName = '<% getCfgGeneral(1, "ispNameCode");%>';
var ispMinorNameCode = '<% getCfgGeneral(1, "ispMinorNameCode");%>';

var bar;
var res;
var count = 0;
var result_flag = 0;
var result_count = 0;
//var request  = initXMLHttpClient();
var request = getRequest();
var progress;

var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';
var getACSIPRst;
var authStatus = '<% getCfgGeneral(1, "auth_status"); %>';
var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
var authTimes = '<% getCfgGeneral(1, "auth_times"); %>';
var authLimit = '<% getCfgGeneral(1, "auth_limit"); %>';

var ispName = '<% getCfgGeneral(1, "ispNameCode"); %>';

var loId;
var iNeedAcsAuthFlag;

var loPwd;

function initTranslation()
{
	var e;
    e = document.getElementById("backPage");
	e.innerHTML = _("backPage");
	e = document.getElementById("inputTips");
	e.innerHTML = _("inputTips");
	e = document.getElementById("pwdTitle");
	e.innerHTML = _("pwdTitle");
	e = document.getElementById("submit");
	e.value = _("regist_submit");
	e = document.getElementById("reset");
	e.value = _("regist_reset");
}

function LoadFrame()
{
	initTranslation();
	var page_style = '<% getCfgGeneral(1, "page_style"); %>';
	document.getElementById("registBgimg").style.background = "url(" + getRegistBgImg(ispName, ispMinorNameCode, page_style) + ")";
	
	var codeTxt;
	if(parseInt(devRegisterSync) == 0)
	{
		if(parseInt(authStatus) == 5)
		{
			if(parseInt(authResult) == 1)
			{
				codeTxt = _("registAlready");
			}
			else
			{
				codeTxt = _("registAlready2");
			}
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authStatus) == 0 && parseInt(authResult) == 1)
		{
			codeTxt = _("serviceDistributeSuccess");
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authResult) == 0 || parseInt(authResult) == 2)
		{
			codeTxt = _("serviceDistributingIncomplete");
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else
		{
			setDisplay("tb_register","");
			setDisplay("tb_progressBar","none");
		}		
	}
	else
	{
		setDisplay("tb_register","");
		setDisplay("tb_progressBar","none");
	}
}

function codeTransform_ais()
{
	var codeTxt;
	if(parseInt(oltAuthRst) == 99)
	{
		codeTxt = _("oltAuthing");
	}
	else if(parseInt(oltAuthRst) != 0)
	{
		codeTxt = _("oltAuthFailed");
	}
	else
	{
		if(parseInt(getACSIPRst) == 99)
		{
			codeTxt = _("getACSIPing");
		}
		else if(parseInt(getACSIPRst) != 0)
		{
			codeTxt = _("getACSIPFailed");
		}
		else
		{
			switch(parseInt(authStatus))
			{
				case 3:
					codeTxt = _("ACSAuthing");
					break;
				case 4:
					codeTxt = _("serviceDistributing");
					break;
				case 5:
					codeTxt = _("serviceDistributeSuccess");
					break;
				case 103:
					codeTxt = _("ACSAuthFailed");
					break;
				case 104:
					codeTxt = _("serviceDistributeFailed");
					break;
				default:
					codeTxt = _("ACSAuthFailed");
					break;					
			}
		}
	}

	return codeTxt;
}

function codeTransform()
{
	var codeTxt;
	var codeTxt2;
	if(parseInt(oltAuthRst) == 99)
	{
		codeTxt = _("oltAuthing");
	}
	else if(parseInt(oltAuthRst) != 0)
	{
		switch(parseInt(oltAuthRst))
		{
			case -1:
				codeTxt = _("oltAuthFailed_info");//"在OLT上注册失败，请检查逻辑ID和密码是否正确。";
				break;
			case 2:
				codeTxt = _("oltAuthFailed_loid");//"在OLT上注册失败(逻辑ID错误)，请检查逻辑ID和密码是否正确。";
				break;
			case 3:
				codeTxt = _("oltAuthFailed_lopwd");//"在OLT上注册失败(逻辑密码错误)，请检查逻辑ID和密码是否正确。";
				break;
			case 4:
				codeTxt = _("oltAuthFailed_loid_conflict");//"在OLT上注册失败(逻辑ID冲突)，请检查逻辑ID和密码是否正确。";
				break;
			case 10:
				codeTxt = _("oltAuthFailed_physn_conflict");//"在OLT上注册失败(物理SN冲突)，请检查输入是否正确。";
				break;
			case 11:
				codeTxt = _("oltAuthFailed_noresourse");//"在OLT上注册失败(无资源)，请重试。";
				break;
			case 12:
				codeTxt = _("oltAuthFailed_type");//"在OLT上注册失败(ONU类型错误)。";
				break;
			case 13:
				codeTxt = _("oltAuthFailed_physn");//"在OLT上注册失败(物理SN错误)，请检查输入是否正确。";
				break;
			case 14:
				codeTxt = _("oltAuthFailed_phypwd");//"在OLT上注册失败(物理密码错误)，请检查输入是否正确。";
				break;
			case 15:
				codeTxt = _("oltAuthFailed_phypwd_conflict");//"在OLT上注册失败(物理密码冲突)，请检查输入是否正确。";
				break;
			default:
				codeTxt = _("oltAuthFailed_default");//"在OLT上注册失败，请重试。";
				break;				
		}
		
	}
	else
	{
		if(parseInt(getACSIPRst) == 99)
		{
			codeTxt = _("getACSIPing");//"OLT注册成功，终端正在获取管理地址；";
		}
		else if(parseInt(getACSIPRst) == -1)
		{
			codeTxt = _("getACSIPFailed");//"终端获取管理地址失败，请重试。";
		}
		else		//getACSIPRst == 0
		{
			if(iNeedAcsAuthFlag == 0)	//first display
			{
				codeTxt = _("getACSIPSuccess");//"终端获取管理地址成功；";
			}
			else
			{
				if(parseInt(authTimes) < parseInt(authLimit))
				{
					//"请重试（剩余尝试次数："
					codeTxt2 = _("retryRestTimes") + (parseInt(authLimit) - parseInt(authTimes)) + ")";
				}
				else
				{
					codeTxt2 = _("retryExceedMaxTimes");//"已超出终端认证最大次数，请联系客服。";
				}
				switch(parseInt(authStatus))
				{
					case 0:
						switch(parseInt(authResult))
						{
							case 99:
								codeTxt = _("ACSAuthSuccessWaitingDistribute");//"终端注册管理平台成功，等待下发业务数据；";
								break;
							case 0:
								codeTxt = _("serviceDistributing");//"正在下发业务，请勿断电或插拔光纤；";
								break;
							case 1:
								codeTxt = _("serviceDistributeSuccess");//"注册全部完成，业务下发配置成功，欢迎使用!";
								break;
							case 2:
								codeTxt = _("serviceDistributeFailed");//"注册成功，下发业务失败。";
								break;
							default:
								codeTxt = _("ACSAuthSuccess");//"终端注册管理平台成功。";
								break;
						}
						break;
					case 1:
						codeTxt = _("ACSAuthFailed_password") + codeTxt2;//"Password不存在。"
						break;
					case 4:
						codeTxt = _("registTimeout");//"注册超时！请检查线路后重试。";
						break;
					case 5:
						codeTxt = _("registAlready");//"已经注册成功，无需重新注册。";
						break;
					case 99:
						codeTxt = _("ACSAuthing");//"终端正在注册管理平台；";
						break;
					default:
						codeTxt = _("oltAuthFailed");//"注册失败，请重试。";	/* 规范里无此提示信息 --获取注册结果失败 */
						break;
				}
			}
		}
	}

	return codeTxt;
}

function identityRegist()
{	
	with ( document.forms[0] ) 
	{
		register();
		return true;
	}	
}
function register(){	
	setDisplay("tb_register","none");
	setDisplay("tb_progressBar","");
	
	progress = new CProgress("progress", 300, 15, 0);
	progress.Create();
	send_request();
	bar = setInterval("progress.Inc();",200);
//		res = setInterval("checkresult();",5000);
	res = setInterval("checkresult();",10000);	//2011-10-13　应丰工要求，修改为10秒
}

function CProgress(progressIdStr, width, height, pos)
{
    this.progressIdStr = progressIdStr;
    this.progressId = document.getElementById(this.progressIdStr);
    this.barIdStr = progressIdStr + "_bar";
    this.barId = null;
    
    this.pos = pos>=100?100:pos;
    this.step = 1;
	this.rate = 10;
	this.limit = 10;
	this.result = _("oltAuthing");

    this.progressWidth = width;
    this.progressHeight = height;
    
    this.Create = Create;

    this.SetStep = SetStep;
    this.SetPos = SetPos;
	this.SetResult = SetResult;
	this.SetRate = SetRate;
	this.SetLimit = SetLimit;
    this.Inc = Inc;
    this.Desc = Desc;
}

function Create()
{
    if (document.all)
    {
        this.progressId.style.width = this.progressWidth+2;
    }
    else
    {
        this.progressId.style.width = this.progressWidth;
    }
    this.progressId.style.height = this.progressHeight;
    this.progressId.style.fontSize = this.progressHeight;
    this.progressId.style.border = "1px solid #000000";
    this.progressId.innerHTML = "<div id=\"" + this.barIdStr + "\" style=\"background-color:#aabbcc;height:100%;text-align:center\"></div>";
    this.barId = document.getElementById(this.barIdStr);
    this.SetPos(this.pos);
}

function SetStep(step)
{
    this.step = step;
}

function SetPos(pos)
{
    this.pos = (pos<=0)?0:pos;
    this.pos = (parseInt(this.pos) >parseInt(this.limit))?this.limit:this.pos;
    if(this.rate == -1)
    	this.pos = 100;

	showResult();
}

function Inc()
{
	count++;		
	this.pos = parseInt(this.pos) + parseInt(this.step);
	this.SetPos(this.pos);
}

function Desc()
{
    this.pos -= this.step;
    this.SetPos(this.pos);
}

function SetLimit(limit){
	this.limit = limit<0?0:limit;
	this.limit = this.limit>100?100:this.limit;
}

function SetRate(rate){	
	this.rate = rate;

	if(parseInt(rate) > parseInt(this.pos)){
		this.SetLimit(parseInt(rate));
	}
}

function SetResult(result){
	this.result = result;
}

function showResult(){	
	if(count > 3000) {								//2400	--8分钟	//2011-10-13应丰工要求修改为10分钟
		progress.barId.style.width = "100%";
		document.getElementById("information").innerHTML = 
			"<a href=\"/devregist/register_pwd.asp\">" + _("registTimeout") + "</a>";
	}else{
		progress.barId.style.width = progress.pos+"%";

/* delete by 吴小娟, 20150303, 原因:注释掉if,pos变化时实时显示当时的result */
//		if(parseInt(progress.pos) >= parseInt(progress.rate))
			document.getElementById("information").innerHTML = progress.result;
	}

	progress.barId.innerHTML=progress.barId.style.width;

	if(progress.barId.style.width == "100%"){
		window.clearInterval(bar);
		window.clearInterval(res);
		return;
	}
}

 // create an XMLHttpClient in a cross-browser manner  
 function initXMLHttpClient(){  
   var xmlhttp;  
   try {xmlhttp=new XMLHttpRequest()} // Mozilla/Safari/IE7 (normal browsers)  
   catch(e){                          // IE (?!)  
     var success=false;  
     var XMLHTTP_IDS=new Array('MSXML2.XMLHTTP.5.0','MSXML2.XMLHTTP.4.0',  
                               'MSXML2.XMLHTTP.3.0','MSXML2.XMLHTTP','Microsoft.XMLHTTP');  
     for (var i=0; i<XMLHTTP_IDS.length && !success; i++)  
       try {success=true; xmlhttp=new ActiveXObject(XMLHTTP_IDS[i])} catch(e){}  
     if (!success) throw new Error('Unable to create XMLHttpRequest!');  
   }  
   return xmlhttp;  
 }  
 
 function send_request(){ 
	loId = document.getElementById("LOID").value;
	if(ispName == 5)	//HGU X_AIS
	{
		request.open('GET','/goform/devRegister_ais?LOID=' + loId + '&' + Math.random(), true); // open asynchronus request  
		request.onreadystatechange = request_handler_ais;          // set request handler  
	}
	else
	{
		request.open('GET','/goform/devRegister?LOID=' + loId + '&' + Math.random(), true); // open asynchronus request  
		request.onreadystatechange = request_handler;          // set request handler  
	}
	request.send(null);                                    // send request  
 } 

function request_handler_ais()
{ 
	if (request.readyState == 4){ // if state = 4 (the operation is completed)
		if (request.status == 200 || request.status == 0){ // and the HTTP status is OK  
			// get progress from the XML node and set progress bar width and innerHTML  
			var array = request.responseText.split("|");
			oltAuthRst = array[0];
			getACSIPRst = array[1];
			authStatus = array[2];
			progress.SetRate(array[3]);	 
			progress.SetResult(codeTransform_ais());
			result_flag = 1;
			result_count += 1;
		}  
		else{ // if request status is different then 200  
			progress.style.width = '100%';  
			progress.innerHTML='Error: ['+request.status+'] '+request.statusText;
		}  
	}
} 

 function request_handler()
 { 
   if (request.readyState == 4){ // if state = 4 (the operation is completed)  
   
     if (request.status == 200 || request.status == 0){ // and the HTTP status is OK  
       // get progress from the XML node and set progress bar width and innerHTML  
		var array = request.responseText.split("|");
		oltAuthRst = array[0];
		getACSIPRst = array[1];
		authStatus = array[2];
		authResult = array[3];
		authTimes = array[4];
		authLimit = array[5];
		iNeedAcsAuthFlag = array[6];
		progress.SetRate(array[7]);	   
		progress.SetResult(codeTransform());
		result_flag = 1;
		result_count += 1;
     }  
     else{ // if request status is different then 200  
       progress.style.width = '100%';  
       progress.innerHTML='Error: ['+request.status+'] '+request.statusText;  
     }  
   }
 } 

 function checkresult(){
	 
	if(result_flag == 1){
		result_flag = 0;
		send_request();		
	}
 }
</script>
</head>
<body onLoad="LoadFrame();">
<form>
  <table align="center" border="0" cellpadding="0" cellspacing="0" width="808">
    <tbody>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td><table align="middle" border="0" cellpadding="0" cellspacing="0" width="808">
            <tbody>
              <tr>
                <td rowspan="3" width="77"></td>
                <td id="registBgimg" align="center" height="323" width="653"><table border="0" cellpadding="0" cellspacing="0" height="50" width="96%">
                    <tbody>
                      <tr>
                        <td align="right"><a id="backPage" href="../login.html"><font color="#000000" size="2"></font></a></td>
                      </tr>
                    </tbody>
                  </table>
                  <table id="tb_register" border="0" cellpadding="0" cellspacing="0" height="200" width="400" style="display:none">
                    <tbody>
                      <tr>
                        <td colspan="2" height="12"></td>
                      </tr>
                      <tr>
                        <td id="inputTips" colspan="2" align="center" height="25"></td>
                      </tr>
                      <tr>
                        <td id="pwdTitle" align="right" height="25" valign="bottom" width="130"></td>
                        <td align="left" valign="bottom" width="200"><input name="LOID" id="LOID" size="24" maxlength="24" type="text"></td>
                      </tr>
                      <tr height="8">
                        <td colspan="2"></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="35"><input id="submit" type="button" onClick="identityRegist()">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <input id="reset" type="reset">
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" height="20"></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="20" width="100%"><font size="2"></font></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="left" height="30"></td>
                      </tr>
                    </tbody>
                  </table>
                  <table id="tb_progressBar" align="center" border="0" cellpadding="0" cellspacing="0" height="80%" width="400">
                    <tbody>
                      <tr>
                        <td colspan="2" id="note" height="32"></td>
                      </tr>
                      <tr align="">
                        <td colspan="2" align="center" height="10" width="100%"><div style="width: 300px; height: 15px; font-size: 15px; border: 1px solid rgb(0, 0, 0);" id="progress" align="left">
                            <div id="progress_bar" style="background-color: rgb(170, 187, 204); height: 100%; text-align: center;"></div>
                          </div></td>
                      </tr>
                      <tr>
                        <td colspan="2" id="information" align="center" height="20" width="100%"></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="20" width="100%"><font size="2"> </font></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="left" height="60"></td>
                      </tr>
                    </tbody>
                  </table></td>
                <td rowspan="3" width="78"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
