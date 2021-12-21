require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponClip")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponReserve")

Warzone.WeaponClipReserve = InheritFrom(LUI.UIElement)

function Warzone.WeaponClipReserve.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponClipReserve)
    self.id = "WeaponClipReserve"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoClip = Warzone.WeaponClip.new(menu, controller)
    self.ammoClip:setScaledLeftRight(false, true, -200, 0)
    self.ammoClip:setScaledTopBottom(true, false, -3.5, 28)

    self:addElement(self.ammoClip)

    self.ammoReserve = Warzone.WeaponReserve.new(menu, controller)
    self.ammoReserve:setScaledLeftRight(false, true, -200, 0)
    self.ammoReserve:setScaledTopBottom(true, false, 28, 49)

    self:addElement(self.ammoReserve)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end