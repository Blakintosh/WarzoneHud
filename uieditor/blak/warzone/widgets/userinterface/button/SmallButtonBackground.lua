Warzone.SmallButtonBackground = InheritFrom(LUI.UIElement)

function Warzone.SmallButtonBackground.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.SmallButtonBackground)
    self:makeFocusable()
    self.id = "SmallButtonBackground"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.buttonBg = LUI.UIImage.new()
    self.buttonBg:setScaledLeftRight(true, true, 0, 0)
    self.buttonBg:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.buttonBg, Wzu.Swatches.ButtonBorder)
    self.buttonBg:setAlpha(0.45)

    Wzu.ClipSequence(self, self.buttonBg, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.Swatches.ButtonBorder,
            setAlpha = 0.45
        }
    })
    Wzu.ClipSequence(self, self.buttonBg, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.Swatches.ButtonBackground,
            setAlpha = 1
        }
    })

    self:addElement(self.buttonBg)

    self.textureLayer = LUI.UIImage.new()
    self.textureLayer:setScaledLeftRight(true, true, 0, 0)
    self.textureLayer:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.textureLayer, Wzu.Colors.White)
    self.textureLayer:setAlpha(0.05)
    self.textureLayer:setImage(RegisterImage("button_gradient"))
    self.textureLayer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.textureLayer:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)

    Wzu.ClipSequence(self, self.textureLayer, "DefaultUp", {
        {
            duration = 0,
            setImage = RegisterImage("white"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.White),
            setAlpha = 0.05
        }
    })
    Wzu.ClipSequence(self, self.textureLayer, "DefaultOver", {
        {
            duration = 0,
            setImage = RegisterImage("widg_gradient_center_out"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Colors.White),
            setAlpha = 0.05
        },
        {
            duration = 200,
            setImage = RegisterImage("widg_gradient_center_out"),
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextFocus),
            setAlpha = 0.3
        }
    })

    self:addElement(self.textureLayer)

    self.bottomLine = LUI.UIImage.new()
    self.bottomLine:setScaledLeftRight(true, true, 0, 0)
    self.bottomLine:setScaledTopBottom(false, true, 0, 1)
    self.bottomLine:setAlpha(0)
    Wzu.SetRGBFromTable(self.bottomLine, Wzu.Swatches.ButtonTextDefault)

    Wzu.ClipSequence(self, self.bottomLine, "DefaultUp", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextDefault),
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.bottomLine, "DefaultOver", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ButtonTextFocus),
            setAlpha = 1
        }
    })
    
    self:addElement(self.bottomLine)

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
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.glow, "DefaultOver", {
        {
            duration = 0,
            setAlpha = 0.6
        }
    })

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultUp")
            end,
            Over = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        }
    }

    --self:playClip("Focus")
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end