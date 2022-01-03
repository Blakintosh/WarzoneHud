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
    self.soundSet = "default"
    self:setLeftRight(true, false, 0, 335)
    self:setTopBottom(true, false, 0, 32)
    self:makeFocusable()
	self:setHandleMouse(true)
    self.anyChildUsesUpdateState = true

    self.background = Warzone.ButtonBackground.new(menu, controller)
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.background)

    self.labelContainer = Warzone.PreGameMenuButtonLabel.new(menu, controller)
    self.labelContainer:setScaledLeftRight(false, false, -50, 50)
    self.labelContainer:setScaledTopBottom(false, false, -16, 16)

    self:addElement(self.labelContainer)

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
            Focus = function()
                Wzu.AnimateSequence(self, "DefaultOver")
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