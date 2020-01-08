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
 * Frame对象，包含对主页面的元素操作及内容页面的替换
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
     * 页面初始化方法
     */
    init : function() {
        this.initData();
        this.initElement();
    },
    /**
     * 初始化数据，包含MENU元素的索引、页面元素的引用
     */
    initData : function() {
    	var frame = this;
    	
        this.mainMenuCounter = 0;
        this.subMenuCounter = 0;

        this.$mainMenu = $("#headerTab ul");
        this.$subMenu = $("#navsub ul");
        this.$content = $("#frameContent");
        
        // 当内容页面被加载时，重新设置页面的高度
        this.$content.load(function() {
        	frame.$content.show();
          //  frame.setContentHeight();
        });

        // 获取所有菜单项
      /* modify by 吴小娟, 20130222, 原因: 修改为从XML文件读取菜单*/
//     this.menuItems = new Menu(curLanguage, curUserType, sysUserType, productName, manageFlag).getMenuItems();
		Yuzation.setMenuDomain(this.productName, this.curUserType);
		this.menuItems = Yuzation.getData();
    },
    /**
     * 获取远程数据，方式为AJAX同步调用
     */
    getRemoteData : function() {
        
    },
    /**
     * 初始化页面元素
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
     * 添加菜单项
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
                    // 中止浏览器默认事件、中止事件冒泡
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
     * 设置内容页面的路径
     * @param {} url
     */
    setContentPath : function(url) {
    	this.setMenuPath();
		this.setFirstMenu();
    	this.$content.hide();
        this.$content.attr("src", url);
    },
    /**
     * 设置内容页面的高度
     */
    setContentHeight : function() {
        setInterval(function() {
            try {
                var height = 0;
                // IE浏览器
                if (window.ActiveXObject) {
                    height = document.getElementById("frameContent").contentWindow.document.body.scrollHeight;
                }
                // 非IE浏览器
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
     * 设置"面包屑"功能
     */
    setMenuPath : function() {
        $("#topNav #topNavMainMenu").text(MenuName);
        $("#topNav #topNavSubMenu").text(Menu2Path);
        $("#topNav #topNavSub2Menu").text(Menu3Path);
    },
    
	/*设置logo下面的一级菜单*/
    setFirstMenu : function() {
        $("#headerLogoImgmenu").text(MenuName); 
    },
	

	
    /**
     * 设置"Logout"元素的样式
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
     * Logout事件函数
     */
    clickLogout : function() {
    /* modify begin by 吴小娟, 20130304, 原因: GPON SFU 2.0用户注销 */
    /*  var Form = new webSubmitForm();
        Form.setAction('login.asp');
        Form.submit();
    */	
		document.location = "/goform/webLogout";
	/* modify end by 吴小娟, 20130304 */
    },
    /* modify by 吴小娟, 20130222, 原因: 增加入参用户类型、产品名称，用于加载对应菜单 */
	show : function(userType, productName,ispName) {
        var frame = this;
		this.curUserType = userType;
		this.productName = productName;
		
        frame.getRemoteData();
        $(document).ready(function() {
            frame.init();
		if(ispName=="9") /*罗马尼亚02F1G版本需求菜单提示信息*/
		{
			menuTipInfo(userType);/*加载菜单提示信息*/
		}
        });
    }
};
