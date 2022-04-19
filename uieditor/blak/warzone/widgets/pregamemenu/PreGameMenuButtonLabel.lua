Warzone.PreGameMenuButtonLabel = InheritFrom(LUI.UIElement)

function Warzone.PreGameMenuButtonLabel.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PreGameMenuButtonLabel)
    self:makeFocusable()
    self.id = "PreGameMenuButtonLabel"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.label = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(true, false, 14, 100)
    self.label:setScaledTopBottom(true, false, 8, 23)

    --[[LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Blak.DebugUtils.SafeRunFunction(function()
        Util.ScaleWidgetToLabel.DownscaleWithMinimum(self:getParent(), self.label, 10, 335)
        Util.ScaleWidgetToLabel.CenteredWithMinimum(self, self.label, 10, 335)
        end)
    end)]]

    Util.LinkToWidget(self.label, self, "displayText", function(modelValue)
        self.label:setText(Engine.Localize(modelValue))
    end)

    Util.ClipSequence(self, self.label, "DefaultUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault)
        }
    })
    Util.ClipSequence(self, self.label, "DefaultOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault)
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