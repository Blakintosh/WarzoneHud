Warzone.OverclockMenuTier = InheritFrom(LUI.UIElement)

local function SubRGBToRarity(self, controller)
    Util.Subscribe(self, controller, "currentWeapon.weaponRarity", function(modelValue)
        if Util.Swatches.Rarities[modelValue + 1] then
            Util.SetRGBFromTable(self, Util.Swatches.Rarities[modelValue + 1])
        else
            Util.SetRGBFromTable(self, Util.Swatches.Rarities[1])
        end
    end)
end

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponDamage")
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponDps")
end

function Warzone.OverclockMenuTier.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuTier)
    self.id = "OverclockMenuTier"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.backer = LUI.UIImage.new()
    self.backer:setScaledLeftRight(true, true, 0, 0)
    self.backer:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.backer, Util.Colors.Black)
    self.backer:setAlpha(0.4)

    self:addElement(self.backer)

    self.pixelPattern = LUI.UIImage.new()
    self.pixelPattern:setScaledLeftRight(true, true, 0, 0)
    self.pixelPattern:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.pixelPattern, Util.Colors.Grey63)
    self.pixelPattern:setAlpha(0.4)
    self.pixelPattern:setImage(RegisterImage("hud_edge_glow_left"))
    self.pixelPattern:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.pixelPattern:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)
    SubRGBToRarity(self.pixelPattern, controller)

    self:addElement(self.pixelPattern)

    self.topBar = LUI.UIImage.new()
    self.topBar:setScaledLeftRight(true, true, 0, 0)
    self.topBar:setScaledTopBottom(true, false, 0, 1)
    Util.SetRGBFromTable(self.topBar, Util.Colors.Grey63)
    SubRGBToRarity(self.topBar, controller)

    self:addElement(self.topBar)

    self.bottomBar = LUI.UIImage.new()
    self.bottomBar:setScaledLeftRight(true, true, 0, 0)
    self.bottomBar:setScaledTopBottom(false, true, -1, 0)
    Util.SetRGBFromTable(self.bottomBar, Util.Colors.Grey63)
    SubRGBToRarity(self.bottomBar, controller)

    self:addElement(self.bottomBar)

    self.bottomGlow = LUI.UIImage.new()
    self.bottomGlow:setScaledLeftRight(true, true, 0, 0)
    self.bottomGlow:setScaledTopBottom(false, true, -10, 10)
    self.bottomGlow:setImage(RegisterImage("hud_glow"))
    Util.SetRGBFromTable(self.bottomGlow, Util.Colors.Grey63)
    self.bottomGlow:setAlpha(0.6)
    SubRGBToRarity(self.bottomGlow, controller)
    
    self:addElement(self.bottomGlow)

    self.weaponTier = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.weaponTier:setScaledLeftRight(true, false, 18, 150)
    self.weaponTier:setScaledTopBottom(true, false, 8, 26)

    Util.SubscribeToText_ToUpper(self.weaponTier, controller, "currentWeapon.weaponTierName")

    self:addElement(self.weaponTier)

    self.weaponOverclocks = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.weaponOverclocks:setScaledLeftRight(true, false, 18, 150)
    self.weaponOverclocks:setScaledTopBottom(true, false, 26, 44)
    self.weaponOverclocks:setText("3 Overclocks")

    Util.Subscribe(self.weaponOverclocks, controller, "currentWeapon.weaponOverclocks", function(modelValue)
        self.weaponOverclocks:setText(Engine.Localize(modelValue .. " Overclocks"))
    end)

    self:addElement(self.weaponOverclocks)

    self.weaponDamageLabel = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.weaponDamageLabel:setScaledLeftRight(false, true, -200, -68)
    self.weaponDamageLabel:setScaledTopBottom(true, false, 8, 26)
    self.weaponDamageLabel:setText("DAMAGE")

    self:addElement(self.weaponDamageLabel)

    self.weaponDpsLabel = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.weaponDpsLabel:setScaledLeftRight(false, true, -200, -68)
    self.weaponDpsLabel:setScaledTopBottom(true, false, 26, 44)
    self.weaponDpsLabel:setText("DPS")

    self:addElement(self.weaponDpsLabel)

    self.weaponDamageValue = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.weaponDamageValue:setScaledLeftRight(true, false, 277, 360)
    self.weaponDamageValue:setScaledTopBottom(true, false, 8, 26)
    self.weaponDamageValue:setText("0")

    Util.SubscribeToText(self.weaponDamageValue, controller, "currentWeapon.weaponDamage")

    self:addElement(self.weaponDamageValue)

    self.weaponDpsValue = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.weaponDpsValue:setScaledLeftRight(true, false, 277, 360)
    self.weaponDpsValue:setScaledTopBottom(true, false, 26, 44)
    self.weaponDpsValue:setText("0")

    Util.Subscribe(self.weaponDpsValue, controller, "currentWeapon.weaponDps", function(modelValue)
        self.weaponDpsValue:setText(Engine.Localize(math.ceil(modelValue)))
    end)

    self:addElement(self.weaponDpsValue)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end