/****************************************************************************************************
 * Filename   : menu_tips.js
 * Author     : ��־��
 * Date       : 2016/09/13
 * Description: Set menu tips information
 * Copyright  : Copyright 2013, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved.
 *
*****************************************************************************************************/

      /**
     * ������ʾ��ķ��
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
*��ʾ��ʾ��Ϣ
*/
function tipsDisplay()
{
    $("#blockdiv").css("display","block");
}



var time_id;

function menuTipInfo(user_type) /*user_type=1:��ʾ��ͨ�û�����user_type=2:��ʾά���û�����*/
{
    $("ul li").mouseover(function(event){

    var menuPara=$(this).attr("id");
    if(menuPara=="Status" ||menuPara=="Settings"||menuPara=="Security"||menuPara=="Application"||menuPara=="Management")
    {
        tipsStyle(event);/*������ʾ��ķ��*/
        time_id = setTimeout('tipsDisplay()',1000);/*�����ڲ˵���ť��1�볬ʱʱ��ʾ��ʾ��Ϣ*/
    }

    if(user_type=="2") /*ά���û���¼��˵���ʾ��Ϣ*/
    {
        /*��ʾ��ʾ��Ϣ*/
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
    else if (user_type=="1")/*��ͨ�û���¼��˵���ʾ��Ϣ*/
    {
        /*��ʾ��ʾ��Ϣ*/
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
        $("#blockdiv").css("display","none"); /*����Ƴ��˵���ťʱ��ʹ��ʾ����ʧ*/

        /*����Ƴ�ʱ��ȡ����ʱ�������������ڲ˵���ť��ͣ����ʱ��
        С��1�룬�Ͳ��ٵ�����ʾ��
        */
        clearTimeout(time_id);
    }

    });

    $("ul li").click(function(){
    var menuPara=$(this).attr("id");
    if(menuPara=="Status" ||menuPara=="Settings"||menuPara=="Security"||menuPara=="Application"||menuPara=="Management")
    {
        $("#blockdiv").css("display","none"); /*������˵���ťʱ��ʹ��ʾ����ʧ*/

        /*������˵���ťʱ��ȡ����ʱ���������������¼��������ڲ˵���ť��ͣ����ʱ���Ͳ��ٵ�����ʾ��
        */
        clearTimeout(time_id);
    }

    });

}

