require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponInfo")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponIconAndRarity")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponClipReserve")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.LethalGrenade")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.TacticalGrenade")

Warzone.Ammo = InheritFrom(LUI.UIElement)

function Warzone.Ammo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Ammo)
    self.id = "Ammo"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.weaponIcon = Warzone.WeaponIconAndRarity.new(menu, controller)
    self.weaponIcon:setScaledLeftRight(true, false, -1, 174)
    self.weaponIcon:setScaledTopBottom(true, false, 22, 95)
    self:addElement(self.weaponIcon)
    
    self.weaponInfo = Warzone.WeaponInfo.new(menu, controller)
    self.weaponInfo:setScaledLeftRight(true, false, 0, 300)
    self.weaponInfo:setScaledTopBottom(true, false, 0, 27)
    self:addElement(self.weaponInfo)

    self.weaponAmmo = Warzone.WeaponClipReserve.new(menu, controller)
    self.weaponAmmo:setScaledLeftRight(false, true, -334, -134)
    self.weaponAmmo:setScaledTopBottom(true, false, 31, 76)
    self:addElement(self.weaponAmmo)

    self.tacNade = Warzone.TacticalGrenade.new(menu, controller)
    self.tacNade:setScaledLeftRight(false, true, -108, -60)
    self.tacNade:setScaledTopBottom(false, true, -76, -52)
    self:addElement(self.tacNade)

    self.lethalNade = Warzone.LethalGrenade.new(menu, controller)
    self.lethalNade:setScaledLeftRight(false, true, -60, -12)
    self.lethalNade:setScaledTopBottom(false, true, -76, -52)
    self:addElement(self.lethalNade)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.weaponIcon:close()
        Sender.weaponInfo:close()
        Sender.weaponAmmo:close()
        Sender.tacNade:close()
        Sender.lethalNade:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end