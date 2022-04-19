Warzone.WeaponDualClip = InheritFrom(LUI.UIElement)

function Warzone.WeaponDualClip.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponDualClip)
    self.id = "WeaponDualClip"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoClip = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, true)
    self.ammoClip:setScaledLeftRight(false, true, -20, 0)
    self.ammoClip:setScaledTopBottom(true, true, 0, 0)

    Util.SubscribeToText(self.ammoClip, controller, "currentWeapon.ammoInDWClip")

    Util.ClipSequence(self, self.ammoClip, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
        }
    })
    Util.ClipSequence(self, self.ammoClip, "LowAmmo", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDWarning)
        }
    })
    Util.ClipSequence(self, self.ammoClip, "UnlimitedAmmo", {
        {
            duration = 0,
            setAlpha = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
        }
    })
    
    Util.AddShadowedElement(self, self.ammoClip)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        LowAmmo = {
            DefaultClip = function()
                Util.AnimateSequence(self, "LowAmmo")
            end
        },
        UnlimitedAmmo = {
            DefaultClip = function()
                Util.AnimateSequence(self, "UnlimitedAmmo")
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
                return IsLowAmmoDWClip(controller)
            end
        }
    })

    Util.SubState(controller, menu, self, "currentWeapon.weapon")
    Util.SubState(controller, menu, self, "currentWeapon.ammoInDWClip")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end