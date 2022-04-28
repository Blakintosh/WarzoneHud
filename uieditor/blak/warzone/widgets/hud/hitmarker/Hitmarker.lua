Warzone.Hitmarker = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    local IsAdsModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "isADS")
    Engine.SetModelValue(IsAdsModel, 0)

    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "zm_hitmarker")
end

function Warzone.Hitmarker.new(menu, controller)
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Hitmarker)
    self.id = "Hitmarker"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.hitmarker = LUI.UIImage.new()
    self.hitmarker:setScaledLeftRight(false, false, -19, 19)
    self.hitmarker:setScaledTopBottom(false, false, -19, 19)
    self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback"))

    self:addElement(self.hitmarker)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)

                self.hitmarker:setScale(1)
                self.hitmarker:setAlpha(0)

                self.clipFinished(self.hitmarker, {})
            end,
            Hit = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(1)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            Headshot = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback_headshot"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(1)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            KillHit = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 0.4, 0.3)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(1)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            KillHeadshot = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 0.4, 0.3)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback_headshot"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(1)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end
        },
        ADS = {
            DefaultClip = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)

                self.hitmarker:setScale(1)
                self.hitmarker:setAlpha(0)

                self.clipFinished(self.hitmarker, {})
            end,
            Hit = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(0.6)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            Headshot = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 1, 1)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback_headshot"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(0.6)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            KillHit = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 0.4, 0.3)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(0.6)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end,
            KillHeadshot = function()
                self:setupElementClipCounter(1)

                self.hitmarker:completeAnimation()
                self.hitmarker:setRGB(1, 0.4, 0.3)
                self.hitmarker:setImage(RegisterImage("ui_iw8_damage_feedback_headshot"))

                self.hitmarker:setScale(1.5)
                self.hitmarker:setAlpha(0.6)
                self.hitmarker:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)

                self.hitmarker:setScale(1)

                self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                    if event.interrupted then
                        self.clipFinished(self.hitmarker, {})
                    else
                        self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                        self.hitmarker:setScale(1)

                        self.hitmarker:registerEventHandler("transition_complete_keyframe", function(widget, event)
                            if event.interrupted then
                                self.clipFinished(self.hitmarker, {})
                            else
                                self.hitmarker:beginAnimation("keyframe", 150, false, false, CoD.TweenType.Linear)

                                self.hitmarker:setScale(1.5)
                                self.hitmarker:setAlpha(0)

                                self.hitmarker:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                            end
                        end)
                    end
                end)
            end
        }
    }
    
    Util.Subscribe(self, controller, "hudItems.zm_hitmarker", function(model)
        local modelValue = Engine.GetModelValue(model)
        if modelValue then
			Console.Print(Blak.DebugUtils.DumpVariableInfo(modelValue))
            modelValue = math.abs(modelValue)
            if modelValue == 0 then
                PlayClip(self, "Hit", controller)
            elseif modelValue == 1 then
                PlayClip(self, "Headshot", controller)
            elseif modelValue == 2 then
                PlayClip(self, "KillHit", controller)
            elseif modelValue == 3 then
                PlayClip(self, "KillHeadshot", controller)
            end
        end
    end)

    self:mergeStateConditions({
        {
            stateName = "ADS",
            condition = function(Hud, Element, StateTable)
                return IsModelValueEqualTo(controller, "hudItems.isADS", 1)
            end
        }
    })
    
    Util.SubState(controller, menu, self, "hudItems.isADS")

    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end