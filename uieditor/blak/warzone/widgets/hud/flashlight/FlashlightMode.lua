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

    self.text = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.text:setScaledLeftRight(false, false, -8, 8)
    self.text:setScaledTopBottom(true, false, 1.5, 10.5)

    Util.LinkToWidgetText(self.text, self, "displayText")

    Util.ClipSequence(self, self.text, "Default", {
        {
            duration = 0,
            setTTF = Util.Fonts.MainRegular,
            setAlpha = 0.5
        }
    })
    Util.ClipSequence(self, self.text, "Active", {
        {
            duration = 0,
            setTTF = Util.Fonts.MainBold,
            setAlpha = 1
        }
    })

    self:addElement(self.text)

    self.footer = LUI.UIImage.new()
    self.footer:setScaledLeftRight(false, false, -8, 8)
    self.footer:setScaledTopBottom(false, true, -1, 0)

    Util.ClipSequence(self, self.footer, "Default", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        }
    })
    Util.ClipSequence(self, self.footer, "Active", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        },
        {
            duration = 200,
            interpolation = Util.TweenGraphs.inOutSine,
            setScaledLeftRight = {false, false, -8, 8}
        }
    })

    self:addElement(self.footer)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Default")
            end
        },
        Active = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Active")
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
    Util.SubState(controller, menu, self, "hudItems.flashlightMode")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end