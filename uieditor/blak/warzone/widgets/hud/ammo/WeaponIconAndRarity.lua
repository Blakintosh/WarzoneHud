Warzone.WeaponIconAndRarity = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponIcon"), "blacktransparent")
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponOverclockName"), "")
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponRarity"), 0)
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
    Wzu.SetRGBFromTable(self.weaponRarity, Wzu.Swatches.Rarities[1])

    Wzu.Subscribe(self.weaponRarity, controller, "currentWeapon.weaponRarity", function(modelValue)
        if Wzu.Swatches.Rarities[modelValue + 1] then
            Wzu.SetRGBFromTable(self.weaponRarity, Wzu.Swatches.Rarities[modelValue + 1])
        else
            Wzu.SetRGBFromTable(self.weaponRarity, Wzu.Swatches.Rarities[1])
        end
    end)

    self:addElement(self.weaponRarity)

    self.weaponIcon = LUI.UIImage.new()
    self.weaponIcon:setScaledLeftRight(true, false, 24, 152)
    self.weaponIcon:setScaledTopBottom(true, false, 2, 66)

    self.weaponIcon:setImage(RegisterImage("blacktransparent"))
    Wzu.SubscribeToImage(self.weaponIcon, controller, "currentWeapon.weaponIcon")

    self:addElement(self.weaponIcon)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end