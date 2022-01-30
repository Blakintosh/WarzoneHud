require("ui.uieditor.blak.warzone.widgets.hud.reloadprompt.ReloadButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.reloadprompt.LowAmmoPrompt")

Warzone.ReloadPrompt = InheritFrom(LUI.UIElement)

function Warzone.ReloadPrompt.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ReloadPrompt)
    self:setSpacing(15)
    self.id = "ReloadPrompt"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.lowAmmo = Warzone.LowAmmoPrompt.new(menu, controller)
    self.lowAmmo:setScaledLeftRight(false, false, -240, 240)
    self.lowAmmo:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.lowAmmo)

    self.reload = Warzone.ReloadButtonPrompt.new(menu, controller)
    self.reload:setScaledLeftRight(false, false, -240, 240)
    self.reload:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.reload)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        Reload = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Reload")
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
        },
        {
            stateName = "Reload",
            condition = function(menu, self, event)
                return IsLowAmmoClip(controller)
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
    Wzu.SubState(controller, menu, self, "currentWeapon.ammoStock")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end