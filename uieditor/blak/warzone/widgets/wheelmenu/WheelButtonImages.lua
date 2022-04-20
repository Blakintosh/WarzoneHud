Warzone.WheelButtonImages = InheritFrom( LUI.UIElement )

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

	self.expanded = LUI.UIImage.new()
	self.expanded:setScaledLeftRight(false, false, -100, 100)
	self.expanded:setScaledTopBottom(false, false, -280, -72)
	self.expanded:setImage(RegisterImage("radial_expanded_kbm_8"))

	Util.ClipSequence(self, self.expanded, "DefaultUp", {
		{
			duration = 0,
			setAlpha = 0
		}
	})
	Util.ClipSequence(self, self.expanded, "DefaultOver", {
		{
			duration = 0,
			setAlpha = 1
		}
	})
	Util.ClipSequence(self, self.expanded, "DisabledUp", {
		{
			duration = 0,
			setAlpha = 0
		}
	})
	Util.ClipSequence(self, self.expanded, "DisabledOver", {
		{
			duration = 0,
			setAlpha = 1
		}
	})

	self:addElement(self.expanded)

	self.slice = LUI.UIImage.new()
	self.slice:setScaledLeftRight(false, false, -170, 170)
	self.slice:setScaledTopBottom(false, false, -168, 172)
	self.slice:setImage(RegisterImage("radial_8slice_available"))

	Util.ClipSequence(self, self.slice, "DefaultUp", {
		{
			duration = 0,
			setAlpha = 0.8
		}
	})
	Util.ClipSequence(self, self.slice, "DefaultOver", {
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

	Util.ClipSequence(self, self.selectedSlice, "DefaultUp", {
		{
			duration = 0,
			setAlpha = 0,
			setImage = RegisterImage("radial_8slice_selected_available")
		}
	})
	Util.ClipSequence(self, self.selectedSlice, "DefaultOver", {
		{
			duration = 0,
			setAlpha = 1,
			setImage = RegisterImage("radial_8slice_selected_available")
		}
	})
	Util.ClipSequence(self, self.selectedSlice, "DisabledUp", {
		{
			duration = 0,
			setAlpha = 0,
			setImage = RegisterImage("radial_8slice_selected_unavailable")
		}
	})
	Util.ClipSequence(self, self.selectedSlice, "DisabledOver", {
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
	Util.LinkToWidget(self.icon, self, "icon", function(modelValue)
		self.icon:setImage(RegisterImage(modelValue))
	end)

	Util.ClipSequence(self, self.icon, "DefaultUp", {
		{
			duration = 0,
			setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
		}
	})
	Util.ClipSequence(self, self.icon, "DefaultOver", {
		{
			duration = 0,
			setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain)
		}
	})
	Util.ClipSequence(self, self.icon, "DisabledUp", {
		{
			duration = 0,
			setRGB = Util.ConvertColorToTable(Util.Swatches.ScorestreakButtonUnavailable)
		}
	})
	Util.ClipSequence(self, self.icon, "DisabledOver", {
		{
			duration = 0,
			setRGB = Util.ConvertColorToTable(Util.Swatches.ScorestreakButtonUnavailable)
		}
	})
	Util.ClipSequence(self, self.icon, "Pulse", {
		{
			duration = 0,
			setAlpha = 1
		},
		{
			duration = 30,
			setAlpha = 0
		},
		{
			duration = 30,
			setAlpha = 1
		},
		{
			duration = 30,
			setAlpha = 0
		},
		{
			duration = 30,
			setAlpha = 1
		},
		{
			duration = 30,
			setAlpha = 0
		},
		{
			duration = 30,
			setAlpha = 1
		}
	})

	self:addElement(self.icon)
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				Util.AnimateSequence(self, "DefaultUp")
			end,
			Focus = function ()
				Util.AnimateSequence(self, "DefaultOver")
			end
		},
		Inactive = {
			DefaultClip = function ()
				Util.AnimateSequence(self, "DisabledUp")
			end,
			Focus = function ()
				Util.AnimateSequence(self, "DisabledOver")
			end
		},
		Pulse = {
			DefaultClip = function()
				Util.AnimateSequence(self, "Pulse")
			end
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

