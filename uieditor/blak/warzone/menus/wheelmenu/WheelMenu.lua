require( "ui.uieditor.blak.warzone.widgets.wheelmenu.WheelButton" )
require( "ui.uieditor.blak.warzone.widgets.wheelmenu.WheelMenuHighResContainer" )

local PreLoadFunc = function ( self, controller )
	Engine.SetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.cybercomRequestedType" ), Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.cybercomActiveType" ) ) )
	self.restoreState = function ( self )
		return true
	end
	
	Engine.CreateModel( Engine.GetModelForController( controller ), "WheelMenu.Selected1" )
	Engine.CreateModel( Engine.GetModelForController( controller ), "WheelMenu.Selected2" )
	Engine.CreateModel( Engine.GetModelForController( controller ), "WheelMenu.Selected3" )

	-- Populate Option data
	local optionsModel = Engine.CreateModel( Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions")
	-- Option 1
	local option1Model = Engine.CreateModel( optionsModel, "1")
	Engine.SetModelValue(Engine.CreateModel(option1Model, "name"), "Option 1")
	Engine.SetModelValue(Engine.CreateModel(option1Model, "icon"), "hud_icon_equipment_flashlight")
	Engine.SetModelValue(Engine.CreateModel(option1Model, "enabled"), true)
	-- Option 2
	local option2Model = Engine.CreateModel( optionsModel, "2")
	Engine.SetModelValue(Engine.CreateModel(option2Model, "name"), "Option 2")
	Engine.SetModelValue(Engine.CreateModel(option2Model, "icon"), "hud_icon_equipment_frag")
	Engine.SetModelValue(Engine.CreateModel(option2Model, "enabled"), true)
	-- Option 3
	local option3Model = Engine.CreateModel( optionsModel, "3")
	Engine.SetModelValue(Engine.CreateModel(option3Model, "name"), "Option 3")
	Engine.SetModelValue(Engine.CreateModel(option3Model, "icon"), "icon_weapon_ar_scharlie")
	Engine.SetModelValue(Engine.CreateModel(option3Model, "enabled"), true)
	-- Option 4
	local option4Model = Engine.CreateModel( optionsModel, "4")
	Engine.SetModelValue(Engine.CreateModel(option4Model, "name"), "Option 4")
	Engine.SetModelValue(Engine.CreateModel(option4Model, "icon"), "icon_weapon_ar_scharlie")
	Engine.SetModelValue(Engine.CreateModel(option4Model, "enabled"), false)
	-- Option 5
	local option5Model = Engine.CreateModel( optionsModel, "5")
	Engine.SetModelValue(Engine.CreateModel(option5Model, "name"), "Option 5")
	Engine.SetModelValue(Engine.CreateModel(option5Model, "icon"), "hud_icon_equipment_frag")
	Engine.SetModelValue(Engine.CreateModel(option5Model, "enabled"), false)
	-- Option 6
	local option6Model = Engine.CreateModel( optionsModel, "6")
	Engine.SetModelValue(Engine.CreateModel(option6Model, "name"), "Option 6")
	Engine.SetModelValue(Engine.CreateModel(option6Model, "icon"), "hud_icon_equipment_flashlight")
	Engine.SetModelValue(Engine.CreateModel(option6Model, "enabled"), false)
	-- Option 7
	local option7Model = Engine.CreateModel( optionsModel, "7")
	Engine.SetModelValue(Engine.CreateModel(option7Model, "name"), "Option 7")
	Engine.SetModelValue(Engine.CreateModel(option7Model, "icon"), "blacktransparent")
	Engine.SetModelValue(Engine.CreateModel(option7Model, "enabled"), false)
	-- Option 8
	local option8Model = Engine.CreateModel( optionsModel, "8")
	Engine.SetModelValue(Engine.CreateModel(option8Model, "name"), "Option 8")
	Engine.SetModelValue(Engine.CreateModel(option8Model, "icon"), "blacktransparent")
	Engine.SetModelValue(Engine.CreateModel(option8Model, "enabled"), false)

	-- Focused
	Engine.CreateModel(Engine.GetModelForController(controller), "WheelMenu.focusedName")
end

local PostLoadFunc = function ( menu, controller )
    menu.disablePopupOpenCloseAnim = true
    menu.disableDarkenElement = true
    menu.disableBlur = true
	menu.currentFocusWidget = nil
	menu.previousFocusWidget = nil
	menu.currentOptionSelected = nil
	menu.degrees = 0
	menu.length = 0

	Engine.SetUIActive( controller, true )

	local f3_local0 = function ()
		local f4_local0 = 0
		if menu.length > 0.6 then
			-- This formula gets the associated button based on [8] tiles (if we want more, decrease the degrees xo)
			local buttonStep = 45
			menu.container.arrow:setZRot(math.floor( (360 - buttonStep + menu.degrees - buttonStep) % 360 ))
			menu.updateButtonStates( 1 + math.floor( (360 - buttonStep + menu.degrees - (buttonStep / 2)) % 360 / buttonStep ) )
		end
	end
	
	menu.updateButtonStates = function ( buttonIndex, requestedType, confirmAsSelected )
		if requestedType == nil then
			requestedType = 1
		end

		local newIndex = false

		local f5_local1 = Engine.GetModel( Engine.GetModelForController( controller ), "WheelMenu" )
		local selectedModel = Engine.GetModel( Engine.GetModelForController( controller ), "WheelMenu.Selected" .. requestedType )
		local wheelMenuModel = Engine.GetModel( Engine.GetModelForController( controller ), "WheelMenu" )

		if buttonIndex == nil then
			if Engine.GetModelValue( selectedModel ) == nil then
				local f5_local4 = 1
				for f5_local5 = 1, 8, 1 do
					if CoD.SafeGetModelValue( wheelMenuModel, "WheelMenuOptions." .. f5_local5 .. ".enabled" ) then
						f5_local4 = f5_local5
						break
					end
				end
				Engine.SetModelValue( selectedModel, f5_local4 )
			end
			buttonIndex = Engine.GetModelValue( selectedModel )
			f3_local0()
			newIndex = true
		end

		local f5_local4 = Engine.GetModel( wheelMenuModel, "WheelMenuOptions." .. buttonIndex )

		-- This was a check for if enabled, reinstate if you don't want disabled elements to show any name label
		if true then
			menu.currentFocusWidget = menu.container["wheelButton" .. buttonIndex]
			if confirmAsSelected == nil then
				menu.currentOptionSelected = menu.currentFocusWidget
				Engine.SetModelValue( selectedModel, buttonIndex )
			end
		end

		-- Change focus
		if menu.currentFocusWidget ~= menu.previousFocusWidget or newIndex then
			if f5_local4 ~= nil then
				local SelectedName = Engine.GetModel( f5_local4, "name" )
				if SelectedName and Engine.GetModel( wheelMenuModel, "focusedName" ) then
					Engine.SetModelValue(Engine.GetModel( wheelMenuModel, "focusedName" ), (Engine.GetModelValue(SelectedName) or ""))
				end
			end

			if menu.currentFocusWidget ~= menu.previousFocusWidget then
				if menu.currentFocusWidget ~= nil then
					if menu.currentFocusWidget.gainFocus then
						menu.currentFocusWidget:gainFocus( {
							name = "gain_focus",
							controller = controller
						} )
						menu.currentFocusWidget.buttonNum = buttonIndex
					end
					if not newIndex then
						menu:playSound( "gain_focus" )
					end
				end
				if menu.previousFocusWidget ~= nil and menu.previousFocusWidget.loseFocus then
					menu.previousFocusWidget:loseFocus( {
						name = "lose_focus",
						controller = controller
					} )
				end
			end
		end
		menu.previousFocusWidget = menu.currentFocusWidget
	end
	
	menu.updateButtonStates()
	menu:subscribeToGlobalModel( controller, "PerController", "RightStick.Length", function ( modelRef )
		local modelValue = Engine.GetModelValue( modelRef )
		if modelValue then
			menu.length = modelValue
			f3_local0()
		end
	end )

	menu:subscribeToGlobalModel( controller, "PerController", "RightStick.Degrees", function ( modelRef )
		local modelValue = Engine.GetModelValue( modelRef )
		if modelValue then
			menu.degrees = modelValue
			f3_local0()
		end
	end )

	-- Plays the close clip & sends script the selected option once menu gets shut
	local CloseOriginal = menu.close
	menu.close = function ( menu )
		local selectedOption = menu.currentOptionSelected

		if selectedOption then
			selectedOption = menu.currentOptionSelected:getModel( controller, "name" )
		end

		if selectedOption ~= nil then
			Engine.SendMenuResponse( controller, "WheelMenu", Engine.GetModelValue( selectedOption ) .. "," .. menu.currentOptionSelected.buttonNum )
		else
			Engine.SendMenuResponse( controller, "WheelMenu", "noOptionSelected" )
		end

		if CoD.isPC then
			Engine.SendClientScriptEntityNotify( controller, "wheel_menu_close" )
		end

		menu.m_inputDisabled = true
		LockInput( menu, controller, false )
		Engine.SetUIActive( controller, false )
		menu:unsubscribeFromAllModels()
		menu:playSound( "menu_start_close" )
		CloseOriginal(menu)
	end
	
	if CoD.useMouse then
		-- Could be worth keeping in mind for stuff like tooltips
		menu.onMouseFocus = function ( focusedButton, event )
			if event.isMouse then
				menu.updateButtonStates( focusedButton.buttonNum, nil, true )
			end
		end
		
		menu.onMouseAction = function ( focusedButton, event )
			if event.isMouse and focusedButton.buttonNum and Engine.GetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "WheelMenu" ), "WheelMenuOptions." .. focusedButton.buttonNum ), "enabled" ) ) == true then
				menu.currentOptionSelected = focusedButton

				focusedButton.decor:setState("Pulse")

				focusedButton.decor:registerEventHandler("clip_over", function(sender, event)
					menu:close()
				end)
			end
		end
	end

	-- Assigns indexes to each of the individual wheel buttons.
	for i = 1, 8, 1 do
		local wheelButton = menu.container["wheelButton" .. i]
		if not wheelButton then return end
		wheelButton.navigation = {}
		if CoD.useMouse then
			wheelButton.buttonNum = i
			wheelButton:registerEventHandler( "gain_focus", menu.onMouseFocus )
			wheelButton:registerEventHandler( "button_action", menu.onMouseAction )
		end
	end
end

LUI.createMenu.WheelMenu = function ( controller )
	local menu = CoD.Menu.NewForUIEditor( "WheelMenu" )
	if PreLoadFunc then
		PreLoadFunc( menu, controller )
	end
	menu.soundSet = "WheelMenu"
	menu:setOwner( controller )
	menu:setLeftRight( true, true, 0, 0 )
	menu:setTopBottom( true, true, 0, 0 )
	menu:playSound( "menu_open", controller )
	menu.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "WheelMenu.buttonPrompts" )
	menu.anyChildUsesUpdateState = true

	menu.container = Warzone.WheelMenuHighResContainer.new(menu, controller)
	menu.container:setScaledLeftRight(false, false, -640, 640)
	menu.container:setScaledTopBottom(false, false, -360, 360)
	menu.container:setScale(1 / _ResolutionScalar)
	menu.container.id = "container"
	menu:addElement(menu.container)

	menu.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				menu:setupElementClipCounter(0)
			end,
			Close = function ()
				menu:setupElementClipCounter(0)
			end
		}
	}

	menu:registerEventHandler( "input_source_changed", function ( element, event )
		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE )
	end )

	menu:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "LastInput" ), function ( modelRef )
		CoD.Menu.UpdateButtonShownState( menu, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE )
	end )

	menu:registerEventHandler( "menu_loaded", function ( element, event )
		LockInput( menu, controller, true )
		SendMenuResponse( menu, "WheelMenu", "opened", controller )

		return element:dispatchEventToChildren( event )
	end )

	-- Close
	menu:AddButtonCallbackFunction( menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function ( sender, menu, controller, parent )
		if not IsGamepad( controller ) then
			Close( menu, controller )
			return true
		else
			
		end
	end, function ( sender, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )
		if not IsGamepad( controller ) then
			return true
		else
			return false
		end
	end, false )
	
	menu:processEvent( {
		name = "menu_loaded",
		controller = controller
	} )

	menu:processEvent( {
		name = "update_state",
		menu = menu
	} )

	if not menu:restoreState() then
		menu.container:processEvent( {
			name = "gain_focus",
			controller = controller
		} )
	end

	LUI.OverrideFunction_CallOriginalSecond( menu, "close", function ( element )
		element.container:close()
		--element.Description:close()
		Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "WheelMenu.buttonPrompts" ) )
	end )
	if PostLoadFunc then
		PostLoadFunc( menu, controller )
	end
	
	return menu
end

