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
    self.label:setLeftRight(true, false, 14, 100)
    self.label:setTopBottom(true, false, 8, 23)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Wzu.ScaleWidgetToLabel.DownscaleWithMinimum(self:getParent(), self.label, 10, 335)
        Wzu.ScaleWidgetToLabel.CenteredWithMinimum(self, self.label, 10, 335)
    end)

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
    
    self:addElement(self.label)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        }
    }

    --self:playClip("Focus")
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end