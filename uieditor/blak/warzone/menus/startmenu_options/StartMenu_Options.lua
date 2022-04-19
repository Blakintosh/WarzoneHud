require("ui.uieditor.blak.warzone.widgets.startmenu_options.startmenu_optionshighrescontainer")
require("ui.uieditor.widgets.startmenu.startmenu_options")

local function PreLoadFunc(menu, controller)
    menu.disablePopupOpenCloseAnim = true
    menu.disableDarkenElement = true

    Engine.LockInput(controller, true)
    Engine.SetUIActive(controller, true)
end

function LUI.createMenu.StartMenu_Options(controller)
    local menu = CoD.Menu.NewForUIEditor("StartMenu_Options")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "iw8"
    menu.id = "StartMenu_Options"
	menu:setOwner(controller)
    menu:setLeftRight(true, false, 0, 1280)
	menu:setTopBottom(true, false, 0, 720)
    menu:makeFocusable()
	menu:playSound("menu_go_back", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "StartMenu_Options.buttonPrompts")
	menu.anyChildUsesUpdateState = true

    menu.container = Warzone.StartMenu_OptionsHighResContainer.new(menu, controller)
    menu.container:setScaledLeftRight(false, false, -640, 640)
    menu.container:setScaledTopBottom(false, false, -360, 360)
    menu.container:setScale(1 / _ResolutionScalar)

    menu:addElement(menu.container)

    menu.options = CoD.StartMenu_Options.new(menu, controller)
    menu.options:setLeftRight(false, false, -575, 575)
    menu.options:setTopBottom(false, false, -260, 260)

    menu.options.id = "options"

    menu:addElement(menu.options)

    Util.SetCursorType(Util.CursorTypes.Normal)
    if not menu:restoreState() then
		menu.options:processEvent({name = "gain_focus", controller = controller})
	end

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
		GoBack(menu, controller)
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
		return true
    end, false)
    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_START, "M", function(ItemRef, menu, controller, ParentRef)
		CloseStartMenu(menu, controller)
		return true
    end, function(ItemRef, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_START, "MENU_DISMISS_MENU")
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
    
	local function CloseFunc(ObjRef)
		ObjRef.container:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "StartMenu_Options.buttonPrompts"))
	end

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", CloseFunc)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end

	return menu
end

