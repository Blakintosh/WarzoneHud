require("ui.uieditor.blak.warzone.widgets.hud.powerups.Powerup")

local WarzonePowerupList = {
    powerup_instant_kill = "ui_mp_br_timer_event_instakill", 
    powerup_double_points = "ui_mp_br_timer_event_doublepoints",
    powerup_fire_sale = "ui_mp_br_timer_event_firesale",
    powerup_mini_gun = "ui_mp_br_timer_event_juggernaut"
}

local PowerupInList = function (self, cf_name)
	if self ~= nil then
		for PowerupIndex = 1, #self, 1 do
			if self[PowerupIndex].properties.key == cf_name then
				return PowerupIndex
			end
		end
	end
	return nil
end

local FindPowerupIndex = function (self, cf_name, modelValue)
	if self ~= nil then
		for powerupIndex = 1, #self, 1 do
			if self[powerupIndex].properties.key == cf_name and self[powerupIndex].models.timeLeft ~= modelValue then
				return powerupIndex
			end
		end
	end
	return -1
end

local CheckForPowerupChanges = function (self, controller)
	if not self.powerupsList then
		self.powerupsList = {}
	end

    local listSizeChanged = false
	local powerupsModel = Engine.GetModel(Engine.GetModelForController(controller), "hudItems.powerups")
    
	for cf_name, shader in pairs(WarzonePowerupList) do
        -- Get status of the powerup.
		local modelValue = Engine.GetModelValue(Engine.GetModel(powerupsModel, cf_name))
		if modelValue ~= nil and 0 < modelValue then
            -- Add powerup to powerup list if it doesn't exist already
			if not PowerupInList(self.powerupsList, cf_name) then
				table.insert(self.powerupsList, {models = {image = shader, status = 1, timeLeft = modelValue, newPowerup = false}, properties = {key = cf_name}})
				listSizeChanged = true
			end
            local PowerupIndex = FindPowerupIndex(self.powerupsList, cf_name)
			if 0 < PowerupIndex then
                -- Update the powerup status at this index
				self.powerupsList[PowerupIndex].models.status = 1
                self.powerupsList[PowerupIndex].models.timeLeft = modelValue
				Engine.SetModelValue(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(controller), "WarzonePowerups"), tostring(PowerupIndex) .. ".status"), 1)
                Engine.SetModelValue(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(controller), "WarzonePowerups"), tostring(PowerupIndex) .. ".timeLeft"), modelValue)
                listSizeChanged = true
			end
		else
            -- Powerup no longer valid, remove it from the list if it's in it
            local PowerupIndex = PowerupInList(self.powerupsList, cf_name)
            if PowerupIndex then
                table.remove(self.powerupsList, PowerupIndex)
                listSizeChanged = true
            end
        end
	end

	if listSizeChanged then
		for ListIndex = 1, #self.powerupsList, 1 do
			self.powerupsList[ListIndex].models.newPowerup = ListIndex == #self.powerupsList
		end
        return true
	end

	for ListIndex = 1, #self.powerupsList, 1 do
		Engine.SetModelValue(Engine.GetModel(powerupsModel, self.powerupsList[ListIndex].properties.key), self.powerupsList[ListIndex].models.status)
	end
    
	return false
end

DataSources.WarzonePowerups = DataSourceHelpers.ListSetup("WarzonePowerups", function (controller, self)
	CheckForPowerupChanges(self, controller)
	return self.powerupsList
end, true)

local function PreLoadFunc(self, controller)

	for cf_name, shader in pairs(WarzonePowerupList) do
		self:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems.powerups"), cf_name), function (model)
            if CheckForPowerupChanges(self.PowerupList, controller) then
				self.PowerupList:updateDataSource()
			end
		end, false)
	end
end

Warzone.PowerupsList = InheritFrom(LUI.UIElement)
Warzone.PowerupsList.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.PowerupsList)
	self.id = "PowerupsList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
    
	self.PowerupList = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.PowerupList:makeFocusable()
	self.PowerupList:setLeftRight(false, false, -400, 400)
	self.PowerupList:setTopBottom(true, false, 0, 40)
    self.PowerupList:setSpacing(4)
	self.PowerupList.id = "PowerupList"
	self.PowerupList:setWidgetType(Warzone.Powerup)
	self.PowerupList:setHorizontalCount(4)
	self.PowerupList:setDataSource("WarzonePowerups")
	self:addElement(self.PowerupList)

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.PowerupList:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end

	return self
end

