Warzone.GunshipCrosshair = InheritFrom(LUI.UIElement)

local function PreLoadFunc(self, controller)
    -- Incase this game is being stupid (so most likely)
    Engine.CreateModel(Engine.GetModelForController(controller), "ac130")

	for i = 0, 2 do
		Engine.CreateModel(Engine.GetModelForController(controller), "ac130."..tostring(i))
		Engine.CreateModel(Engine.GetModelForController(controller), "ac130."..tostring(i)..".active")
    end

    Engine.CreateModel(Engine.GetModelForController(controller), "vehicle.pulseWeaponFired")
end

Warzone.GunshipCrosshair.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.GunshipCrosshair)
	self.id = "GunshipCrosshair"
	self.soundSet = "default"
    self:setScaledLeftRight(true, false, 0, 100)
    self:setScaledTopBottom(true, false, 0, 60)
	self.anyChildUsesUpdateState = true

    self.OneOhFive = LUI.UIImage.new()
    self.OneOhFive:setScaledLeftRight(false, false, -120, 120)
    self.OneOhFive:setScaledTopBottom(false, false, -80, 80)
    self.OneOhFive:setImage(RegisterImage("mp_ac130_105mm_reticle"))

	Util.ClipSequence(self, self.OneOhFive, "TwFvDefault", {
		{
			duration = 0,
			setAlpha = 0
		}
	})
	Util.CopySequence(self, self.OneOhFive, self.OneOhFive, "TwFvDefault", "TwFvOnFire")
	Util.CopySequence(self, self.OneOhFive, self.OneOhFive, "TwFvDefault", "FrtyDefault")
	Util.CopySequence(self, self.OneOhFive, self.OneOhFive, "TwFvDefault", "FrtyOnFire")
	Util.CopySequence(self, self.OneOhFive, self.OneOhFive, "TwFvDefault", "Default")

	Util.ClipSequence(self, self.OneOhFive, "OoFDefault", {
		{
			duration = 0,
			setAlpha = 1,
			setScale = 1
		}
	})
	Util.ClipSequence(self, self.OneOhFive, "OoFOnFire", {
		{
			duration = 0,
			setAlpha = 1,
			setScale = 1.15
		},
		{
			duration = 100,
			setScale = 0.9
		},
		{
			duration = 100,
			setScale = 1
		}
	})

    self:addElement(self.OneOhFive)

    self.Fourty = LUI.UIImage.new()
    self.Fourty:setScaledLeftRight(false, false, -160, 160)
    self.Fourty:setScaledTopBottom(true, false, 246, 336)
    self.Fourty:setImage(RegisterImage("mp_ac130_40mm_reticle"))

	Util.CopySequence(self, self.OneOhFive, self.Fourty, "TwFvDefault", "TwFvDefault")
	Util.CopySequence(self, self.OneOhFive, self.Fourty, "TwFvDefault", "TwFvOnFire")
	Util.CopySequence(self, self.OneOhFive, self.Fourty, "TwFvDefault", "OoFDefault")
	Util.CopySequence(self, self.OneOhFive, self.Fourty, "TwFvDefault", "OoFOnFire")
	Util.CopySequence(self, self.OneOhFive, self.Fourty, "OoFDefault", "FrtyDefault")
	Util.CopySequence(self, self.OneOhFive, self.Fourty, "TwFvDefault", "Default")

	Util.ClipSequence(self, self.Fourty, "FrtyOnFire", {
		{
			duration = 0,
			setAlpha = 1,
			setScale = 1.2
		},
		{
			duration = 150,
			setScale = 1
		}
	})

    self:addElement(self.Fourty)

    self.TwentyFive = LUI.UIImage.new()
    self.TwentyFive:setScaledLeftRight(false, false, -50, 50)
    self.TwentyFive:setScaledTopBottom(false, false, -30, 30)
    self.TwentyFive:setImage(RegisterImage("mp_ac130_25mm_reticle"))

	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "TwFvDefault", "FrtyDefault")
	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "TwFvDefault", "FrtyOnFire")
	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "TwFvDefault", "OoFDefault")
	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "TwFvDefault", "OoFOnFire")
	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "OoFDefault", "TwFvDefault")
	Util.CopySequence(self, self.OneOhFive, self.TwentyFive, "TwFvDefault", "Default")

	Util.ClipSequence(self, self.TwentyFive, "TwFvOnFire", {
		{
			duration = 0,
			setAlpha = 1,
			setScale = 1
		},
		{
			duration = 50,
			setScale = 1.1
		},
		{
			duration = 50,
			setScale = 1.1
		},
		{
			duration = 100,
			setScale = 1
		}
	})

    self:addElement(self.TwentyFive)

    self.clipsPerState = {
        TwFv = {
            DefaultClip = function()
                Util.AnimateSequence(self, "TwFvDefault")
            end,
            OnFire = function()
                Util.AnimateSequence(self, "TwFvOnFire")
			end
        },
        Frty = {
            DefaultClip = function()
                Util.AnimateSequence(self, "FrtyDefault")
            end,
            OnFire = function()
                Util.AnimateSequence(self, "FrtyOnFire")
            end
        },
        OoF = {
            DefaultClip = function()
                Util.AnimateSequence(self, "OoFDefault")
            end,
            OnFire = function()
                Util.AnimateSequence(self, "OoFOnFire")
            end
        },
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Default")
            end,
            OnFire = function()
                Util.AnimateSequence(self, "Default")
            end
        }
    }

    self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "vehicle.pulseWeaponFired"), function(ModelRef)
        PlayClip(self, "OnFire", controller)
    end)

    -- CBA
    self:mergeStateConditions({
        {
            stateName = "OoF",
            condition = function(HudRef, ItemRef, StateTable)
                --return AlwaysTrue()
                return IsModelValueEqualTo(controller, "ac130.0.active", 1)
            end
        },
        {
            stateName = "Frty",
            condition = function(HudRef, ItemRef, StateTable)
                return IsModelValueEqualTo(controller, "ac130.1.active", 1)
            end
        },
        {
            stateName = "TwFv",
            condition = function(HudRef, ItemRef, StateTable)
                return IsModelValueEqualTo(controller, "ac130.2.active", 1)
            end
        }
    })

    Util.SubState(controller, menu, self, "ac130.0.active")
    Util.SubState(controller, menu, self, "ac130.1.active")
    Util.SubState(controller, menu, self, "ac130.2.active")

    if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end