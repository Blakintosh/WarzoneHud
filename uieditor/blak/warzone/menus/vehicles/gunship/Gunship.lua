require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipHighResContainer")

DataSources.GunshipWeapons = DataSourceHelpers.ListSetup("GunshipWeapons", function(InstanceRef)
	local dataTable = {}

	-- 105MM
	table.insert(dataTable, {
		models = {
			reloadTime = 6,
			name = "105MM",
			capacity = 1,
			reloadingModel = "ac130.0.reloading",
			activeModel = "ac130.0.active",
			ammoModel = "ac130.0.ammo"
		}
	})
	-- 40MM
	table.insert(dataTable, {
		models = {
			reloadTime = 4,
			name = "40MM",
			capacity = 5,
			reloadingModel = "ac130.1.reloading",
			activeModel = "ac130.1.active",
			ammoModel = "ac130.1.ammo"
		}
	})
	-- 25MM
	table.insert(dataTable, {
		models = {
			reloadTime = 2,
			name = "25MM",
			capacity = 30,
			reloadingModel = "ac130.2.reloading",
			activeModel = "ac130.2.active",
			ammoModel = "ac130.2.ammo"
		}
	})

    return dataTable
end)

local PostLoadFunc = function (HudRef, InstanceRef)
	HudRef.m_inputDisabled = true
end

local PreLoadFunc = function(HudRef, InstanceRef)
	local model = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130datasourcerefresh")
	Engine.SetModelValue(model, 0)

	Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130")

	-- Create UIModel definitions
	for i = 0, 2 do
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i))
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".reloading")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".active")
		Engine.CreateModel(Engine.GetModelForController(InstanceRef), "ac130."..tostring(i)..".ammo")
	end
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

	-- UI Model subscriptions
	Util.LinkWidgetToUIModel(menu, controller, "105_reloading", "ac130.0.reloading")
	Util.LinkWidgetToUIModel(menu, controller, "40_reloading", "ac130.1.reloading")
	Util.LinkWidgetToUIModel(menu, controller, "25_reloading", "ac130.2.reloading")

	Util.LinkToWidget(menu, menu, "active_weapon", function(modelVal)
		for i = 0, 2 do
			Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "ac130."..i..".active"), (i == modelVal))
		end
	end)

	menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_PCKEY_MWHEELUP, "MWHEELUP", function (widget, menu, controller, parent)
		Console.Print("Yer")
		return true
	end, function (widget, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_PCKEY_MWHEELUP, "MENU_SOCIAL")
		return true
	end, false)
	
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

