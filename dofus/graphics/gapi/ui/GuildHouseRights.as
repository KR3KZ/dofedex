class dofus.graphics.gapi.ui.GuildHouseRights extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildHouseRights";
	function GuildHouseRights()
	{
		super();
	}
	function __set__house(var2)
	{
		this._hHouse = var2;
		return this.__get__house();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.GuildHouseRights.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("GUILD_HOUSE");
		this._lblAddThisHouseToGuildSystem.text = this.api.lang.getText("GUILD_HOUSE_ENABLE_FOR_THIS_HOUSE");
		this._lblGuildHouseNotice.text = this.api.lang.getText("GUILD_HOUSE_NOTICE");
		this._lblDisplayEmblemTitle.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_ON_DOOR_TITLE") + ":";
		this._lblDisplayLabelForOthers.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_FOR_OTHERS");
		this._lblDisplayLabelForGuild.text = this.api.lang.getText("GUILD_HOUSE_DISPLAY_EMBLEM_FOR_GUILD");
		this._lblHouseAccessTitle.text = this.api.lang.getText("GUILD_HOUSE_HOUSE_ACCESS_TITLE") + ":";
		this._lblAllowGuildToAccessHouse.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_HOUSE_ALLOW_GUILDMATES");
		this._lblDenyOtherToAccessHouse.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_HOUSE_DENY_OTHERS");
		this._lblSafesAccessTitle.text = this.api.lang.getText("GUILD_HOUSE_SAFES_ACCESS_TITLE") + ":";
		this._lblAllowGuildToAccessSafes.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_SAFES_ALLOW_GUILDMATES");
		this._lblDenyOtherToAccessSafes.text = this.api.lang.getText("GUILD_HOUSE_ACCESS_SAFES_DENY_OTHERS");
		this._lblOtherTitle.text = this.api.lang.getText("GUILD_HOUSE_OTHER_TITLE") + ":";
		this._lblAllowRespawn.text = this.api.lang.getText("GUILD_HOUSE_ALLOW_RESPAWN");
		this._lblAllowTeleport.text = this.api.lang.getText("GUILD_HOUSE_ALLOW_TELEPORT");
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnEnableHouseSharing.addEventListener("click",this);
		this._btnShowEmblemForOthers.addEventListener("click",this);
		this._btnShowEmblemForGuild.addEventListener("click",this);
		this._btnAllowGuildToAccessHouse.addEventListener("click",this);
		this._btnDenyOtherToAccessHouse.addEventListener("click",this);
		this._btnAllowGuildToAccessSafes.addEventListener("click",this);
		this._btnDenyOtherToAccessSafes.addEventListener("click",this);
		this._btnAllowRespawn.addEventListener("click",this);
		this._btnAllowTeleport.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._hHouse.addEventListener("shared",this);
		this._hHouse.addEventListener("guild",this);
	}
	function initData()
	{
		this.api.network.Houses.state();
	}
	function update()
	{
		this._btnEnableHouseSharing.selected = this._hHouse.isShared;
		this._btnShowEmblemForGuild.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_DOORSIGN_GUILD);
		this._btnShowEmblemForOthers.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_DOORSIGN_OTHERS);
		this._btnAllowGuildToAccessHouse.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_ALLOWDOOR_GUILD);
		this._btnDenyOtherToAccessHouse.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_FORBIDDOOR_OTHERS);
		this._btnAllowGuildToAccessSafes.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_ALLOWCHESTS_GUILD);
		this._btnDenyOtherToAccessSafes.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_FORBIDCHESTS_OTHERS);
		this._btnAllowRespawn.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_RESPAWN);
		this._btnAllowTeleport.selected = this._hHouse.isShared && this._hHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT);
		this._mcMask._visible = !this._btnEnableHouseSharing.selected;
		this._eEmblem.data = this.api.datacenter.Player.guildInfos.emblem;
	}
	function validate()
	{
		var var2 = 0;
		if(this._btnShowEmblemForGuild.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_DOORSIGN_GUILD;
		}
		if(this._btnShowEmblemForOthers.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_DOORSIGN_OTHERS;
		}
		if(this._btnAllowGuildToAccessHouse.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_ALLOWDOOR_GUILD;
		}
		if(this._btnDenyOtherToAccessHouse.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_FORBIDDOOR_OTHERS;
		}
		if(this._btnAllowGuildToAccessSafes.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_ALLOWCHESTS_GUILD;
		}
		if(this._btnDenyOtherToAccessSafes.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_FORBIDCHESTS_OTHERS;
		}
		if(this._btnAllowRespawn.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_RESPAWN;
		}
		if(this._btnAllowTeleport.selected)
		{
			var2 = var2 + dofus.datacenter.House.GUILDSHARE_TELEPORT;
		}
		this.api.network.Houses.rights(var2);
		this.unloadThis();
	}
	function guild(var2)
	{
		this.update();
	}
	function shared(var2)
	{
		this.update();
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnEnableHouseSharing:
				if(this._btnEnableHouseSharing.selected)
				{
					this.api.network.Houses.share();
				}
				else
				{
					this.api.network.Houses.unshare();
				}
				break;
			case this._btnValidate:
				this.validate();
				break;
			default:
				if(var0 !== this._btnCancel)
				{
					break;
				}
			case this._btnClose:
				this.unloadThis();
		}
	}
}
