//javascript for login.html
var isEmpty = true;
var gLoginFlag = 0;

$(document).ready(function(){
	//change the stylesheet of login
	showAnimateLine();

	$("#login_tip").css("display", "");
	showAnimateTip("login_tip");

	checkEmpty("login_setup_1_div");
	$(".login-block input").focusin(function(){
	  $(this).parent(".login-block").addClass("login-block-focused");
	});
	$(".login-block input").focusout(function(){
	  $(this).parent(".login-block").removeClass("login-block-focused");
	});

	$(".login-block input").keyup(function(){
		$(this).parents(".login-input").eq(0).find("input").each(function(){
			if($(this).attr("id") == "login_username"){
				return true;
			}
			else{
				if($(this).val() != ""){
					isEmpty = false;
					return false;
				}
				else{
					isEmpty = true;
					return true;
				}
			}
		})
		checkPasswordEmpty($(this).parents(".login-input").eq(0).find("input[type='password']").attr("id"));
		if(isEmpty == true){
			$(".login_block button[type='submit']").attr("disabled", "disabled");
			$("#btn_login_step_2").removeAttr("disabled");
		}else{
			$(".login_block button[type='submit']:not('#btn_login_step_2')").removeAttr("disabled");
		}
	});

	$(".pwd-show-switch").bind("click", function(){
 		if($(this).attr("class").indexOf("filled") != -1){
 			if(9 > judedNavation()){
 				var $pwdInput = $(this).parent(".password_block").find("input");
 				if($pwdInput.attr("type").indexOf("password") != -1){
 					var inputStr = createInput($pwdInput.attr("id"), $pwdInput.attr("name"), "password", "text", $pwdInput.val(),  $pwdInput.attr("class"));
 					$pwdInput.replaceWith($(inputStr));
 					$(this).addClass("open");
 				}else{
 					var inputStr = createInput($pwdInput.attr("id"), $pwdInput.attr("name"), "password", "password", $pwdInput.val(),  $pwdInput.attr("class"));
 					$pwdInput.replaceWith($(inputStr));
 					$(this).removeClass("open");
 				}
 			}else{
 				var $pwd_input = $(this).parent(".password_block").find("input");
		 		if($pwd_input.attr("type") == "password"){
		 			$pwd_input[0].type = "text";
		 			$(this).addClass("open");
		 		}else if($pwd_input.attr("type") == "text"){
					$pwd_input[0].type = "password";
					$(this).removeClass("open");
		 		}else{
		 			$pwd_input[0].type = "password";
		 			$(this).removeClass("open");
	 			}
 			}
 		}
	});
/*
	$("#login_form1").validate({
	debug:true,
	rules: {
		login_username: { required: true},
        login_password: { required: true}
    },
	errorPlacement: function(error, element) { //错误信息位置设置方法
		error.insertAfter( element.parent() );
	},
	messages: {
				  login_username: { required: "请输入用户名"},
                  login_password: { required: "请输入密码"}
			  },
	  submitHandler: function(form){//校验成功回调
	  	console.log("validate login data ok!");
	  },
	  invalidHandler: function(form, validator) {  //校验失败回调
   		console.log("validate login data failed......");
   		return false;
   	  }
	}); 
*/
	
});


function showAnimateTip(id)
{
	$("#"+id).animate({
	   left: 0 
	}, 500);
}

function showAnimateLine()
{
	var speed=6;
    //line2.innerHTML = line1.innerHTML;
    //document.getElementById("line2").innerHTML = document.getElementById("line1").innerHTML;
    function Marquee(){
      if(document.getElementById("line2").offsetWidth-document.getElementById("line").scrollLeft<=0)
        document.getElementById("line").scrollLeft-=document.getElementById("line1").offsetWidth;
      else{
        document.getElementById("line").scrollLeft++;
      }
    }
   	setInterval(Marquee,speed);
}

function checkEmpty(id){
	var emptyFlag = true;
	$("#"+id).find("input").each(function(){
		if($(this).attr("disabled") == "disabled"){
			emptyFlag = "disabled";
			return true;
		}
		else{
			if($(this).val() != ""){
				emptyFlag = false;
				return false;
			}
			else{
				emptyFlag = true;
				return true;
			}
		}
	});

	if(emptyFlag == true){
		$("#"+id).find("input[type='submit']").attr("disabled", "disabled");
	}else{
		$("#"+id).find("input[type='submit']").removeAttr("disabled");
	}

	checkPasswordEmpty($("#"+id).find("input[type='password']").attr("id"));
}

function checkPasswordEmpty(id){
 	if($("#"+id).val() != ""){
 		$("#"+id + "+ .pwd-show-switch").addClass("filled");
 	}
 	else{ 		
 		$("#"+id + "+ .pwd-show-switch").removeClass("filled");
 	}
 }

 function roundFadeOut(){
 	$(".round-bg").fadeOut(1500);
 	setTimeout("roundFadeIn()", 2000);
 }

function roundFadeIn(){
 	$(".round-bg").fadeIn(1500);
 	setTimeout("roundFadeOut()", 2000);
}

var interval;
var process = 0;

function fillConfProcess()
{
	console.log("fill configuration process...");
	interval = setInterval("fillNum()", 150);
}

function fillNum(){
	if(process <= 100){
		$("#conf_process").text(process);
		if(0 < process && 22 >= process){
			$(".conf-notice span").text("正在设置网关...");
		}else if(23 < process && 33 >= process){
			$(".conf-notice span").text("提交配置信息成功!");
		}else if(34 < process && 42 >= process){
			$(".conf-notice span").text("开始下载配置信息!");
		}else if(43 < process && 53 >= process){
			$(".conf-notice span").text("下载配置信息成功!");
		}else if(54 < process && 65 >= process){
			$(".conf-notice span").text("配置网关上行信息...");
		}else if(66 < process && 74 >= process){
			$(".conf-notice span").text("上行信息配置成功~");
		}else if(75 < process && 85 >= process){
			$(".conf-notice span").text("WiFi信息配置成功!");
		}
		else if(86 < process && 100 >= process){
			$(".conf-notice span").text("准备重启启动!");
		}
	}else{
		clearInterval(interval);
		$(".conf-notice span").text("请等待一分钟，即可开始上网~");
		setTimeout("window.location.href='main.html'", 3000);
	}
	process++;
}

function checkFirstLogin()
{
	gLoginFlag = getCookie("loginFlag");
	if(gLoginFlag == 1){
		console.log("Already logged on and configured the device ever!");
		return false;
	}
	else{
		console.log("Never logged on to the device...");
		return true;
	}
}

//javascript 操作 cookie
//写ookies
function setCookie(name,value)
{
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*1000);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
//读取cookies
function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg)){
		return unescape(arr[2]);
	}else{
		return null;	
	}
}

function judedNavation()
{
	if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/6./i)=="6."){ 
		return 6;
	} 
	else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7."){ 
		return 7;
	} 
	else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){ 
		return 8;
	} 
	else if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/9./i)=="9."){ 
		return 9;
	}
	else{
		return 10;
	}
}

function createInput(id, name, placeholder, type, value, classname)
{
	var inputObj = "<input ";
	inputObj += "id='" + id + "' ";
	inputObj += "class='" + classname + "' ";
	inputObj += "name='" + name + "' ";
	inputObj += "placeholder='" + placeholder + "' ";
	inputObj += "type='" + type + "' ";
	inputObj += "value='" + value + "' ";
	inputObj += ">";
	return inputObj;
}