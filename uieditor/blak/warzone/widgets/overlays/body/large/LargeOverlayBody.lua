require("ui.uieditor.blak.warzone.widgets.overlays.common.OverlayButton")
require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menutitle")

Warzone.LargeOverlayBody = InheritFrom(LUI.UIElement)

Warzone.LargeOverlayBody.new = function (menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.LargeOverlayBody)
    self:makeFocusable()
	self:setScaledLeftRight(false, false, -570, 570)
    self:setScaledTopBottom(true, false, 0, 310)
	self.id = "LargeOverlayBody"
	self.soundSet = "none"
    self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

    -- Title bar
    self.title = Warzone.MenuTitle.new(menu, controller)
    self.title:setScaledLeftRight(true, false, 0, 150)
    self.title:setScaledTopBottom(true, false, 26, 64)
    Wzu.LinkToWidgetText(self.title.title, self, "title", true)

    self:addElement(self.title)

    self.desc = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Colors.Grey191, false)
    self.desc:setScaledLeftRight(true, false, 62, 762)
    self.desc:setScaledTopBottom(true, false, 84, 98)
    self.desc:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
    self.desc:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)

    Wzu.LinkToWidgetText(self.desc, self, "description")

    self:addElement(self.desc)

    self.options = LUI.UIList.new(menu, controller, 3, 0, nil, true, false, 0, 0, false, false)
	self.options:makeFocusable()
	self.options:setScaledLeftRight(true, false, 62, 462)
	self.options:setScaledTopBottom(true, false, 220, 290)
	self.options:setWidgetType(Warzone.OverlayButton)
	self.options:setVerticalCount(2)
	self.options:setSpacing(12)
    self.options.id = "options"
	self.options:linkToElementModel(self, "listDatasource", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.options:setDataSource(ModelValue)
		end
	end)

	self.options:linkToElementModel(self.options, "disabled", true, function (ModelRef)
		CoD.Menu.UpdateButtonShownState(self.options, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
	end)

	self.options:registerEventHandler("gain_focus", function (Sender, Event)
		local f7_local0 = nil
		if Sender.gainFocus then
			f7_local0 = Sender:gainFocus(Event)
		elseif Sender.super.gainFocus then
			f7_local0 = Sender:gainFocus(Event)
		end
		CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
		return f7_local0
	end)
	self.options:registerEventHandler("lose_focus", function (Sender, Event)
		local f8_local0 = nil
		if Sender.loseFocus then
			f8_local0 = Sender:loseFocus(Event)
		elseif Sender.super.loseFocus then
			f8_local0 = Sender:loseFocus(Event)
		end
		return f8_local0
	end)

	menu:AddButtonCallbackFunction(self.options, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function (self, menu, controller, parent)
		if not IsDisabled(self, controller) then
			ProcessListAction(self, self, controller)
			return true
		end
        return false
	end, function (self, menu, controller)
		if not IsDisabled(self, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
			return true
		else
			return false
		end
	end, false)
	self:addElement(self.options)

    self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.options:processEvent(Event) then
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

