Warzone.OverclockMenuProgressMeter = InheritFrom(LUI.UIElement)

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
    self.backer:setScaledTopBottom(true, false, 0, 6)
    Wzu.SetRGBFromTable(self.backer, Wzu.Swatches.HUDMain)

    self:addElement(self.backer)

    self.filler = LUI.UIImage.new()
    self.filler:setScaledLeftRight(true, true, 1, -1)
    self.filler:setScaledTopBottom(true, false, 1, 5)
    Wzu.SetRGBFromTable(self.filler, Wzu.Swatches.HUDShadow)

    self:addElement(self.filler)

    self.progress = LUI.UIImage.new()
    self.progress:setScaledLeftRight(true, true, 1, -1)
    self.progress:setScaledTopBottom(true, false, 1, 5)
    Wzu.SetRGBFromTable(self.progress, Wzu.Colors.SmoothBlue)
    self.progress:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.progress:setShaderVector(1, 0, 0, 0, 0)
    self.progress:setShaderVector(2, 1, 0, 0, 0)
    self.progress:setShaderVector(3, 0, 0, 0, 0)
    self.progress:setShaderVector(0, 0.5, 0, 0, 0)

    self:addElement(self.progress)

    self.base = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.base:setScaledLeftRight(true, false, 0, 100)
    self.base:setScaledTopBottom(true, false, 6, 20)
    self.base:setText("BASE")

    self:addElement(self.base)

    self.label1 = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.label1:setScaledLeftRight(false, false, -209.5, -207.5)
    self.label1:setScaledTopBottom(true, false, 6, 20)
    self.label1:setText("1.5X")

    self:addElement(self.label1)

    self.label2 = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.label2:setScaledLeftRight(false, false, -1, 1)
    self.label2:setScaledTopBottom(true, false, 6, 20)
    self.label2:setText("2.5X")

    self:addElement(self.label2)

    self.label3 = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.label3:setScaledLeftRight(false, true, -100, 0)
    self.label3:setScaledTopBottom(true, false, 6, 20)
    self.label3:setText("4X")

    self:addElement(self.label3)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end