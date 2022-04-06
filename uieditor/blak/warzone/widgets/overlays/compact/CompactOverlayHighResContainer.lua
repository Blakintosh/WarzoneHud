require("ui.uieditor.blak.warzone.widgets.overlays.common.OverlayBackground")
require("ui.uieditor.blak.warzone.widgets.userinterface.layout.MenuFooterPrompts")

Warzone.CompactOverlayHighResContainer = InheritFrom(LUI.UIElement)

Warzone.CompactOverlayHighResContainer.new = function (menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.CompactOverlayHighResContainer)
	self.id = "CompactOverlayHighResContainer"
	self.soundSet = "none"
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

    self.background = Warzone.OverlayBackground.new(menu, controller)
    self.background:setScaledLeftRight(false, false, -360, 360)
    self.background:setScaledTopBottom(true, false, 250, 390)

    self:addElement(self.background)
	
	self.frameWidget = LUI.UIFrame.new(menu, controller, 0, 0, false)
	self.frameWidget:setScaledLeftRight(false, false, -360, 360)
    self.frameWidget:setScaledTopBottom(true, false, 250, 390)
	self.frameWidget:linkToElementModel(self, nil, false, function (ModelRef)
		self.frameWidget:setModel(ModelRef, controller)
	end)
	self.frameWidget:linkToElementModel(self, "frameWidget", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.frameWidget:changeFrameWidget(ModelValue)
		end
	end)
    
	self.frameWidget.id = "frameWidget"

    self:addElement(self.frameWidget)
	
    self.buttons = Warzone.MenuFooterPrompts.new(menu, controller)
	self.buttons:setScaledLeftRight(false, false, -360, 360)
	self.buttons:setScaledTopBottom(true, false, 390, 434)

    self.buttons:registerEventHandler("menu_loaded", function(sender, event)
        self.buttons:setModel(menu.buttonModel, controller)
    end)

	self:addElement(self.buttons)

	self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.frameWidget:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.background:close()
		Sender.buttons:close()
		Sender.frameWidget:close()
	end)
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

