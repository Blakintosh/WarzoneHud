require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuCodeFragments")
require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuPinButton")
require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuInputtedDigit")

DataSources.KeypadPinDigits = DataSourceHelpers.ListSetup("KeypadPinDigits", function(controller)
    local returnTable = {}

    for i = 0, 5 do
        table.insert(returnTable, {
            models = {
                index = i + 1 --might need changing to i+1
            }
        })
    end

    return returnTable
end, true)

local function Keypad_InputKey(controller, digit)
    Engine.SendMenuResponse(controller, "MWRKeypadMenu", digit)

    for i = 1, 6 do
        local ModelRef = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.inputDigit" .. tostring(i))
        local ModelVal = Engine.GetModelValue(ModelRef)
        if not ModelVal or ModelVal == "-" then
            Engine.SetModelValue(ModelRef, digit)
            break
        end
    end
end

local function Keypad_Backspace(controller)
    Engine.SendMenuResponse(controller, "MWRKeypadMenu", "backspace")

    for i = 6, 1, -1 do
        local ModelRef = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.inputDigit" .. tostring(i))
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal and ModelVal ~= "-" then
            Engine.SetModelValue(ModelRef, "-")
            break
        end
    end
end

DataSources.KeypadPad = DataSourceHelpers.ListSetup("KeypadPad", function(controller)
    local returnTable = {}

    for i = 1, 9 do
        table.insert(returnTable, {
            models = {
                digit = i,
                image = nil,
                inputFunction = Keypad_InputKey
            },
            properties = {
                type = "number"
            }
        })
    end

    table.insert(returnTable, {
        models = {
            digit = nil,
            image = "ui_mp_br_bunker_keypad_backspace_icon",
            inputFunction = Keypad_Backspace
        },
        properties = {
            type = "image"
        }
    })

    table.insert(returnTable, {
        models = {
            digit = 0,
            image = nil,
            inputFunction = Keypad_InputKey
        },
        properties = {
            type = "number"
        }
    })

    -- Hash??

    return returnTable
end, true)

Warzone.KeypadMenuHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.KeypadMenuHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.KeypadMenuHighResContainer)
    self.id = "KeypadMenuHighResContainer"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:makeFocusable()
    self.onlyChildrenFocusable = true
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    -- Title "Enter access code"
    self.title = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.title:setScaledLeftRight(false, false, -150, 150)
    self.title:setScaledTopBottom(true, false, 140, 164)
    self.title:setText(Engine.Localize("Enter Access Code"))

    Util.AddShadowedElement(self, self.title)

    self.codeHint = Warzone.KeypadMenuCodeFragments.new(menu, controller)
    self.codeHint:setScaledLeftRight(true, false, 20, 200)
    self.codeHint:setScaledTopBottom(true, false, 130, 180)
    
    self:addElement(self.codeHint)

    self.pinNumbers = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    self.pinNumbers.id = "pinNumbers"
    self.pinNumbers:setScaledLeftRight(false, false, -300, 300)
    self.pinNumbers:setScaledTopBottom(true, false, 176, 220)
    self.pinNumbers:setWidgetType(Warzone.KeypadMenuInputtedDigit)
    self.pinNumbers:setHorizontalCount(6)
    self.pinNumbers:setSpacing(10)
    self.pinNumbers:setDataSource("KeypadPinDigits")

    self:addElement(self.pinNumbers)

	self.pinButtons = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    self.pinButtons:makeFocusable()
    self.pinButtons.id = "pinButtons"
    self.pinButtons:setScaledLeftRight(false, false, -300, 300)
    self.pinButtons:setScaledTopBottom(true, false, 230, 630)
    self.pinButtons:setWidgetType(Warzone.KeypadMenuPinButton)
    self.pinButtons:setHorizontalCount(3)
    self.pinButtons:setVerticalCount(4)
    self.pinButtons:setSpacing(12)
    self.pinButtons:setDataSource("KeypadPad")

    self.pinButtons:registerEventHandler("gain_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        elseif Sender.super.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)
        return ReturnVal
    end)

    self.pinButtons:registerEventHandler("lose_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        elseif Sender.super.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE)
        return ReturnVal
    end) -- Change?
    
    menu:AddButtonCallbackFunction(self.pinButtons, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        local FuncVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "inputFunction"))

        if FuncVal then
            local DigitVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "digit"))
            FuncVal(controller, DigitVal)
        end
        return true
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, false)

    self:addElement(self.pinButtons)

    self.footer = Warzone.MenuFooter.new(menu, controller)
    self.footer:setScaledLeftRight(true, true, 0, 0)
    self.footer:setScaledTopBottom(false, true, -48, 0)

    self:addElement(self.footer)

    self:registerEventHandler("gain_focus", function(sender, event)
        if sender.m_focusable then
            if sender.pinButtons:processEvent(event) then
                return true
            end
        end
        return LUI.UIElement.gainFocus(sender, event)
    end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.codeHint:close()
		self.pinButtons:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end