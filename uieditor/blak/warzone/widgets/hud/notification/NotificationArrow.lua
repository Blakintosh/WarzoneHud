
Warzone.NotificationArrow = InheritFrom(LUI.UIElement)

function Warzone.NotificationArrow.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.NotificationArrow)
    self.id = "NotificationArrow"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.image = LUI.UIImage.new()
    self.image:setScaledLeftRight(false, false, -50, 50)
    self.image:setScaledTopBottom(false, false, -50, 50)
    self.image:setZRot(90)
    self.image:setImage(RegisterImage("battlepass_arrow_atlas"))
    self.image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
    self.image:setShaderVector(0, 4, 13, 0, 0)
    self.image:setShaderVector(1, 10, 0, 0, 0)

    self:addElement(self.image)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end