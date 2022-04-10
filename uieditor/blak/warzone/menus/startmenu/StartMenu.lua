require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenubutton")
require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenulogo")
require("ui.uieditor.blak.warzone.widgets.startmenu.startmenuhighrescontainer")

DataSources.WarzoneStartMenuGameOptions = ListHelper_SetupDataSource("WarzoneStartMenuGameOptions", function (f69_arg0)
	local dataTable = {}
	
    -- Return to Game
    table.insert(dataTable, {models = {displayText = "WZMENU_RETURN_GAME", action = StartMenuGoBack_ListElement}})

    -- Karelia Options
    table.insert(dataTable, {models = {displayText = "KARELIA_MENU_OPTIONS", action = StartMenuGoBack_ListElement}})
    -- BO3 Options
    table.insert(dataTable, {models = {displayText = "WZMENU_OPTIONS_GAME", action = function(f398_arg0, f398_arg1, controller, arg3, menu)
        menu:saveState()
	    OpenOverlay(menu, "StartMenu_Options", controller)
    end}})

    -- Restart Game
    if Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME) and (not not (Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) == true) or Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) == true) then
        table.insert(dataTable, {models = {displayText = "MPUI_RESTART_MAP", action = RestartGame}})
    end
    -- Quit / End Game
    if Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME) == true then
        table.insert(dataTable, {models = {displayText = "MENU_END_GAME", action = QuitGame_MP}})
    else
        table.insert(dataTable, {models = {displayText = "MENU_QUIT_GAME", action = QuitGame_MP}})
    end

    -- Quit to Desktop
    table.insert(dataTable, {models = {displayText = "WZMENU_QUIT_TO_DESKTOP", action = OpenPCQuit}})
    
	return dataTable
end, true)

local function PreLoadFunc(menu, controller)
    menu.disablePopupOpenCloseAnim = true
    menu.disableDarkenElement = true

    Engine.LockInput(controller, true)
    Engine.SetUIActive(controller, true)
end

function LUI.createMenu.StartMenu_Main(controller)
    local menu = CoD.Menu.NewForUIEditor("StartMenu_Main")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "iw8"
    menu.id = "StartMenu_Main"
	menu:setOwner(controller)
    menu:setLeftRight(true, false, 0, 1280)
	menu:setTopBottom(true, false, 0, 720)
    menu:makeFocusable()
	menu:playSound("menu_pause", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "StartMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true
    --menu:setForceMouseEventDispatch(true)

    menu.container = Warzone.StartMenuHighResContainer.new(menu, controller)
    menu.container:setScaledLeftRight(false, false, -640, 640)
    menu.container:setScaledTopBottom(false, false, -360, 360)
    menu.container:setScale(1 / _ResolutionScalar)

    menu:addElement(menu.container)

    menu.container.id = "container"

    if not menu:restoreState() then
		menu.container:processEvent({name = "gain_focus", controller = controller})
	end

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function(ItemRef, menu, controller, ParentRef)
		RefreshLobbyRoom(menu, controller)
		StartMenuGoBack(menu, controller)
    end, function(ItemRef, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
		return true
    end, false)
    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_NONE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
		RefreshLobbyRoom(menu, controller)
		StartMenuGoBack(menu, controller)
    end, function(ItemRef, menu, controller)
        return nil
    end, false)
    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_START, "M", function(ItemRef, menu, controller, ParentRef)
		RefreshLobbyRoom(menu, controller)
		StartMenuGoBack(menu, controller)
		return true
    end, function(ItemRef, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_START, "MENU_DISMISS_MENU")
		return true
    end, false)
    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "S", function (widget, menu, controller, parent)
		if IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() then
			OpenPopup(menu, "Social_Main", controller, "", "")
			return true
        end
        return false
	end, function (widget, menu, controller)
		if IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "MENU_SOCIAL")
			return true
		else
			return false
		end
	end, false)

    menu:registerEventHandler("menu_loaded", function(sender, event)
        return menu:dispatchEventToChildren(event)
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
		ObjRef.container:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "StartMenu.buttonPrompts"))
	end

	LUI.OverrideFunction_CallOriginalSecond(menu, "close", CloseFunc)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end

	return menu
end

