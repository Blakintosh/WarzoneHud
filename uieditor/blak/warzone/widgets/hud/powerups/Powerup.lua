Warzone.Powerup = InheritFrom(LUI.UIElement)

Warzone.Powerup.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.Powerup)
	self.id = "Powerup"
	self.soundSet = "default"
	self:setScaledLeftRight(true, false, 0, 40)
	self:setScaledTopBottom(true, false, 0, 40)

    self.Circle = LUI.UIImage.new()
    self.Circle:setScaledLeftRight(true, true, 0, 0)
    self.Circle:setScaledTopBottom(true, true, 0, 0)
    self.Circle:setImage(RegisterImage("hud_ability_base_circle"))
    Util.SetRGBFromTable(self.Circle, Util.Colors.PowerupOrange)
    self.Circle:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
    self.Circle:setShaderVector(0, 0.5, 0, 0, 0)
	self.Circle:setShaderVector(1, 0.5, 0, 0, 0)
	self.Circle:setShaderVector(2, 0.5, 0, 0, 0)
	self.Circle:setShaderVector(3, 0, 0, 0, 0)

    Util.LinkToWidget(self.Circle, self, "timeLeft", function(modelValue)
        self.Circle:setShaderVector(0, CoD.GetVectorComponentFromString(modelValue, 1), CoD.GetVectorComponentFromString(modelValue, 2), CoD.GetVectorComponentFromString(modelValue, 3), CoD.GetVectorComponentFromString(modelValue, 4))
    end)

    Util.ClipSequence(self, self.Circle, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.Circle, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    
    self:addElement(self.Circle)
	
    self.PowerupImage = LUI.UIImage.new()
	self.PowerupImage:setScaledLeftRight(false, false, -16, 16)
	self.PowerupImage:setScaledTopBottom(false, false, -16, 16)

	Util.LinkToWidget(self.PowerupImage, self, "image", function(modelValue)
		self.PowerupImage:setImage(RegisterImage(modelValue))
	end)

    Util.ClipSequence(self, self.PowerupImage, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.PowerupImage, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

	self:addElement(self.PowerupImage)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        Enabled = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Enabled")
            end
        }
    }

	self:mergeStateConditions({
        {
            stateName = "Enabled", 
            condition = function (menu, self, event)
		        return IsSelfModelValueEqualTo(self, controller, "status", 1)
	        end
        }
    })

    Util.LinkWidgetToState(self, self, menu, "status")

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
        Sender.Circle:close()
		Sender.PowerupImage:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

