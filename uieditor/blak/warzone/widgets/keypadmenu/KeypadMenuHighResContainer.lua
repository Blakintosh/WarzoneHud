require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuCodeFragments")
require("ui.uieditor.blak.warzone.widgets.keypadmenu.KeypadMenuPinButton")

DataSources.KeypadPinDigits = DataSourceHelpers.ListSetup("KeypadPinDigits", function(InstanceRef)
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

function Keypad_InputKey(InstanceRef, digit)
    Engine.SendMenuResponse(InstanceRef, "MWRKeypadMenu", digit)

    for i = 1, 6 do
        local ModelRef = Engine.GetModel(Engine.GetModelForController(InstanceRef), "keypadMenu.inputDigit" .. tostring(i))
        local ModelVal = Engine.GetModelValue(ModelRef)
        if not ModelVal or ModelVal == "-" then
            Engine.SetModelValue(ModelRef, digit)
            break
        end
    end
end

function Keypad_Backspace(InstanceRef)
    Engine.SendMenuResponse(InstanceRef, "MWRKeypadMenu", "backspace")

    for i = 6, 1, -1 do
        local ModelRef = Engine.GetModel(Engine.GetModelForController(InstanceRef), "keypadMenu.inputDigit" .. tostring(i))
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal and ModelVal ~= "-" then
            Engine.SetModelValue(ModelRef, "-")
            break
        end
    end
end

DataSources.KeypadPad = DataSourceHelpers.ListSetup("KeypadPad", function(InstanceRef)
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
    self.pinNumbers:setScaledTopBottom(true, false, 46, 90)
    self.pinNumbers:setWidgetType(CoD.KeypadMenuPinButton)
    self.pinNumbers:setHorizontalCount(6)
    self.pinNumbers:setSpacing(5)
    self.pinNumbers:setDataSource("KeypadPinDigits")

    self:addElement(self.pinNumbers)

    self:registerEventHandler("gain_focus", function(sender, event)
        if sender.m_focusable then
            if sender.pinNumbers:processEvent(event) then
                return true
            end
        end
        return LUI.UIElement.gainFocus(sender, event)
    end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.codeHint:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end