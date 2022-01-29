require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickup")

local SetupWaypointContainer = function (self, objective)
	if objective.objId then
		self.objId = objective.objId

		local waypointWidget = self.Waypoint
		waypointWidget.objective = self.objective
		waypointWidget:setupWaypoint(objective)
		--waypointWidget.WaypointCenter.waypointCenterImage:setImage(RegisterImage(waypointWidget.waypoint_image_default))

		local objectiveController = objective.controller
		local objectiveId = self.objId

		if waypointWidget.objective.minimapMaterial ~= nil then
			Engine.SetObjectiveIcon(objectiveController, objectiveId, CoD.GametypeBase.mapIconType, waypointWidget.objective.minimapMaterial)
		else
			Engine.ClearObjectiveIcon(objectiveController, objectiveId, CoD.GametypeBase.mapIconType)
		end

		--[[if waypointWidget.waypoint_label_default == "" then
			waypointWidget.WaypointText:setState("NoText")
		else
			waypointWidget.WaypointText:setState("DefaultState")
		end

		if waypointWidget.objective.hide_arrow then
			waypointWidget.WaypointArrowContainer:setState("Invisible")
		end

		waypointWidget.WaypointText.text:setText(Engine.Localize(waypointWidget.waypoint_label_default))]]
	end
end

local UpdateWaypoint = function (self, objective)
	self.Waypoint:update(objective)
	--[[if objective.objState ~= nil then
		if objective.objState == CoD.OBJECTIVESTATE_DONE then
			self:setState("Done")
		else
			self:setState("Default")
		end
		if self.visible == true then
			self:show()
		else
			self:hide()
		end
	end]]
end

local ShouldShowWaypoint = function (self, objective)
	local objectiveController = objective.controller
	local waypointWidget = self.Waypoint
	local objectiveTeam = Engine.GetObjectiveTeam(objectiveController, self.objId)
	if objectiveTeam == Enum.team_t.TEAM_FREE or objectiveTeam == Enum.team_t.TEAM_NEUTRAL then
		return true
	else
		return waypointWidget:isOwnedByMyTeam(objectiveController)
	end
end

local PostLoadFunc = function (self)
	self.update = UpdateWaypoint
	self.shouldShow = ShouldShowWaypoint
	self.setupWaypointContainer = SetupWaypointContainer
end

Warzone.WeaponPickupContainer = InheritFrom(LUI.UIElement)
Warzone.WeaponPickupContainer.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.WeaponPickupContainer)
	self.id = "WeaponPickupContainer"
	self.soundSet = "default"
	self:setLeftRight(true, false, 0, 1280)
	self:setTopBottom(true, false, 0, 720)
	self.anyChildUsesUpdateState = true
    
	self.Waypoint = Warzone.WeaponPickup.new(menu, controller)
	self.Waypoint:setLeftRight(false, false, -160, 160)
	self.Waypoint:setTopBottom(false, false, -135, 135)

    Wzu.ClipSequence(self, self.Waypoint, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.Waypoint, "Visible", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
	self:addElement(self.Waypoint)
	
	self.clipsPerState = {DefaultState = {DefaultClip = function ()
		Wzu.AnimateSequence(self, "DefaultState")
	end}, Visible = {DefaultClip = function ()
		Wzu.AnimateSequence(self, "Visible")
	end}}

    self:mergeStateConditions({
        {
            stateName = "Visible",
            condition = function(menu, self, event)
                if IsModelValueTrue(controller, "hudItems.showCursorHint") then
                    return not IsModelValueEqualTo(controller, "hudItems.cursorHintText", "")
                end
                return false
            end
        }
    })
    Wzu.SubState(controller, menu, self, "hudItems.showCursorHint")
    Wzu.SubState(controller, menu, self, "hudItems.cursorHintText")

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (sender)
        if sender.Waypoint then
		    sender.Waypoint:close()
        end
	end)

	if PostLoadFunc then
		PostLoadFunc(self)
	end
	return self
end

