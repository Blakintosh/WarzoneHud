Warzone.PreGameMenuLogo = InheritFrom(LUI.UIElement)

function Warzone.PreGameMenuLogo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PreGameMenuLogo)
    self.id = "PreGameMenuLogo"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.image = LUI.UIImage.new()
    self.image:setLeftRight(true, true, 0, 0)
    self.image:setTopBottom(true, true, 0, 0)
    self.image:setImage(RegisterImage("cust_hud_zm_karelia_logo"))

    self:addElement(self.image)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end