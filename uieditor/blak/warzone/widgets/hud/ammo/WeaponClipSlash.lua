Warzone.WeaponClipSlash = InheritFrom(LUI.UIElement)

function Warzone.WeaponClipSlash.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponClipSlash)
    self.id = "WeaponClipSlash"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoSlash = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.ammoSlash:setScaledLeftRight(false, true, -20, 0)
    self.ammoSlash:setScaledTopBottom(true, true, 0, 0)

    self.ammoSlash:setText(" / ")
    
    Wzu.AddShadowedElement(self, self.ammoSlash)

    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end