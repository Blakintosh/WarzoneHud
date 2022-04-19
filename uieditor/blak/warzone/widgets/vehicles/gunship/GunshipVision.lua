require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipGlowText")

Warzone.GunshipVision = InheritFrom(LUI.UIElement)

Warzone.GunshipVision.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.GunshipVision)
	self.id = "GunshipVision"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true

    self.visionMode = Warzone.GunshipGlowText.new(menu, controller)
    self.visionMode:setScaledLeftRight(true, false, 0, 300)
    self.visionMode:setScaledTopBottom(true, false, 0, 30)
    self.visionMode:setGlowText("NORM")

    self.visionMode:linkToElementModel(menu, "visionMode", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.visionMode:setText(ModelVal)
        end
    end)

    self:addElement(self.visionMode)

    self.label = Warzone.GunshipGlowText.new(menu, controller)
    self.label:setScaledLeftRight(true, false, 0, 300)
    self.label:setScaledTopBottom(true, false, 30, 44)
    self.label:setGlowText("Vision System")

    self:addElement(self.label)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.label:close()
        Sender.visionMode:close()
	end)

    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end