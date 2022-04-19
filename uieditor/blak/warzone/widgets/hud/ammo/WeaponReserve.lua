Warzone.WeaponReserve = InheritFrom(LUI.UIElement)

function Warzone.WeaponReserve.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponReserve)
    self.id = "WeaponReserve"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.ammoReserve = Util.TextElement(Util.Fonts.MainRegular, Util.Colors.Grey191, true)
    self.ammoReserve:setScaledLeftRight(false, true, -200, 0)
    self.ammoReserve:setScaledTopBottom(true, true, 0, 0)

    Util.SubscribeToText(self.ammoReserve, controller, "currentWeapon.ammoStock")

    Util.ClipSequence(self, self.ammoReserve, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Util.ConvertColorToTable(Util.Colors.Grey191)
        }
    })
    Util.ClipSequence(self, self.ammoReserve, "NoAmmo", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDWarning)
        }
    })
    Util.ClipSequence(self, self.ammoReserve, "NoDraw", {
        {
            duration = 0,
            setAlpha = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.Grey191)
        }
    })
    
    Util.AddShadowedElement(self, self.ammoReserve)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Util.AnimateSequence(self, "DefaultState")
                end)
            end
        },
        NoAmmo = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Util.AnimateSequence(self, "NoAmmo")
                end)
            end
        },
        NoDraw = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Util.AnimateSequence(self, "NoDraw")
                end)
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "NoDraw",
            condition = function(menu, self, event)
                return not WeaponUsesAmmo(controller)
            end
        },
        {
            stateName = "NoAmmo",
            condition = function(menu, self, event)
                return IsModelValueEqualTo(controller, "currentWeapon.ammoStock", 0)
            end
        }
    })

    Util.SubState(controller, menu, self, "currentWeapon.weapon")
    Util.SubState(controller, menu, self, "currentWeapon.ammoStock")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end