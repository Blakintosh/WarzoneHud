Warzone.Killstreak = InheritFrom(LUI.UIElement)

local function PreLoadFunc(self, controller)
	Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "showDpadRight")
	Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "iconDpadRight")
end

Warzone.Killstreak.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.Killstreak)
	self.id = "Killstreak"
	self.soundSet = "default"

    self.backer = LUI.UIImage.new()
	self.backer:setScaledLeftRight(false, true, -60, 0)
	self.backer:setScaledTopBottom(false, false, -22, 22)
	self.backer:setImage(RegisterImage("widg_gradient_right_to_left"))
	Util.SetRGBFromTable(self.backer, Util.Swatches.GlobalKeyColorMid)
	self.backer:setAlpha(0.2)

	Util.ClipSequence(self, self.backer, "Show", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.backer, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

	self:addElement(self.backer)

	self.texture = LUI.UIImage.new()
	self.texture:setScaledLeftRight(false, true, -60, 0)
	self.texture:setScaledTopBottom(false, false, -22, 22)
	self.texture:setImage(RegisterImage("widg_gradient_right_to_left"))
	Util.SetRGBFromTable(self.texture, Util.Swatches.GlobalKeyColor)
	self.texture:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
	self.texture:setShaderVector(0, 2, 2, 1, 1)
	self.texture:setAlpha(0.4)

	Util.CopySequence(self, self.backer, self.texture, "Show", "Show")
	Util.CopySequence(self, self.backer, self.texture, "DefaultState", "DefaultState")

	self:addElement(self.texture)

	self.icon = LUI.UIImage.new()
	self.icon:setScaledLeftRight(false, true, -46, -4)
	self.icon:setScaledTopBottom(false, false, -21, 21)
	self.icon:setImage(RegisterImage("blacktransparent"))

	Util.SubscribeToImage(self.icon, controller, "hudItems.iconDpadRight")

	Util.CopySequence(self, self.backer, self.icon, "Show", "Show")
	Util.CopySequence(self, self.backer, self.icon, "DefaultState", "DefaultState")

	self:addElement(self.icon)

	self.button = Warzone.ButtonPrompt.new(menu, controller)
    self.button:setScaledLeftRight(false, true, -76, -60)
    self.button:setScaledTopBottom(false, false, -8, 8)
    self.button:setButtonPrompt("actionslot 4", "actionslot 4")

    Util.CopySequence(self, self.backer, self.button, "Show", "Show")
	Util.CopySequence(self, self.backer, self.button, "DefaultState", "DefaultState")

    self:addElement(self.button)

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				Util.AnimateSequence(self, "DefaultState")
			end
		},
		Show = {
			DefaultClip = function()
				Util.AnimateSequence(self, "Show")
			end
		}
	}

	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, self, event)
				return IsModelValueEqualTo(controller, "hudItems.showDpadRight", 1)
			end
		}
	})

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

