Warzone.ReturnAO = InheritFrom(LUI.UIElement)

function Warzone.ReturnAO.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ReturnAO)
    self.id = "ReturnAO"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.icon = LUI.UIImage.new()
    self.icon:setScaledLeftRight(false, false, -30, 30)
    self.icon:setScaledTopBottom(true, false, 0, 60)
    self.icon:setImage(RegisterImage("hud_icon_warning"))
    Wzu.SetRGBFromTable(self.icon, Wzu.Swatches.EnemyTeam)

    self:addElement(self.icon)

    self.label = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.EnemyTeam, true)
    self.label:setScaledLeftRight(false, false, -200, 200)
    self.label:setScaledTopBottom(true, false, 56, 90)
    self.label:setText("DANGER AHEAD")

    Wzu.AddShadowedElement(self, self.label)

    self.timeLeft = Wzu.TextElement(Wzu.Fonts.KillstreakRegular, Wzu.Swatches.HUDMain, true)
    self.timeLeft:setScaledLeftRight(false, false, -200, 200)
    self.timeLeft:setScaledTopBottom(true, false, 100, 123)
    self.timeLeft:setText("63.5")

    Wzu.AddShadowedElement(self, self.timeLeft)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end