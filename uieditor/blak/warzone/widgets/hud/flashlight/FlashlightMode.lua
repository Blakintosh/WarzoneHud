Warzone.FlashlightMode = InheritFrom(LUI.UIElement)

function Warzone.FlashlightMode.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.FlashlightMode)
    self.id = "FlashlightMode"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setScaledLeftRight(true, false, 0, 16)
    self:setScaledTopBottom(true, false, 0, 16)

    self.text = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.text:setScaledLeftRight(false, false, -8, 8)
    self.text:setScaledTopBottom(true, false, 1.5, 10.5)

    Wzu.LinkToWidgetText(self.text, self, "displayText")

    Wzu.ClipSequence(self, self.text, "Default", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainRegular,
            setAlpha = 0.5
        }
    })
    Wzu.ClipSequence(self, self.text, "Active", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainBold,
            setAlpha = 1
        }
    })

    self:addElement(self.text)

    self.footer = LUI.UIImage.new()
    self.footer:setScaledLeftRight(false, false, -8, 8)
    self.footer:setScaledTopBottom(false, true, -1, 0)

    Wzu.ClipSequence(self, self.footer, "Default", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        }
    })
    Wzu.ClipSequence(self, self.footer, "Active", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        },
        {
            duration = 200,
            interpolation = Wzu.TweenGraphs.inOutSine,
            setScaledLeftRight = {false, false, -8, 8}
        }
    })

    self:addElement(self.footer)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Default")
            end
        },
        Active = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Active")
            end
        }
    }

    self:mergeStateConditions({{
        stateName = "Active",
        condition = function(menu, self, event)
            local modelValue = Engine.GetModelValue(Engine.GetModel(self:getModel(), "elementId"))
            if modelValue then
                return IsModelValueEqualTo(controller, "hudItems.flashlightMode", modelValue)
            end
            return false
        end
    }})
    Wzu.SubState(controller, menu, self, "hudItems.flashlightMode")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end