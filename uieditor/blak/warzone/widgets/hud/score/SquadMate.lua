require( "ui.uieditor.widgets.onOffImage" )
require("ui.uieditor.blak.warzone.widgets.hud.score.HealthBar")
require("ui.uieditor.blak.warzone.widgets.hud.score.PlusPointsContainer")

Warzone.SquadMate = InheritFrom(LUI.UIElement)

function Warzone.SquadMate.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.SquadMate)
    self:setScaledLeftRight(true, false, 0, 195)
    self:setScaledTopBottom(false, true, -40, 0)
    self.id = "SquadMate"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.background, Util.Colors.Black)
    self.background:setAlpha(0.3)
    self.background:setImage(RegisterImage("ui_mp_br_squad_widget_backer_gradient"))

    Util.ClipSequence(self, self.background, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0.3
        }
    })
    Util.ClipSequence(self, self.background, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.background)

    self.cash = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.Cash, false)
    self.cash:setScaledLeftRight(true, false, 18.5, 100)
    self.cash:setScaledTopBottom(false, true, -14, -3)
    self.cash:setText(Engine.Localize("$500"))
    self.cash:setPriority(5)

    Util.ClipSequence(self, self.cash, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.cash, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self.cash.lastPlayerScore = 0
    Util.LinkToWidget(self.cash, self, "playerScore", function(modelValue)
        Util.Tween.interpolate(self.cash, 1000, Util.TweenGraphs.inOutSine, function(progress)
            local value = Util.GetTweenedProgress(progress, self.cash.lastPlayerScore, modelValue)
            self.cash:setText(Engine.Localize("$" .. math.floor(value)))
        end)

        self.cash:registerEventHandler("tween_complete", function(sender, event)
            self.cash.lastPlayerScore = modelValue
        end)
    end)

    self:addElement(self.cash)

    self.healthBar = Warzone.HealthBar.new(menu, controller)
    self.healthBar:setScaledLeftRight(true, false, 18, 104)
    self.healthBar:setScaledTopBottom(false, true, -20, -16)

    Util.LinkWidgetToElementModel(self.healthBar, self, controller)

    Util.ClipSequence(self, self.healthBar, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.healthBar, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.healthBar)

    self.squadLeader = CoD.onOffImage.new(menu, controller)
    self.squadLeader:setScaledLeftRight(true, false, 2, 16)
    self.squadLeader:setScaledTopBottom(true, false, 1, 15)
    self.squadLeader.image:setImage(RegisterImage("ui_mp_br_player_status_squad_leader"))

    self.squadLeader:mergeStateConditions({
        {
            stateName = "On", 
            condition = function(menu, widget, event)
                -- Edge cases where client num != 0 only happen in pubs, so no need for me to care
                return IsSelfModelValueEqualTo(self, controller, "clientNum", 0)
            end
        }
    })

    Util.ClipSequence(self, self.squadLeader, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.squadLeader, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.squadLeader)

    self.username = Util.TextElement(Util.Fonts.BattlenetBold, Util.Swatches.HUDMain, true)
    self.username:setScaledLeftRight(true, false, 19, 100)
    self.username:setScaledTopBottom(true, false, 1, 11)

    Util.LinkToWidget(self.username, self, "playerName", function(modelValue)
        self.username:setText(Engine.Localize(modelValue))
    end)

    Util.ClipSequence(self, self.username, "DefaultState", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.username, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Util.AddShadowedElement(self, self.username)

    self.plusPoints = Warzone.PlusPointsContainer.new(menu, controller)
    self.plusPoints:setScaledLeftRight(true, false, 18.5, 100)
    self.plusPoints:setScaledTopBottom(false, true, -14, -3)
    self.plusPoints:setPriority(4)
    
    self:addElement(self.plusPoints)

    Util.LinkToWidget(self, self, "clientNum", function(modelValue)
        local color = Util.GetClientColor(modelValue)
        Util.SetRGBFromTable(self.username, color)
        Util.SetRGBFromTable(self.squadLeader, color)
    end)

   self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        Hidden = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Hidden")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "Hidden",
            condition = function(menu, self, event)
                return IsSelfModelValueEqualTo(self, controller, "playerScoreShown", 0)
            end
        }
    })

    Util.LinkWidgetToState(self, self, menu, "playerScoreShown")

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.healthBar:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end