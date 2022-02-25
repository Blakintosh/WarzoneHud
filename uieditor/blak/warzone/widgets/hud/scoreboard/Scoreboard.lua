require("ui.uieditor.blak.warzone.widgets.hud.scoreboard.ScoreboardRow")
require("ui.uieditor.blak.warzone.widgets.hud.scoreboard.ScoreboardHeader")
require("ui.uieditor.blak.warzone.widgets.hud.scoreboard.TeamIconAndLabel")

Warzone.Scoreboard = InheritFrom(LUI.UIElement)

local blockKeyEvent = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg1[f2_arg2]
	f2_arg1[f2_arg2] = function (...)
		if Engine.IsVisibilityBitSet(f2_arg0, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then
			Engine.BlockGameFromKeyEvent()
		end
		return f2_local0(...)
	end

end

local PostLoadFunc = function (self, controller, menu)
	if not CoD.isMultiplayer then
		LUI.OverrideFunction_CallOriginalSecond(self.ScoresList, "navigateItemUp", function (Sender)
			if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then
				Engine.BlockGameFromKeyEvent()
			end
		end)
		LUI.OverrideFunction_CallOriginalSecond(self.ScoresList, "navigateItemDown", function (Sender)
			if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then
				Engine.BlockGameFromKeyEvent()
			end
		end)
	else
		if Dvar.ui_gametype:get() == "prop" then
			blockKeyEvent(controller, self.ScoresList, "navigateItemDown")
		end
	end
	self.updateDataSource = self.ScoresList.updateDataSource
end

function Warzone.Scoreboard.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
	self:setUseStencil(false)
	self:setClass(Warzone.Scoreboard)
	self.id = "Scoreboard"
	self.soundSet = "iw8"
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

    self.team = Warzone.TeamIconAndLabel.new(menu, controller)
    self.team:setScaledLeftRight(true, false, 0, 128)
    self.team:setScaledTopBottom(true, false, 32, 160)

    self:addElement(self.team)

    self.scoreListBackerTop = LUI.UIImage.new()
    self.scoreListBackerTop:setScaledLeftRight(true, true, 248, -8)
    self.scoreListBackerTop:setScaledTopBottom(true, false, 32, 36)
    Wzu.SetRGBFromTable(self.scoreListBackerTop, Wzu.Swatches.GlobalKeyColorMid)
    self.scoreListBackerTop:setAlpha(0.4)

    self:addElement(self.scoreListBackerTop)

    self.scoreListBackerBottom = LUI.UIImage.new()
    self.scoreListBackerBottom:setScaledLeftRight(true, true, 248, -8)
    self.scoreListBackerBottom:setScaledTopBottom(true, false, 156, 160)
    Wzu.SetRGBFromTable(self.scoreListBackerBottom, Wzu.Swatches.GlobalKeyColorMid)
    self.scoreListBackerBottom:setAlpha(0.4)

    self:addElement(self.scoreListBackerBottom)

    self.mapName = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.mapName:setScaledLeftRight(true, false, 272, 300)
    self.mapName:setScaledTopBottom(true, false, 8, 32)
    self.mapName:setText("NOVOMORY")

    Wzu.AddShadowedElement(self, self.mapName)
    
    self.row1bg = LUI.UIImage.new()
    self.row1bg:setScaledLeftRight(true, true, 252, -12)
    self.row1bg:setScaledTopBottom(true, false, 36, 66)
    self.row1bg:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.row1bg, Wzu.Swatches.FriendlyTeam)

    self:addElement(self.row1bg)
    
    self.row3bg = LUI.UIImage.new()
    self.row3bg:setScaledLeftRight(true, true, 252, -12)
    self.row3bg:setScaledTopBottom(true, false, 96, 126)
    self.row3bg:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.row3bg, Wzu.Swatches.FriendlyTeam)

    self:addElement(self.row3bg)

    self.row2bg = LUI.UIImage.new()
    self.row2bg:setScaledLeftRight(true, true, 252, -12)
    self.row2bg:setScaledTopBottom(true, false, 66, 96)
    self.row2bg:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.row2bg, Wzu.Swatches.GlobalKeyColorMid)

    self:addElement(self.row2bg)
    
    self.row4bg = LUI.UIImage.new()
    self.row4bg:setScaledLeftRight(true, true, 252, -12)
    self.row4bg:setScaledTopBottom(true, false, 126, 156)
    self.row4bg:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.row4bg, Wzu.Swatches.GlobalKeyColorMid)

    self:addElement(self.row4bg)

    self.header = Warzone.ScoreboardHeader.new(menu, controller)
    self.header:setScaledLeftRight(true, true, 248, 0)
    self.header:setScaledTopBottom(true, false, 12, 28)

    self:addElement(self.header)

    self.ScoresList = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
	self.ScoresList:makeFocusable()
	self.ScoresList:setScaledLeftRight(true, true, 248, 0)
	self.ScoresList:setScaledTopBottom(true, false, 36, 156)
	self.ScoresList:setWidgetType(Warzone.ScoreboardRow)
	self.ScoresList:setVerticalCount(18)
	self.ScoresList:setSpacing(0)
	self.ScoresList:setDataSource("ScoreboardTeam1List")
	self.ScoresList:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "scoreboardInfo.muteButtonPromptVisible"), function (ModelRef)
		local f8_local0 = {controller = controller, name = "model_validation", modelValue = Engine.GetModelValue(ModelRef), modelName = "scoreboardInfo.muteButtonPromptVisible"}
		CoD.Menu.UpdateButtonShownState(self.ScoresList, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
	end)
	self.ScoresList:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "forceScoreboard"), function (ModelRef)
		local f9_local0 = self.ScoresList
		local f9_local1 = {controller = controller, name = "model_validation", modelValue = Engine.GetModelValue(ModelRef), modelName = "forceScoreboard"}
		CoD.Menu.UpdateButtonShownState(f9_local0, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
		CoD.Menu.UpdateButtonShownState(f9_local0, menu, controller, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED)
	end)
	self.ScoresList:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "factions.isCoDCaster"), function (ModelRef)
		local f10_local0 = {controller = controller, name = "model_validation", modelValue = Engine.GetModelValue(ModelRef), modelName = "factions.isCoDCaster"}
		CoD.Menu.UpdateButtonShownState(self.ScoresList, menu, controller, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED)
	end)
	self.ScoresList:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "CodCaster.showCodCasterScoreboard"), function (ModelRef)
		local f11_local0 = {controller = controller, name = "model_validation", modelValue = Engine.GetModelValue(ModelRef), modelName = "CodCaster.showCodCasterScoreboard"}
		CoD.Menu.UpdateButtonShownState(self.ScoresList, menu, controller, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED)
	end)
	self.ScoresList:registerEventHandler("gain_focus", function (Sender, Event)
		local f12_local0 = nil
		if Sender.gainFocus then
			f12_local0 = Sender:gainFocus(Event)
		elseif Sender.super.gainFocus then
			f12_local0 = Sender:gainFocus(Event)
		end
		CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_START)
		CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
		CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED)
		return f12_local0
	end)
	self.ScoresList:registerEventHandler("lose_focus", function (Sender, Event)
		local f13_local0 = nil
		if Sender.loseFocus then
			f13_local0 = Sender:loseFocus(Event)
		elseif Sender.super.loseFocus then
			f13_local0 = Sender:loseFocus(Event)
		end
		return f13_local0
	end)
	menu:AddButtonCallbackFunction(self.ScoresList, controller, Enum.LUIButton.LUI_KEY_START, nil, function (sender, menuref, controllerIndex, f14_arg3)
		if ScoreboardCanShowGamerCard(sender, controllerIndex) then
			ShowGamerCardForScoreboardRow(controllerIndex, sender)
			return true
		else

		end
	end, function (sender, menuRef, controllerIndex)
		if ScoreboardCanShowGamerCard(sender, controllerIndex) then
			CoD.Menu.SetButtonLabel(menuRef, Enum.LUIButton.LUI_KEY_START, "PLATFORM_SHOW_GAMERCARD")
			return true
		else
			return false
		end
	end, false)
	menu:AddButtonCallbackFunction(self.ScoresList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, nil, function (sender, menuRef, controllerIndex, f16_arg3)
		if IsScoreboardPlayerMuted(controllerIndex, sender) and not ScoreboardMuteButtonPromptHidden(sender, controllerIndex) then
			ToggleScoreboardClientMute(sender, controllerIndex)
			return true
		elseif not IsScoreboardPlayerMuted(controllerIndex, sender) and not ScoreboardMuteButtonPromptHidden(sender, controllerIndex) then
			ToggleScoreboardClientMute(sender, controllerIndex)
			return true
		else

		end
	end, function (sender, menuRef, controllerIndex)
		if IsScoreboardPlayerMuted(controllerIndex, sender) and not ScoreboardMuteButtonPromptHidden(sender, controllerIndex) then
			CoD.Menu.SetButtonLabel(menuRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_UNMUTE_CAPS")
			return true
		elseif not IsScoreboardPlayerMuted(controllerIndex, sender) and not ScoreboardMuteButtonPromptHidden(sender, controllerIndex) then
			CoD.Menu.SetButtonLabel(menuRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_MUTE_CAPS")
			return true
		else
			return false
		end
	end, false)
	menu:AddButtonCallbackFunction(self.ScoresList, controller, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED, "C", function (sender, menuRef, controllerIndex, f18_arg3)
		if ScoreboardVisible(controllerIndex) and IsCodCaster(controllerIndex) and not IsModelValueTrue(controllerIndex, "CodCaster.showCodCasterScoreboard") then
			SetControllerModelValue(controllerIndex, "CodCaster.showCodCasterScoreboard", true)
			return true
		elseif ScoreboardVisible(controllerIndex) and IsCodCaster(controllerIndex) and IsModelValueTrue(controllerIndex, "CodCaster.showCodCasterScoreboard") then
			SetControllerModelValue(controllerIndex, "CodCaster.showCodCasterScoreboard", false)
			return true
		else

		end
	end, function (sender, menuRef, controllerIndex)
		if ScoreboardVisible(controllerIndex) and IsCodCaster(controllerIndex) and not IsModelValueTrue(controllerIndex, "CodCaster.showCodCasterScoreboard") then
			CoD.Menu.SetButtonLabel(menuRef, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED, "MENU_TOGGLE_CODCASTERS")
			return true
		elseif ScoreboardVisible(controllerIndex) and IsCodCaster(controllerIndex) and IsModelValueTrue(controllerIndex, "CodCaster.showCodCasterScoreboard") then
			CoD.Menu.SetButtonLabel(menuRef, Enum.LUIButton.LUI_KEY_LSTICK_PRESSED, "MENU_TOGGLE_CODCASTERS")
			return true
		else
			return false
		end
	end, false)

	self:addElement(self.ScoresList)

    self.ScoresList.id = "ScoresList"

    self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.ScoresList:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)

    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end