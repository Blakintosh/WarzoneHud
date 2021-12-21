Warzone.WeaponClip = InheritFrom(LUI.UIElement)

function Warzone.WeaponClip.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponClip)
    self.id = "WeaponClip"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoClip = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.ammoClip:setScaledLeftRight(false, true, -200, 0)
    self.ammoClip:setScaledTopBottom(true, true, 0, 0)

    Wzu.SubscribeToText(self.ammoClip, controller, "currentWeapon.ammoInClip")

    Wzu.ClipSequence(self, self.ammoClip, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.ammoClip, "LowAmmo", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })
    Wzu.ClipSequence(self, self.ammoClip, "UnlimitedAmmo", {
        {
            duration = 0,
            setAlpha = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    
    Wzu.AddShadowedElement(self, self.ammoClip)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        LowAmmo = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "LowAmmo")
            end
        },
        UnlimitedAmmo = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "UnlimitedAmmo")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "UnlimitedAmmo",
            condition = function(menu, self, event)
                return not WeaponUsesAmmo(controller)
            end
        },
        {
            stateName = "LowAmmo",
            condition = function(menu, self, event)
                return IsLowAmmoClip(controller)
            end
        }
    })

    Wzu.SubState(controller, menu, self, "currentWeapon.weapon")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoInClip")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end