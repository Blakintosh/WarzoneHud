require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipHighResContainer")

DataSources.GunshipWeapons = DataSourceHelpers.ListSetup("GunshipWeapons", function(InstanceRef)
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

    menu.container = Warzone.GunshipHighResContainer.new(menu, controller)
	menu.container:setScaledLeftRight(false, false, -640, 640)
	menu.container:setScaledTopBottom(false, false, -360, 360)
	menu.container:setScale(1 / _ResolutionScalar)

	menu:addElement(menu.container)
	
	menu:processEvent({name = "menu_loaded", controller = controller})
	menu:processEvent({name = "update_state", menu = menu})

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", function (self)
		self.container:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "Gunship.buttonPrompts"))
	end)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end
	
	return menu
end

