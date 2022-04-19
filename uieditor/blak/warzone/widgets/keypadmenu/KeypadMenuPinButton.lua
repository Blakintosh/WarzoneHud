Warzone.KeypadMenuPinButton = InheritFrom(LUI.UIElement)

function Warzone.KeypadMenuPinButton.new(menu, controller)
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
	self:setClass(Warzone.KeypadMenuPinButton)
	self.id = "KeypadMenuPinButton"
	self.soundSet = "default"
	self:setScaledLeftRight(true, false, 0, 70)
	self:setScaledTopBottom(true, false, 0, 70)
	self:makeFocusable()
	self:setHandleMouse(true)
	self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    self.background:setImage(RegisterImage("ui_mp_br_bunker_keypad_button_base"))
    self.background:setRGB(0.6, 0.6, 0.6)

    self:addElement(self.background)

    self.buttonImage = LUI.UIImage.new()
    self.buttonImage:setScaledLeftRight(false, false, -32.5, 32.5)
    self.buttonImage:setScaledTopBottom(false, false, -32.5, 32.5)
    self.buttonImage:setImage(RegisterImage("blacktransparent"))
    self.buttonImage:setRGB(0.6, 0.6, 0.6)

    self.buttonImage:linkToElementModel(self, "image", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.buttonImage:setImage(RegisterImage(ModelVal))
        end
    end)

    self:addElement(self.buttonImage)

    self.focused = LUI.UIImage.new()
    self.focused:setScaledLeftRight(true, true, 0, 0)
    self.focused:setScaledTopBottom(true, true, 0, 0)
    self.focused:setImage(RegisterImage("ui_mp_br_bunker_keypad_button_overlay"))
    self.focused:setAlpha(0)
    self.focused:setRGB(0.8, 0.6, 0.3)

    self:addElement(self.focused)

    self.buttonText = LUI.UIText.new()
    self.buttonText:setScaledLeftRight(true, true, 0, 0)
    self.buttonText:setScaledTopBottom(true, false, 17, 53)
    self.buttonText:setRGB(0.6, 0.6, 0.6)
    self.buttonText:setTTF("fonts/main_regular.ttf")
    self.buttonText:setText("")

    self.buttonText:linkToElementModel(self, "digit", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.buttonText:setText(tostring(ModelVal))
        end
    end)

    self:addElement(self.buttonText)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(4)

                self.focused:completeAnimation()
                self.focused:setAlpha(0)
                self.clipFinished(self.focused, {})

                self.background:completeAnimation()
                self.background:setRGB(0.6, 0.6, 0.6)
                self.clipFinished(self.background, {})

                self.buttonText:completeAnimation()
                self.buttonText:setRGB(0.6, 0.6, 0.6)
                self.clipFinished(self.buttonText, {})

                self.buttonImage:completeAnimation()
                self.buttonImage:setRGB(0.6, 0.6, 0.6)
                self.clipFinished(self.buttonImage, {})
            end,
            GainFocus = function()
                self:setupElementClipCounter(4)

                self.focused:completeAnimation()
                self.focused:setAlpha(0)

                self.focused:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.focused:setAlpha(1)
                self.focused:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.background:completeAnimation()
                self.background:setRGB(0.6, 0.6, 0.6)

                self.background:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.background:setRGB(0.8, 0.6, 0.3)
                self.background:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.buttonText:completeAnimation()
                self.buttonText:setRGB(0.6, 0.6, 0.6)

                self.buttonText:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.buttonText:setRGB(0.8, 0.6, 0.3)
                self.buttonText:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.buttonImage:completeAnimation()
                self.buttonImage:setRGB(0.6, 0.6, 0.6)

                self.buttonImage:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.buttonImage:setRGB(0.8, 0.6, 0.3)
                self.buttonImage:registerEventHandler("transition_complete_keyframe", self.clipFinished)
            end,
            Focus = function()
                self:setupElementClipCounter(4)

                self.focused:completeAnimation()
                self.focused:setAlpha(1)
                self.clipFinished(self.focused, {})

                self.background:completeAnimation()
                self.background:setRGB(0.8, 0.6, 0.3)
                self.clipFinished(self.background, {})

                self.buttonText:completeAnimation()
                self.buttonText:setRGB(0.8, 0.6, 0.3)
                self.clipFinished(self.buttonText, {})

                self.buttonImage:completeAnimation()
                self.buttonImage:setRGB(0.8, 0.6, 0.3)
                self.clipFinished(self.buttonImage, {})
            end,
            LoseFocus = function()
                self:setupElementClipCounter(4)

                self.focused:completeAnimation()
                self.focused:setAlpha(1)

                self.focused:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.focused:setAlpha(0)
                self.focused:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.background:completeAnimation()
                self.background:setRGB(0.8, 0.6, 0.3)

                self.background:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.background:setRGB(0.6, 0.6, 0.6)
                self.background:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.buttonText:completeAnimation()
                self.buttonText:setRGB(0.8, 0.6, 0.3)

                self.buttonText:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.buttonText:setRGB(0.6, 0.6, 0.6)
                self.buttonText:registerEventHandler("transition_complete_keyframe", self.clipFinished)

                self.buttonImage:completeAnimation()
                self.buttonImage:setRGB(0.8, 0.6, 0.3)

                self.buttonImage:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
                self.buttonImage:setRGB(0.6, 0.6, 0.6)
                self.buttonImage:registerEventHandler("transition_complete_keyframe", self.clipFinished)
            end
        }
    }
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end