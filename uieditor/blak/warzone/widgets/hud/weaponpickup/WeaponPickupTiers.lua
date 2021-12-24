Warzone.WeaponPickupTiers = InheritFrom(LUI.UIElement)

local function SubRGBToRarity(self, controller)
    Wzu.Subscribe(self, controller, "prospectiveWeapon.attributes.weaponRarity", function(modelValue)
        if Wzu.Swatches.Rarities[modelValue + 1] then
            Wzu.SetRGBFromTable(self, Wzu.Swatches.Rarities[modelValue + 1])
        else
            Wzu.SetRGBFromTable(self, Wzu.Swatches.Rarities[1])
        end
    end)
end

function Warzone.WeaponPickupTiers.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponPickupTiers)
    self.id = "WeaponPickupTiers"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.tier = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.tier:setScaledLeftRight(false, true, -300, 0)
    self.tier:setScaledTopBottom(true, false, 0, 16)
    self.tier:setText("S-TIER")

    Wzu.Subscribe(self.tier, controller, "prospectiveWeapon.attributes.weaponTier", function(modelValue)
        self.tier:setText(LocalizeToUpperString(modelValue))
    end)

    SubRGBToRarity(self.tier, controller)

    Wzu.AddShadowedElement(self, self.tier)

    self.msiAfterburner = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.msiAfterburner:setScaledLeftRight(false, true, -300, 0)
    self.msiAfterburner:setScaledTopBottom(true, false, 16, 26)
    self.msiAfterburner:setText("0 OVERCLOCKS")

    SubRGBToRarity(self.msiAfterburner, controller)

    Wzu.Subscribe(self.msiAfterburner, controller, "prospectiveWeapon.attributes.weaponOverclocks", function(modelValue)
        self.msiAfterburner:setText(LocalizeToUpperString(modelValue .. " overclocks"))
    end)

    Wzu.AddShadowedElement(self, self.msiAfterburner)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end