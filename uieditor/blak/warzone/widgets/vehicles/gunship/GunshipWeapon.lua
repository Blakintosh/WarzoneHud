require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipGlowText")
require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipWeaponName")

Warzone.GunshipWeapon = InheritFrom(LUI.UIElement)

Warzone.GunshipWeapon.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.GunshipWeapon)
	self.id = "GunshipWeapon"
	self.soundSet = "default"
    self:setScaledLeftRight(true, false, 0, 100)
    self:setScaledTopBottom(true, false, 0, 60)
	self.anyChildUsesUpdateState = true

    -- e.g. 105mm
    self.caliberLabel = Warzone.GunshipWeaponName.new(menu, controller)
    self.caliberLabel:setScaledLeftRight(true, false, 0, 100)
    self.caliberLabel:setScaledTopBottom(true, false, 0, 20)

	Util.LinkWidgetToElementModel(self.caliberLabel, self, controller)
    
    self:addElement(self.caliberLabel)

    -- Ammo
    self.ammo = Warzone.GunshipGlowText.new(menu, controller)
    self.ammo:setScaledLeftRight(false, true, -100, -55)
    self.ammo:setScaledTopBottom(true, false, 34, 58)

    self.ammo:setGlowText("0")

    Util.LinkToWidget(self.ammo, self, "ammo", function(modelValue)
		Util.Subscribe(self.ammo, controller, modelValue, function(modelValue2)
			self.ammo:setGlowText(modelValue2)
		end)
	end)

    self:addElement(self.ammo)

    -- Slash
    self.slash = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.slash:setScaledLeftRight(true, false, 45, 55)
    self.slash:setScaledTopBottom(true, false, 39, 54)
    self.slash:setAlpha(0.6)
    self.slash:setText("/")

    self:addElement(self.slash)

    -- Capacity
    self.capacity = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.capacity:setScaledLeftRight(true, false, 55, 100)
    self.capacity:setScaledTopBottom(true, false, 39, 54)
    self.capacity:setAlpha(0.6)
    self.capacity:setText("0")

	Util.LinkToWidgetText(self.capacity, self, "capacity")

    self:addElement(self.capacity)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function (sender)
		sender.ammo:close()
        sender.caliberLabel:close()
	end)
    
    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end