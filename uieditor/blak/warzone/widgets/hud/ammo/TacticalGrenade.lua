Warzone.TacticalGrenade = InheritFrom(LUI.UIElement)

function Warzone.TacticalGrenade.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.TacticalGrenade)
    self.id = "TacticalGrenade"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.circle = LUI.UIImage.new()
    self.circle:setScaledLeftRight(true, false, 12, 22)
    self.circle:setScaledTopBottom(true, false, 7, 17)
    self.circle:setImage(RegisterImage("hud_circle_small"))

    Util.ClipSequence(self, self.circle, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.circle, "NoAmmo", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.circle, "NoNade", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.circle)

    self.icon = LUI.UIImage.new()
    self.icon:setScaledLeftRight(true, false, 0, 24)
    self.icon:setScaledTopBottom(true, false, 0, 24)
    self.icon:setImage(RegisterImage("hud_icon_equipment_flare"))

    --Util.SubscribeToImage(self.icon, controller, "CurrentSecondaryOffhand.secondaryOffhand")

    Util.ClipSequence(self, self.icon, "DefaultState", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.White),
            setAlpha = 1,
            setScaledLeftRight = {true, false, 0, 24},
            setScaledTopBottom = {true, false, 0, 24}
        }
    })
    Util.ClipSequence(self, self.icon, "NoAmmo", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.Grey63),
            setAlpha = 1,
            setScaledLeftRight = {true, false, 3, 31},
            setScaledTopBottom = {true, false, -2, 26}
        }
    })
    Util.ClipSequence(self, self.icon, "NoNade", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.White),
            setAlpha = 0,
            setScaledLeftRight = {true, false, 0, 24},
            setScaledTopBottom = {true, false, 0, 24}
        }
    })

    self:addElement(self.icon)

    self.nadeCount = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.nadeCount:setScaledLeftRight(true, false, 24, 48)
    self.nadeCount:setScaledTopBottom(true, false, 4, 22)

    Util.SubscribeToText(self.nadeCount, controller, "CurrentSecondaryOffhand.secondaryOffhandCount")

    Util.ClipSequence(self, self.nadeCount, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.nadeCount, "NoAmmo", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.nadeCount, "NoNade", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Util.AddShadowedElement(self, self.nadeCount)

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
        NoNade = {
            DefaultClip = function()
                Blak.DebugUtils.SafeRunFunction(function()
                Util.AnimateSequence(self, "NoNade")
                end)
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "NoNade",
            condition = function(menu, self, event)
                return IsModelValueEqualTo(controller, "CurrentSecondaryOffhand.secondaryOffhand", "blacktransparent")
            end
        },
        {
            stateName = "NoAmmo",
            condition = function(menu, self, event)
                return IsModelValueEqualTo(controller, "CurrentSecondaryOffhand.secondaryOffhandCount", 0)
            end
        }
    })

    Util.SubState(controller, menu, self, "CurrentSecondaryOffhand.secondaryOffhand")
    Util.SubState(controller, menu, self, "CurrentSecondaryOffhand.secondaryOffhandCount")

    Util.Subscribe(self, controller, "CurrentPrimaryOffhand.secondaryOffhandCount", function(modelValue)
        if self.storedNadeCount and self.storedNadeCount < modelValue then
            Engine.PlaySound(Util.Sounds.Grenades.RestockTactical)
        end
        self.storedNadeCount = modelValue
    end)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end