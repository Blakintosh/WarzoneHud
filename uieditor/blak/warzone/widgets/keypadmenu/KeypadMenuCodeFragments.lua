Warzone.KeypadMenuCodeFragments = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.GetModelForController(controller), "keypadMenu")

    for i = 1, 6 do
        Engine.CreateModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_" .. tostring(i))
    end
end

function Warzone.KeypadMenuCodeFragments.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.KeypadMenuCodeFragments)
    self.id = "KeypadMenuCodeFragments"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setLeftRight(true, true, 0, 0)
    self.background:setTopBottom(true, true, 0, 0)
    self.background:setImage(RegisterImage("black"))
    self.background:setAlpha(0.3)

    self:addElement(self.background)

    self.title = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.title:setScaledLeftRight(true, true, 4, -4)
    self.title:setScaledTopBottom(true, false, 6, 20)
    self.title:setText("Laptop Code Fragments")

    self:addElement(self.title)

    self.code = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.code:setScaledLeftRight(true, true, 4, -4)
    self.code:setScaledTopBottom(true, false, 16, 50)
    self.code:setText("-- -- --")

    local Digit1Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_1")
    local Digit2Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_2")
    local Digit3Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_3")
    local Digit4Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_4")
    local Digit5Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_5")
    local Digit6Mdl = Engine.GetModel(Engine.GetModelForController(controller), "keypadMenu.keypad_digit_6")

    local function ValidateDigit(modelValue)
        if modelValue == nil then
            return nil
        else
            return tostring(modelValue)
        end
    end

    --[[SubscribeToMultipleModels(self.code, { Digit1Mdl, Digit2Mdl, Digit3Mdl, Digit4Mdl, Digit5Mdl, Digit6Mdl }, function(ModelRef)
        Blak.DebugUtils.SafeRunFunction(function()
        local Vals = {
            ValidateDigit(Engine.GetModelValue(Digit1Mdl)) or "-",
            ValidateDigit(Engine.GetModelValue(Digit2Mdl)) or "-",
            ValidateDigit(Engine.GetModelValue(Digit3Mdl)) or "-",
            ValidateDigit(Engine.GetModelValue(Digit4Mdl)) or "-",
            ValidateDigit(Engine.GetModelValue(Digit5Mdl)) or "-",
            ValidateDigit(Engine.GetModelValue(Digit6Mdl)) or "-",
        }

        local WorkingCode = ""

        Blak.DebugUtils.Log("idk?")

        for i = 1, #Vals do
            if Vals[i] then
                Blak.DebugUtils.Log("Boddle of wodah")
                Blak.DebugUtils.Log(Vals[i])
                WorkingCode = WorkingCode .. tostring(Vals[i])
            else
                Blak.DebugUtils.Log("NO")
                WorkingCode = WorkingCode .. "-"
            end

            if i == 2 or i == 4 then
                Blak.DebugUtils.Log("ADD SPACE")
                WorkingCode = WorkingCode .. " "
            end
        end

        self.code:setText(WorkingCode)
        end)
    end)]]

    self:addElement(self.code)
    
    --[[LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.frame:close()
        self.blur:close()
    end)]]
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end