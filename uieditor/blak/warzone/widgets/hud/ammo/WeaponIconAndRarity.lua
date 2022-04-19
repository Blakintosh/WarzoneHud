Warzone.WeaponIconAndRarity = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponIcon"), "blacktransparent")
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponOverclockName"), "")
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponRarity"), 0)
end

local function ResolveRarityIcon(self, controller)
    local value = 1

    local ocVal = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentWeapon.weaponOverclocks"))
    if ocVal then
        value = value + ocVal
    end

    local rarityVal = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentWeapon.weaponRarity"))
    if rarityVal and rarityVal > 6 then
        value = value + 1
    end

    if rarityVal == 0 then
        self:setImage(RegisterImage("blacktransparent"))
        return
    end

    self:setImage(RegisterImage("icon_rarity_" .. tostring(value)))
end

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
    Util.SetRGBFromTable(self.weaponRarity, Util.Swatches.Rarities[1])

    Util.Subscribe(self.weaponRarity, controller, "currentWeapon.weaponRarity", function(modelValue)
        if Util.Swatches.Rarities[modelValue + 1] then
            Util.SetRGBFromTable(self.weaponRarity, Util.Swatches.Rarities[modelValue + 1])
        else
            Util.SetRGBFromTable(self.weaponRarity, Util.Swatches.Rarities[1])
        end
    end)

    self:addElement(self.weaponRarity)

    self.rarityIconGlow = LUI.UIImage.new()
    self.rarityIconGlow:setScaledLeftRight(true, false, 22, 64)
    self.rarityIconGlow:setScaledTopBottom(true, false, 32, 68)
    self.rarityIconGlow:setImage(RegisterImage("hud_glow"))
    self.rarityIconGlow:setAlpha(0.3)
    Util.SetRGBFromTable(self.rarityIconGlow, Util.Swatches.Rarities[1])

    Util.Subscribe(self.rarityIconGlow, controller, "currentWeapon.weaponRarity", function(modelValue)
        if Util.Swatches.Rarities[modelValue + 1] then
            Util.SetRGBFromTable(self.rarityIconGlow, Util.Swatches.Rarities[modelValue + 1])
        else
            Util.SetRGBFromTable(self.rarityIconGlow, Util.Swatches.Rarities[1])
        end
    end)

    self:addElement(self.rarityIconGlow)

    self.rarityIcon = LUI.UIImage.new()
    self.rarityIcon:setScaledLeftRight(true, false, 34, 50)
    self.rarityIcon:setScaledTopBottom(true, false, 42, 58)
    self.rarityIcon:setImage(RegisterImage("icon_rarity_5"))
    Util.SetRGBFromTable(self.rarityIcon, Util.Swatches.RaritiesLight[1])

    Util.Subscribe(self.rarityIcon, controller, "currentWeapon.weaponRarity", function(modelValue)
        ResolveRarityIcon(self.rarityIcon, controller)
        if Util.Swatches.RaritiesLight[modelValue + 1] then
            Util.SetRGBFromTable(self.rarityIcon, Util.Swatches.RaritiesLight[modelValue + 1])
        else
            Util.SetRGBFromTable(self.rarityIcon, Util.Swatches.RaritiesLight[1])
        end
    end)

    Util.Subscribe(self.rarityIcon, controller, "currentWeapon.weaponOverclocks", function(modelValue)
        ResolveRarityIcon(self.rarityIcon, controller)
    end)

    self:addElement(self.rarityIcon)

    self.weaponIcon = LUI.UIImage.new()
    self.weaponIcon:setScaledLeftRight(true, false, 24, 152)
    self.weaponIcon:setScaledTopBottom(true, false, 2, 66)
    self.weaponIcon:setScale(1)

    self.weaponIcon:setImage(RegisterImage("blacktransparent"))
    Util.SubscribeToImage(self.weaponIcon, controller, "currentWeapon.weaponIcon")

    self:addElement(self.weaponIcon)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end