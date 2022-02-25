Warzone.ScoreboardRow = InheritFrom(LUI.UIElement)

function Warzone.ScoreboardRow.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ScoreboardRow)
    self.id = "ScoreboardRow"
    self.soundSet = "default"
    self:makeFocusable()
	self:setHandleMouse(true)
    self.anyChildUsesUpdateState = true
    self:setScaledLeftRight(true, false, 0, 714)
    self:setScaledTopBottom(true, false, 0, 30)

    self.leftBorder = LUI.UIImage.new()
    self.leftBorder:setScaledLeftRight(true, false, 0, 4)
    self.leftBorder:setScaledTopBottom(true, true, 0, 0)
    self.leftBorder:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.leftBorder, Wzu.Swatches.GlobalKeyColorMid)

    self:addElement(self.leftBorder)

    self.rightBorder = LUI.UIImage.new()
    self.rightBorder:setScaledLeftRight(false, true, -4, 0)
    self.rightBorder:setScaledTopBottom(true, true, 0, 0)
    self.rightBorder:setAlpha(0.4)
    Wzu.SetRGBFromTable(self.rightBorder, Wzu.Swatches.GlobalKeyColorMid)

    self:addElement(self.rightBorder)

    self.focusBg = LUI.UIImage.new()
    self.focusBg:setScaledLeftRight(true, true, 4, -4)
    self.focusBg:setScaledTopBottom(true, true, 0, 0)
    self.focusBg:setAlpha(0)
    Wzu.SetRGBFromTable(self.focusBg, Wzu.Colors.Black)

    Wzu.ClipSequence(self, self.focusBg, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusBg, "Focus", {
        {
            duration = 0,
            setAlpha = 0.8
        }
    })

    self:addElement(self.focusBg)

    self.focusBg2 = LUI.UIImage.new()
    self.focusBg2:setScaledLeftRight(true, true, 4, -4)
    self.focusBg2:setScaledTopBottom(true, true, 0, 0)
    self.focusBg2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.focusBg2:setShaderVector(0, 2, 2, 1, 1)
    self.focusBg2:setAlpha(0)
    Wzu.SetRGBFromTable(self.focusBg2, Wzu.Swatches.FriendlyTeam)

    Wzu.ClipSequence(self, self.focusBg2, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusBg2, "Focus", {
        {
            duration = 0,
            setAlpha = 0.5
        }
    })

    self:addElement(self.focusBg2)

    self.focusBorderTop = LUI.UIImage.new()
    self.focusBorderTop:setScaledLeftRight(true, true, 4, -4)
    self.focusBorderTop:setScaledTopBottom(true, false, 0, 1)
    self.focusBorderTop:setAlpha(0)
    Wzu.SetRGBFromTable(self.focusBorderTop, Wzu.Swatches.FriendlyTeam)

    Wzu.ClipSequence(self, self.focusBorderTop, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusBorderTop, "Focus", {
        {
            duration = 0,
            setAlpha = 0.8
        }
    })

    self:addElement(self.focusBorderTop)

    self.focusBorderBottom = LUI.UIImage.new()
    self.focusBorderBottom:setScaledLeftRight(true, true, 4, -4)
    self.focusBorderBottom:setScaledTopBottom(false, true, -1, 0)
    self.focusBorderBottom:setAlpha(0)
    Wzu.SetRGBFromTable(self.focusBorderBottom, Wzu.Swatches.FriendlyTeam)

    Wzu.ClipSequence(self, self.focusBorderBottom, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.focusBorderBottom, "Focus", {
        {
            duration = 0,
            setAlpha = 0.8
        }
    })

    self:addElement(self.focusBorderBottom)

    self.gradientTop = LUI.UIImage.new()
    self.gradientTop:setScaledLeftRight(true, true, 4, -4)
    self.gradientTop:setScaledTopBottom(true, false, -4, 0)
    self.gradientTop:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.gradientTop:setShaderVector(0, 2, 2, 1, 1)
    self.gradientTop:setAlpha(0)
    self.gradientTop:setImage(RegisterImage("widg_gradient_bottom_to_top"))
    Wzu.SetRGBFromTable(self.gradientTop, Wzu.Swatches.GlobalKeyColorMid)

    Wzu.ClipSequence(self, self.gradientTop, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.gradientTop, "Focus", {
        {
            duration = 0,
            setAlpha = 0.4
        }
    })

    self:addElement(self.gradientTop)

    self.gradientBottom = LUI.UIImage.new()
    self.gradientBottom:setScaledLeftRight(true, true, 4, -4)
    self.gradientBottom:setScaledTopBottom(false, true, 0, 4)
    self.gradientBottom:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.gradientBottom:setShaderVector(0, 2, 2, 1, 1)
    self.gradientBottom:setAlpha(0)
    self.gradientBottom:setImage(RegisterImage("widg_gradient_bottom_to_top"))
    self.gradientBottom:setZRot(180)
    Wzu.SetRGBFromTable(self.gradientBottom, Wzu.Swatches.GlobalKeyColorMid)

    Wzu.ClipSequence(self, self.gradientBottom, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.gradientBottom, "Focus", {
        {
            duration = 0,
            setAlpha = 0.4
        }
    })

    self:addElement(self.gradientBottom)

    self.username = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.username:setScaledLeftRight(true, false, 24, 50)
    self.username:setScaledTopBottom(true, false, 8, 22)

    Wzu.LinkToWidget(self.username, self, "clientNum", function(modelValue)
        self.username:setText(GetClientNameAndClanTag(controller, modelValue))
    end)

    Wzu.ClipSequence(self, self.username, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.username, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.username)

    self.col0 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.col0:setScaledLeftRight(false, true, -468, -418)
    self.col0:setScaledTopBottom(true, false, 8, 22)
    self.col0:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.LinkToWidget(self.col0, self, "clientNum", function(modelValue)
        self.col0:setText(Engine.Localize(GetScoreboardPlayerScoreColumn(controller, 0, modelValue)))
    end)

    Wzu.ClipSequence(self, self.col0, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.col0, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.col0)

    self.col1 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.col1:setScaledLeftRight(false, true, -388, -338)
    self.col1:setScaledTopBottom(true, false, 8, 22)
    self.col1:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.LinkToWidget(self.col1, self, "clientNum", function(modelValue)
        self.col1:setText(Engine.Localize(GetScoreboardPlayerScoreColumn(controller, 1, modelValue)))
    end)

    Wzu.ClipSequence(self, self.col1, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.col1, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.col1)

    self.col2 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.col2:setScaledLeftRight(false, true, -308, -258)
    self.col2:setScaledTopBottom(true, false, 8, 22)
    self.col2:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.LinkToWidget(self.col2, self, "clientNum", function(modelValue)
        self.col2:setText(Engine.Localize(GetScoreboardPlayerScoreColumn(controller, 2, modelValue)))
    end)

    Wzu.ClipSequence(self, self.col2, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.col2, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.col2)

    self.col3 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.col3:setScaledLeftRight(false, true, -228, -178)
    self.col3:setScaledTopBottom(true, false, 8, 22)
    self.col3:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.LinkToWidget(self.col3, self, "clientNum", function(modelValue)
        self.col3:setText(Engine.Localize(GetScoreboardPlayerScoreColumn(controller, 3, modelValue)))
    end)

    Wzu.ClipSequence(self, self.col3, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.col3, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.col3)

    self.col4 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.col4:setScaledLeftRight(false, true, -148, -88)
    self.col4:setScaledTopBottom(true, false, 8, 22)
    self.col4:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.LinkToWidget(self.col4, self, "clientNum", function(modelValue)
        self.col4:setText(Engine.Localize(GetScoreboardPlayerScoreColumn(controller, 4, modelValue)))
    end)

    Wzu.ClipSequence(self, self.col4, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.col4, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.col4)

    self.ping = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.ping:setScaledLeftRight(false, true, -58, -8)
    self.ping:setScaledTopBottom(true, false, 8, 22)
    self.ping:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    self.ping:linkToElementModel(self, "ping", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.ping:setText(ModelValue)
		end
	end)

    Wzu.ClipSequence(self, self.ping, "DefaultClip", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.ping, "Focus", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.PlayerTeam)
        }
    })

    self:addElement(self.ping)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultClip")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "Focus")
            end
        }
    }

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end