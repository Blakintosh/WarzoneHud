require("ui.uieditor.blak.warzone.widgets.userinterface.button.SmallButtonBackground")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenubuttonlabel")

Warzone.OverclockMenuButton = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuButton.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuButton)
    self.id = "OverclockMenuButton"
    self:makeFocusable()
	self:setHandleMouse(true)
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true

    self.background = Warzone.SmallButtonBackground.new(menu, controller)
    self.background:setLeftRight(true, true, 0, 0)
    self.background:setTopBottom(true, true, 0, 0)

    self:addElement(self.background)

    self.labelContainer = Warzone.OverclockMenuButtonLabel.new(menu, controller)
    self.labelContainer:setScaledLeftRight(false, false, -50, 50)
    self.labelContainer:setScaledTopBottom(false, false, -11, 11)
    self.labelContainer:setScale(1 / _ResolutionScalar)

    Wzu.LinkWidgetToElementModel(self.labelContainer, self, controller)

    self:addElement(self.labelContainer)

    menu:AddButtonCallbackFunction(self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
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
    end, false)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(0)
            end,
            Focus = function()
                self:setupElementClipCounter(0)
            end
        },
        Disabled = {
            DefaultClip = function()
                self:setupElementClipCounter(0)
            end,
            Focus = function()
                self:setupElementClipCounter(0)
            end
        }
    }
    
    self:mergeStateConditions({{stateName = "Disabled", condition = function (menu, self, event)
		if not IsDisabled(self, controller) then
            return IsSelfModelValueEqualTo(self, controller, "available", 0)
        end
        return true
	end}})

    Wzu.LinkWidgetToState(self, self, menu, "disabled")
    Wzu.LinkWidgetToState(self, self, menu, "available")

    self:registerEventHandler("gain_focus", function(self, event)
        self.background:processEvent(event)
        self.labelContainer:processEvent(event)
        return LUI.UIElement.gainFocus(self, event)
    end)

    self:registerEventHandler("lose_focus", function(self, event)
        self.background:processEvent(event)
        self.labelContainer:processEvent(event)
        return LUI.UIElement.loseFocus(self, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end