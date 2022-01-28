Warzone.PlusPointsContainer = InheritFrom(LUI.UIElement)

function Warzone.PlusPointsContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PlusPointsContainer)
    self.id = "PlusPointsContainer"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end