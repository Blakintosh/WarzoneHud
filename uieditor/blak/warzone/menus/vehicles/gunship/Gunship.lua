--[[require("ui.uieditor.widgets.blak.veh.ac130.blakac130vision")
require("ui.uieditor.widgets.blak.veh.ac130.blakac130weapon")
require("ui.uieditor.widgets.blak.veh.ac130.blakac130crosshair")
require("ui.uieditor.blak_utils.DebugUtils")]]

DataSources.BlakAC130Weapons = DataSourceHelpers.ListSetup("BlakAC130Weapons", function(InstanceRef)
	local dataTable = {}

	for i = 0, 2 do
		local WorkingModel = "ac130."..tostring(i).."."

		table.insert(dataTable, {
			models = {
				reloadTime = WorkingModel.."reloadTime",
				reloading = WorkingModel.."reloading",
				active = WorkingModel.."active",
				name = WorkingModel.."name",
				ammo = WorkingModel.."ammo", --Otherwise it won't refresh when we gert a script notify!
				capacity = WorkingModel.."capacity",
			}
		})
	end

    return dataTable
end)

local PostLoadFunc = function (HudRef, InstanceRef)
	HudRef.m_inputDisabled = true
end

local PreLoadFunc = function(HudRef, InstanceRef)
	local model = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130datasourcerefresh")
	Engine.SetModelValue(model, 0)

	Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130")

	for i = 0, 2 do
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i))
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".reloadTime")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".reloading")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".active")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".name")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".ammo")
		--[[local ScriptNotifyModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".scriptNotify")

		-- This should hopefully mean the script notify is not lost whenever the data source gets refreshed
		HudRef:subscribeToModel(ScriptNotifyModel, function(ModelRef)
			local ModelVal = Engine.GetModelValue(ModelRef)
			if ModelVal then
				LinkModelToScriptNotify(InstanceRef, HudRef, "ac130."..tostring(i)..".ammo", ModelVal)
			end
		end)]]

		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".capacity")
	end
	
    --[[LinkModelToScriptNotify(InstanceRef, HudRef, "ac130.0.ammo", "105_ammo")
    LinkModelToScriptNotify(InstanceRef, HudRef, "ac130.1.ammo", "40_ammo")
    LinkModelToScriptNotify(InstanceRef, HudRef, "ac130.2.ammo", "25_ammo")]]
end

LUI.createMenu.Gunship = function (controller)
	local menu = CoD.Menu.NewForUIEditor("Gunship")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "default"
	menu:setOwner(controller)
	menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "Gunship.buttonPrompts")
    menu.anyChildUsesUpdateState = true

    -- Top right
    menu.killstreakLabel = LUI.UIText.new()
    menu.killstreakLabel:setLeftRight(false, true, -310, -100)
    menu.killstreakLabel:setTopBottom(true, false, 80, 92)
    menu.killstreakLabel:setText("AC-130 ONLINE")
    menu.killstreakLabel:setTTF("fonts/killstreak_regular.ttf")

    menu:addElement(menu.killstreakLabel)

	-- Top left
	menu.visionLabel = CoD.BlakAC130Vision.new(menu, controller)
	menu.visionLabel:setLeftRight(true, false, 100, 400)
	menu.visionLabel:setTopBottom(true, false, 70, 114)

	menu:addElement(menu.visionLabel)

	-- Weapons
	menu.weapons = LUI.UIList.new(menu, controller, 0, 0, nil, false, false, false, 0, 0, false, false)
	menu.weapons:setLeftRight(true, false, 490, 790)
	menu.weapons:setTopBottom(true, false, 550, 650)
	menu.weapons:setWidgetType(CoD.BlakAC130Weapon)
	menu.weapons:setDataSource("BlakAC130Weapons")
	menu.weapons:setHorizontalCount(3)

	menu.weapons:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "ac130datasourcerefresh"), function(ModelRef)
		menu.weapons:updateDataSource()
	end)

	menu:addElement(menu.weapons)

	menu.crosshair = CoD.BlakAC130Crosshair.new(menu, controller)
	menu.crosshair:setLeftRight(false, false, -300, 300)
	menu.crosshair:setTopBottom(true, false, 100, 620)

	menu:addElement(menu.crosshair)
	
	menu:processEvent({name = "menu_loaded", controller = controller})
	menu:processEvent({name = "update_state", menu = menu})

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", function (Sender)
		Sender.visionLabel:close()
		Sender.weapons:close()
		Sender.crosshair:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "Gunship.buttonPrompts"))
	end)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end
	return menu
end

