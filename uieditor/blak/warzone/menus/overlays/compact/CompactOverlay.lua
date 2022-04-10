require("ui.uieditor.blak.warzone.widgets.overlays.compact.compactoverlayhighrescontainer")

local PostLoadFunc = function (menu, controller)
	menu.disablePopupOpenCloseAnim = true
end

LUI.createMenu.CompactOverlay = function (controller)
	local menu = CoD.Menu.NewForUIEditor("CompactOverlay")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "iw8"
	menu:setOwner(controller)
	menu:setLeftRight(true, false, 0, 1280)
	menu:setTopBottom(true, false, 0, 720)
    menu:makeFocusable()
	menu:playSound("popup_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "CompactOverlay.buttonPrompts")
	menu.onlyChildrenFocusable = true
    menu.anyChildUsesUpdateState = true

    menu.contents = Warzone.CompactOverlayHighResContainer.new(menu, controller)
    menu.contents:setScaledLeftRight(false, false, -640, 640)
    menu.contents:setScaledTopBottom(false, false, -360, 360)
    menu.contents:setScale(1 / _ResolutionScalar)

    menu.contents:linkToElementModel(menu, nil, false, function (model)
		menu.contents:setModel(model, controller)
	end)

    Wzu.ClipSequence(menu, menu.contents, "Default", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.outBounce,
            setAlpha = 1
        }
    })

    menu:addElement(menu.contents)

    menu.contents.id = "contents"
	
	menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function (self, menu, controller, super)
		return true
	end, function (self, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "")
		return false
	end, false)
	menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function (self, menu, controller, super)
        if HasOverlayBackAction(menu) then
			PerformOverlayBack(menu, self, controller, menu)
			return true
		end
        return false
	end, function (f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
		if HasOverlayBackAction(f7_arg1) then
			return true
		else
			return false
		end
	end, false)

	menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBX_PSSQUARE, nil, function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		return true
	end, function (f9_arg0, menu, f9_arg2)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBX_PSSQUARE, "")
		return false
	end, false)
	menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, nil, function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		return true
	end, function (f11_arg0, menu, f11_arg2)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "")
		return false
	end, false)

    menu.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(menu, "Default")
            end
        }
    }

	menu:processEvent({name = "menu_loaded", controller = controller})
	menu:processEvent({name = "update_state", menu = menu})

    Wzu.SetCursorType(Wzu.CursorTypes.Normal)
	if not menu:restoreState() then
		menu.contents:processEvent({name = "gain_focus", controller = controller})
	end

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", function (Sender)
		Sender.contents:close()
		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "CompactOverlay.buttonPrompts"))
	end)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end
	return menu
end

