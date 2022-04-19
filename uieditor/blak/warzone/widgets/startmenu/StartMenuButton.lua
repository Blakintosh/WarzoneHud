require("ui.uieditor.blak.warzone.widgets.userinterface.button.ButtonBackground")

Warzone.StartMenuButton = InheritFrom(LUI.UIElement)

function Warzone.StartMenuButton.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.StartMenuButton)
    self.id = "StartMenuButton"
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

    self.label = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(true, false, 14, 100)
    self.label:setScaledTopBottom(true, false, 8, 23)

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
                Util.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Util.AnimateSequence(self, "DefaultOver")
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
        Util.SetCursorType(Util.CursorTypes.Active, controller)
        return LUI.UIElement.gainFocus(self, event)
    end)

    self:registerEventHandler("lose_focus", function(self, event)
        self.background:processEvent(event)
        Util.SetCursorType(Util.CursorTypes.Normal, controller)
        return LUI.UIElement.loseFocus(self, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end