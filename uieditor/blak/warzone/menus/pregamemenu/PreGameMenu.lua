require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenuhighrescontainer")

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

	menu.soundSet = "iw8"
    menu.id = "PreGameMenu"
	menu:setOwner(controller)
    menu:setLeftRight(true, true, 0, 0)
	menu:setTopBottom(true, true, 0, 0)
    menu:makeFocusable()
	menu:playSound("menu_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "PreGameMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true
    menu.onlyChildrenFocusable = true

    --menu.selectedMode

    --menu.buttonList

    menu.contents = Warzone.PreGameMenuHighResContainer.new(menu, controller)
    menu.contents:setScaledLeftRight(false, false, -640, 640)
    menu.contents:setScaledTopBottom(false, false, -360, 360)
    menu.contents:setScale(1 / _ResolutionScalar)
    menu.contents.id = "contents"

    menu:addElement(menu.contents)
    
    if not menu:restoreState() then
		menu.contents:processEvent({name = "gain_focus", controller = controller})
	end

    -- for testing only
    --[[menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
        Close(menu, controller)
    end, function(ItemRef, menu, controller)
        return nil
    end, false)]]
	
	menu:processEvent({
        name = "menu_loaded",
        controller = controller
    })
	
	menu:processEvent({
        name = "update_state",
        menu = menu
    })
    
	local function CloseFunc(ObjRef)
		ObjRef.contents:close()

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

