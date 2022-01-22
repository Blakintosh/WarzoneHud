Warzone.HealthBarFiller = InheritFrom(LUI.UIElement)

function Warzone.HealthBarFiller.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.HealthBarFiller)
    self.id = "HealthBarFiller"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.filler = LUI.UIImage.new()
    self.filler:setScaledLeftRight(true, true, 0, -0)
    self.filler:setScaledTopBottom(true, true, 0, -0)
    self.filler:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.filler:setShaderVector(1, 0, 0, 0, 0)
    self.filler:setShaderVector(2, 1, 0, 0, 0)
    self.filler:setShaderVector(3, 0, 0, 0, 0)

    self:addElement(self.filler)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end