Warzone.RoundCounter = InheritFrom(LUI.UIElement)

function Warzone.RoundCounter.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.RoundCounter)
    self.id = "RoundCounter"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.roundChangeGlow = LUI.UIImage.new()
    self.roundChangeGlow:setScaledLeftRight(true, false, 40, 228)
    self.roundChangeGlow:setScaledTopBottom(false, false, -42.5, 42.5)
    self.roundChangeGlow:setImage(RegisterImage("wdg_ellipse_glow"))
    self.roundChangeGlow:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.roundChangeGlow:setShaderVector(0, 2.0, 2.0, 1.0, 1.0)
    Wzu.SetRGBFromTable(self.roundChangeGlow, Wzu.Swatches.GlobalKeyColor)
    self.roundChangeGlow:setAlpha(0.75)

    Wzu.ClipSequence(self, self.roundChangeGlow, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.roundChangeGlow, "Initial", {
        {
            duration = 0,
            setAlpha = 0.75
        },
        {
            duration = 2000,
            setAlpha = 0.75
        },
        {
            duration = 300,
            setAlpha = 0,
            interpolation = Wzu.TweenGraphs.inQuad
        }
    })
    Wzu.ClipSequence(self, self.roundChangeGlow, "RoundChange", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 500,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0.75,
            interpolation = Wzu.TweenGraphs.inQuad
        },
        {
            repeat_start = true,
            repeat_count = 10
        },
        {
            duration = 1000,
            setAlpha = 0.75
        },
        {
            repeat_end = true
        },
        {
            duration = 300,
            setAlpha = 0,
            interpolation = Wzu.TweenGraphs.inQuad
        }
    })

    self:addElement(self.roundChangeGlow)

    self.nextWaveIn = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.nextWaveIn:setScaledLeftRight(true, false, 86, 186)
    self.nextWaveIn:setScaledTopBottom(true, false, 24, 44)
    self.nextWaveIn:setText(Engine.Localize("NEXT WAVE IN"))

    Wzu.ClipSequence(self, self.nextWaveIn, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.nextWaveIn, "Initial", {
        {
            duration = 0,
            setAlpha = 1,
            setText = Engine.Localize("WAVE")
        },
        {
            duration = 2000,
            setAlpha = 1
        },
        {
            duration = 300,
            setAlpha = 0,
            interpolation = Wzu.TweenGraphs.inQuad
        }
    })
    Wzu.ClipSequence(self, self.nextWaveIn, "RoundChange", {
        {
            duration = 0,
            setAlpha = 0,
            setText = Engine.Localize("NEXT WAVE IN")
        },
        {
            duration = 500,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 1,
            interpolation = Wzu.TweenGraphs.inQuad
        },
        {
            repeat_start = true,
            repeat_count = 10
        },
        {
            duration = 1000,
            setAlpha = 1
        },
        {
            repeat_end = true
        },
        {
            duration = 300,
            setAlpha = 0,
            interpolation = Wzu.TweenGraphs.inQuad
        }
    })

    Wzu.AddShadowedElement(self, self.nextWaveIn)

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(false, false, -35, 35)
    self.background:setScaledTopBottom(false, false, -35, 35)
    self.background:setImage(RegisterImage("hud_ability_base_circle"))
    Wzu.SetRGBFromTable(self.background, Wzu.Swatches.BackgroundDisabled)
    self.background:setAlpha(0.8)

    self:addElement(self.background)

    self.spinner = LUI.UIImage.new()
    self.spinner:setScaledLeftRight(false, false, -36.5, 36.5)
    self.spinner:setScaledTopBottom(false, false, -36.5, 36.5)
    self.spinner:setImage(RegisterImage("hud_countdown_outer_circle"))
    Wzu.SetRGBFromTable(self.spinner, Wzu.Swatches.GlobalKeyColor)
    
    Wzu.ClipSequence(self, self.spinner, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 1,
            setZRot = 0
        }
    })
    Wzu.ClipSequence(self, self.spinner, "Initial", {
        {
            duration = 0,
            setAlpha = 1,
            setZRot = 0
        }
    })
    Wzu.ClipSequence(self, self.spinner, "RoundChange", {
        {
            duration = 0,
            setAlpha = 1,
            setZRot = 0
        },
        {
            duration = 800,
            setAlpha = 1,
            setZRot = 0
        },
        {
            repeat_start = true,
            repeat_count = 5
        },
        {
            duration = 0,
            setAlpha = 0.5,
            setZRot = 0
        },
        {
            duration = 1000,
            interpolation = Wzu.TweenGraphs.outQuint,
            setAlpha = 1,
            setZRot = -450
        },
        {
            duration = 0,
            setAlpha = 0.5,
            setZRot = -90
        },
        {
            duration = 1000,
            interpolation = Wzu.TweenGraphs.outQuint,
            setAlpha = 1,
            setZRot = -540
        },
        {
            repeat_end = true
        },
        {
            duration = 0,
            setAlpha = 1,
            setZRot = 0
        }
    })
    self.uid = "smoke"

    self:addElement(self.spinner)

    self.roundNumber = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.GlobalKeyColor, false)
    self.roundNumber:setScaledLeftRight(false, false, -20, 20)
    self.roundNumber:setScaledTopBottom(true, false, 16, 55)
    self.roundNumber:setText(Engine.Localize("0"))

    local roundTimer = 13

    Wzu.ClipSequence(self, self.roundNumber, "DefaultClip", {
        {
            duration = 0,
            setScale = 1
        }
    })
    Wzu.ClipSequence(self, self.roundNumber, "Initial", {
        {
            duration = 0,
            setScale = 1,
            setText = Engine.Localize("1")
        }
    })
    Wzu.ClipSequence(self, self.roundNumber, "RoundChange", {
        {
            duration = 0,
            setScale = 1
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScale = 0
        },
        {
            duration = 500,
            setScale = 0
        },
        {
            duration = 200,
            setScale = 0,
            setText = function()
                roundTimer = 11
                return Engine.Localize(roundTimer)
            end
        },
        {
            repeat_start = true,
            repeat_count = 10
        },
        {
            duration = 0,
            setScale = 0,
            setText = function()
                roundTimer = roundTimer - 1
                return Engine.Localize(roundTimer)
            end
        },
        {
            duration = 250,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScale = 1
        },
        {
            duration = 450,
            setScale = 1
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScale = 0
        },
        {
            repeat_end = true
        },
        {
            duration = 0,
            setText = function()
                return Engine.Localize(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "GameScore.roundsPlayed")) - 1)
            end,
            setScale = 0
        },
        {
            duration = 250,
            setScale = 0
        },
        {
            duration = 250,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScale = 1
        }
    })

    self:addElement(self.roundNumber)

    self.ghostRing = LUI.UIImage.new()
    self.ghostRing:setScaledLeftRight(false, false, -45, 45)
    self.ghostRing:setScaledTopBottom(false, false, -45, 45)
    self.ghostRing:setImage(RegisterImage("hud_ability_base_circle"))
    self.ghostRing:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
    Wzu.SetRGBFromTable(self.ghostRing, Wzu.Swatches.GlobalKeyColor)
    self.ghostRing:setAlpha(0)

    Wzu.ClipSequence(self, self.ghostRing, "DefaultClip", {
        {
            duration = 0,
            setScale = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.ghostRing, "Initial", {
        {
            duration = 0,
            setScale = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.ghostRing, "RoundChange", {
        {
            duration = 0,
            setScale = 0,
            setAlpha = 0.6
        },
        {
            duration = 800,
            setScale = 0,
            setAlpha = 0.6
        },
        {
            repeat_start = true,
            repeat_count = 10
        },
        {
            duration = 0,
            setScale = 0,
            setAlpha = 0.6,
            exec = function()
                if roundTimer then
                    if roundTimer < 4 then
                        Engine.PlaySound(Wzu.Sounds.Countdowns.MatchStart.Low)
                    elseif roundTimer < 6 then
                        Engine.PlaySound(Wzu.Sounds.Countdowns.MatchStart.Near)
                    else
                        Engine.PlaySound(Wzu.Sounds.Countdowns.MatchStart.General)
                    end
                end
            end
        },
        {
            duration = 400,
            setScale = 1.25,
            setAlpha = 0,
            interpolation = Wzu.TweenGraphs.inOutQuad
        },
        {
            duration = 600,
            setScale = 1.25,
            setAlpha = 0
        },
        {
            repeat_end = true
        }
    })

    self:addElement(self.ghostRing)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultClip")
            end,
            RoundChange = function()
                Wzu.AnimateSequence(self, "RoundChange")
            end,
            Initial = function()
                Wzu.AnimateSequence(self, "Initial")
            end
        }
    }

    Wzu.Subscribe(self, controller, "GameScore.roundsPlayed", function(modelValue)
        if modelValue ~= 2 then
            PlayClip(self, "RoundChange", controller)
        else
            PlayClip(self, "Initial", controller)
        end
    end)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end