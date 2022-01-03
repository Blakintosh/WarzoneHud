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

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(false, false, -50, 50)
    self.label:setScaledTopBottom(true, false, 3, 17)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Wzu.ScaleWidgetToLabel.Centered(self, self.label, 10)
        Wzu.ScaleWidgetToLabel.CenteredDownscale(self:getParent(), self.label, 10)
    end)

    Wzu.LinkToWidget(self.label, self, "name", function(modelValue)
        self.label:setText(Engine.Localize(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")))
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