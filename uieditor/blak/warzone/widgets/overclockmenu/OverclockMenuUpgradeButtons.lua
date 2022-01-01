require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenubutton")

Warzone.OverclockMenuUpgradeButtons = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuUpgradeButtons.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuUpgradeButtons)
    self.id = "OverclockMenuUpgradeButtons"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
	self:makeFocusable()
    self:setHandleMouse(true)
	self.onlyChildrenFocusable = true

    self.caliberLabel = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.caliberLabel:setScaledLeftRight(true, false, 100, 160)
    self.caliberLabel:setScaledTopBottom(true, false, 24, 38)
    self.caliberLabel:setText("Calibers:")

    self:addElement(self.caliberLabel)

    self.button1 = Warzone.OverclockMenuButton.new(menu, controller)
    self.button1:setScaledLeftRight(false, false, -228.5, -188.5)
    self.button1:setScaledTopBottom(true, false, 20, 42)
    self.button1.index = 1

    Wzu.SetElementModel_Create(self.button1, controller, "overclockTree", "1")

    self:addElement(self.button1)

    self.button2 = Warzone.OverclockMenuButton.new(menu, controller)
    self.button2:setScaledLeftRight(false, false, -20, 20)
    self.button2:setScaledTopBottom(true, false, 20, 42)
    self.button2.index = 2

    Wzu.SetElementModel_Create(self.button2, controller, "overclockTree", "2")

    self:addElement(self.button2)

    self.button3 = Warzone.OverclockMenuButton.new(menu, controller)
    self.button3:setScaledLeftRight(false, true, -120, -80)
    self.button3:setScaledTopBottom(true, false, 20, 42)
    self.button3.index = 3

    Wzu.SetElementModel_Create(self.button3, controller, "overclockTree", "3")

    self:addElement(self.button3)

    self.button1.navigation = {right = self.button2}
    self.button2.navigation = {left = self.button1, right = self.button3}
    self.button3.navigation = {left = self.button2}

    CoD.Menu.AddNavigationHandler(menu, self, controller)

    self.button1.id = "ocButton1"
    self.button2.id = "ocButton2"
    self.button3.id = "ocButton3"

    self:registerEventHandler("gain_focus", function (self, event)
		if self.m_focusable then
			if self.button1:processEvent(event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(self, event)
	end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end