require("ui.uieditor.blak.warzone.widgets.userinterface.button.FooterButton")

local ResizeForKeyPrompt = function (self)
	if IsElementInState(self, "DefaultState") then
		OverrideWidgetWidth(self, 0)
	else
		local basePosition = 14
		local storeSizeX = nil
		if Engine.LastInput_Gamepad() then
			local leftAnchor, rightAnchor, dimStart, dimEnd = self.buttonPromptImage:getLocalLeftRight()
			local sizeX, sizeY = self.buttonPromptImage:getLocalSize()
            storeSizeX = sizeX
			self.buttonPromptImage:setLeftRight(leftAnchor, rightAnchor, basePosition, basePosition + sizeX)
		else
            Util.ScaleWidgetToLabel.Centered(self.promptButton, self.promptButton.label, 8)
			local leftAnchor, rightAnchor, dimStart, dimEnd = self.promptButton:getLocalLeftRight()
			local sizeX, sizeY = self.promptButton:getLocalSize()
            storeSizeX = 0
			self.promptButton:setLeftRight(leftAnchor, rightAnchor, basePosition, basePosition + sizeX)
		end

		local leftAnchor, rightAnchor, dimStart, dimEnd = self.label:getLocalLeftRight()
		local labelWidth = self.label:getTextWidth()
		local baseLabelPos = basePosition + storeSizeX + 12

		self.label:setLeftRight(leftAnchor, rightAnchor, baseLabelPos, baseLabelPos + labelWidth)
		self:setWidth(baseLabelPos + labelWidth + 32)
	end

	if self:getParent() then
		self:getParent():setLayoutCached(false)
	end
end

local PCPostLoadFunc = function (self, controller, menu)
	self:setHandleMouse(true)
	self:registerEventHandler("resize_prompt", function (Sender, Event)
		ResizeForKeyPrompt(self)
	end)
	self:registerEventHandler("button_action", function (Sender, Event)
		CoD.PCUtil.SimulateButtonPressUsingElement(controller, Sender)
		return true
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function (f7_arg0, f7_arg1)
		ResizeForKeyPrompt(self)
	end)
end

local PostLoadFunc = function (self, controller, menu)
	if CoD.isPC then
		PCPostLoadFunc(self, controller, menu)
	end
	self.label:linkToElementModel(self, "Label", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			self.label:setText(Engine.Localize(ModelValue))
			self.promptButton.label:setText(Engine.Localize(ModelValue))
			if CoD.isPC then
				ResizeForKeyPrompt(self)
			end
		end
	end)
end

Warzone.MenuButtonPrompt = InheritFrom(LUI.UIElement)
Warzone.MenuButtonPrompt.new = function (menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.MenuButtonPrompt)
	self.id = "MenuButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true

	self.buttonPromptImage = LUI.UIImage.new()
	self.buttonPromptImage:setScaledLeftRight(true, false, 17, 34)
	self.buttonPromptImage:setScaledTopBottom(false, false, -9, 8)
	self.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	self.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(self.buttonPromptImage)

    Util.ClipSequence(self, self.buttonPromptImage, "DefaultState", {
        {
            duration = 0,
            setRGB = {1, 1, 1},
            setAlpha = 0,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 1, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "Disabled", {
        {
            duration = 0,
            setRGB = {0.5, 0.5, 0.5},
            setAlpha = 0.5,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 0, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledDefault", {
        {
            duration = 0,
            setRGB = {1, 1, 1},
            setAlpha = 1,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 1, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledHide", {
        {
            duration = 0,
            setLeftRight = {true, false, 0, 32},
            setTopBottom = {true, false, 0, 31},
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledOver", {
        {
            duration = 0,
            setRGB = {1, 1, 1},
            setAlpha = 1,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 1, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "DisabledPC", {
        {
            duration = 0,
            setRGB = {0.5, 0.5, 0.5},
            setAlpha = 0,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 0, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledPCDefault", {
        {
            duration = 0,
            setRGB = {1, 1, 1},
            setAlpha = 0,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 1, 0, 0, 0}
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledPCHide", {
        {
            duration = 0,
            setLeftRight = {true, false, 0, 32},
            setTopBottom = {true, false, 0, 31},
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.buttonPromptImage, "EnabledPCOver", {
        {
            duration = 0,
            setRGB = {1, 1, 1},
            setAlpha = 0,
            setMaterial = LUI.UIImage.GetCachedMaterial("uie_saturation_normal"),
            setShaderVector = {0, 1, 0, 0, 0}
        }
    })
	
	self.label = Util.TightTextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain)
	self.label:setScaledLeftRight(true, false, 42, 88)
	self.label:setScaledTopBottom(false, false, -7, 7)
	self.label:setText(Engine.Localize("Select"))
	LUI.OverrideFunction_CallOriginalFirst(self.label, "setText", function (sender, text)
		ScaleWidgetToLabel(self, sender, -40)
	end)

    Util.ClipSequence(self, self.label, "DefaultState", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.label, "Disabled", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.Grey191),
            setAlpha = 0.5
        }
    })
    Util.ClipSequence(self, self.label, "EnabledDefault", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.label, "EnabledHide", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.label, "EnabledOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.label, "DisabledPC", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Colors.Grey191),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.label, "EnabledPCDefault", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.label, "EnabledPCHide", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.label, "EnabledPCOver", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.HUDMain),
            setAlpha = 0
        }
    })
	self:addElement(self.label)

    self.promptButton = Warzone.FooterButton.new(menu, controller)
    self.promptButton:setScaledLeftRight(true, false, 0, 40)
    self.promptButton:setScaledTopBottom(false, false, -11, 11)

    local noA = { duration = 0, setAlpha = 0 }
    local fullA = { duration = 0, setAlpha = 1 }
    Util.ClipSequence(self, self.promptButton, "DefaultState", {noA})
    Util.ClipSequence(self, self.promptButton, "Disabled", {noA})
    Util.ClipSequence(self, self.promptButton, "EnabledDefault", {noA})
    Util.ClipSequence(self, self.promptButton, "EnabledHide", {noA})
    Util.ClipSequence(self, self.promptButton, "EnabledOver", {noA})
    Util.ClipSequence(self, self.promptButton, "DisabledPC", {fullA})
    Util.ClipSequence(self, self.promptButton, "EnabledPCDefault", {fullA})
    Util.ClipSequence(self, self.promptButton, "EnabledPCHide", {fullA})
    Util.ClipSequence(self, self.promptButton, "EnabledPCOver", {fullA})

    self:addElement(self.promptButton)

	self.clipsPerState = {DefaultState = {DefaultClip = function ()
		Util.AnimateSequence(self, "DefaultState")
	end}, Disabled = {DefaultClip = function ()
		Util.AnimateSequence(self, "Disabled")
	end}, Enabled = {DefaultClip = function ()
		Util.AnimateSequence(self, "EnabledDefault")
	end, Hide = function ()
		Util.AnimateSequence(self, "EnabledHide")
	end, Over = function ()
		Util.AnimateSequence(self, "EnabledOver")
	end}, DisabledPC = {DefaultClip = function ()
		Util.AnimateSequence(self, "DisabledPC")
	end}, EnabledPC = {DefaultClip = function ()
		Util.AnimateSequence(self, "EnabledPCDefault")
	end, Hide = function ()
		Util.AnimateSequence(self, "EnabledPCHide")
	end, Over = function ()
		Util.AnimateSequence(self, "EnabledPCOver")
	end}, InitialState = {DefaultClip = function ()
		self:setupElementClipCounter(0)
	end}}
	self:mergeStateConditions({{stateName = "Disabled", condition = function (HudRef, ItemRef, UpdateTable)
		if IsSelfModelValueEqualToEnum(ItemRef, controller, "", Enum.LUIButtonPromptStates.FLAG_DISABLE_PROMPTS) then
			return IsGamepad(controller)
		end
		return false
	end}, {stateName = "Enabled", condition = function (HudRef, ItemRef, UpdateTable)
		if IsSelfModelValueEqualToEnum(ItemRef, controller, "", Enum.LUIButtonPromptStates.FLAG_ENABLE_PROMPTS) then
            return IsGamepad(controller)
		end
        return false
	end}, {stateName = "DisabledPC", condition = function (HudRef, ItemRef, UpdateTable)
		if IsSelfModelValueEqualToEnum(ItemRef, controller, "", Enum.LUIButtonPromptStates.FLAG_DISABLE_PROMPTS) then
			if not IsGamepad(controller) then
				return not ShouldHideButtonPromptForPC(ItemRef, controller, HudRef)
			end
		end
		return false
	end}, {stateName = "EnabledPC", condition = function (HudRef, ItemRef, UpdateTable)
		if IsSelfModelValueEqualToEnum(ItemRef, controller, "", Enum.LUIButtonPromptStates.FLAG_ENABLE_PROMPTS) then
			if not IsGamepad(controller) then
				return not ShouldHideButtonPromptForPC(ItemRef, controller, HudRef)
			end
		end
	end}, {stateName = "InitialState", condition = function (HudRef, ItemRef, UpdateTable)
		return AlwaysFalse()
	end}})
	self:linkToElementModel(self, nil, true, function (ModelRef)
		menu:updateElementState(self, {name = "model_validation", menu = menu, modelValue = Engine.GetModelValue(ModelRef), modelName = nil})
	end)
	if self.m_eventHandlers.input_source_changed then
		local f4_local4 = self.m_eventHandlers.input_source_changed
		self:registerEventHandler("input_source_changed", function (Sender, Event)
			local f28_local0 = Event.menu
			if not f28_local0 then
				f28_local0 = menu
			end
			Event.menu = f28_local0
			Sender:updateState(Event)
			return f4_local4(Sender, Event)
		end)
	else
		self:registerEventHandler("input_source_changed", LUI.UIElement.updateState)
	end

	self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "LastInput"), function (ModelRef)
		menu:updateElementState(self, {name = "model_validation", menu = menu, modelValue = Engine.GetModelValue(ModelRef), modelName = "LastInput"})
	end)

	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function (f30_arg0, f30_arg1)
		if IsElementInState(f30_arg0, "DefaultState") then
			OverrideWidgetWidth(self, "0")
			DisableMouseButton(self, controller)
		else
			RestoreWidgetWidth(self)
			EnableMouseButton(self, controller)
		end
	end)

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.promptButton:close()
	end)
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

