require("ui.uieditor.blak.warzone.widgets.hud.score.HealthBar")

Warzone.ButtonPrompt = InheritFrom(LUI.UIElement)

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

    Wzu.ClipSequence(self, self.unboundBacker, "Disabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.unboundBacker, "Enabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.unboundBacker)

    self.backer = LUI.UIImage.new()
    self.backer:setScaledLeftRight(true, false, 0, 16)
    self.backer:setScaledTopBottom(true, false, 0, 16)
    self.backer:setImage(RegisterImage("ui_keybind_backing"))

    Wzu.ClipSequence(self, self.backer, "Disabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.backer, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.backer)

    self.keyBind = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Colors.Asphalt, false)
    self.keyBind:setScaledLeftRight(false, false, -8, 8)
    self.keyBind:setScaledTopBottom(true, false, 0, 16)
    self.keyBind:setText(Engine.Localize("[{+activate}]"))
    self.keyBind:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    Wzu.ClipSequence(self, self.keyBind, "Disabled", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.keyBind, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.keyBind)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Enabled")
            end
        },
        Disabled = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Disabled")
            end
        }
    }
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end