require("ui.uieditor.blak.warzone.widgets.userinterface.button.MenuButtonPrompt")
require("ui.uieditor.widgets.FooterButtonPrompt")

local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2)
	f1_arg0:setForceMouseEventDispatch(true)
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = DataSources
	if f2_local0 then
		f2_local0 = DataSources.LiveEventViewer
		if f2_local0 then
			f2_local0 = DataSources.LiveEventViewer.getModel()
		end
	end
	if f2_local0 then
		local f2_local1 = Engine.GetModel(f2_local0, "currentQuality")
		if f2_local1 then
			f2_arg0:subscribeToModel(f2_local1, function (ModelRef)
				local f4_local0 = f2_arg0.Xbtn:getModel()
				if f4_local0 then
					f4_local0 = Engine.GetModel(f4_local0, "Label")
				end
				if f4_local0 then
					Engine.ForceNotifyModelSubscriptions(f4_local0)
				end
			end)
		end
	end
	if CoD.isPC then
		f0_local0(f2_arg0, f2_arg1, f2_arg2)
	end
end

Warzone.MenuFooterPrompts = InheritFrom(LUI.UIElement)
Warzone.MenuFooterPrompts.new = function (menu, controller)
	local self = LUI.UIHorizontalList.new({left = 0, top = 0, right = 0, bottom = 0, leftAnchor = true, topAnchor = true, rightAnchor = true, bottomAnchor = true, spacing = 0})
	self:setAlignment(LUI.Alignment.Left)
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.MenuFooterPrompts)
	self.id = "MenuFooterPrompts"
	self.soundSet = "default"
	self:setScaledLeftRight(true, false, 0, 528)
	self:setTopBottom(true, false, 0, 32)
	self.anyChildUsesUpdateState = true

	self.Abtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.Abtn:setScaledLeftRight(true, false, 0, 88)
	self.Abtn:setScaledTopBottom(false, false, -22, 22)
	self.Abtn.label:setText(Engine.Localize(""))
	self.Abtn:subscribeToGlobalModel(controller, "Controller", "primary_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.Abtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.Abtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_XBA_PSCROSS, false, function (ModelRef)
		self.Abtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.Abtn)
	
	self.Bbtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.Bbtn:setScaledLeftRight(true, false, 88, 168)
	self.Bbtn:setScaledTopBottom(false, false, -22, 22)
	self.Bbtn.label:setText(Engine.Localize(""))
	self.Bbtn:subscribeToGlobalModel(controller, "Controller", "secondary_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.Bbtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.Bbtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, false, function (ModelRef)
		self.Bbtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.Bbtn)
	
	self.Xbtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.Xbtn:setScaledLeftRight(true, false, 168, 256)
	self.Xbtn:setScaledTopBottom(false, false, -22, 22)
	self.Xbtn.label:setText(Engine.Localize(""))
	self.Xbtn:subscribeToGlobalModel(controller, "Controller", "alt1_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.Xbtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.Xbtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_XBX_PSSQUARE, false, function (ModelRef)
		self.Xbtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.Xbtn)
	
	self.OptionsBtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.OptionsBtn:setScaledLeftRight(true, false, 256, 344)
	self.OptionsBtn:setScaledTopBottom(false, false, -22, 22)
	self.OptionsBtn.label:setText(Engine.Localize(""))
	self.OptionsBtn:subscribeToGlobalModel(controller, "Controller", "start_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.OptionsBtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.OptionsBtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_START, false, function (ModelRef)
		self.OptionsBtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.OptionsBtn)
	
	self.Ybtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.Ybtn:setScaledLeftRight(true, false, 344, 432)
	self.Ybtn:setScaledTopBottom(false, false, -22, 22)
	self.Ybtn.label:setText(Engine.Localize(""))
	self.Ybtn:subscribeToGlobalModel(controller, "Controller", "alt2_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.Ybtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.Ybtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, false, function (ModelRef)
		self.Ybtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.Ybtn)
	
	self.LTbtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.LTbtn:setScaledLeftRight(true, false, 432, 520)
	self.LTbtn:setScaledTopBottom(false, false, -22, 22)
	self.LTbtn.label:setText(Engine.Localize(""))
	self.LTbtn:subscribeToGlobalModel(controller, "Controller", "left_trigger_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.LTbtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.LTbtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_LTRIG, false, function (ModelRef)
		self.LTbtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.LTbtn)
	
	self.RTbtn = Warzone.MenuButtonPrompt.new(menu, controller)
	self.RTbtn:setScaledLeftRight(true, false, 520, 608)
	self.RTbtn:setScaledTopBottom(false, false, -22, 22)
	self.RTbtn.label:setText(Engine.Localize(""))
	self.RTbtn:subscribeToGlobalModel(controller, "Controller", "right_trigger_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.RTbtn.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.RTbtn:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_RTRIG, false, function (ModelRef)
		self.RTbtn:setModel(ModelRef, controller)
	end)
	self:addElement(self.RTbtn)
	
	self.LeftStick = Warzone.MenuButtonPrompt.new(menu, controller)
	self.LeftStick:setScaledLeftRight(true, false, 608, 696)
	self.LeftStick:setScaledTopBottom(false, false, -22, 22)
	self.LeftStick.label:setText(Engine.Localize(""))
	self.LeftStick:subscribeToGlobalModel(controller, "Controller", "move_left_stick_button_image", function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.LeftStick.buttonPromptImage:setImage(RegisterImage(ModelValue))
		end
	end)
	self.LeftStick:linkToElementModel(self, "" .. Enum.LUIButton.LUI_KEY_LSTICK_PRESSED, false, function (ModelRef)
		self.LeftStick:setModel(ModelRef, controller)
	end)
	self:addElement(self.LeftStick)
	
	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.Abtn:close()
		Sender.Bbtn:close()
		Sender.Xbtn:close()
		Sender.OptionsBtn:close()
		Sender.Ybtn:close()
		Sender.LTbtn:close()
		Sender.RTbtn:close()
		Sender.LeftStick:close()
	end)
	if f0_local1 then
		f0_local1(self, controller, menu)
	end
	return self
end

