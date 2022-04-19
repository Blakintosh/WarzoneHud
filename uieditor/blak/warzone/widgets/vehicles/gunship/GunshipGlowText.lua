Warzone.GunshipGlowText = InheritFrom(LUI.UIElement)

Warzone.GunshipGlowText.new = function (HudRef, InstanceRef)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, InstanceRef)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.GunshipGlowText)
	self.id = "GunshipGlowText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true

    self.backer = LUI.UIText.new()
    self.backer:setLeftRight(true, true, 0, 0)
    self.backer:setTopBottom(true, true, 0, 0)
    self.backer:setRGB(0, 0, 0)
    self.backer:setAlpha(0.4)
    self.backer:setTTF("fonts/killstreak_regular.ttf")
    self.backer:setText(Engine.Localize("MENU_NEW"))
    self.backer:setMaterial(LUI.UIImage.GetCachedMaterial("sw4_2d_uie_font_cached_glow"))
	self.backer:setShaderVector(0.000000, 0.65, 0.000000, 0.000000, 0.000000)
	self.backer:setShaderVector(1.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	self.backer:setShaderVector(2.000000, 1.000000, 0.000000, 0.000000, 0.000000)

    self:addElement(self.backer)

    self.text = LUI.UIText.new()
    self.text:setLeftRight(true, true, 0, 0)
    self.text:setTopBottom(true, true, 0, 0)
    self.text:setTTF("fonts/killstreak_regular.ttf")
    self.text:setText(Engine.Localize("MENU_NEW"))

    self:addElement(self.text)

    LUI.OverrideFunction_CallOriginalFirst(self, "setLeftRight", function(Sender, a1, a2, a3, a4)
        local Start = a3 - a4
        if a1 then
            Start = 0
        end
        local End = a4 - a3
        if a2 then
            End = 0
        end
        Sender.backer:setLeftRight(a1, a2, Start, End)
        Sender.text:setLeftRight(a1, a2, Start, End)
    end)

    LUI.OverrideFunction_CallOriginalFirst(self, "setTopBottom", function(Sender, a1, a2, a3, a4)
        local Start = a3 - a4
        if a1 then
            Start = 0
        end
        local End = a4 - a3
        if a2 then
            End = 0
        end
        Sender.backer:setTopBottom(a1, a2, Start, End)
        Sender.text:setTopBottom(a1, a2, Start, End)
    end)

    self.setGlowText = function(Widget, Text)
        Widget.backer:setText(Text)
        Widget.text:setText(Text)
    end

    if PostLoadFunc then
		PostLoadFunc(self, InstanceRef, HudRef)
	end
	return self
end