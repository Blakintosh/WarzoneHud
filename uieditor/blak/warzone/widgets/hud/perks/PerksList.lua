require("ui.uieditor.blak.warzone.widgets.hud.perks.Perk")

local WarzonePerkList = {
    juggernaut = "wz_icon_perk_armorvest", 
    bulletdamage = "wz_icon_perk_bulletdamage",
    combat_efficiency = "wz_icon_perk_combat_efficiency",
    extraammo = "wz_icon_perk_extraammo",
    fastmeleerecovery = "wz_icon_perk_fastmeleerecovery",
    sleight_of_hand = "wz_icon_perk_fastreload",
    phdflopper = "wz_icon_perk_phdflopper",
    quick_revive = "wz_icon_perk_quickrevive",
    rof = "wz_icon_perk_rof",
    marathon = "wz_icon_perk_staminup"
}

local PerkInList = function (self, cf_name)
	if self ~= nil then
		for PerkIndex = 1, #self, 1 do
			if self[PerkIndex].properties.key == cf_name then
				return PerkIndex
			end
		end
	end
	return nil
end

local FindPerkIndex = function (self, cf_name, modelValue)
	if self ~= nil then
		for perkIndex = 1, #self, 1 do
			if self[perkIndex].properties.key == cf_name and self[perkIndex].models.status ~= modelValue then
				return perkIndex
			end
		end
	end
	return -1
end

local CheckForPerkChanges = function (self, controller)
	if not self.perksList then
		self.perksList = {}
	end

	local listSizeChanged = false
	local perksModel = Engine.GetModel(Engine.GetModelForController(controller), "hudItems.perks")

	for cf_name, shader in pairs(WarzonePerkList) do
        -- Get status of the perk.
		local modelValue = Engine.GetModelValue(Engine.GetModel(perksModel, cf_name))
		if modelValue ~= nil and 0 < modelValue then
            -- Add perk to perk list if it doesn't exist already
			if not PerkInList(self.perksList, cf_name) then
				table.insert(self.perksList, {models = {image = shader, status = modelValue, newPerk = false}, properties = {key = cf_name}})
				listSizeChanged = true
			end

			local PerkIndex = FindPerkIndex(self.perksList, cf_name, modelValue)
			if 0 < PerkIndex then
                -- Update the perk status at this index
				self.perksList[PerkIndex].models.status = modelValue
				Engine.SetModelValue(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(controller), "WarzonePerks"), tostring(PerkIndex) .. ".status"), modelValue)
			end
		else
            -- Perk no longer valid, remove it from the list if it's in it
            local PerkIndex = PerkInList(self.perksList, cf_name)
            if PerkIndex then
                table.remove(self.perksList, PerkIndex)
                listSizeChanged = true
            end
        end
	end

	if listSizeChanged then
		for ListIndex = 1, #self.perksList, 1 do
			self.perksList[ListIndex].models.newPerk = ListIndex == #self.perksList
		end
        return true
	end

	for ListIndex = 1, #self.perksList, 1 do
		Engine.SetModelValue(Engine.GetModel(perksModel, self.perksList[ListIndex].properties.key), self.perksList[ListIndex].models.status)
	end
    
	return false
end

DataSources.WarzonePerks = DataSourceHelpers.ListSetup("WarzonePerks", function (controller, self)
	CheckForPerkChanges(self, controller)
	return self.perksList
end, true)

local function PreLoadFunc(self, controller)
    local UpdateModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "perkListUpdated")
    Engine.SetModelValue(UpdateModel, 0)

	for cf_name, shader in pairs(WarzonePerkList) do
		self:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems.perks"), cf_name), function (model)
			if CheckForPerkChanges(self.PerkList, controller) then
				self.PerkList:updateDataSource()
                Engine.SetModelValue(UpdateModel, 1 - Engine.GetModelValue(UpdateModel))
			end
		end, false)
	end
end

Warzone.PerksList = InheritFrom(LUI.UIElement)
Warzone.PerksList.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.PerksList)
	self.id = "PerksList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
    
	self.PerkList = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.PerkList:makeFocusable()
	self.PerkList:setLeftRight(true, false, 0, 300)
	self.PerkList:setTopBottom(true, false, 0, 22)
    self.PerkList:setSpacing(4)
	self.PerkList.id = "PerkList"
	self.PerkList:setWidgetType(Warzone.Perk)
	self.PerkList:setHorizontalCount(10)
	self.PerkList:setDataSource("WarzonePerks")
	self:addElement(self.PerkList)

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.PerkList:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end

	return self
end

