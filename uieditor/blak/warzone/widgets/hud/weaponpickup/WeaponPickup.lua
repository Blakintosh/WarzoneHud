require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupMainBody")

local SetupWaypoint = function (self, objective)
	if objective.objId then
		self:setLeftRight(false, false, 0, 0)
		self:setTopBottom(false, false, 0, 0)
		self.objId = objective.objId
		local objectiveId = self.objective.id
		self.waypoint_label_default = self.objective.waypoint_text

		if self.waypoint_label_default == nil then
			self.waypoint_label_default = ""
		end

		local objectiveProperties = self.objective
		local fadeWhenTargeted
		if objectiveProperties.waypoint_fade_when_targeted ~= "enable" and objectiveProperties.waypoint_fade_when_targeted ~= true then
			fadeWhenTargeted = false
		else
			fadeWhenTargeted = true
		end
		self.waypoint_fade_when_targeted = fadeWhenTargeted
		
        local clampToContainer
		if objectiveProperties.waypoint_clamp ~= "enable" and objectiveProperties.waypoint_clamp ~= true then
			clampToContainer = false
		else
			clampToContainer = true
		end
		self.waypoint_container_clamp = clampToContainer

		local showDistance
		if objectiveProperties.show_distance ~= "enable" and objectiveProperties.show_distance ~= true then
			showDistance = false
		else
			showDistance = true
		end
		self.show_distance = showDistance

		local hideArrow
		if objectiveProperties.hide_arrow ~= "enable" and objectiveProperties.hide_arrow ~= true then
			hideArrow = false
		else
			hideArrow = true
		end
		self.hide_arrow = hideArrow

		self.waypoint_image_default = nil

		if self.objective.waypoint_image ~= nil then
			self.waypoint_image_default = self.objective.waypoint_image
		end

		self:setupWaypointContainer(self.objId)

		if self.waypoint_fade_when_targeted then
			self:setEntityContainerFadeWhenTargeted(true)
		end

		if self.waypoint_container_clamp then
			self:setEntityContainerClamp(true)
		end

		if not self.isClamped then
			--self.WaypointDistanceIndicatorContainer:setAlpha(1)
		end

		local objectiveEntity = Engine.GetObjectiveEntity(objective.controller, objective.objId)

		--local distanceIndicator = self.WaypointDistanceIndicatorContainer.DistanceIndicator

		local objEnt
		if objectiveEntity ~= 0 then
			objEnt = objectiveEntity
		else
			objEnt = objective.objId
		end
		--distanceIndicator:setupDistanceIndicator(objEnt, fadeWhenTargeted == nil, self.show_distance)

		self.snapToCenterWhenContested = true
		self.snapToCenterForObjectiveTeam = true
		self.snapToCenterForOtherTeams = true
		self.updateState = true
		self.zOffset = 0

		if self.objective.waypoint_z_offset ~= nil then
			self.zOffset = self.objective.waypoint_z_offset
		end

		self.pulse = false

		if self.objective.pulse_waypoint ~= nil then
			self.pulse = self.objective.pulse_waypoint == "enable"
		end

		--self.progressMeter:setImage(RegisterMaterial("hud_objective_circle_meter"))

		if self.objId == 0 or self.objId == 2 then
			self:setState("DefaultState")
			--self.CaptureZoneNumberContainer:setState("DefaultState")
			self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(objective.controller), "zmInventory.zc_change_progress_bar_color"), function (model)
				local modelValue = Engine.GetModelValue(model)
				if modelValue == 0 then
					self:setState("NotCapturing")
				elseif modelValue == 1 then
					self:setState("DefaultState")
				end
			end)
		else
			self:setState("NotCapturing")
			--self.CaptureZoneNumberContainer:setState("NotCapturing")
		end

		local objSubstring = tonumber(string.sub(objectiveId, string.len(objectiveId)))
		if objSubstring and 0 < objSubstring then
			--self.CaptureZoneNumberContainer.Number:setImage(RegisterImage("t7_zm_hd_num_" .. objSubstring .. "_glow"))
			--self.CaptureZoneNumberContainer.NumberShadow:setImage(RegisterImage("t7_zm_hd_num_" .. objSubstring .. "_shadow"))
		end
	end
end

local Unused_TeamShenanigans = function (self, probController)
	if Engine.GetTeamID(probController, Engine.GetPredictedClientNum(probController)) ~= Engine.GetObjectiveTeam(probController, self.objId) then
		return false
	else
		return true
	end
end

local Unused_GetObjectiveTeam = function (self, controllerProbably)
	return Engine.GetObjectiveTeam(controllerProbably, self.objId)
end

local GetObjectivePlayerUsing = function (self, controller, f4_arg2, f4_arg3)
	if Engine.IsPlayerInVehicle(controller) == true then
		return false
	elseif Engine.IsPlayerRemoteControlling(controller) == true then
		return false
	elseif Engine.IsPlayerWeaponViewOnlyLinked(controller) == true then
		return false
	else
		return Engine.ObjectiveIsPlayerUsing(controller, self.objId, Engine.GetPredictedClientNum(controller))
	end
end

local f0_local6 = function (f5_arg0, f5_arg1)
	f5_arg0.isClamped = true
	f5_arg0.WaypointArrowContainer:setupEdgePointer(90)
	f5_arg0.WaypointArrowContainer.WaypointArrowWidget:setState("DefaultState")
	local f5_local0 = f5_arg0.WaypointText
	local f5_local1
	if f5_arg0.snapped then
		f5_local1 = 1
		if not f5_local1 then

		else
			f5_local0:setAlpha(f5_local1)
			f5_arg0.WaypointDistanceIndicatorContainer:setAlpha(0)
		end
	end
	f5_local1 = 0
end

local Unused_Unk = function (f6_arg0, f6_arg1)
	f6_arg0.isClamped = false
	f6_arg0.WaypointArrowContainer:setupUIElement()
	f6_arg0.WaypointArrowContainer:setZRot(0)
	f6_arg0.WaypointArrowContainer.WaypointArrowWidget:setState("DefaultState")
	f6_arg0.WaypointText:setAlpha(1)
	f6_arg0.WaypointDistanceIndicatorContainer:setAlpha(1)
end

local Unused_ObjectiveIconShenanigans = function (self, f7_arg1, f7_arg2, f7_arg3, color)
	if f7_arg3 then
		if color then
			Engine.SetObjectiveIcon(f7_arg1, f7_arg2, self.mapIconType, f7_arg3, color.r, color.g, color.b)
			Engine.SetObjectiveIcon(f7_arg1, f7_arg2, CoD.GametypeBase.shoutcasterMapIconType, f7_arg3, color.r, color.g, color.b)
		else
			Engine.SetObjectiveIcon(f7_arg1, f7_arg2, self.mapIconType, f7_arg3)
			Engine.SetObjectiveIcon(f7_arg1, f7_arg2, CoD.GametypeBase.shoutcasterMapIconType, f7_arg3)
		end
		Engine.SetObjectiveIconPulse(f7_arg1, f7_arg2, self.mapIconType, self.pulse)
	else
		Engine.ClearObjectiveIcon(f7_arg1, f7_arg2, self.mapIconType)
		Engine.ClearObjectiveIcon(f7_arg1, f7_arg2, CoD.GametypeBase.shoutcasterMapIconType)
		Engine.SetObjectiveIconPulse(f7_arg1, f7_arg2, self.mapIconType, false)
	end
end

local Unused_ClearObjectiveIcon = function (f8_arg0, f8_arg1, f8_arg2)
	Engine.ClearObjectiveIcon(f8_arg1, f8_arg2, f8_arg0.mapIconType)
	Engine.ClearObjectiveIcon(f8_arg1, f8_arg2, CoD.GametypeBase.shoutcasterMapIconType)
end

local UpdateProgress = function (self, possiblyController, unk, unk1)
	--self.progressMeter:setShaderVector(0, Engine.GetObjectiveProgress(possiblyController, self.objId), 0, 0, 0)
end

local UpdatePlayerUsing = function (self, objective, unk, unk1)
	local playerUsing = GetObjectivePlayerUsing(self, objective.controller, unk, unk1)
	if self.playerUsing == playerUsing then
		return 
	elseif playerUsing == true then
		if self.playerUsing ~= nil then
			self:beginAnimation("snap_in", 250, true, true)
		end
		self.snapped = true
		--self.WaypointText:setAlpha(1)
		self:setEntityContainerStopUpdating(true)
		self:setLeftRight(false, false, -75, 75)
		self:setTopBottom(false, false, 99, 249)
		--self.WaypointArrowContainer:setAlpha(0)
	else
		if self.playerUsing ~= nil then
			self:beginAnimation("snap_out", 250, true, true)
		end
		self.snapped = false
		self:setEntityContainerStopUpdating(false)
		self:setLeftRight(false, false, -160, 160)
		self:setTopBottom(false, false, -70, 70)
		--self.WaypointArrowContainer:setAlpha(1)
	end
	self.playerUsing = playerUsing
end

local Update = function (self, objective)
	local waypointController = objective.controller
	local objectiveId = self.objId
	if Engine.GetObjectiveEntity(waypointController, objectiveId) and not ping then
		self:setupWaypointContainer(objectiveId, 0, 0, self.zOffset)
	else
		local unk, f11_local3, f11_local4 = Engine.GetObjectivePosition(waypointController, objectiveId)
		self:setupWaypointContainer(objectiveId, unk, f11_local3, f11_local4 + self.zOffset)
	end

	local scale3d
	if not self.objective.scale3d or self.objective.scale3d == 0 then
		scale3d = false
	else
		scale3d = true
	end
	self:setEntityContainerScale(scale3d)

	if self.objective.show3dDirectionArrow and self.objective.show3dDirectionArrow ~= 0 then
		--self.WaypointArrowContainer:setup3dPointer(objectiveId)
	end

	local f11_local4 = Engine.GetTeamID(waypointController, Engine.GetPredictedClientNum(waypointController))
	local f11_local5 = Engine.ObjectiveIsTeamUsing(waypointController, objectiveId, f11_local4)
	local f11_local6 = Engine.ObjectiveIsAnyOtherTeamUsing(waypointController, objectiveId, f11_local4)
	self:updatePlayerUsing(objective, f11_local5, f11_local6)
	self:updateProgress(waypointController, f11_local5, f11_local6)
end

-- May need editing
local SetWaypointState = function (self, waypointState)
	if self.animationState == waypointState then
		return 
	elseif waypointState == "waypoint_line_of_sight" then
		self:setAlpha(1)
		--[[self.WaypointArrowContainer.WaypointArrowWidget:setState("SolidArrowState")
		local waypointText = self.WaypointText
		local alphaValue
		if self.snapped or not self.isClamped then
			alphaValue = 1
        else
            alphaValue = 0
		end
        waypointText:setAlpha(alphaValue)]]
	elseif waypointState == "waypoint_out_of_line_of_sight" then
		self:setAlpha(1)
		--[[self.WaypointArrowContainer.WaypointArrowWidget:setState("DefaultState")
		local waypointText = self.WaypointText
		local alphaValue
		if self.snapped or not self.isClamped then
			alphaValue = 1
        else
            alphaValue = 0
		end
        waypointText:setAlpha(alphaValue)]]
	elseif waypointState == "waypoint_distance_culled" then
		self:setAlpha(0)
	end
end

local function PreLoadFunc(self, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectiveWeapon"), "attributes"), "weaponRarity")
end

local PostLoadFunc = function (self, controller)
	self.setupWaypoint = SetupWaypoint
	self.update = Update
	self.updateProgress = UpdateProgress
	self.updatePlayerUsing = UpdatePlayerUsing
	self.SetWaypointState = SetWaypointState
end

local function SubRGBToRarity(self, controller)
    Wzu.Subscribe(self, controller, "prospectiveWeapon.attributes.weaponRarity", function(modelValue)
        if Wzu.Swatches.Rarities[modelValue + 1] then
            Wzu.SetRGBFromTable(self, Wzu.Swatches.Rarities[modelValue + 1])
        else
            Wzu.SetRGBFromTable(self, Wzu.Swatches.Rarities[1])
        end
    end)
end

Warzone.WeaponPickup = InheritFrom(LUI.UIElement)

Warzone.WeaponPickup.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.WeaponPickup)
	self.id = "WeaponPickup"
	self.soundSet = "default"
	self:setLeftRight(true, false, 0, 320)
	self:setTopBottom(true, false, 0, 140)
	self.anyChildUsesUpdateState = true

	self.backgroundUpper = LUI.UIImage.new()
    self.backgroundUpper:setLeftRight(true, true, 0, 0)
    self.backgroundUpper:setTopBottom(true, false, 0, 24)
    self.backgroundUpper:setRGB(0, 0, 0)
    self.backgroundUpper:setAlpha(0.85)

    self:addElement(self.backgroundUpper)

    self.backgroundLower = LUI.UIImage.new()
    self.backgroundLower:setLeftRight(true, true, 0, 0)
    self.backgroundLower:setTopBottom(true, false, 24, 140)
    self.backgroundLower:setRGB(0, 0, 0)
    self.backgroundLower:setAlpha(0.8)

    self:addElement(self.backgroundLower)
    
	self.interiorGlow = LUI.UIImage.new()
    self.interiorGlow:setLeftRight(true, true, 0, 0)
    self.interiorGlow:setTopBottom(true, false, 24, 140)
    self.interiorGlow:setAlpha(0.4)
    self.interiorGlow:setImage(RegisterImage("hud_edge_glow_bottom_left"))
    self.interiorGlow:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.interiorGlow:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    SubRGBToRarity(self.interiorGlow, controller)

    self:addElement(self.interiorGlow)

    self.divider = LUI.UIImage.new()
    self.divider:setLeftRight(true, true, 0, 0)
    self.divider:setTopBottom(true, false, 23, 24)

    SubRGBToRarity(self.divider, controller)

    self:addElement(self.divider)

    self.triangle = LUI.UIImage.new()
    self.triangle:setLeftRight(true, false, 7, 20)
    self.triangle:setTopBottom(true, false, 37, 50)
    self.triangle:setImage(RegisterImage("hud_reticle_triangle_outline_pointright"))

    SubRGBToRarity(self.triangle, controller)

    self:addElement(self.triangle)

    self.bottomBar = LUI.UIImage.new()
    self.bottomBar:setLeftRight(true, true, 0, 0)
    self.bottomBar:setTopBottom(false, true, -1, 0)

    SubRGBToRarity(self.bottomBar, controller)

    self:addElement(self.bottomBar)

    self.bottomGlow = LUI.UIImage.new()
    self.bottomGlow:setLeftRight(true, true, 0, 0)
    self.bottomGlow:setTopBottom(false, true, -8, 8)
    self.bottomGlow:setImage(RegisterImage("hud_glow"))

    SubRGBToRarity(self.bottomGlow, controller)

    self:addElement(self.bottomGlow)

    self.main = Warzone.WeaponPickupMainBody.new(menu, controller)
    self.main:setScaledLeftRight(false, false, -148, 148)
    self.main:setScaledTopBottom(false, false, -60.5, 60.5)
    self.main:setScale(1 / _ResolutionScalar)

    self:addElement(self.main)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(sender)
        if sender.main then
            sender.main:close()
        end
    end)

	if PostLoadFunc then
		PostLoadFunc(self, controller)
	end
	return self
end

