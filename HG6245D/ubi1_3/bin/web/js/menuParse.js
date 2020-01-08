/****************************************************************************************************
 * Filename   : menuParse.js
 * Author     : wuxj
 * Date       : 2013/02/21
 * Description: Get menus from XML and then put into json
 * Copyright  : Copyright 2013, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved.
 *
*****************************************************************************************************/

var Yuzation = {
	data: [],

	/*
	* external API to set resource path and file
	*/
	setMenuDomain: function(project, userType){		
		var URI = window.location.protocol + "//" + window.location.host 
			+ "/menu/" 
			+ project + "/"
			+ userType + ".xml";
		this._getMenusFromXML(URI);
	},
	/*
	* external API to get data
	*/
	getData: function(){
		return this.data;
	},
	/*
	* private function to get menus data from XML
	*/
	_getMenusFromXML: function(URI) {
			
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			var request=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
			var request=new ActiveXObject("Microsoft.XMLHTTP");
		}
		request.open("GET", URI, false); 
		request.send(null);
		
		if(request.status === 200) {
			this.data = this._getSubMenus(1, request.responseXML.documentElement);			
		}
	},
	/*
	* private function to get subMenus from preMenu
	* @param  curLevel: level of current subMenu
	* @param  preMenu:  object of previous level menu
	* @return curMenus: object of current subMenu 
	*/
	_getSubMenus: function(curLevel, preMenu){
		var curMenus;
		
		if(curLevel > 3)
		{
			curMenus = null;
		}
		else
		{
			var tagName = "menu" + curLevel;
			var curMenusArr = preMenu.getElementsByTagName(tagName);
			var curMenuDataArr = [];
			
			for(var i = 0; i < curMenusArr.length; i++) 
			{
				var name = curMenusArr[i].getAttribute("name");
				var url = curMenusArr[i].getAttribute("url");

				var subMenus = this._getSubMenus(curLevel + 1, curMenusArr[i]);
				this._setData(curMenuDataArr, name, url, subMenus);				
			}
			
			curMenus = curMenuDataArr;
		}

		return curMenus;

	},
	/*
	* private function to set data as json
	*/
	_setData: function(curData, nameValue, urlValue, subMenusValue){
		if(subMenusValue == null)
		{
			curData.push({name: nameValue, url: urlValue});
		}
		else
		{
			curData.push({name: nameValue, url: urlValue, subMenus: subMenusValue});
		}
	}

}
