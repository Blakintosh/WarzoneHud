Warzone.OverclockMenuBackground = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuBackground.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuBackground)
    self.id = "OverclockMenuBackground"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.backer = LUI.UIImage.new()
    self.backer:setLeftRight(true, true, 0, 0)
    self.backer:setTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.backer, Wzu.Colors.Black)
    self.backer:setAlpha(0.8)

    self:addElement(self.backer)

    self.pixelPattern = LUI.UIImage.new()
    self.pixelPattern:setLeftRight(true, true, 0, 0)
    self.pixelPattern:setTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.pixelPattern, Wzu.Colors.Grey63)
    self.pixelPattern:setAlpha(0.2)
    self.pixelPattern:setImage(RegisterImage("hud_edge_glow_bottom_left"))
    self.pixelPattern:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.pixelPattern:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    self:addElement(self.pixelPattern)

    self.topBar = LUI.UIImage.new()
    self.topBar:setLeftRight(true, true, 0, 0)
    self.topBar:setTopBottom(true, false, 0, 2)
    Wzu.SetRGBFromTable(self.topBar, Wzu.Swatches.MenuBorder)

    self:addElement(self.topBar)

    self.bottomBar = LUI.UIImage.new()
    self.bottomBar:setLeftRight(true, true, 0, 0)
    self.bottomBar:setTopBottom(false, true, -2, 0)
    Wzu.SetRGBFromTable(self.bottomBar, Wzu.Swatches.MenuTitle)

    self:addElement(self.bottomBar)

    self.bottomGlow = LUI.UIImage.new()
    self.bottomGlow:setLeftRight(true, true, 0, 0)
    self.bottomGlow:setTopBottom(false, true, -16, 14)
    self.bottomGlow:setImage(RegisterImage("hud_glow"))
    Wzu.SetRGBFromTable(self.bottomGlow, Wzu.Swatches.ButtonTextFocus)
    self.bottomGlow:setAlpha(0.8)
    
    self:addElement(self.bottomGlow)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end