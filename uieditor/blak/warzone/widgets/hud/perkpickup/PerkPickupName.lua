Warzone.PerkPickupName = InheritFrom(LUI.UIElement)

function Warzone.PerkPickupName.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PerkPickupName)
    self.id = "PerkPickupName"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.weaponName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.weaponName:setScaledLeftRight(true, false, 0, 300)
    self.weaponName:setScaledTopBottom(true, false, -4, 20)
    Util.SubscribeToText(self.weaponName, controller, "prospectivePerk.attributes.name")

    Util.AddShadowedElement(self, self.weaponName)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end