Warzone.ReturnAO = InheritFrom(LUI.UIElement)

function Warzone.ReturnAO.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ReturnAO)
    self.id = "ReturnAO"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.icon = LUI.UIImage.new()
    self.icon:setScaledLeftRight(false, false, -30, 30)
    self.icon:setScaledTopBottom(true, false, 0, 60)
    self.icon:setImage(RegisterImage("hud_icon_warning"))
    Util.SetRGBFromTable(self.icon, Util.Swatches.EnemyTeam)

    self:addElement(self.icon)

    self.label = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.EnemyTeam, true)
    self.label:setScaledLeftRight(false, false, -200, 200)
    self.label:setScaledTopBottom(true, false, 56, 90)
    self.label:setText("DANGER AHEAD")

    Util.ClipSequence(self, self.label, "DefaultState", {
        {
            duration = 0,
            setText = "DANGER AHEAD"
        }
    })
    Util.ClipSequence(self, self.label, "Urgent", {
        {
            duration = 0,
            setText = "DANGER IMMINENT"
        }
    })

    Util.AddShadowedElement(self, self.label)

    self.timeLeft = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, true)
    self.timeLeft:setScaledLeftRight(false, false, -200, 200)
    self.timeLeft:setScaledTopBottom(true, false, 100, 123)
    self.timeLeft:setText("63.5")

    Util.Subscribe(self.timeLeft, controller, "karelia.outOfBoundsTime", function(modelValue)
        self.timeLeft:setText(modelValue .. "." .. tostring(math.random(0, 9)))
    end)

    Util.AddShadowedElement(self, self.timeLeft)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        Urgent = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Urgent")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "Urgent",
            condition = function(self, menu, event)
                return IsModelValueLessThan(controller, "karelia.outOfBoundsTime", 50)
            end
        }
    })
    Util.SubState(controller, menu, self, "karelia.outOfBoundsTime")

    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end