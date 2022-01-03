require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenubutton")
require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenulogo")

DataSources.PreGameHost = DataSourceHelpers.ListSetup("PreGameHost", function(controller)
    local returnTable = {}

    table.insert(returnTable, {
        models = {
            displayText = "Start Game",
            action = function(Widget, Sender, controller)
                Engine.SendMenuResponse(controller, "PreGameMenu", "start_game")
            end
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Start Game (Skip Infil)",
            action = function(Widget, Sender, controller)
                Engine.SendMenuResponse(controller, "PreGameMenu", "start_game_skip_infil")
            end
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Change Game Mode"
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Mutators"
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Credits"
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Options"
        }
    })

    table.insert(returnTable, {
        models = {
            displayText = "Quit",
            action = QuitGame_MP
        }
    })

    return returnTable
end, true)

local function PreLoadFunc(menu, controller)
    menu.disablePopupOpenCloseAnim = true
    menu.disableBlur = true
    menu.disableDarkenElement = true

    Engine.LockInput(controller, true)
    Engine.SetUIActive(controller, true)
end

--LUI.hudMenuType.PreGameMenu = "hud"
function LUI.createMenu.PreGameMenu(controller)
    local menu = CoD.Menu.NewForUIEditor("PreGameMenu")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "HUD"
    menu.id = "PreGameMenu"
	menu:setOwner(controller)
    menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)
    menu:makeFocusable()
	menu:playSound("menu_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "PreGameMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true
    menu:setForceMouseEventDispatch(true)

    menu.logo = Warzone.PreGameMenuLogo.new(menu, controller)
    menu.logo:setLeftRight(true, false, 95, 481)
    menu.logo:setTopBottom(true, false, -24, 362)
    menu.logo:setImage(RegisterImage("cust_hud_zm_karelia_logo"))
    menu.logo:setRFTMaterial(LUI.UIImage.GetCachedMaterial("uie_aberration"))
	menu.logo:setShaderVector(0, 0.1, 1, 0, 0)
	menu.logo:setShaderVector(1, 0, 0, 0, 0)
	menu.logo:setShaderVector(2, 0, 0, 0, 0)
	menu.logo:setShaderVector(3, 0, 0, 0, 0)
	menu.logo:setShaderVector(4, 0, 0, 0, 0)

    Wzu.ClipSequence(menu, menu.logo, "Default", {
        {
            duration = 0,
            setShaderVector = {0, 0, 1, 0, 0}
        },
        {
            duration = 12000,
            interpolation = Wzu.TweenGraphs.inOutSine,
            setShaderVector = {0, 0.4, 1, 0, 0}
        },
        {
            duration = 12000,
            interpolation = Wzu.TweenGraphs.inOutSine,
            setShaderVector = {0, 0, 1, 0, 0}
        }
    })

    menu:addElement(menu.logo)

    --menu.selectedMode

    --menu.buttonList

    menu.buttonList = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    menu.buttonList:makeFocusable()
    menu.buttonList.id = "buttonList"
    menu.buttonList:setLeftRight(true, false, 122, 422)
    menu.buttonList:setTopBottom(true, false, 215, 595)
    menu.buttonList:setWidgetType(Warzone.PreGameMenuButton)
    --menu.buttonList:setWidgetType(CoD.MWRStartListButton)
    menu.buttonList:setVerticalCount(7)
    menu.buttonList:setSpacing(8)
    menu.buttonList:setDataSource("PreGameHost")

    menu.buttonList:registerEventHandler("gain_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        elseif Sender.super.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end)

    menu.buttonList:registerEventHandler("lose_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        elseif Sender.super.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end) -- Change?
    
    menu:AddButtonCallbackFunction(menu.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        local ActionModelVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "action"))
        if ActionModelVal then
            ActionModelVal(menu, ItemRef, controller)
        end
        return true
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, false)

    menu:addElement(menu.buttonList)

    --[[menu.buttonHints = CoD.MW19ButtonPrompts.new(menu, controller)
    menu.buttonHints:setLeftRight(false, false, -400, 400)
    menu.buttonHints:setTopBottom(true, false, 550, 600)

    menu:addElement(menu.buttonHints)

    menu.buttonHints:setModel(menu.buttonModel, controller)

    menu.buttonHints:addButtonPrompt(menu, controller, "primary_button_image", Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
    menu.buttonHints:addButtonPrompt(menu, controller, "secondary_button_image", Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)]]
    
    if not menu:restoreState() then
		menu.buttonList:processEvent({name = "gain_focus", controller = controller})
	end

    --[[menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
        Engine.SendMenuResponse(controller, "PreGameMenu", "closed")
        Close(menu, controller)
    end, function(ItemRef, menu, controller)
        return nil
    end, false)]]

    menu.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(menu, "Default", {
                    looping = true,
                    clipName = "DefaultClip"
                })
            end
        }
    }
	
	menu:processEvent({
        name = "menu_loaded",
        controller = controller
    })
	
	menu:processEvent({
        name = "update_state",
        menu = menu
    })
    
	local function CloseFunc(ObjRef)
		ObjRef.buttonList:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "PreGameMenu.buttonPrompts"))
	end

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", CloseFunc)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end

    
    menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)

	return menu
end

