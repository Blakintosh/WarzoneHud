Warzone.MenuTitle = InheritFrom(LUI.UIElement)

function Warzone.MenuTitle.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.MenuTitle)
    self.id = "MenuTitle"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.title = Wzu.TextElement(Wzu.Fonts.MainLight, Wzu.Swatches.MenuTitle, false)
    self.title:setScaledLeftRight(true, false, 60, 150)
    self.title:setScaledTopBottom(true, false, 0, 38)
    self:addElement(self.title)

    self.horizontalBar = LUI.UIImage.new()
    self.horizontalBar:setScaledLeftRight(true, false, 0, 177)
    self.horizontalBar:setScaledTopBottom(true, false, 35, 36)
    Wzu.SetRGBFromTable(self.horizontalBar, Wzu.Swatches.MenuTitle)

    self:addElement(self.horizontalBar)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end