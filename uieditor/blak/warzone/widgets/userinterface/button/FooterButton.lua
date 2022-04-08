require("ui.uieditor.blak.warzone.widgets.userinterface.button.ButtonPromptBackground")

Warzone.FooterButton = InheritFrom(LUI.UIElement)

function Warzone.FooterButton.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.FooterButton)
    self.id = "FooterButton"
    self.soundSet = "iw8"
	self:setHandleMouse(true)
    self.anyChildUsesUpdateState = true

    self.background = Warzone.ButtonPromptBackground.new(menu, controller)
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.background)

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.label:setScaledLeftRight(false, false, -16, 16)
    self.label:setScaledTopBottom(false, false, -7, 7)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(widget, text)
        Wzu.ScaleWidgetToLabel.Centered(self, self.label, 8)
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
            Over = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        }
    }

    self:registerEventHandler("mouseenter", function(self, event)
        self.background:processEvent(event)
        self:playSound("list_up", controller)
        return LUI.UIElement.mouseEnter(self, event)
    end)

    self:registerEventHandler("mouseleave", function(self, event)
        self.background:processEvent(event)
        return LUI.UIElement.mouseLeave(self, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end