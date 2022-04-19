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

	self.corners = Warzone.CorneredBorder.new(menu, controller, 8)
	self.corners:setScaledLeftRight(true, true, 0, 0)
	self.corners:setScaledTopBottom(true, true, 0, 0)
	Util.SetRGBFromTable(self.corners, Util.Swatches.HUDMain)

	self:addElement(self.corners)

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.background, Util.Swatches.GlobalKeyColorMid)
    self.background:setAlpha(0.2)

    self:addElement(self.background)

	self.texture = LUI.UIImage.new()
    self.texture:setScaledLeftRight(true, true, 0, 0)
    self.texture:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.texture, Util.Swatches.ButtonBackgroundFocus)
    self.texture:setAlpha(0.2)
	self.texture:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.texture:setShaderVector(0, 2, 2, 1, 1)
	self.texture:setImage(RegisterImage("widg_gradient_bottom_to_top"))
	self.texture:setZRot(180)

    self:addElement(self.texture)

    self.title = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.title:setScaledLeftRight(true, true, 4, -4)
    self.title:setScaledTopBottom(true, false, 4, 18)
    self.title:setText("Laptop Code Fragments")

    self:addElement(self.title)

    self.code = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.code:setScaledLeftRight(true, true, 4, -4)
    self.code:setScaledTopBottom(true, false, 24, 50)
    self.code:setText("?? ?? ??")

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

    Util.SubscribeMultiple(self.code, controller, { "keypadMenu.keypad_digit_1", "keypadMenu.keypad_digit_2", "keypadMenu.keypad_digit_3", "keypadMenu.keypad_digit_4", "keypadMenu.keypad_digit_5", "keypadMenu.keypad_digit_6" }, function(ModelRef)
        local Vals = {
            ValidateDigit(Engine.GetModelValue(Digit1Mdl)) or "?",
            ValidateDigit(Engine.GetModelValue(Digit2Mdl)) or "?",
            ValidateDigit(Engine.GetModelValue(Digit3Mdl)) or "?",
            ValidateDigit(Engine.GetModelValue(Digit4Mdl)) or "?",
            ValidateDigit(Engine.GetModelValue(Digit5Mdl)) or "?",
            ValidateDigit(Engine.GetModelValue(Digit6Mdl)) or "?",
        }

        local WorkingCode = ""

        for i = 1, #Vals do
            if Vals[i] then
                WorkingCode = WorkingCode .. tostring(Vals[i])
            else
                WorkingCode = WorkingCode .. "?"
            end

            if i == 2 or i == 4 then
                WorkingCode = WorkingCode .. " "
            end
        end

        self.code:setText(WorkingCode)
    end)

    self:addElement(self.code)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.corners:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end