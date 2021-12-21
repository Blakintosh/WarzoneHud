Warzone.WeaponIconAndRarity = InheritFrom(LUI.UIElement)

function Warzone.WeaponIconAndRarity.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponIconAndRarity)
    self.id = "WeaponIconAndRarity"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.weaponRarity = LUI.UIImage.new()
    self.weaponRarity:setScaledLeftRight(true, false, 0, 175)
    self.weaponRarity:setScaledTopBottom(true, false, 0, 73)

    self.weaponRarity:setImage(RegisterImage("wdg_ellipse_glow"))
    self.weaponRarity:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.weaponRarity, Wzu.Colors.Rarities.Epic)

    self:addElement(self.weaponRarity)

    self.weaponIcon = LUI.UIImage.new()
    self.weaponIcon:setScaledLeftRight(true, false, 24, 152)
    self.weaponIcon:setScaledTopBottom(true, false, 2, 66)

    self.weaponIcon:setImage(RegisterImage("blacktransparent"))
    Wzu.Subscribe(self, controller, "currentWeapon.equippedWeaponReference", function(modelValue)
        modelValue = modelValue:gsub("_iw8_zm", "")
        modelValue = modelValue:gsub("_kar_zm", "")

        self.weaponIcon:setImage(RegisterImage("icon_weapon_" .. modelValue))
    end)

    self:addElement(self.weaponIcon)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end