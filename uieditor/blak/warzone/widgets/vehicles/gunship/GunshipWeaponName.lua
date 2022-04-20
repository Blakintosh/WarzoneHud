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

	Util.ClipSequence(self.reloadBarContainer, self.reloadBar, "DefaultState", {
		{
			duration = 0,
			setShaderVector = {0, 0, 0, 0, 0}
		}
	})
	Util.ClipSequence(self.reloadBarContainer, self.reloadBar, "Reloading", {
		{
			duration = 0,
			setShaderVector = {0, 1, 0, 0, 0}
		},
		{
			duration = function()
				return (self.reloadTime * 1000)
			end,
			setShaderVector = {0, 0, 0, 0, 0}
		}
	})

    self.reloadBarContainer:addElement(self.reloadBar)

	self.reloadBarContainer.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self.reloadBarContainer, "DefaultState")
            end
        },
        Reloading = {
            DefaultClip = function()
                Util.AnimateSequence(self.reloadBarContainer, "Reloading")
            end
        }
    }

    self.reloadBarContainer:mergeStateConditions({
        {
            stateName = "Reloading",
            condition = function(HudRef, ItemRef, StateTable)
                local ReloadingMdl = Engine.GetModelValue(Engine.GetModel(self:getModel(), "reloadingModel"))
                if ReloadingMdl then
                    return IsModelValueEqualTo(controller, ReloadingMdl, 1)
                end
                return false
            end
        }
    })

    Util.LinkToWidget(self.reloadBarContainer, self, "reloadingModel", function(modelValue)
		Util.SubState(controller, menu, self.reloadBarContainer, modelValue)
	end)

    self:addElement(self.reloadBarContainer)

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

    self.weaponName = LUI.UIText.new()
    self.weaponName:setScaledLeftRight(false, false, -50, 50)
    self.weaponName:setScaledTopBottom(true, false, 3, 17)
    self.weaponName:setRGB(0.7, 0.7, 0.7)
    self.weaponName:setText("105MM")
    self.weaponName:setTTF("fonts/main_regular.ttf")

	Util.LinkToWidgetText(self.weaponName, self, "name", true)

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
                local ActiveMdl = Engine.GetModelValue(Engine.GetModel(self:getModel(), "activeModel"))
                if ActiveMdl then
                    return IsModelValueTrue(controller, ActiveMdl)
                end
                return false
            end
        }
    })

	Util.LinkToWidget(self, self, "activeModel", function(modelValue)
		Util.SubState(controller, menu, self, modelValue)
	end)

	Util.LinkToWidget(self, self, "reloadTime", function(modelValue)
		self.reloadTime = modelValue
	end)
    
    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end