Warzone.ButtonBackground = InheritFrom(LUI.UIElement)

function Warzone.ButtonBackground.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ButtonBackground)
    self.id = "ButtonBackground"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.buttonBg = LUI.UIImage.new()
    self.buttonBg:setScaledLeftRight(true, true, 0, 0)
    self.buttonBg:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.buttonBg, Wzu.Swatches.ButtonBackground)
    self.buttonBg:setAlpha(0.3)

    self:addElement(self.buttonBg)

    self.textureLayer = LUI.UIImage.new()
    self.textureLayer:setScaledLeftRight(true, true, 0, 0)
    self.textureLayer:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.textureLayer, Wzu.Swatches.ButtonTextFocus)
    self.textureLayer:setAlpha(0.1)
    self.textureLayer:setImage(RegisterImage("button_gradient"))
    self.textureLayer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.textureLayer:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    self:addElement(self.textureLayer)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end