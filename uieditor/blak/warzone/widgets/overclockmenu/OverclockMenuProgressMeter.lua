Warzone.OverclockMenuProgressMeter = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), "focusedUpgradeIndex")
end

function Warzone.OverclockMenuProgressMeter.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuProgressMeter)
    self.id = "OverclockMenuProgressMeter"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.backer = LUI.UIImage.new()
    self.backer:setScaledLeftRight(true, true, 0, 0)
    self.backer:setScaledTopBottom(true, false, 0, 8)
    Util.SetRGBFromTable(self.backer, Util.Colors.WarmerMedGrey)

    self:addElement(self.backer)

    self.filler = LUI.UIImage.new()
    self.filler:setScaledLeftRight(true, true, 0.5, -0.5)
    self.filler:setScaledTopBottom(true, false, 0.5, 7.5)
    Util.SetRGBFromTable(self.filler, Util.Swatches.HUDShadow)

    self:addElement(self.filler)

    local progressForOC = {0, 0.167, 0.5, 1}

    self.upgradeMeter = LUI.UIImage.new()
    self.upgradeMeter:setScaledLeftRight(true, true, 0.5, -0.5)
    self.upgradeMeter:setScaledTopBottom(true, false, 0.5, 7.5)
    Util.SetRGBFromTable(self.upgradeMeter, Util.Colors.BlueGrey)
    self.upgradeMeter:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.upgradeMeter:setShaderVector(1, 0, 0, 0, 0)
    self.upgradeMeter:setShaderVector(2, 1, 0, 0, 0)
    self.upgradeMeter:setShaderVector(3, 0, 0, 0, 0)
    self.upgradeMeter:setShaderVector(0, 0, 0, 0, 0)

    Util.Subscribe(self.upgradeMeter, controller, "overclockTree.focusedUpgradeIndex", function(modelValue)
        self.upgradeMeter:setShaderVector(0, progressForOC[modelValue + 1], 0, 0, 0)
    end)

    self:addElement(self.upgradeMeter)

    self.progress = LUI.UIImage.new()
    self.progress:setScaledLeftRight(true, true, 0.5, -0.5)
    self.progress:setScaledTopBottom(true, false, 0.5, 7.5)
    Util.SetRGBFromTable(self.progress, Util.Colors.PictonBlue)
    self.progress:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.progress:setShaderVector(1, 0, 0, 0, 0)
    self.progress:setShaderVector(2, 1, 0, 0, 0)
    self.progress:setShaderVector(3, 0, 0, 0, 0)
    self.progress:setShaderVector(0, 0, 0, 0, 0)

    Util.Subscribe(self.progress, controller, "currentWeapon.weaponOverclocks", function(modelValue)
        self.progress:setShaderVector(0, progressForOC[modelValue + 1], 0, 0, 0)
    end)

    self:addElement(self.progress)

    self.base = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.base:setScaledLeftRight(true, false, 0, 100)
    self.base:setScaledTopBottom(true, false, 8, 22)
    self.base:setText("BASE")

    self:addElement(self.base)

    self.label1 = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.label1:setScaledLeftRight(false, false, -209.5, -207.5)
    self.label1:setScaledTopBottom(true, false, 8, 22)
    self.label1:setText("1.5X")

    self:addElement(self.label1)

    self.label2 = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.label2:setScaledLeftRight(false, false, -1, 1)
    self.label2:setScaledTopBottom(true, false, 8, 22)
    self.label2:setText("2.5X")

    self:addElement(self.label2)

    self.label3 = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.label3:setScaledLeftRight(false, true, -100, 0)
    self.label3:setScaledTopBottom(true, false, 8, 22)
    self.label3:setText("4X")

    self:addElement(self.label3)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end