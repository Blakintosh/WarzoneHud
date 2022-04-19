Warzone.WeaponPickupName = InheritFrom(LUI.UIElement)

function Warzone.WeaponPickupName.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponPickupName)
    self.id = "WeaponPickupName"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.weaponName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.weaponName:setScaledLeftRight(true, false, 0, 300)
    self.weaponName:setScaledTopBottom(true, false, -4, 18)

    Util.SubscribeToText(self.weaponName, controller, "prospectiveWeapon.attributes.weaponName")

    Util.AddShadowedElement(self, self.weaponName)

    self.weaponCategory = Util.TextElement(Util.Fonts.MainRegular, Util.Colors.Grey191, true)
    self.weaponCategory:setScaledLeftRight(true, false, 0, 300)
    self.weaponCategory:setScaledTopBottom(true, false, 16, 28)

    Util.SubscribeToText(self.weaponCategory, controller, "prospectiveWeapon.attributes.weaponClass")

    Util.AddShadowedElement(self, self.weaponCategory)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end