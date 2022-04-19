Warzone.WheelButtonImages = InheritFrom( LUI.UIElement )

local function PostLoadFunc(self, controller, menu)
	self.setWheelRotation = function(self, angle)
		self:setZRot(angle)
		self.icon:setZRot(-angle)
	end
end

Warzone.WheelButtonImages.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end
	self:setUseStencil( false )
	self:setClass( Warzone.WheelButtonImages )
	self.id = "WheelButtonImages"
	self.soundSet = "none"
	self:makeFocusable()
	self.anyChildUsesUpdateState = true

	self.slice = LUI.UIImage.new()
	self.slice:setScaledLeftRight(false, false, -170, 170)
	self.slice:setScaledTopBottom(false, false, -168, 172)
	self.slice:setImage(RegisterImage("radial_8slice_available"))

	Wzu.ClipSequence(self, self.slice, "DefaultUp", {
		{
			duration = 0,
			setAlpha = 0.8
		}
	})
	Wzu.ClipSequence(self, self.slice, "DefaultOver", {
		{
			duration = 0,
			setAlpha = 0.8
		}
	})

	self:addElement(self.slice)

	self.selectedSlice = LUI.UIImage.new()
	self.selectedSlice:setScaledLeftRight(false, false, -170, 170)
	self.selectedSlice:setScaledTopBottom(false, false, -168, 172)
	self.selectedSlice:setImage(RegisterImage("radial_8slice_selected_available"))
	self.selectedSlice:setAlpha(1)

	Wzu.ClipSequence(self, self.selectedSlice, "DefaultUp", {
		{
			duration = 0,
			setAlpha = 0,
			setImage = RegisterImage("radial_8slice_selected_available")
		}
	})
	Wzu.ClipSequence(self, self.selectedSlice, "DefaultOver", {
		{
			duration = 0,
			setAlpha = 1,
			setImage = RegisterImage("radial_8slice_selected_available")
		}
	})
	Wzu.ClipSequence(self, self.selectedSlice, "DisabledUp", {
		{
			duration = 0,
			setAlpha = 0,
			setImage = RegisterImage("radial_8slice_selected_unavailable")
		}
	})
	Wzu.ClipSequence(self, self.selectedSlice, "DisabledOver", {
		{
			duration = 0,
			setAlpha = 1,
			setImage = RegisterImage("radial_8slice_selected_unavailable")
		}
	})

	self:addElement(self.selectedSlice)

	self.icon = LUI.UIImage.new()
	self.icon:setScaledLeftRight(false, false, -30, 30)
	self.icon:setScaledTopBottom(false, false, -155, -95)
	self.icon:setImage(RegisterImage("hud_icon_equipment_flashlight"))
	Wzu.LinkToWidget(self.icon, self, "icon", function(modelValue)
		self.icon:setImage(RegisterImage(modelValue))
	end)

	Wzu.ClipSequence(self, self.icon, "DefaultUp", {
		{
			duration = 0,
			setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
		}
	})
	Wzu.ClipSequence(self, self.icon, "DefaultOver", {
		{
			duration = 0,
			setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
		}
	})
	Wzu.ClipSequence(self, self.icon, "DisabledUp", {
		{
			duration = 0,
			setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ScorestreakButtonUnavailable)
		}
	})
	Wzu.ClipSequence(self, self.icon, "DisabledOver", {
		{
			duration = 0,
			setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.ScorestreakButtonUnavailable)
		}
	})

	self:addElement(self.icon)
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				Wzu.AnimateSequence(self, "DefaultUp")
			end,
			Focus = function ()
				Wzu.AnimateSequence(self, "DefaultOver")
			end,
		},
		Inactive = {
			DefaultClip = function ()
				Wzu.AnimateSequence(self, "DisabledUp")
			end,
			Focus = function ()
				Wzu.AnimateSequence(self, "DisabledOver")
			end,
		}
	}
	self:mergeStateConditions( {
		{
			stateName = "Inactive",
			condition = function ( menu, element, event )
				return not IsSelfModelValueTrue( element, controller, "enabled" )
			end
		}
	} )
	self:linkToElementModel( self, "enabled", true, function ( model )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "enabled"
		} )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	return self
end

