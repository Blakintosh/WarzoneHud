
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
    --[[self:makeFocusable()
    self.onlyChildrenFocusable = true]]
    self.anyChildUsesUpdateState = true

    self.caliberLabel = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.caliberLabel:setScaledLeftRight(true, false, 100, 160)
    self.caliberLabel:setScaledTopBottom(true, false, 24, 38)
    self.caliberLabel:setText("Calibers:")

    self:addElement(self.caliberLabel)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end