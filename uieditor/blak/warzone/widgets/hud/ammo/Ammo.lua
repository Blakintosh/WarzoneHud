require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponInfo")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponIconAndRarity")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponClipReserve")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.LethalGrenade")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.TacticalGrenade")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.AltWeaponPrompt")
-- Not part of "ammo", but attached to its HUD
require("ui.uieditor.blak.warzone.widgets.hud.flashlight.Flashlight")

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

    Util.ClipSequence(self, self.weaponIcon, "Default", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, -1, 174}
        }
    })
    Util.ClipSequence(self, self.weaponIcon, "DualWield", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, -27, 148}
        }
    })
    
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

    self.altWeapon = Warzone.AltWeaponPrompt.new(menu, controller)
    self.altWeapon:setScaledLeftRight(false, true, -260, -100)
    self.altWeapon:setScaledTopBottom(false, true, -44, 0)

    self:addElement(self.altWeapon)

    self.flashlight = Warzone.Flashlight.new(menu, controller)
    self.flashlight:setScaledLeftRight(false, true, -160, -12)
    self.flashlight:setScaledTopBottom(false, true, -44, 0)

    self:addElement(self.flashlight)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Default")
            end
        },
        DualWield = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DualWield")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "DualWield",
            condition = function(menu, self, event)
                return IsModelValueGreaterThanOrEqualTo(controller, "currentWeapon.ammoInDWClip", 0)
            end
        }
    })

    Util.SubState(controller, menu, self, "currentWeapon.ammoInDWClip")
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.weaponIcon:close()
        Sender.weaponInfo:close()
        Sender.weaponAmmo:close()
        Sender.tacNade:close()
        Sender.lethalNade:close()
        Sender.flashlight:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end