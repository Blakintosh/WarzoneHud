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

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(true, false, 14, 100)
    self.label:setScaledTopBottom(true, false, 8, 23)

    --[[LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Blak.DebugUtils.SafeRunFunction(function()
        Wzu.ScaleWidgetToLabel.DownscaleWithMinimum(self:getParent(), self.label, 10, 335)
        Wzu.ScaleWidgetToLabel.CenteredWithMinimum(self, self.label, 10, 335)
        end)
    end)]]

    Wzu.LinkToWidget(self.label, self, "displayText", function(modelValue)
        self.label:setText(Engine.Localize(modelValue))
    end)

    Wzu.ClipSequence(self, self.label, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault)
        }
    })
    Wzu.ClipSequence(self, self.label, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault)
        },
        {
            duration = 100,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextFocus)
        }
    })
    Wzu.ClipSequence(self, self.label, "DisabledUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDisabled),
            setAlpha = 0.6
        }
    })
    Wzu.ClipSequence(self, self.label, "DisabledOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDisabled),
            setAlpha = 0.6
        }
    })
    
    self:addElement(self.label)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        },
        Disabled = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DisabledUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DisabledOver")
            end
        }
    }

    --self:playClip("Focus")
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end