Warzone.ButtonBackground = InheritFrom(LUI.UIElement)

function Warzone.ButtonBackground.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ButtonBackground)
    self.id = "ButtonBackground"
    self:makeFocusable()
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.buttonBg = LUI.UIImage.new()
    self.buttonBg:setScaledLeftRight(true, true, 0, 0)
    self.buttonBg:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.buttonBg, Wzu.Swatches.ButtonBackground)
    self.buttonBg:setAlpha(0.3)

    Wzu.ClipSequence(self, self.buttonBg, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackground),
            setAlpha = 0.3
        }
    })
    Wzu.ClipSequence(self, self.buttonBg, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackground),
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.buttonBg, "DisabledUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackgroundDisabled),
            setAlpha = 0.5
        }
    })
    Wzu.ClipSequence(self, self.buttonBg, "DisabledOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackgroundDisabled),
            setAlpha = 0.5
        }
    })

    self:addElement(self.buttonBg)

    self.textureLayer = LUI.UIImage.new()
    self.textureLayer:setScaledLeftRight(true, true, 0, 0)
    self.textureLayer:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.textureLayer, Wzu.Swatches.ButtonTextFocus)
    self.textureLayer:setAlpha(0.1)
    self.textureLayer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.textureLayer:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    Wzu.ClipSequence(self, self.textureLayer, "DefaultUp", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.MenuButtonText),
            setAlpha = 0.1
        }
    })
    Wzu.ClipSequence(self, self.textureLayer, "DefaultOver", {
        {
            duration = 0,
            setImage = RegisterImage("button_gradient"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.MenuButtonText),
            setAlpha = 0.1
        },
        {
            duration = 200,
            setImage = RegisterImage("button_gradient"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextFocus),
            setAlpha = 0.3
        }
    })
    Wzu.ClipSequence(self, self.textureLayer, "DisabledUp", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.White),
            setAlpha = 0.1
        }
    })
    Wzu.ClipSequence(self, self.textureLayer, "DisabledOver", {
        {
            duration = 0,
            setImage = RegisterImage("button_gradient"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.Grey128),
            setAlpha = 0.1
        }
    })

    self:addElement(self.textureLayer)

    self.topLine = LUI.UIImage.new()
    self.topLine:setScaledLeftRight(true, true, 0, 0)
    self.topLine:setScaledTopBottom(true, false, -1, 0)
    self.topLine:setAlpha(0)
    Wzu.SetRGBFromTable(self.topLine, Wzu.Swatches.ButtonTextDefault)

    Wzu.ClipSequence(self, self.topLine, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.topLine, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextFocus),
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.topLine, "DisabledUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.topLine, "DisabledOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    
    self:addElement(self.topLine)

    self.glow = LUI.UIImage.new()
    self.glow:setScaledLeftRight(true, true, -2, 2)
    self.glow:setScaledTopBottom(true, true, -2, 2)
    Wzu.SetRGBFromTable(self.glow, Wzu.Swatches.ButtonBackgroundFocus)
    self.glow:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
    self.glow:setImage(RegisterImage("button_glow"))
    self.glow:setAlpha(0)
    self.glow:setShaderVector(0, 0.04, 0.5, 0, 0)
    self.glow:setupNineSliceShader(12, 12)
    
    self:addElement(self.glow)

    Wzu.ClipSequence(self, self.glow, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackgroundFocus),
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.glow, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonBackgroundFocus),
            setAlpha = 0.6
        }
    })
    Wzu.ClipSequence(self, self.glow, "DisabledUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.MenuLocked),
            setAlpha = 0.6
        },
        {
            duration = 100,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.glow, "DisabledOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.MenuLocked),
            setAlpha = 0
        },
        {
            duration = 200,
            setAlpha = 0.6
        }
    })

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
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end