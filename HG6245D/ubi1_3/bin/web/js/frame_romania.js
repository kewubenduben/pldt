var sysUserType = '2';

var MenuName = "";
var Menu2Path = "";
var Menu3Path = "";
var manageFlag = 0;

function stManageFlag(ManageFlag)
{
    manageFlag = ManageFlag;
}
/**
 * Frame���󣬰�������ҳ���Ԫ�ز���������ҳ����滻
 * @type Object
 */
var Frame = {
    menuItems : [],
    mainMenuCounter : 0,
    subMenuCounter : 0,
    sub2MenuCounter : 0,
    $mainMenu : null,
    $subMenu : null,
    $content : null,

	curUserType: 0,
	productName: "",
	
    /**
     * ҳ���ʼ������
     */
    init : function() {
        this.initData();
        this.initElement();
    },
    /**
     * ��ʼ�����ݣ�����MENUԪ�ص�������ҳ��Ԫ�ص�����
     */
    initData : function() {
    	var frame = this;
    	
        this.mainMenuCounter = 0;
        this.subMenuCounter = 0;

        this.$mainMenu = $("#headerTab ul");
        this.$subMenu = $("#navsub ul");
        this.$content = $("#frameContent");
        
        // ������ҳ�汻����ʱ����������ҳ��ĸ߶�
        this.$content.load(function() {
        	frame.$content.show();
          //  frame.setContentHeight();
        });

        // ��ȡ���в˵���
      /* modify by ��С��, 20130222, ԭ��: �޸�Ϊ��XML�ļ���ȡ�˵�*/
//     this.menuItems = new Menu(curLanguage, curUserType, sysUserType, productName, manageFlag).getMenuItems();
		Yuzation.setMenuDomain(this.productName, this.curUserType);
		this.menuItems = Yuzation.getData();
    },
    /**
     * ��ȡԶ�����ݣ���ʽΪAJAXͬ������
     */
    getRemoteData : function() {
        
    },
    /**
     * ��ʼ��ҳ��Ԫ��
     */
    initElement : function() {
//    	$("#headerTitle").text(productName);
    	
    	this.setLogoutElement();
    	
        this.addMenuItems(this.$mainMenu, this.menuItems, "main");
        this.addMenuItems(this.$subMenu, this.menuItems[0].subMenus, "sub");
        
        MenuName = _(this.menuItems[0].name);
        Menu2Path = _(this.menuItems[0].subMenus[0].name);
        Menu3Path = _(this.menuItems[0].subMenus[0].subMenus[0].name);
        
        
        this.menuItems[0].subMenus[0]
        
        $("#navsub ul li.subMenu:eq(0)").click();
    },
    /**
     * ��Ӳ˵���
     * @param {} element
     * @param {} menus
     * @param {} type
     */
    addMenuItems : function(element, menus, type) {
        var frame = this;
        if (type == "main") {
            this.mainMenuCounter = 0;
            for (var i = 0, len = menus.length; i < len; i++) {
				/*
                element.append('<li value="' + i + '">' +
                	'<div class="tabBtnLeft"></div>' +
                	'<div class="tabBtnCenter">' + menus[i].name + '</div>' +
                	'<div class="tabBtnRight"></div>' + '</li>');
				*/
				element.append('<li value="' + i + '" id="'+ _(menus[i].name)+'">' + _(menus[i].name) + '</li>');
            }
            element.children("li").eq(0).addClass("selected");
            element.children("li").click(function() {
                if (!element.children("li").eq(this.value).is(".selected")) {
                    element.children("li").eq(frame.mainMenuCounter).removeClass("selected");
                    element.children("li").eq(this.value).addClass("selected");
                    frame.mainMenuCounter = this.value;
                    frame.addMenuItems($("#navsub ul"), menus[this.value].subMenus, "sub");
					
                    MenuName = _(menus[this.value].name);
                    if (menus[this.value].subMenus.length > 0) {
                        Menu2Path = _(menus[this.value].subMenus[0].name);
                    } else {
                        Menu2Path = MenuName;
                    }

                    if (menus[this.value].subMenus[0].subMenus.length > 0) {
                        Menu3Path = _(menus[this.value].subMenus[0].subMenus[0].name);
                    } else {
                        Menu3Path = Menu2Path;
                    }

                    $("#navsub ul li.subMenu:eq(0)").click();
                }
            });
        } else if (type == "sub") {
            frame.subMenuCounter = 0;
            element.empty();
            for (var i = 0, len = menus.length; i < len; i++) {
                element.append('<li class="subMenu" value="' + i + '">' +
                		'<div id="'+_(menus[i].name) +'">' + _(menus[i].name) + '</div></li>');
            }
            element.find("li.subMenu").click(function() {
                element.find("li.subMenu").eq(frame.subMenuCounter).removeClass("hover");
                $(this).addClass("hover");
                frame.subMenuCounter = this.value;
                frame.addMenuItems($(this), menus[this.value].subMenus, "sub2");

                Menu2Path = _(menus[this.value].name);
                if (menus[this.value].subMenus.length > 0) {
                    Menu3Path = _(menus[this.value].subMenus[0].name);
                } else {
                    Menu3Path = Menu2Path;
                }

                frame.setContentPath(menus[this.value].url);
            });
        } else if (type == "sub2") {
            frame.sub2MenuCounter = 0;
            if (element.find("ul").length == 0) {
                element.append("<ul></ul>");
                element.find("ul").empty();
                for (var i = 0, len = menus.length; i < len; i++) {
                    element.find("ul").append('<li class="sub2Menu" value="' + i + '"><div>' + _(menus[i].name) + '</div></li>');
                }
                element.find("ul li.sub2Menu").click(function(event) {
                    // ��ֹ�����Ĭ���¼�����ֹ�¼�ð��
                    if(event) {
                        event.preventDefault();
                        event.stopPropagation();
                    } else if (window.event) {
                        window.event.cancelable = false;
                        window.event.cancelBubble = true;
                    }

                    element.find("ul li.sub2Menu").eq(frame.sub2MenuCounter).removeClass("hover");
                    $(this).addClass("hover");
                    frame.sub2MenuCounter = this.value;

                    Menu3Path = _(menus[this.value].name);

                    frame.setContentPath(menus[this.value].url);
                });
            } else {
                element.find("ul").show();
                element.find("ul li.sub2Menu").removeClass("hover");

                frame.setContentPath(menus[frame.sub2MenuCounter].url);
            }
            element.find("ul li.sub2Menu").eq(frame.sub2MenuCounter).addClass("hover");
            frame.$subMenu.find("li").not(element).find("ul").hide();
        }
    },
    /**
     * ��������ҳ���·��
     * @param {} url
     */
    setContentPath : function(url) {
    	this.setMenuPath();
		this.setFirstMenu();
    	this.$content.hide();
        this.$content.attr("src", url);
    },
    /**
     * ��������ҳ��ĸ߶�
     */
    setContentHeight : function() {
        setInterval(function() {
            try {
                var height = 0;
                // IE�����
                if (window.ActiveXObject) {
                    height = document.getElementById("frameContent").contentWindow.document.body.scrollHeight;
                }
                // ��IE�����
                else if (window.XMLHttpRequest) {
                    height = document.getElementById("frameContent").contentWindow.document.body.offsetHeight;
                }
                height = Math.max(height, 470);
                $("#center").height(height + 25);
                $("#navsub").height(height + 25);
                $("#content").height(height + 25);
                $("#frameWarpContent").height(height);
                $("#frameContent").height(height);
            } catch (e) {
            }
        }, 200);
    },
    /**
     * ����"���м"����
     */
    setMenuPath : function() {
        $("#topNav #topNavMainMenu").text(MenuName);
        $("#topNav #topNavSubMenu").text(Menu2Path);
        $("#topNav #topNavSub2Menu").text(Menu3Path);
    },
    
	/*����logo�����һ���˵�*/
    setFirstMenu : function() {
        $("#headerLogoImgmenu").text(MenuName); 
    },
	

	
    /**
     * ����"Logout"Ԫ�ص���ʽ
     */
    setLogoutElement : function() {
    	var frame = this;
    	
        $("#headerLogout span").mouseover(function() {
            $("#headerLogout span").css({
                "color" : "#66b32e",
                "text-decoration" : "underline"
            });
        });
        $("#headerLogout span").mouseout(function() {
            $("#headerLogout span").css({
                "color" : "#FFFFFF",
                "text-decoration" : "none"
            });
        });
        $("#headerLogout span").click(function() {
			frame.clickLogout();
        });
    },
    /**
     * Logout�¼�����
     */
    clickLogout : function() {
    /* modify begin by ��С��, 20130304, ԭ��: GPON SFU 2.0�û�ע�� */
    /*  var Form = new webSubmitForm();
        Form.setAction('login.asp');
        Form.submit();
    */	
		document.location = "/goform/webLogout";
	/* modify end by ��С��, 20130304 */
    },
    /* modify by ��С��, 20130222, ԭ��: ��������û����͡���Ʒ���ƣ����ڼ��ض�Ӧ�˵� */
	show : function(userType, productName,ispName) {
        var frame = this;
		this.curUserType = userType;
		this.productName = productName;
		
        frame.getRemoteData();
        $(document).ready(function() {
            frame.init();
		if(ispName=="9") /*��������02F1G�汾����˵���ʾ��Ϣ*/
		{
			menuTipInfo(userType);/*���ز˵���ʾ��Ϣ*/
		}
        });
    }
};
