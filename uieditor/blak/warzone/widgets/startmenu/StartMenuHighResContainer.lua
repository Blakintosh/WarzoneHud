require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menutitle")
require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menufooter")
require("ui.uieditor.blak.warzone.widgets.startmenu.StartMenuButton")
require("ui.uieditor.blak.warzone.widgets.startmenu.StartMenuMissionInfo")

Warzone.StartMenuHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.StartMenuHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.StartMenuHighResContainer)
    self.id = "StartMenuHighResContainer"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true
    self:makeFocusable()
    self.onlyChildrenFocusable = true
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    self.bg = LUI.UIImage.new()
    self.bg:setScaledLeftRight(true, true, 0, 0)
    self.bg:setScaledTopBottom(true, true, 0, 0)
    self.bg:setRGB(0, 0, 0)
    self.bg:setAlpha(0.5)

    self:addElement(self.bg)

    -- Title bar
    self.title = Warzone.MenuTitle.new(menu, controller)
    self.title:setScaledLeftRight(true, false, 0, 150)
    self.title:setScaledTopBottom(true, false, 26, 64)
    self.title.title:setText(Engine.Localize("MENU_PAUSED_CAPS"))

    self:addElement(self.title)

    self.buttonList = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    self.buttonList:makeFocusable()
    self.buttonList.id = "buttonList"
    self.buttonList:setScaledLeftRight(true, false, 66, 366)
    self.buttonList:setScaledTopBottom(true, false, 104, 484)
    self.buttonList:setWidgetType(Warzone.StartMenuButton)
    self.buttonList:setVerticalCount(7)
    self.buttonList:setSpacing(8)
    self.buttonList:setDataSource("WarzoneStartMenuGameOptions")

    self.buttonList:registerEventHandler("gain_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        elseif Sender.super.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end)

    self.buttonList:registerEventHandler("lose_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        elseif Sender.super.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end) -- Change?
    
    menu:AddButtonCallbackFunction(self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        ProcessListAction(menu, ItemRef, controller)
        return true
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, false)

    self:addElement(self.buttonList)

    self.missionInfo = Warzone.StartMenuMissionInfo.new(menu, controller)
    self.missionInfo:setScaledLeftRight(true, false, 480, 930)
    self.missionInfo:setScaledTopBottom(true, false, 82, 382)

    self:addElement(self.missionInfo)

    self.footer = Warzone.MenuFooter.new(menu, controller)
    self.footer:setScaledLeftRight(true, true, 0, 0)
    self.footer:setScaledTopBottom(false, true, -48, 0)

    self:addElement(self.footer)

    self.version = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.version:setScaledLeftRight(false, true, -200, -16)
    self.version:setScaledTopBottom(false, true, -22, -8)
    self.version:setAlpha(0.5)

    self.version:setText("Version: "..VERSION_WATERMARK)

    self:addElement(self.version)

    self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.buttonList:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.title:close()
        self.buttonList:close()
        self.footer:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end