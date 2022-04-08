require("ui.uieditor.blak.warzone.widgets.userinterface.button.SmallButtonBackground")
require("ui.uieditor.blak.warzone.widgets.userinterface.button.ButtonFocusInfo")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.OverclockMenuButtonInfoBody")
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
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)

    Wzu.LinkWidgetToElementModel(self.background, self, controller)

    self.background:mergeStateConditions({{stateName = "Disabled", condition = function (menu, widget, event)
		if not IsDisabled(self.background, controller) then
            return IsSelfModelValueEqualTo(self.background, controller, "available", 0)
        end
        return true
	end}})

    Wzu.LinkWidgetToState(self.background, self, menu, "disabled")
    Wzu.LinkWidgetToState(self.background, self, menu, "available")

    self:addElement(self.background)

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.ButtonTextDefault, false)
    self.label:setScaledLeftRight(false, false, -50, 50)
    self.label:setScaledTopBottom(true, false, 3, 17)

    LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function(sender, text)
        Wzu.ScaleWidgetToLabel.Centered(self, self.label, 10)
    end)

    Wzu.LinkToWidget(self.label, self, "name", function(modelValue)
        self.label:setText(Engine.Localize(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")))
    end)

    Wzu.ClipSequence(self, self.label, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.label, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 1
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

    self.focusInfo = Warzone.ButtonFocusInfo.new(menu, controller)
    self.focusInfo:setScaledLeftRight(false, true, 4, 40)
    self.focusInfo:setScaledTopBottom(false, true, 4, 40)
    self.focusInfo.frameWidget:changeFrameWidget("Warzone.OverclockMenuButtonInfoBody")

    Wzu.ClipSequence(self, self.focusInfo, "DefaultUp", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusInfo, "DefaultOver", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.focusInfo, "DisabledUp", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusInfo, "DisabledOver", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 1
        }
    })

	self.focusInfo:linkToElementModel(self, nil, false, function (ModelRef)
		self.focusInfo:setModel(ModelRef, controller)
	end)

    self:addElement(self.focusInfo)

    menu:AddButtonCallbackFunction(self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        if self.currentState ~= "Disabled" then
            Engine.SendMenuResponse(controller, "OverclockMenu", self.index) -- This is really ghetto but the more lua i do the more i realise i dont care
            
            local parent = self:getParent()
            if parent then
                if parent["overclockButton" .. tostring(self.index + 1)] and Engine.LastInput_Gamepad() then
                    parent["overclockButton" .. tostring(self.index)]:processEvent({name = "lose_focus", controller = controller})
                    parent["overclockButton" .. tostring(self.index + 1)]:processEvent({name = "gain_focus", controller = controller})
                end
            end
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

    --[[LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(self, state)
        self.background:setState(state)
        self.labelContainer:setState(state)
    end)]]

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
        if self.index then
            Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "overclockTree.focusedUpgradeIndex"), self.index)
        end
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