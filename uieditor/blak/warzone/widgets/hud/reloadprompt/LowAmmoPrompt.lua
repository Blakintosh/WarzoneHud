Warzone.LowAmmoPrompt = InheritFrom(LUI.UIElement)

function Warzone.LowAmmoPrompt.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.LowAmmoPrompt)
    self.id = "LowAmmoPrompt"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.prompt = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.prompt:setScaledLeftRight(false, false, -240, 240)
    self.prompt:setScaledTopBottom(true, false, -1, 17)

    self.prompt:setText(Engine.Localize("LOW AMMO"))

    Wzu.ClipSequence(self, self.prompt, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0,
            setText = Engine.Localize("NO AMMO"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.prompt, "Low", {
        {
            duration = 0,
            setAlpha = 1,
            setText = Engine.Localize("LOW AMMO"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDCaution)
        }
    })
    Wzu.ClipSequence(self, self.prompt, "No", {
        {
            duration = 0,
            setAlpha = 1,
            setText = Engine.Localize("NO AMMO"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })

    Wzu.AddShadowedElement(self, self.prompt)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        Low = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Low")
            end
        },
        No = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "No")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "No",
            condition = function(menu, self, event)
                local returnValue = IsModelValueLessThanOrEqualTo(controller, "currentWeapon.ammoInClip", 0)
                if returnValue then
                    returnValue = IsModelValueLessThanOrEqualTo(controller, "currentWeapon.ammoInDWClip", 0)
                    if returnValue then
                        returnValue = IsModelValueLessThanOrEqualTo(controller, "currentWeapon.ammoStock", 0)
                    end
                end
                return returnValue
            end
        },
        {
            stateName = "Low",
            condition = function(menu, self, event)
                local returnValue = IsLowAmmoClip(controller)
                if returnValue then
                    returnValue = IsLowAmmoDWClip(controller)
                    if returnValue then
                        returnValue = IsModelValueLessThanOrEqualTo(controller, "currentWeapon.ammoStock", 0)
                    end
                end
                return returnValue
            end
        }
    })

    Wzu.SubState(controller, menu, self, "currentWeapon.weapon")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoInDWClip")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoInClip")
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoStock")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end