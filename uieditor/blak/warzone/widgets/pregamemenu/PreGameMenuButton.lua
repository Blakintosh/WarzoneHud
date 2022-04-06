require("ui.uieditor.blak.warzone.widgets.userinterface.button.ButtonBackground")
require("ui.uieditor.blak.warzone.widgets.pregamemenu.PreGameMenuButtonLabel")

Warzone.PreGameMenuButton = InheritFrom(LUI.UIElement)

function Warzone.PreGameMenuButton.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PreGameMenuButton)
    self.id = "PreGameMenuButton"
    self.soundSet = "iw8"
    self:setScaledLeftRight(true, false, 0, 335)
    self:setScaledTopBottom(true, false, 0, 32)
    self:makeFocusable()
	self:setHandleMouse(true)
    self.anyChildUsesUpdateState = true

    self.background = Warzone.ButtonBackground.new(menu, controller)
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.background)

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(true, false, 14, 100)
    self.label:setScaledTopBottom(true, false, 8, 23)

    Wzu.LinkToWidgetText(self.label, self, "displayText")

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

    --[[self:registerEventHandler("mouseenter", function(self, event)
        self:dispatchEventToChildren(event)
        return LUI.UIElement.mouseEnter(self, event)
    end)

    self:registerEventHandler("mouseleave", function(self, event)
        self:dispatchEventToChildren(event)
        return LUI.UIElement.mouseLeave(self, event)
    end)]]

    self:registerEventHandler("gain_focus", function(self, event)
        self.background:processEvent(event)
        return LUI.UIElement.gainFocus(self, event)
    end)

    self:registerEventHandler("lose_focus", function(self, event)
        self.background:processEvent(event)
        return LUI.UIElement.loseFocus(self, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end