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

    self.ammoReserve = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Colors.Grey191, true)
    self.ammoReserve:setScaledLeftRight(false, true, -200, 0)
    self.ammoReserve:setScaledTopBottom(true, true, 0, 0)

    Wzu.SubscribeToText(self.ammoReserve, controller, "currentWeapon.ammoStock")

    Wzu.ClipSequence(self, self.ammoReserve, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.Grey191)
        }
    })
    Wzu.ClipSequence(self, self.ammoReserve, "NoAmmo", {
        {
            duration = 0,
            setAlpha = 1,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })
    Wzu.ClipSequence(self, self.ammoReserve, "NoDraw", {
        {
            duration = 0,
            setAlpha = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.Grey191)
        }
    })
    
    Wzu.AddShadowedElement(self, self.ammoReserve)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Wzu.AnimateSequence(self, "DefaultState")
                end)
            end
        },
        NoAmmo = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Wzu.AnimateSequence(self, "NoAmmo")
                end)
            end
        },
        NoDraw = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Wzu.AnimateSequence(self, "NoDraw")
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

    Wzu.SubState(controller, menu, self, "currentWeapon.weapon")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoStock")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end