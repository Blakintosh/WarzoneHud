require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")

Warzone.ReloadButtonPrompt = InheritFrom(LUI.UIElement)

function Warzone.ReloadButtonPrompt.new(menu, controller)
    local self = LUI.UIHorizontalList.new({left = 0, top = 0, right = 0, bottom = 0, leftAnchor = true, topAnchor = true, rightAnchor = true, bottomAnchor = true, spacing = 0})
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setAlignment(LUI.Alignment.Center)
    self:setClass(Warzone.ReloadButtonPrompt)
    self:setSpacing(15)
    self.id = "ReloadButtonPrompt"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.button = Warzone.ButtonPrompt.new(menu, controller)
    self.button:setScaledLeftRight(true, false, 0, 16)
    self.button:setScaledTopBottom(true, false, 0, 16)
    self.button:setButtonPrompt("reload", "usereload")
    --self.button.keyBind:setText(Engine.Localize("[{+reload}]"))

    Util.ClipSequence(self, self.button, "Reload", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.button, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.button)

    self.prompt = Util.ContainedShadowTextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain)
    self.prompt:setScaledLeftRight(true, false, 0, 64)
    self.prompt:setScaledTopBottom(true, false, -1, 17)

    self.prompt.text:setText(Engine.Localize("RELOAD"))

    Util.ClipSequence(self, self.prompt, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0,
            exec = function()
                self.prompt.text:setText(Engine.Localize("RELOAD"))
            end,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
        }
    })
    Util.ClipSequence(self, self.prompt, "Reload", {
        {
            duration = 0,
            setAlpha = 1,
            exec = function()
                self.prompt.text:setText(Engine.Localize("RELOAD"))
            end,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
        }
    })

    self:addElement(self.prompt)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        Reload = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Reload")
            end
        },
        Low = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        No = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
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
                local returnValue = IsLowAmmoClip(controller)
                if returnValue then
                    returnValue = IsLowAmmoDWClip(controller)
                end
                return returnValue
            end
        }
    })

    Util.SubState(controller, menu, self, "currentWeapon.weapon")
    Util.SubState(controller, menu, self, "currentWeapon.ammoInDWClip")
    Util.SubState(controller, menu, self, "currentWeapon.ammoInClip")
    Util.SubState(controller, menu, self, "currentWeapon.ammoStock")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end