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

    self.caliberLabel:linkToElementModel(self, nil, false, function(ModelRef)
        self.caliberLabel:setModel(ModelRef, controller)
    end)
    
    self:addElement(self.caliberLabel)

    -- Ammo
    self.ammo = Warzone.GunshipGlowText.new(menu, controller)
    self.ammo:setScaledLeftRight(false, true, -100, -55)
    self.ammo:setScaledTopBottom(true, false, 34, 58)

    self.ammo:setGlowText("0")

    self.ammo:linkToElementModel(self, "ammo", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            --Widget.ammo:unsubscribeFromAllModels() --Redundancy

            self.ammo:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelVal), function(ModelRef2)
                local ModelVal2 = Engine.GetModelValue(ModelRef2)
                if ModelVal2 then
                    self.ammo:setGlowText(ModelVal2)
                end
            end)
        end
    end)

    self:addElement(self.ammo)

    -- Slash
    self.slash = LUI.UIText.new()
    self.slash:setScaledLeftRight(true, false, 45, 55)
    self.slash:setScaledTopBottom(true, false, 39, 54)
    self.slash:setTTF("fonts/killstreak_regular.ttf")
    self.slash:setAlpha(0.6)
    self.slash:setText("/")

    self:addElement(self.slash)

    -- Capacity
    self.capacity = LUI.UIText.new()
    self.capacity:setScaledLeftRight(true, false, 55, 100)
    self.capacity:setScaledTopBottom(true, false, 39, 54)
    self.capacity:setTTF("fonts/killstreak_regular.ttf")
    self.capacity:setAlpha(0.6)
    self.capacity:setText("0")

    self.capacity:linkToElementModel(self, "capacity", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.capacity:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelVal), function(ModelRef2)
                local ModelVal2 = Engine.GetModelValue(ModelRef2)
                if ModelVal2 then
                    self.capacity:setText(Engine.Localize(ModelVal2))
                end
            end)
        end
    end)

    self:addElement(self.capacity)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.ammo:close()
        Sender.caliberLabel:close()
	end)
    
    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end