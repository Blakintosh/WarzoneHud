require("ui.uieditor.blak.warzone.widgets.hud.score.HealthBarFiller")

Warzone.HealthBar = InheritFrom(LUI.UIElement)

function Warzone.HealthBar.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.HealthBar)
    self.id = "HealthBar"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Util.SetRGBFromTable(self.background, Util.Colors.Black)
    self.background:setAlpha(0.2)

    self:addElement(self.background)

    self.damageBar = Warzone.HealthBarFiller.new(menu, controller)
    self.damageBar:setScaledLeftRight(true, true, 0.5, -0.5)
    self.damageBar:setScaledTopBottom(true, true, 0.5, -0.5)
    self.damageBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.damageBar:setShaderVector(1, 0, 0, 0, 0)
    self.damageBar:setShaderVector(2, 1, 0, 0, 0)
    self.damageBar:setShaderVector(3, 0, 0, 0, 0)
    Util.SetRGBFromTable(self.damageBar.filler, Util.Swatches.HUDWarning)

    self:addElement(self.damageBar)

    self.healthBar = Warzone.HealthBarFiller.new(menu, controller)
    self.healthBar:setScaledLeftRight(true, true, 0.5, -0.5)
    self.healthBar:setScaledTopBottom(true, true, 0.5, -0.5)
    self.healthBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.healthBar:setShaderVector(0, 1, 0, 0, 0)
    self.healthBar:setShaderVector(1, 0, 0, 0, 0)
    self.healthBar:setShaderVector(2, 1, 0, 0, 0)
    self.healthBar:setShaderVector(3, 0, 0, 0, 0)
    Util.SetRGBFromTable(self.healthBar.filler, Util.Colors.White)

    Util.ClipSequence(self, self.healthBar, "LowHealth", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDStable)
        },
        {
            duration = 267,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDWarningDanger)
        },
        {
            duration = 267,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDStable)
        }
    })
    Util.ClipSequence(self, self.healthBar, "DefaultClip", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.FieldUpgradeIdle)
        }
    })

    self:addElement(self.healthBar)

    self.healthBar.filler.lastValue = 1
    self.damageBar.filler.lastValue = 1

    local function GainHealth(modelValue)
        Util.Tween.interpolate(self.healthBar.filler, 1000, Util.TweenGraphs.linear, function(progress)
            local value = Util.GetTweenedProgress(progress, self.healthBar.filler.lastValue, modelValue)
            self.healthBar.filler:setShaderVector(0, value, 0, 0, 0)
        end)

        self.healthBar.filler:registerEventHandler("tween_complete", function(sender, event)
            if not event.interrupted then
                self.healthBar.filler.lastValue = modelValue
            else
                self.healthBar.filler.lastValue = Util.GetTweenedProgress(event.progress, self.healthBar.filler.lastValue, modelValue)
            end
        end)

        Util.Tween.interpolate(self.damageBar.filler, 1000, Util.TweenGraphs.linear, function(progress)
            local value = Util.GetTweenedProgress(progress, self.damageBar.filler.lastValue, modelValue)
            self.damageBar.filler:setShaderVector(0, value, 0, 0, 0)
        end)

        self.damageBar.filler:registerEventHandler("tween_complete", function(sender, event)
            if not event.interrupted then
                self.damageBar.filler.lastValue = modelValue
            else
                self.damageBar.filler.lastValue = Util.GetTweenedProgress(event.progress, self.damageBar.filler.lastValue, modelValue)
            end
        end)
    end

    local function LoseHealth(modelValue)
        self.healthBar.filler:completeAnimation()
        self.healthBar.filler.lastValue = modelValue
        self.healthBar.filler:setShaderVector(0, modelValue, 0, 0, 0)

        Util.Tween.interpolate(self.damageBar.filler, 1000, Util.TweenGraphs.linear, function(progress)
            local value = Util.GetTweenedProgress(progress, self.damageBar.filler.lastValue, modelValue)
            self.damageBar.filler:setShaderVector(0, value, 0, 0, 0)
        end)

        self.damageBar.filler:registerEventHandler("tween_complete", function(sender, event)
            self.damageBar.filler.lastValue = modelValue
        end)
    end

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultClip")
            end
        },
        LowHealth = {
            DefaultClip = function()
                Util.AnimateSequence(self, "LowHealth", {
                    looping = true,
                    clipName = "DefaultClip"
                })
            end
        }
    }

    self.lastHealth = 1
    Util.LinkToWidget(self, self, "clientNum", function(modelValue)
        self:mergeStateConditions({{
            stateName = "LowHealth",
            condition = function(menu, self, event)
                return IsModelValueLessThanOrEqualTo(controller, "PlayerList.client"..modelValue..".health", 0.25)
            end
        }})

        Util.SubState(controller, menu, self, "PlayerList.client"..modelValue..".health")

        Util.Subscribe(self, controller, "PlayerList.client"..modelValue..".health", function(modelValue2)
            if modelValue2 > self.lastHealth then
                GainHealth(modelValue2)
            elseif modelValue2 < self.lastHealth then
                LoseHealth(modelValue2)
            end
            self.lastHealth = modelValue2
        end)
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end