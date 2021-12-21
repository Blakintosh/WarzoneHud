Warzone.HealthBar = InheritFrom(LUI.UIElement)

function Warzone.HealthBar.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.HealthBar)
    self.id = "HealthBar"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.background, Wzu.Colors.Black)
    self.background:setAlpha(0.2)

    self:addElement(self.background)

    self.filler = LUI.UIImage.new()
    self.filler:setScaledLeftRight(true, true, 0.5, -0.5)
    self.filler:setScaledTopBottom(true, true, 0.5, -0.5)
    Wzu.SetRGBFromTable(self.filler, Wzu.Swatches.HUDMain)

    self:addElement(self.filler)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end