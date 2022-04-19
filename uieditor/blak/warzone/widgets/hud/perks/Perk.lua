Warzone.Perk = InheritFrom(LUI.UIElement)

Warzone.Perk.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.Perk)
	self.id = "Perk"
	self.soundSet = "default"
	self:setScaledLeftRight(true, false, 0, 11)
	self:setScaledTopBottom(true, false, 0, 11)
	
    self.PerkImage = LUI.UIImage.new()
	self.PerkImage:setLeftRight(true, true, 0, 0)
	self.PerkImage:setTopBottom(true, true, 0, 0)

	Util.LinkToWidget(self.PerkImage, self, "image", function(modelValue)
		self.PerkImage:setImage(RegisterImage(modelValue))
	end)

    Util.ClipSequence(self, self.background, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.background, "Enabled", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

	self:addElement(self.PerkImage)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
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
		Sender.PerkImage:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

