Warzone.ButtonPrompt = InheritFrom(LUI.UIElement)

local function AbbreviatePCKey(self, key)
    if string.match( Engine.GetKeyBindingLocalizedString( controller, "+"..key ), "UNBOUND" ) then
        return ""
    end

    if string.len( Engine.GetKeyBindingLocalizedString(controller, "+"..key) ) == 1 then
        return Engine.Localize( Engine.GetKeyBindingLocalizedString(controller, "+"..key) )
    end
        
    if string.match( Engine.GetKeyBindingLocalizedString( controller, "+"..key ), "%s" ) then
        if string.len( Engine.GetKeyBindingLocalizedString( controller, "+"..key ):match("^(.-)%s") ) > 1 then
            if string.len( Engine.GetKeyBindingLocalizedString( controller, "+"..key ):reverse():match("^(.-)%s") ) > 1 then
                return ""
            else
                return ( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+"..key ):reverse():match("^(.-)%s") ) )
            end
        else
            return ( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+"..key ):match("^(.-)%s") ) )
        end
    end
end

function Warzone.ButtonPrompt.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ButtonPrompt)
    self:setScaledLeftRight(true, false, 0, 195)
    self:setScaledTopBottom(false, true, -40, 0)
    self.id = "ButtonPrompt"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.unboundBacker = LUI.UIImage.new()
    self.unboundBacker:setScaledLeftRight(true, false, 0, 16)
    self.unboundBacker:setScaledTopBottom(true, false, 0, 16)
    self.unboundBacker:setImage(RegisterImage("ui_keybind_backing_unbound"))

    Util.ClipSequence(self, self.unboundBacker, "Disabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.unboundBacker, "Enabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.unboundBacker, "EnabledGamepad", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.unboundBacker)

    self.backer = LUI.UIImage.new()
    self.backer:setScaledLeftRight(true, true, 0, 0)
    self.backer:setScaledTopBottom(true, false, 0, 16)
    self.backer:setImage(RegisterImage("ui_keybind_backing"))
    self.backer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
    self.backer:setShaderVector(0, 0.04, 0.5, 0, 0)
    self.backer:setupNineSliceShader(12, 12)

    Util.ClipSequence(self, self.backer, "Disabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.backer, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.backer, "EnabledGamepad", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.backer)

    self.keyBind = Util.TextElement(Util.Fonts.MainRegular, Util.Colors.Asphalt, false)
    self.keyBind:setScaledLeftRight(true, true, 0, 0)
    self.keyBind:setScaledTopBottom(true, false, 0, 16)

    LUI.OverrideFunction_CallOriginalFirst(self.keyBind, "setText", function(widget, text)
        ScaleWidgetToLabel(self, self.keyBind, 16)
    end)

    self.setButtonPrompt = function(self, pcKey, gamepadButton)
        self.assignedKey = pcKey
        self.gamepadKey = gamepadButton

        if not Engine.LastInput_Gamepad() and self.assignedKey then
            self.keyBind:setText(AbbreviatePCKey(self, self.assignedKey))
        elseif Engine.LastInput_Gamepad() and self.gamepadKey then
            self.keyBind:setText(Engine.Localize("[{+"..self.gamepadKey.."}]"))
        end
    end

    self.keyBind:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Util.ClipSequence(self, self.keyBind, "Disabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.keyBind, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.keyBind, "EnabledGamepad", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.keyBind)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Enabled")
            end
        },
        Disabled = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Disabled")
            end
        },
        EnabledGamepad = {
            DefaultClip = function()
                Util.AnimateSequence(self, "EnabledGamepad")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "EnabledGamepad",
            condition = function(one, two, three)
                return Engine.LastInput_Gamepad()
            end
        }
    })

    self:registerEventHandler("input_source_changed", function(sender, event)
        if not Engine.LastInput_Gamepad() and self.assignedKey then
            self.keyBind:setText(AbbreviatePCKey(self, self.assignedKey))
        elseif Engine.LastInput_Gamepad() and self.gamepadKey then
            self.keyBind:setText(Engine.Localize("[{+"..self.gamepadKey.."}]"))
        end
        menu:updateElementState(self, { menu = menu })
        ScaleWidgetToLabel(self, self.keyBind, 16)
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end