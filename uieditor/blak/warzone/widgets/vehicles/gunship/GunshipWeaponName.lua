Warzone.GunshipWeaponName = InheritFrom(LUI.UIElement)

Warzone.GunshipWeaponName.new = function (menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.GunshipWeaponName)
	self.id = "GunshipWeaponName"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true

    self.inactive = LUI.UIImage.new()
    self.inactive:setRGB(0, 0, 0)
    self.inactive:setAlpha(0.4)
    self.inactive:setScaledLeftRight(true, true, 0, 0)
    self.inactive:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.inactive)

    self.active = LUI.UIImage.new()
    self.active:setRGB(0.7, 0.7, 0.7)
    self.active:setScaledLeftRight(true, true, 0, 0)
    self.active:setScaledTopBottom(true, true, 0, 0)
    self.active:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.active:setShaderVector(1, 0, 0, 0, 0)
    self.active:setShaderVector(2, 1, 0, 0, 0)
    self.active:setShaderVector(3, 0, 0, 0, 0)

    self:addElement(self.active)

    self.reloadBarContainer = LUI.UIElement.new()
    self.reloadBarContainer:setScaledLeftRight(true, true, 0, 0)
    self.reloadBarContainer:setScaledTopBottom(true, true, 0, 0)

    self.reloadBar = LUI.UIImage.new()
    self.reloadBar:setScaledLeftRight(true, true, 0, 0)
    self.reloadBar:setScaledTopBottom(true, true, 0, 0)
    self.reloadBar:setRGB(1, 0.2, 0.1)
    self.reloadBar:setAlpha(0.8)
    self.reloadBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
    self.reloadBar:setShaderVector(1, 0, 0, 0, 0)
    self.reloadBar:setShaderVector(2, 1, 0, 0, 0)
    self.reloadBar:setShaderVector(3, 0, 0, 0, 0)

    self.reloadBarContainer:addElement(self.reloadBar)

    self.left = LUI.UIImage.new()
    self.left:setScaledLeftRight(true, false, -0.5, 0.5)
    self.left:setScaledTopBottom(true, true, 0, 0)
    self.left:setRGB(0.7, 0.7, 0.7)

    self:addElement(self.left)

    self.right = LUI.UIImage.new()
    self.right:setScaledLeftRight(false, true, -0.5, 0.5)
    self.right:setScaledTopBottom(true, true, 0, 0)
    self.right:setRGB(0.7, 0.7, 0.7)

    self:addElement(self.right)

    self.reloadBarContainer.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self.reloadBarContainer:setupElementClipCounter(1)

                self.reloadBar:completeAnimation()
                self.reloadBar:setShaderVector(0, 0, 0, 0, 0)

                self.reloadBarContainer.clipFinished(self.reloadBar, {})
            end
        },
        Reloading = {
            DefaultClip = function()
                self.reloadBarContainer:setupElementClipCounter(1)

                self.reloadBar:completeAnimation()
                self.reloadBar:setShaderVector(0, 1, 0, 0, 0)
                
                local ModelVal = Engine.GetModelValue(Engine.GetModel(self:getModel(), "reloadTime"))

                local ReloadTimeVal = nil
                if ModelVal then
                    ReloadTimeVal = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), ModelVal))
                end

                if ReloadTimeVal then
                    self.reloadBar:beginAnimation("keyframe", ReloadTimeVal * 1000, false, false, CoD.TweenType.Linear)
                end
                self.reloadBar:setShaderVector(0, 0, 0, 0, 0)

                if ReloadTimeVal then
                    self.reloadBar:registerEventHandler("transition_complete_keyframe", self.reloadBarContainer.clipFinished)
                else
                    self.reloadBarContainer.clipFinished(self.reloadBar, {})
                end
            end
        }
    }

    self.reloadBarContainer:mergeStateConditions({
        {
            stateName = "Reloading",
            condition = function(HudRef, ItemRef, StateTable)
                local ReloadingMdl = Engine.GetModelValue(Engine.GetModel(self:getModel(), "reloading"))
                if ReloadingMdl then
                    return IsModelValueEqualTo(controller, ReloadingMdl, 1)
                end
                return false
            end
        }
    })

    self.reloadBarContainer:linkToElementModel(self, "reloading", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.reloadBarContainer:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelVal), function(ModelRef2)
                menu:updateElementState(self.reloadBarContainer, {
                    name = "model_validation",
                    menu = menu,
                    modelValue = Engine.GetModelValue(ModelRef2),
                    modelName = ModelVal
                })
            end)
        end
    end)

    self:addElement(self.reloadBarContainer)

    self.weaponName = LUI.UIText.new()
    self.weaponName:setScaledLeftRight(false, false, -50, 50)
    self.weaponName:setScaledTopBottom(true, false, 3, 17)
    self.weaponName:setRGB(0.7, 0.7, 0.7)
    self.weaponName:setText("105MM")
    self.weaponName:setTTF("fonts/main_regular.ttf")

    self.weaponName:linkToElementModel(self, "name", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.weaponName:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelVal), function(ModelRef2)
                local ModelVal2 = Engine.GetModelValue(ModelRef2)
                if ModelVal2 then
                    self.weaponName:setText(LocalizeToUpperString(ModelVal2))
                end
            end)
        end
    end)

    self:addElement(self.weaponName)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(2)

                self.weaponName:completeAnimation()
                self.weaponName:setRGB(0.7, 0.7, 0.7)

                self.clipFinished(self.weaponName, {})

                self.active:completeAnimation()
                self.active:setZRot(180)
                self.active:setShaderVector(0, 0, 0, 0, 0)
            end,
            Active = function()
                self:setupElementClipCounter(2)

                self.weaponName:completeAnimation()
                self.weaponName:setRGB(0.7, 0.7, 0.7)

                self.clipFinished(self.weaponName, {})

                self.active:completeAnimation()
                self.active:setZRot(0)
                self.active:setShaderVector(0, 0, 0, 0, 0)
                self.active:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                self.active:setShaderVector(0, 1, 0, 0, 0)

                self.active:registerEventHandler("transition_complete_keyframe", self.clipFinished)
            end
        },
        Active = {
            DefaultClip = function()
                self:setupElementClipCounter(2)

                self.weaponName:completeAnimation()
                self.weaponName:setRGB(0.2, 0.2, 0.2)

                self.clipFinished(self.weaponName, {})

                self.active:completeAnimation()
                self.active:setZRot(0)
                self.active:setShaderVector(0, 1, 0, 0, 0)
            end,
            DefaultState = function()
                self:setupElementClipCounter(2)

                self.weaponName:completeAnimation()
                self.weaponName:setRGB(0.2, 0.2, 0.2)

                self.clipFinished(self.weaponName, {})

                self.active:completeAnimation()
                self.active:setZRot(180)
                self.active:setShaderVector(0, 1, 0, 0, 0)
                self.active:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                self.active:setShaderVector(0, 0, 0, 0, 0)

                self.active:registerEventHandler("transition_complete_keyframe", self.clipFinished)
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "Active",
            condition = function(HudRef, ItemRef, StateTable)
                local ActiveMdl = Engine.GetModelValue(Engine.GetModel(self:getModel(), "active"))
                if ActiveMdl then
                    return IsModelValueEqualTo(controller, ActiveMdl, 1)
                end
                return false
            end
        }
    })

    --SubscribeToModelAndUpdateState()
    self:linkToElementModel(self, "active", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelVal), function(ModelRef2)
                menu:updateElementState(self, {
                    name = "model_validation",
                    menu = menu,
                    modelValue = Engine.GetModelValue(ModelRef2),
                    modelName = ModelVal
                })
            end)
        end
    end)
    
    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end