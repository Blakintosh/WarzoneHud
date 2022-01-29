require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponClip")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponDualClip")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.WeaponClipSlash")

Warzone.WeaponClipInfo = InheritFrom(LUI.UIElement)

function Warzone.WeaponClipInfo.new(menu, controller)
    local self = LUI.UIHorizontalList.new({left = 0, top = 0, right = 0, bottom = 0, leftAnchor = true, topAnchor = true, rightAnchor = true, bottomAnchor = true, spacing = 0})
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setAlignment(LUI.Alignment.Right)
    self:setClass(Warzone.WeaponClipInfo)
    self.id = "WeaponClipInfo"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoClip = Warzone.WeaponClip.new(menu, controller)

    Wzu.ClipSequence(self, self.ammoClip, "Hidden", {
        {
            duration = 0,
            setScaledLeftRight = {false, true, -18, 0}
        }
    })

    Wzu.ClipSequence(self, self.ammoClip, "OneDigit", {
        {
            duration = 0,
            setScaledLeftRight = {false, true, -18, 0}
        }
    })
    Wzu.ClipSequence(self, self.ammoClip, "TwoDigits", {
        {
            duration = 0,
            setScaledLeftRight = {false, true, -32, 0}
        }
    })
    Wzu.ClipSequence(self, self.ammoClip, "ThreeDigits", {
        {
            duration = 0,
            setScaledLeftRight = {false, true, -46, 0}
        }
    })

    self:addElement(self.ammoClip)

    self.ammoSlash = Warzone.WeaponClipSlash.new(menu, controller)
    self.ammoSlash:setScaledLeftRight(false, true, -25, 0)
    self.ammoSlash:setScaledTopBottom(true, true, 0, 0)

    Wzu.ClipSequence(self, self.ammoSlash, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.ammoSlash, "OneDigit", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.ammoSlash, "TwoDigits", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.ammoSlash, "ThreeDigits", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.ammoSlash)

    self.ammoDWClip = Warzone.WeaponDualClip.new(menu, controller)
    self.ammoDWClip:setScaledLeftRight(false, true, -20, 0)
    self.ammoDWClip:setScaledTopBottom(true, true, 0, 0)

    Wzu.ClipSequence(self, self.ammoDWClip, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.ammoDWClip, "OneDigit", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.ammoDWClip, "TwoDigits", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.ammoDWClip, "ThreeDigits", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.ammoDWClip)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "OneDigit")
            end
        },
        Hidden = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Hidden")
            end
        },
        TwoDigits = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "TwoDigits")
            end
        },
        ThreeDigits = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "ThreeDigits")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "Hidden",
            condition = function(menu, self, event)
                return IsModelValueEqualTo(controller, "currentWeapon.ammoInDWClip", -1)
            end
        },
        {
            stateName = "ThreeDigits",
            condition = function(menu, self, event)
                return IsModelValueGreaterThanOrEqualTo(controller, "currentWeapon.ammoInClip", 100)
            end
        },
        {
            stateName = "TwoDigits",
            condition = function(menu, self, event)
                return IsModelValueGreaterThanOrEqualTo(controller, "currentWeapon.ammoInClip", 10)
            end
        }
    })

    Wzu.SubState(controller, menu, self, "currentWeapon.weapon")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoInDWClip")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoInClip")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end