

CoD.GetCachedObjective = function (Objective)
	if Objective == nil then
		return nil
	elseif CoD.Zombie.ObjectivesTable[Objective] ~= nil then
		return CoD.Zombie.ObjectivesTable[Objective]
	end

	local Info = Engine.GetObjectiveInfo(Objective)
	if Info ~= nil then
		CoD.Zombie.ObjectivesTable[Objective] = Info
	end

	return Info
end

local SetupWaypoint = function (Sender, Event)
    if Sender.objective.id then
        --[[if Sender.objective.id == "zm_wz_weapon_prompt" then
            Sender.gameTypeContainer = Warzone.WeaponPickupContainer.new(Sender.menu, Event.controller)
        elseif Sender.objective.id == "zm_wz_perk_prompt" then
            Sender.gameTypeContainer = Warzone.PerkPickupContainer.new(Sender.menu, Event.controller)
        else]]
            Sender.gameTypeContainer = CoD.GenericWaypointContainer.new(Sender.menu, Event.controller)
        --end
        Sender.gameTypeContainer:setLeftRight(true, true, 0, 0)
        Sender.gameTypeContainer:setTopBottom(true, true, 0, 0)
                    
        Sender:addElement(Sender.gameTypeContainer)
    end

	Sender.gameTypeContainer.objective = Sender.objective
	Sender.gameTypeContainer:setupWaypointContainer(Event)
end

local PostLoadFunc = function (self, controller, menu)
    local newObjective = function (Sender, Event)
        local objName = Engine.GetObjectiveName(Event.controller, Event.objId)
        local objCached = CoD.GetCachedObjective(objName)
    
        if objCached == nil then
            return 
        elseif Dvar.cg_luiDebug:get() == true then
            DebugPrint("Waypoint ID " .. Event.objId .. ": " .. objName .. ": " .. #Sender.WaypointContainerList .. " waypoints active")
        end
    
        if not Sender.savedStates then
            Sender.savedStates = {}
            Sender.savedEntNums = {}
            Sender.savedObjectiveNames = {}
            Sender.savedTeam = -1
            Sender.savedRound = -1
        end
    
        local objState = Engine.GetObjectiveState(controller, Event.objId)

        local objSaved = Sender.savedStates[Event.objId]
        if not objSaved then
            objSaved = CoD.OBJECTIVESTATE_EMPTY
        end
    
        local objModel = nil
        if Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId) == 0 then
            objModel = Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId)
        else
            objModel = Engine.GetModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "state")
        end
    
        if CoD.GetTeamID(controller) ~= Sender.savedTeam or Engine.GetRoundsPlayed(controller) ~= Sender.savedRound then
            Sender.savedStates = {}
            Sender.savedEntNums = {}
            Sender.savedObjectiveNames = {}
        end
    
        if not CoD.isCampaign and Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) and objState == objSaved and CoD.SafeGetModelValue(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "entNum") == Sender.savedEntNums[Event.objId] and objName == Sender.savedObjectiveNames[Event.objId] then
            if objModel ~= nil then
                Engine.ForceNotifyModelSubscriptions(objModel)
            end
            return 
        elseif objState ~= nil then
            Engine.SetModelValue(objModel, CoD.OBJECTIVESTATE_EMPTY)
            Engine.SetModelValue(objModel, objState)
        end
    
        Sender.savedStates[Event.objId] = objState
        Sender.savedEntNums[Event.objId] = CoD.SafeGetModelValue(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "entNum")
        Sender.savedObjectiveNames[Event.objId] = objName
        Sender.savedTeam = CoD.GetTeamID(controller)
        Sender.savedRound = Engine.GetRoundsPlayed(controller)
    
        if objName then
            Sender.WaypointWidgetContainer = CoD.WaypointWidgetContainer.new(menu, Event.controller)
            Sender.WaypointWidgetContainer.objective = objCached
            Sender.WaypointWidgetContainer.setupWaypoint = SetupWaypoint
            Sender.WaypointWidgetContainer:setupWaypoint(Event)
            Sender.WaypointWidgetContainer:setLeftRight(true, true, 0, 0)
            Sender.WaypointWidgetContainer:setTopBottom(true, true, 0, 0)
    
            Sender:addElement(Sender.WaypointWidgetContainer)
    
            table.insert(Sender.WaypointContainerList, Sender.WaypointWidgetContainer)
            Sender.WaypointWidgetContainer:update(Event)
            Sender.WaypointWidgetContainer:setModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId))
            Sender.WaypointWidgetContainer:subscribeToModel(objModel, function (ModelRef)
                local ModelValue = Engine.GetModelValue(ModelRef)
                Sender.savedStates[Event.objId] = ModelValue
                if ModelValue == CoD.OBJECTIVESTATE_ACTIVE or ModelValue == CoD.OBJECTIVESTATE_CURRENT or ModelValue == CoD.OBJECTIVESTATE_DONE then
                    Sender.WaypointWidgetContainer:show()
                    Sender.WaypointWidgetContainer:update({
                        controller = Event.controller,
                        objState = ModelValue
                    })
                elseif ModelValue == CoD.OBJECTIVESTATE_EMPTY then
                    Sender:removeWaypoint(Event.objId)
                    Sender.savedEntNums[Event.objId] = nil
                else
                    Sender.WaypointWidgetContainer:hide()
                end
            end)
    
            if Engine.GetModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "updateTime") ~= nil then
                Sender.WaypointWidgetContainer:subscribeToModel(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "updateTime"), function (ModelRef)
                    Sender.WaypointWidgetContainer:update({
                        controller = Event.controller
                    })
                end)
            end
    
            Sender.WaypointWidgetContainer:subscribeToModel(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "progress"), function (ModelRef)
                Sender.WaypointWidgetContainer:update({
                    controller = Event.controller,
                    progress = Engine.GetModelValue(ModelRef)
                })
            end)
    
            Sender.WaypointWidgetContainer:subscribeToModel(Engine.GetModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "objective" .. Event.objId), "clientUseMask"), function (ModelRef)
                Sender.WaypointWidgetContainer:update({
                    controller = Event.controller,
                    clientUseMask = Engine.GetModelValue(ModelRef)
                })
            end)
    
            if Engine.GetModel(Engine.GetModelForController(Event.controller), "profile.colorBlindMode") then
                Sender.WaypointWidgetContainer:subscribeToModel(Engine.GetModel(Engine.GetModelForController(Event.controller), "profile.colorBlindMode"), function (ModelRef)
                    Sender.WaypointWidgetContainer:update({
                        controller = Event.controller
                    })
                end, false)
            end
        end
    
        return true
    end

	self.WaypointBase.WaypointContainerList = {}

	CoD.Zombie.ObjectivesTable = Engine.BuildObjectivesTable()
	if CoD.Zombie.ObjectivesTable == nil or #CoD.Zombie.ObjectivesTable == 0 then
		error("LUI Error: Failed to load objectives.json!")
	end

	for index = #CoD.Zombie.ObjectivesTable, 1, -1 do
		CoD.Zombie.ObjectivesTable[CoD.Zombie.ObjectivesTable[index].id] = CoD.Zombie.ObjectivesTable[index]
		table.remove(CoD.Zombie.ObjectivesTable, index)
	end

	self:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(controller), "newObjectiveType" .. Enum.ObjectiveTypes.OBJECTIVE_TYPE_WAYPOINT), function (ModelRef)
		newObjective(self.WaypointBase, {
			controller = controller,
			objId = Engine.GetModelValue(ModelRef),
			objType = Enum.ObjectiveTypes.OBJECTIVE_TYPE_WAYPOINT
		})
	end, false)
end

Warzone.Waypoints = InheritFrom(LUI.UIElement)

function Warzone.Waypoints.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Waypoints)
    self.id = "Waypoints"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    -- Waypoint Shenanigans
    self.GenericWaypointContainer = CoD.GenericWaypointContainer.new(menu, controller)
	self.GenericWaypointContainer:setLeftRight(false, false, -640, 640)
	self.GenericWaypointContainer:setTopBottom(false, false, -360, 360)
	self.GenericWaypointContainer:setAlpha(0)
	self:addElement(self.GenericWaypointContainer)

	
	self.WaypointBase = CoD.WaypointBase.new(menu, controller)
	self.WaypointBase:setLeftRight(false, false, -640, 640)
	self.WaypointBase:setTopBottom(false, false, -360, 360)
    self.WaypointBase:registerEventHandler("menu_loaded", function (Sender, Event)
        SizeToSafeArea(Sender, controller)
        return Sender:dispatchEventToChildren(Event)
    end)
	self:addElement(self.WaypointBase)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.GenericWaypointContainer:close()
        self.WaypointBase:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end