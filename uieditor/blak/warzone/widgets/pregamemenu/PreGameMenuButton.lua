require("ui.uieditor.blak.warzone.widgets.userinterface.button.ButtonBackground")

Warzone.PreGameMenuButton = InheritFrom(LUI.UIElement)

function Warzone.PreGameMenuButton.new(menu, controller)
    local self = LUI.UIButton.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PreGameMenuButton)
    self.id = "PreGameMenuButton"
    self:makeFocusable()
	self:setHandleMouse(true)
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = Warzone.ButtonBackground.new(menu, controller)
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.background)

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(true, false, 14, 100)
    self.label:setScaledTopBottom(true, false, 3, 17)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Wzu.ScaleWidgetToLabel.WithMinimum(self, self.label, 10, 335)
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

    --[[menu:AddButtonCallbackFunction(self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        Blak.DebugUtils.Log("amongus")
        if self.currentState ~= "Disabled" then
            Engine.SendMenuResponse(controller, "OverclockMenu", self.index) -- This is really ghetto but the more lua i do the more i realise i dont care
            return true
        end
        return false
    end, function(ItemRef, menu, controller)
        if self.currentState ~= "Disabled" then
            CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
            return true
        end
        return false
    end, false)]]

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
        self:dispatchEventToChildren(event)
        return LUI.UIElement.mouseEnter(self, event)
    end)

    self:registerEventHandler("mouseleave", function(self, event)
        self:dispatchEventToChildren(event)
        return LUI.UIElement.mouseLeave(self, event)
    end)

    self:registerEventHandler("gain_focus", function(self, event)
        self:dispatchEventToChildren(event)
        return LUI.UIElement.gainFocus(self, event)
    end)

    self:registerEventHandler("lose_focus", function(self, event)
        self:dispatchEventToChildren(event)
        return LUI.UIElement.loseFocus(self, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end