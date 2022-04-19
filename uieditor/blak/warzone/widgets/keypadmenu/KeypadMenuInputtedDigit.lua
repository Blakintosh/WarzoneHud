Warzone.KeypadMenuInputtedDigit = InheritFrom(LUI.UIElement)

function Warzone.KeypadMenuInputtedDigit.new(HudRef, InstanceRef)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(HudRef, InstanceRef)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.KeypadMenuInputtedDigit)
    self:setScaledLeftRight(true, false, 0, 30)
    self:setScaledTopBottom(true, false, 0, 30)
    self.id = "KeypadMenuInputtedDigit"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.txt = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.txt:setScaledLeftRight(true, true, 0, 0)
    self.txt:setScaledTopBottom(true, false, 0, 30)
    self.txt:setText("-")

    self.txt:linkToElementModel(self, "index", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.txt:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "keypadMenu.inputDigit" .. tostring(ModelVal)), function(ModelRef2)
                local ModelVal2 = Engine.GetModelValue(ModelRef2)
                if ModelVal2 then
                    self.txt:setText(tostring(ModelVal2))
                else
                    self.txt:setText("-")
                end
            end)
        end
    end)

    self:addElement(self.txt)

    self.footer = LUI.UIImage.new()
    self.footer:setScaledLeftRight(true, true, 0, 0)
    self.footer:setScaledTopBottom(false, true, -1, 0)
    Util.SetRGBFromTable(self.footer, Util.Swatches.HUDMain)

    self:addElement(self.footer)
    
    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end