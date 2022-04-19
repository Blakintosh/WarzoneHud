
require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuHighResContainer")

local function PreLoadFunc(menu, controller)
    menu.disablePopupOpenCloseAnim = true
    menu.disableBlur = true
    menu.disableDarkenElement = true

    Engine.LockInput(controller, true)
    Engine.SetUIActive(controller, true)

	for i = 1, 6 do
		local Mdl = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "keypadMenu"), "inputDigit"..tostring(i))
		Engine.SetModelValue(Mdl, nil)
	end
end

function LUI.createMenu.KeypadMenu(controller)
	local menu = CoD.Menu.NewForUIEditor("KeypadMenu")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "HUD"
    menu.id = "KeypadMenu"
	menu:setOwner(controller)
    menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)
    menu:makeFocusable()
	menu:playSound("menu_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "KeypadMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true

    menu.container = Warzone.KeypadMenuHighResContainer.new(menu, controller)
    menu.container:setScaledLeftRight(false, false, -640, 640)
    menu.container:setScaledTopBottom(false, false, -360, 360)
    menu.container:setScale(1 / _ResolutionScalar)
	menu.container.id = "container"

    menu:addElement(menu.container)
	
	if not menu:restoreState() then
		menu.container:processEvent({name = "gain_focus", controller = controller})
	end

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "ESC", function(ItemRef, HudRef, InstanceRef, ParentRef)
        Engine.SendMenuResponse(InstanceRef, "KeypadMenu", "closed")
        Close(HudRef, InstanceRef)
    end, function(ItemRef, HudRef, InstanceRef)
        CoD.Menu.SetButtonLabel(HudRef, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
        return true
    end, false)
	
	menu:processEvent({
        name = "menu_loaded",
        controller = controller
    })
	
	menu:processEvent({
        name = "update_state",
        menu = menu
    })
    
	local function CloseFunc(self)
		self.container:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "KeypadMenu.buttonPrompts"))
	end

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", CloseFunc)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end

    
    menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)

	return menu
end

