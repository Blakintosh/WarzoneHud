Warzone.SmallButtonBackground = InheritFrom(LUI.UIElement)

function Warzone.SmallButtonBackground.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.SmallButtonBackground)
    self.id = "SmallButtonBackground"
    self.soundSet = "default"
    self:makeFocusable()
    self.anyChildUsesUpdateState = true

    self.buttonBg = LUI.UIImage.new()
    self.buttonBg:setScaledLeftRight(true, true, 0, 0)
    self.buttonBg:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.buttonBg, Util.Swatches.ButtonBackground)
    self.buttonBg:setAlpha(0.8)

    Util.ClipSequence(self, self.buttonBg, "DefaultUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackground),
            setAlpha = 0.8
        }
    })
    Util.ClipSequence(self, self.buttonBg, "DefaultOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackground),
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.buttonBg, "DisabledUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackgroundDisabled),
            setAlpha = 0.5
        }
    })
    Util.ClipSequence(self, self.buttonBg, "DisabledOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackgroundDisabled),
            setAlpha = 1
        }
    })

    self:addElement(self.buttonBg)

    self.textureLayer = LUI.UIImage.new()
    self.textureLayer:setScaledLeftRight(true, true, 0, 0)
    self.textureLayer:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.textureLayer, Util.Colors.White)
    self.textureLayer:setAlpha(0.05)
    self.textureLayer:setImage(RegisterImage("button_gradient"))
    self.textureLayer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.textureLayer:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    Util.ClipSequence(self, self.textureLayer, "DefaultUp", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextureUnfocused),
            setAlpha = 0.05
        }
    })
    Util.ClipSequence(self, self.textureLayer, "DefaultOver", {
        {
            duration = 0,
            setImage = RegisterImage("widg_gradient_center_out"),
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextureUnfocused),
            setAlpha = 0.05
        },
        {
            duration = 200,
            setImage = RegisterImage("widg_gradient_center_out"),
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextFocus),
            setAlpha = 0.3
        }
    })
    Util.ClipSequence(self, self.textureLayer, "DisabledUp", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Util.ConvertColorToTable(Util.Colors.White),
            setAlpha = 0.1
        }
    })
    Util.ClipSequence(self, self.textureLayer, "DisabledOver", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Util.ConvertColorToTable(Util.Colors.White),
            setAlpha = 0.1
        }
    })

    self:addElement(self.textureLayer)

    self.bottomLine = LUI.UIImage.new()
    self.bottomLine:setScaledLeftRight(true, true, 0, 0)
    self.bottomLine:setScaledTopBottom(false, true, 0, 1)
    self.bottomLine:setAlpha(0)
    Util.SetRGBFromTable(self.bottomLine, Util.Swatches.ButtonTextDefault)

    Util.ClipSequence(self, self.bottomLine, "DefaultUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.bottomLine, "DefaultOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextFocus),
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.bottomLine, "DisabledUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.bottomLine, "DisabledOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    
    self:addElement(self.bottomLine)

    self.glow = LUI.UIImage.new()
    self.glow:setScaledLeftRight(true, true, -2, 2)
    self.glow:setScaledTopBottom(true, true, -2, 2)
    Util.SetRGBFromTable(self.glow, Util.Swatches.ButtonBackgroundFocus)
    self.glow:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
    self.glow:setImage(RegisterImage("button_glow"))
    self.glow:setAlpha(0)
    self.glow:setShaderVector(0, 0.04, 0.5, 0, 0)
    self.glow:setupNineSliceShader(12, 12)
    
    self:addElement(self.glow)

    Util.ClipSequence(self, self.glow, "DefaultUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackgroundFocus),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.glow, "DefaultOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.ButtonBackgroundFocus),
            setAlpha = 0.6
        }
    })
    Util.ClipSequence(self, self.glow, "DisabledUp", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.MenuLocked),
            setAlpha = 0.6
        },
        {
            duration = 100,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.glow, "DisabledOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.MenuLocked),
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
                Util.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Util.AnimateSequence(self, "DefaultOver")
            end
        },
        Disabled = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DisabledUp")
            end,
            Focus = function()
                Util.AnimateSequence(self, "DisabledOver")
            end
        }
    }

    --self:playClip("Focus")
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end