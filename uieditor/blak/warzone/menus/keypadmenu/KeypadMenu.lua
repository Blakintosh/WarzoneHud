
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

    menu:addElement(menu.container)

    --[[menu.codeHint = CoD.MWRKeypadCodeFragments.new(menu, controller)
    menu.codeHint:setLeftRight(true, false, 20, 200)
    menu.codeHint:setTopBottom(true, false, 130, 180)
    
    menu:addElement(menu.codeHint)

    menu.keypadMain = CoD.MWRKeypadMain.new(menu, controller)
    menu.keypadMain:setLeftRight(false, false, -400, 400)
    menu.keypadMain:setTopBottom(true, false, 130, 600)

    menu:addElement(menu.keypadMain)

    menu.pinButtons = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    menu.pinButtons:makeFocusable()
    menu.pinButtons.id = "pinButtons"
    menu.pinButtons:setLeftRight(false, false, -300, 300)
    menu.pinButtons:setTopBottom(true, false, 230, 630)
    menu.pinButtons:setWidgetType(CoD.MWRKeypadButton)
    menu.pinButtons:setHorizontalCount(3)
    menu.pinButtons:setVerticalCount(4)
    menu.pinButtons:setSpacing(6)
    menu.pinButtons:setDataSource("MWRKeypadPad")

    menu.pinButtons:registerEventHandler("gain_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        elseif Sender.super.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)
        return ReturnVal
    end)

    menu.pinButtons:registerEventHandler("lose_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        elseif Sender.super.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)
        return ReturnVal
    end) -- Change?
    
    menu:AddButtonCallbackFunction(menu.pinButtons, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, HudRef, InstanceRef, ParentRef)
        local FuncVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "inputFunction"))

        Blak.DebugUtils.Log("8964 UwU")

        if FuncVal then
            Blak.DebugUtils.Log("yeah ok")
            local DigitVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "digit"))
            FuncVal(InstanceRef, DigitVal)
        end
        return true
    end, function(ItemRef, HudRef, InstanceRef)
        CoD.Menu.SetButtonLabel(HudRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, false)

    menu:addElement(menu.pinButtons)]]

    --[[local f1_local11 = CoD.buttonprompt_small.new(HudRef, InstanceRef)
	f1_local11:setLeftRight(true, false, 208, 422)
	f1_local11:setTopBottom(true, false, 515.5, 546.5)
	f1_local11.label:setText(Engine.Localize("MENU_SELECT"))
	f1_local11:subscribeToGlobalModel(InstanceRef, "Controller", "primary_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f1_local11.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	HudRef:addElement(f1_local11)
	HudRef.PromptSelect = f1_local11]]

    --[[HudRef.buttonHints = CoD.MW19ButtonPrompts.new(HudRef, InstanceRef)
    HudRef.buttonHints:setLeftRight(false, false, -400, 400)
    HudRef.buttonHints:setTopBottom(true, false, 550, 600)

    HudRef:addElement(HudRef.buttonHints)

    HudRef.buttonHints:setModel(HudRef.buttonModel, InstanceRef)

    HudRef.buttonHints:addButtonPrompt(HudRef, InstanceRef, "primary_button_image", Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
    HudRef.buttonHints:addButtonPrompt(HudRef, InstanceRef, "secondary_button_image", Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)]]

    --[[local f3_local2 = CoD.FooterButtonPrompt.new(HudRef, InstanceRef)
	f3_local2:setLeftRight(true, false, 88, 168)
	f3_local2:setTopBottom(true, false, 0, 32)
	f3_local2.label:setText(Engine.Localize(""))
	f3_local2.keyPrompt.keybind:setText(Engine.Localize(""))
	f3_local2:subscribeToGlobalModel(InstanceRef, "Controller", "secondary_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f3_local2.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	f3_local2:linkToElementModel(HudRef, "" .. Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, false, function (ModelRef)
		f3_local2:setModel(ModelRef, InstanceRef)
	end)
	HudRef:addElement(f3_local2)
	HudRef.Bbtn = f3_local2]]
    
    if not menu:restoreState() then
		--menu.pinButtons:processEvent({name = "gain_focus", controller = controller})
	end

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "ESC", function(ItemRef, HudRef, InstanceRef, ParentRef)
        Engine.SendMenuResponse(InstanceRef, "KeypadMenu", "closed")
        Close(HudRef, InstanceRef)
    end, function(ItemRef, HudRef, InstanceRef)
        CoD.Menu.SetButtonLabel(HudRef, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
        return true
    end, false)

    menu:registerEventHandler("menu_loaded", function(Sender, Event)
        --CoD.Menu.TestUpdateButtonShownState(Sender, HudRef, InstanceRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        --CoD.Menu.UpdateButtonShownState(Sender, HudRef, Event.controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)
    end)
	
	menu:processEvent({
        name = "menu_loaded",
        controller = controller
    })
	
	menu:processEvent({
        name = "update_state",
        menu = menu
    })
    
	local function CloseFunc(ObjRef)
		--[[ObjRef.codeHint:close()
        ObjRef.keypadMain:close()
		ObjRef.pinButtons:close()]]

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

