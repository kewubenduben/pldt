/****************************************************************************************************
 * Filename   : menu_tips.js
 * Author     : 白志旺
 * Date       : 2016/09/13
 * Description: Set menu tips information
 * Copyright  : Copyright 2013, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved.
 *
*****************************************************************************************************/

      /**
     * 设置提示框的风格
     */

function tipsStyle(event)
{
    x=event.screenX;
    y=event.screenY;
    $("#blockdiv").css({
    "color":"white",
    "background-color":"#66b32e",
    "font-family":"Arial",
    "font-size":"80%",
    "padding":"5px",
    "left":x+15,
    "top":y-70,
    "border-radius":"10px",
    "width":"300px",
    "height":"60px",
    "position":"absolute"
    });
}

/**
*显示提示信息
*/
function tipsDisplay()
{
    $("#blockdiv").css("display","block");
}



var time_id;

function menuTipInfo(user_type) /*user_type=1:表示普通用户级别；user_type=2:表示维护用户级别*/
{
    $("ul li").mouseover(function(event){

    var menuPara=$(this).attr("id");
    if(menuPara=="Status" ||menuPara=="Settings"||menuPara=="Security"||menuPara=="Application"||menuPara=="Management")
    {
        tipsStyle(event);/*设置提示框的风格*/
        time_id = setTimeout('tipsDisplay()',1000);/*鼠标放在菜单按钮上1秒超时时显示提示信息*/
    }

    if(user_type=="2") /*维护用户登录后菜单提示信息*/
    {
        /*显示提示信息*/
        if(menuPara=="Status")
        {	
            document.getElementById("blockdiv").innerHTML="<p>You can browse Device Info,Optical Power and State of WIFI ,WAN ,LAN ,PON ,VOIP</p>";
        }
        else if(menuPara=="Settings")
        {
            document.getElementById("blockdiv").innerHTML="<p>You can set WIFI, LAN ,WAN, VOIP,DHCP Server, Remote Management,Authentication</p>";
        }
        else if(menuPara=="Security")
        {
            document.getElementById("blockdiv").innerHTML="<p>You can set Firewall,Remote Control,DDOS and HTTPS</p>";
        }
        else if(menuPara=="Application")
        {
            document.getElementById("blockdiv").innerHTML="<p>You can set DDNS,Port Forwarding,UPNP,DMZ and Diagnosis</p>";
        }
        else if(menuPara=="Management")
        {
            document.getElementById("blockdiv").innerHTML="<p>You can do: modify User Accout,Reboot Device,Local Upgrade,Config Backup,Restore Factory Setting</p>";
        }

    }
    else if (user_type=="1")/*普通用户登录后菜单提示信息*/
    {
        /*显示提示信息*/
        if(menuPara=="Status")
        {
        document.getElementById("blockdiv").innerHTML="<p>You can browse Device Info,Optical Power and State of WIFI ,WAN ,LAN ,PON ,VOIP</p>";
        }
        else if(menuPara=="Settings")
        {
        document.getElementById("blockdiv").innerHTML="<p>You can do WIFI Settings:Open/Close WiFI,Select SSID,WPA Algorithms and Security Policy,Config SSID Name and Password</p>";
        }
        else if(menuPara=="Management")
        {
        document.getElementById("blockdiv").innerHTML="<p>You can do Account Management and Reboot Device</p>";
        }
    }

    });

    $("ul li").mouseout(function(){
    var menuPara=$(this).attr("id");
    if(menuPara=="Status" ||menuPara=="Settings"||menuPara=="Security"||menuPara=="Application"||menuPara=="Management")
    {
        $("#blockdiv").css("display","none"); /*鼠标移出菜单按钮时，使提示框消失*/

        /*鼠标移出时，取消定时器，即如果鼠标在菜单按钮上停留的时间
        小于1秒，就不再弹出提示框
        */
        clearTimeout(time_id);
    }

    });

    $("ul li").click(function(){
    var menuPara=$(this).attr("id");
    if(menuPara=="Status" ||menuPara=="Settings"||menuPara=="Security"||menuPara=="Application"||menuPara=="Management")
    {
        $("#blockdiv").css("display","none"); /*鼠标点击菜单按钮时，使提示框消失*/

        /*鼠标点击菜单按钮时，取消定时器，即如果鼠标点击事件发生，在菜单按钮上停留的时，就不再弹出提示框
        */
        clearTimeout(time_id);
    }

    });

}

