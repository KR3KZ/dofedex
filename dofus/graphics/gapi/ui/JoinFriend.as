if(!dofus.graphics.gapi.ui.JoinFriend)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.graphics)
	{
		_global.dofus.graphics = new Object();
	}
	if(!dofus.graphics.gapi)
	{
		_global.dofus.graphics.gapi = new Object();
	}
	if(!dofus.graphics.gapi.ui)
	{
		_global.dofus.graphics.gapi.ui = new Object();
	}
	dofus.graphics.gapi.ui.JoinFriend = function()
	{
		super();
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var var1 = dofus.graphics.gapi.ui.JoinFriend = function()
	{
		super();
	}.prototype;
	var1.__set__servers = function __set__servers(var2)
	{
		this._eaServers = var2;
		return this.__get__servers();
	};
	var1.__set__remainingTime = function __set__remainingTime(var2)
	{
		this._nRemainingTime = var2;
		return this.__get__remainingTime();
	};
	var1.init = function init()
	{
		super.init(false,dofus.graphics.gapi.ui.JoinFriend.CLASS_NAME);
	};
	var1.createChildren = function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	};
	var1.addListeners = function addListeners()
	{
		var ref = this;
		this._mcDirectPlay.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this._btnSearch.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		var var2 = new Object();
		var2.onSetFocus = function(var2, var3)
		{
			if(eval(Selection.getFocus())._parent == ref._tiSearch)
			{
				if(ref._tiSearch.text == ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE"))
				{
					ref._tiSearch.text = "";
				}
			}
			else if(ref._tiSearch.text == "")
			{
				ref._tiSearch.text = ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE");
			}
		};
		Selection.addListener(var2);
	};
	var1.initTexts = function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("JOIN_FRIEND_SERVER");
		this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
		this._lblDirectPlay.text = this.api.lang.getText("DIRECT_PLAY");
		this._lblDownload.text = this.api.lang.getText("JOIN_FRIEND_INVITE");
	};
	var1.getLessPopulatedServer = function getLessPopulatedServer(var2)
	{
		if(var2.length == 1)
		{
			return var2[0].id;
		}
		var2.sortOn("populationWeight",Array.NUMERIC | Array.ASCENDING);
		var var3 = var2[0].populationWeight;
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var2.length)
		{
			if(var2[var5].populationWeight == var3)
			{
				var4.push(var2[var5]);
			}
			var5 = var5 + 1;
		}
		var4.sortOn("completion",Array.NUMERIC | Array.ASCENDING);
		var var6 = var4[0].completion;
		var var7 = new ank.utils.();
		var var8 = 0;
		while(var8 < var4.length)
		{
			if(var4[var8].completion == var6)
			{
				var7.push(var4[var8]);
			}
			var8 = var8 + 1;
		}
		return var7[Math.round(Math.random() * (var7.length - 1))].id;
	};
	var1.selectServer = function selectServer(var2)
	{
		this.gapi.loadUIComponent("ServerInformations","ServerInformations",{server:var2});
		this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected",this);
		this.gapi.getUIComponent("ServerInformations").addEventListener("canceled",this);
	};
	var1.findFriend = function findFriend()
	{
		if(this._tiSearch.text == this.api.lang.getText("PSEUDO_DOFUS_SIMPLE") || !this._tiSearch.text.length)
		{
			return undefined;
		}
		this.api.network.Account.searchForFriend(this._tiSearch.text);
	};
	var1.onShortcut = function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
		{
			this.click({target:this._btnSearch});
			return false;
		}
		return true;
	};
	var1.click = function click(var2)
	{
		switch(var2.target._name)
		{
			case "_mcAutomaticSelect":
				var var3 = new ank.utils.();
				var var4 = 0;
				while(var4 < this._eaServers.length)
				{
					if(this._eaServers[var4].state == dofus.datacenter.Server.SERVER_ONLINE && this._eaServers[var4].isAllowed())
					{
						var3.push(this._eaServers[var4]);
					}
					var4 = var4 + 1;
				}
				if(var3.length <= 0)
				{
					§§push("ERROR_BOX");
					§§push("ALL_SERVERS_ARE_DOWN");
					§§push(1);
					§§push(this.api);
					§§push("lang");
				}
				else
				{
					var var5 = new ank.utils.();
					var var6 = 0;
					while(var6 < var3.length)
					{
						if(var3[var6].canLog && (var3[var6].typeNum == dofus.datacenter.Server.SERVER_CLASSIC || var3[var6].typeNum == dofus.datacenter.Server.SERVER_RETRO))
						{
							var5.push(var3[var6]);
						}
						var6 = var6 + 1;
					}
					var3 = var5;
					if(var3.length <= 0)
					{
						if(this._nRemainingTime <= 0)
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_NOT_FULL_MEMBER"),"ERROR_BOX");
						}
						else
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_FULL_MEMBER"),"ERROR_BOX");
						}
						break;
					}
					this._eaPreselectedServers = var3;
					var5 = new ank.utils.();
					var var7 = 0;
					while(var7 < var3.length)
					{
						if(var3[var7].community == this.api.datacenter.Basics.communityId || var3[var7].community == dofus.datacenter.Server.SERVER_COMMUNITY_INTERNATIONAL)
						{
							var5.push(var3[var7]);
						}
						var7 = var7 + 1;
					}
					var3 = var5;
					if(var3.length <= 0)
					{
						if(this._nRemainingTime <= 0)
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_NOT_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
						}
						else
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
						}
						break;
					}
					this.selectServer(this.getLessPopulatedServer(var3));
					break;
				}
			default:
				this.api.kernel.showMessage(undefined,§§pop()[§§pop()].getText(),§§pop());
				break;
			case "_mcManualSelect":
				this.api.datacenter.Basics.forceManualServerSelection = true;
				this.api.network.Account.getServersList();
				break;
			case "_btnSearch":
				this.findFriend();
		}
	};
	var1.yes = function yes(var2)
	{
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < this._eaPreselectedServers.length)
		{
			if(this._eaPreselectedServers[var4].community == 2)
			{
				var3.push(this._eaPreselectedServers[var4]);
			}
			var4 = var4 + 1;
		}
		if(var3.length > 0)
		{
			this.selectServer(this.getLessPopulatedServer(var3));
		}
		else
		{
			this.selectServer(this.getLessPopulatedServer(this._eaPreselectedServers));
		}
	};
	var1.serverSelected = function serverSelected(var2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
		var var3 = new dofus.datacenter.	(var2.value,1,0);
		if(var3.isAllowed())
		{
			this.api.datacenter.Basics.aks_current_server = var3;
			this.api.datacenter.Basics.createCharacter = true;
			this.api.network.Account.setServer(var2.value);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"),"ERROR_BOX");
		}
	};
	var1.canceled = function canceled(var2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
	};
	var1["\x02\x10\x14"]("\t)",function()
	{
	}
	,var1.__set__remainingTime);
	var1["\x02\x10\x14"]("H\x02�\x04",function()
	{
	}
	,var1[""]);
	eval("\x04\x02\b7N�\x05")(var1,null,1);
	dofus.graphics.gapi.ui.JoinFriend = function()
	{
		super();
	}[""] = "3";
	dofus.graphics.gapi.ui.JoinFriend = function()
	{
		super();
	}["\x07\x01"] = 500;
}
