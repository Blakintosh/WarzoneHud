Warzone.OverclockMenuButtonLabel = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuButtonLabel.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuButtonLabel)
    self:makeFocusable()
    self.id = "OverclockMenuButtonLabel"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.label = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(false, false, -50, 50)
    self.label:setScaledTopBottom(true, false, 3, 17)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Util.ScaleWidgetToLabel.Centered(self, self.label, 10)
        Util.ScaleWidgetToLabel.CenteredDownscale(self:getParent(), self.label, 10)
    end)

    Util.LinkToWidget(self.label, self, "name", function(modelValue)
        self.label:setText(Engine.Localize(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")))
    end)

    Util.ClipSequence(self, self.label, "DefaultUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault),
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.label, "DefaultOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault),
            setAlpha = 1
        },
        {
            duration = 100,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextFocus)
        }
    })
    Util.ClipSequence(self, self.label, "DisabledUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDisabled),
            setAlpha = 0.6
        }
    })
    Util.ClipSequence(self, self.label, "DisabledOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDisabled),
            setAlpha = 0.6
        }
    })
    
    self:addElement(self.label)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Util.AnimateSequence(self, "DefaultOver")
            end
        },
        Disabled = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DisabledUp")
            end,
            Focus = function()
                Util.AnimateSequence(self, "DisabledOver")
            end
        }
    }

    --self:playClip("Focus")
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end