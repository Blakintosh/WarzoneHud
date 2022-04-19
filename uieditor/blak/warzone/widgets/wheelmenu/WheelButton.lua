require("ui.uieditor.blak.warzone.widgets.wheelmenu.WheelButtonImages")

Warzone.WheelButton = InheritFrom( LUI.UIElement )

local function PostLoadFunc(self, controller, menu)
	self.setWheelRotation = function(self, angle)
		self:setZRot(angle)
		self.decor.icon:setZRot(-angle)
	end
end

Warzone.WheelButton.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end
	self:setUseStencil( false )
	self:setClass( Warzone.WheelButton )
	self.id = "WheelButton"
	self.soundSet = "none"
	self:makeFocusable()
	self.anyChildUsesUpdateState = true
	self.onlyChildrenFocusable = true

	self.decor = Warzone.WheelButtonImages.new(menu, controller)
	self.decor:setScaledLeftRight(false, false, -0, 0)
	self.decor:setScaledTopBottom(false, false, -0, 0)
	self.decor.id = "decor"

	Util.LinkWidgetToElementModel(self.decor, self, controller)

	self:addElement(self.decor)

	self.focusableComponent = LUI.UIImage.new()
	self.focusableComponent:setScaledLeftRight(false, false, -30, 30)
	self.focusableComponent:setScaledTopBottom(false, false, -155, -95)
	self.focusableComponent:makeFocusable()
	self.focusableComponent:setHandleMouse( true )
	self.focusableComponent:setAlpha(0.00001)
	self.focusableComponent.id = "focusableComponent"

	self.focusableComponent.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self.focusableComponent:setupElementClipCounter(0)
			end,
			Focus = function()
				self.focusableComponent:setupElementClipCounter(0)
			end
		}
	}

	self.focusableComponent:registerEventHandler("gain_focus", function(sender, event)
		if sender.m_focusable then
			if self:processEvent(event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(sender, event)
	end)

	self.focusableComponent:registerEventHandler("button_action", function(sender, event)
		if self:processEvent(event) then
			return true
		end
		return nil
	end)

	self:addElement(self.focusableComponent)

	self:registerEventHandler("gain_focus", function(sender, event)
		if self.m_focusable then
			if self.decor:processEvent(event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(self, event)
	end)
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	return self
end

