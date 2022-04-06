require("ui.uieditor.blak.warzone.widgets.basewidgets.CorneredBorder")

Warzone.OverlayBackground = InheritFrom(LUI.UIElement)

Warzone.OverlayBackground.new = function (menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.OverlayBackground)
	self.id = "OverlayBackground"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true

    self.mainBg = LUI.UIImage.new()
    self.mainBg:setScaledLeftRight(true, true, 0, 0)
    self.mainBg:setScaledTopBottom(true, true, 0, 0)
    self.mainBg:setAlpha(0.35)
    Wzu.SetRGBFromTable(self.mainBg, Wzu.Swatches.PopupBackground)

    self:addElement(self.mainBg)

    self.dotBg = LUI.UIImage.new()
    self.dotBg:setScaledLeftRight(true, true, 0, 0)
    self.dotBg:setScaledTopBottom(true, true, 0, 0)
    self.dotBg:setAlpha(0.35)

    self.dotBg:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.dotBg:setShaderVector(0, 2, 2, 1, 1)
    
    Wzu.SetRGBFromTable(self.dotBg, Wzu.Swatches.PopupBgGradient)

    self:addElement(self.dotBg)

    self.gradBg = LUI.UIImage.new()
    self.gradBg:setScaledLeftRight(true, true, 0, 0)
    self.gradBg:setScaledTopBottom(true, true, 0, 0)
    self.gradBg:setAlpha(0.7)

    self.gradBg:setImage(RegisterImage("widg_gradient_bottom_to_top"))
    self.gradBg:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.gradBg:setShaderVector(0, 2, 2, 1, 1)
    Wzu.SetRGBFromTable(self.gradBg, Wzu.Swatches.PopupBgGradient)

    self:addElement(self.gradBg)

    self.borders = Warzone.CorneredBorder.new(menu, controller, 20)
    self.borders:setScaledLeftRight(true, true, 0, 0)
    self.borders:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.borders, Wzu.Swatches.PopupFrame)

    self:addElement(self.borders)

    self.glowTop = LUI.UIImage.new()
    self.glowTop:setScaledLeftRight(true, true, 0, 0)
    self.glowTop:setScaledTopBottom(true, false, -2, 3)
    Wzu.SetRGBFromTable(self.glowTop, Wzu.Swatches.PopupFrame)
    self.glowTop:setImage(RegisterImage("hud_glow"))

    self:addElement(self.glowTop)

    self.glowBottom = LUI.UIImage.new()
    self.glowBottom:setScaledLeftRight(true, true, 0, 0)
    self.glowBottom:setScaledTopBottom(false, true, -3, 2)
    Wzu.SetRGBFromTable(self.glowBottom, Wzu.Swatches.PopupFrame)
    self.glowBottom:setImage(RegisterImage("hud_glow"))

    self:addElement(self.glowBottom)
    
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

