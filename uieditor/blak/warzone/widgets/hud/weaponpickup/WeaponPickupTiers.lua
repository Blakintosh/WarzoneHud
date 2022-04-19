Warzone.WeaponPickupTiers = InheritFrom(LUI.UIElement)

local function SubRGBToRarity(self, controller)
    Util.Subscribe(self, controller, "prospectiveWeapon.attributes.weaponRarity", function(modelValue)
        if Util.Swatches.RaritiesLight[modelValue + 1] then
            Util.SetRGBFromTable(self, Util.Swatches.RaritiesLight[modelValue + 1])
        else
            Util.SetRGBFromTable(self, Util.Swatches.RaritiesLight[1])
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

    self.tier = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, true)
    self.tier:setScaledLeftRight(false, true, -300, 0)
    self.tier:setScaledTopBottom(true, false, 0, 16)
    self.tier:setText("S-TIER")

    Util.Subscribe(self.tier, controller, "prospectiveWeapon.attributes.weaponTier", function(modelValue)
        self.tier:setText(LocalizeToUpperString(modelValue))
    end)

    SubRGBToRarity(self.tier, controller)

    Util.AddShadowedElement(self, self.tier)

    self.msiAfterburner = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.msiAfterburner:setScaledLeftRight(false, true, -300, 0)
    self.msiAfterburner:setScaledTopBottom(true, false, 16, 26)
    self.msiAfterburner:setText("0 OVERCLOCKS")

    SubRGBToRarity(self.msiAfterburner, controller)

    Util.Subscribe(self.msiAfterburner, controller, "prospectiveWeapon.attributes.weaponOverclocks", function(modelValue)
        self.msiAfterburner:setText(LocalizeToUpperString(modelValue .. " overclocks"))
    end)

    Util.AddShadowedElement(self, self.msiAfterburner)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end