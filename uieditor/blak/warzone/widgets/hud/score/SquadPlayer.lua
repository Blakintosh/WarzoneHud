require( "ui.uieditor.widgets.onOffImage" )
require("ui.uieditor.blak.warzone.widgets.hud.score.HealthBar")
require("ui.uieditor.blak.warzone.widgets.hud.perks.PerksList")
require("ui.uieditor.blak.warzone.widgets.hud.score.PlusPointsContainer")

Warzone.SquadPlayer = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "perkListUpdated")
end

function Warzone.SquadPlayer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.SquadPlayer)
    self:setScaledLeftRight(true, false, 0, 255)
    self:setScaledTopBottom(false, true, -47, 0)
    self.id = "SquadPlayer"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.background, Util.Colors.Black)
    self.background:setAlpha(0.3)
    self.background:setImage(RegisterImage("ui_mp_br_squad_widget_backer_gradient"))

    self:addElement(self.background)

    self.cash = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.Cash, false)
    self.cash:setScaledLeftRight(true, false, 18.5, 100)
    self.cash:setScaledTopBottom(false, true, -18, -4)
    self.cash:setText(Engine.Localize("$500"))
    self.cash:setPriority(5)

    Util.ClipSequence(self, self.cash, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -16, -2}
        }
    })
    Util.ClipSequence(self, self.cash, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -18, -4}
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
    self.healthBar:setScaledLeftRight(true, false, 18, 151)
    self.healthBar:setScaledTopBottom(false, true, -23, -18)

    Util.LinkWidgetToElementModel(self.healthBar, self, controller)

    Util.ClipSequence(self, self.healthBar, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -21, -16}
        }
    })
    Util.ClipSequence(self, self.healthBar, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -23, -18}
        }
    })

    self:addElement(self.healthBar)

    self.squadLeader = CoD.onOffImage.new()
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

    self:addElement(self.squadLeader)

    self.username = Util.TextElement(Util.Fonts.BattlenetBold, Util.Swatches.HUDMain, true)
    self.username:setScaledLeftRight(true, false, 19, 100)
    self.username:setScaledTopBottom(true, false, 1, 13)

    Util.LinkToWidget(self.username, self, "playerName", function(modelValue)
        self.username:setText(Engine.Localize(modelValue))
    end)

    Util.AddShadowedElement(self, self.username)

    self.perksList = Warzone.PerksList.new(menu, controller)
    self.perksList:setScaledLeftRight(true, false, 19, 300)
    self.perksList:setScaledTopBottom(true, false, 13, 33)

    self:addElement(self.perksList)

    self.plusPoints = Warzone.PlusPointsContainer.new(menu, controller)
    self.plusPoints:setScaledLeftRight(true, false, 18.5, 151)
    self.plusPoints:setScaledTopBottom(false, true, -18, -4)
    self.plusPoints:setPriority(4)

    Util.ClipSequence(self, self.plusPoints, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -16, -2}
        }
    })
    Util.ClipSequence(self, self.plusPoints, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -18, -4}
        }
    })
    
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
        HasPerks = {
            DefaultClip = function()
                Util.AnimateSequence(self, "HasPerks")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "HasPerks",
            condition = function(menu, self, event)
                return (#self.perksList.PerkList.perksList > 0)
            end
        }
    })
    
    Util.SubState(controller, menu, self, "hudItems.perkListUpdated")

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.healthBar:close()
        Sender.perksList:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end