require("ui.uieditor.blak.warzone.widgets.hud.score.HealthBar")
require("ui.uieditor.blak.warzone.widgets.hud.perks.PerksList")

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
    Wzu.SetRGBFromTable(self.background, Wzu.Colors.Black)
    self.background:setAlpha(0.3)
    self.background:setImage(RegisterImage("ui_mp_br_squad_widget_backer_gradient"))

    self:addElement(self.background)

    self.cash = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.Cash, false)
    self.cash:setScaledLeftRight(true, false, 18.5, 100)
    self.cash:setScaledTopBottom(false, true, -18, -4)
    self.cash:setText(Engine.Localize("$500"))

    Wzu.ClipSequence(self, self.cash, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -16, -2}
        }
    })
    Wzu.ClipSequence(self, self.cash, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -18, -4}
        }
    })

    self.cash.lastPlayerScore = 0
    Wzu.LinkToWidget(self.cash, self, "playerScore", function(modelValue)
        Wzu.Tween.interpolate(self.cash, 1000, Wzu.TweenGraphs.inOutSine, function(progress)
            local value = Wzu.GetTweenedProgress(progress, self.cash.lastPlayerScore, modelValue)
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

    Wzu.ClipSequence(self, self.healthBar, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -21, -16}
        }
    })
    Wzu.ClipSequence(self, self.healthBar, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -23, -18}
        }
    })

    self:addElement(self.healthBar)

    self.squadLeader = LUI.UIImage.new()
    self.squadLeader:setScaledLeftRight(true, false, 2, 16)
    self.squadLeader:setScaledTopBottom(true, false, 1, 15)
    self.squadLeader:setImage(RegisterImage("ui_mp_br_player_status_squad_leader"))
    self:addElement(self.squadLeader)

    self.username = Wzu.TextElement(Wzu.Fonts.BattlenetBold, Wzu.Swatches.HUDMain, true)
    self.username:setScaledLeftRight(true, false, 19, 100)
    self.username:setScaledTopBottom(true, false, 1, 13)

    Wzu.LinkToWidget(self.username, self, "playerName", function(modelValue)
        self.username:setText(Engine.Localize(modelValue))
    end)

    Wzu.AddShadowedElement(self, self.username)

    self.perksList = Warzone.PerksList.new(menu, controller)
    self.perksList:setScaledLeftRight(true, false, 19, 300)
    self.perksList:setScaledTopBottom(true, false, 13, 33)

    self:addElement(self.perksList)

    Wzu.LinkToWidget(self, self, "clientNum", function(modelValue)
        local color = Wzu.GetClientColor(modelValue)
        Wzu.SetRGBFromTable(self.username, color)
        Wzu.SetRGBFromTable(self.squadLeader, color)
    end)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        HasPerks = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "HasPerks")
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
    
    Wzu.SubState(controller, menu, self, "hudItems.perkListUpdated")

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.healthBar:close()
        Sender.perksList:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end