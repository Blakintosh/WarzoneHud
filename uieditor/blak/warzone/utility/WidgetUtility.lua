Wzu.TextElement = function(font, color, shadow)
    local self = LUI.UITightText.new()

    self:setTTF(font)
    self:setText(Engine.Localize("MENU_NEW"))
    Wzu.SetRGBFromTable(self, color)

    if shadow then
        self.shadow = LUI.UITightText.new()
        self.shadow:setTTF(font)
        self.shadow:setText(Engine.Localize("MENU_NEW"))
        Wzu.SetRGBFromTable(self.shadow, Wzu.Swatches.HUDShadow)
        self.shadow:setAlpha(0.6)

        -- Shadow will copy main on everything
        LUI.OverrideFunction_CallOriginalFirst(self, "setText", function(self, text)
            self.shadow:setText(string.gsub(Engine.Localize(text), "%^%d", ""))
        end)
        LUI.OverrideFunction_CallOriginalFirst(self, "setAlignment", function(self, alignment)
            self.shadow:setAlignment(alignment)
        end)
        LUI.OverrideFunction_CallOriginalFirst(self, "setScaledLeftRight", function(self, leftAnchor, rightAnchor, startPos, endPos)
            self.shadow:setScaledLeftRight(leftAnchor, rightAnchor, startPos + 1, endPos + 1)
        end)
        LUI.OverrideFunction_CallOriginalFirst(self, "setScaledTopBottom", function(self, leftAnchor, rightAnchor, startPos, endPos)
            self.shadow:setScaledTopBottom(leftAnchor, rightAnchor, startPos + 0.5, endPos + 0.5)
        end)
        LUI.OverrideFunction_CallOriginalFirst(self, "setAlpha", function(self, alpha)
            if alpha == 1 then
                alpha = 0.6
            end
            self.shadow:setAlpha(alpha)
        end)
        LUI.OverrideFunction_CallOriginalFirst(self, "beginAnimation", function(self, name, duration, unk, unk2, tweenType)
            self.shadow:beginAnimation(name, duration, unk, unk2, tweenType)
        end)
    end

    return self
end

Wzu.AddShadowedElement = function(parent, self)
    parent:addElement(self.shadow)
    parent:addElement(self)
end

Wzu.GetModel = function(controller, modelName)
    return Engine.GetModel(Engine.GetModelForController(controller), modelName)
end

Wzu.SetElementModel = function(self, controller, modelPt1, modelPt2)
    self:subscribeToGlobalModel(controller, modelPt1, modelPt2, function(model)
        self:setModel(model, controller)
    end)
end

Wzu.SetElementModel_Create = function(self, controller, modelPt1, modelPt2)
    self:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), modelPt1), modelPt2), function(model)
        self:setModel(model, controller)
    end)
end

Wzu.Subscribe = function(self, controller, modelName, callback)
    self:subscribeToModel(Wzu.GetModel(controller, modelName), function(model)
        local modelValue = Engine.GetModelValue(model)
        if modelValue then
            callback(modelValue)
        end
    end)
end

Wzu.LinkToWidget = function(self, parent, modelName, callback)
    self:linkToElementModel(parent, modelName, true, function(model)
        local modelValue = Engine.GetModelValue(model)
        if modelValue ~= nil then
            callback(modelValue)
        end
    end)
end

Wzu.LinkWidgetToElementModel = function(self, parent, controller)
    self:linkToElementModel(parent, nil, false, function(model)
        self:setModel(model, controller)
    end)
end

Wzu.SubVisBit = function(InstanceRef, HudRef, parent, VisiblityBit)
    parent:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. VisiblityBit), function(ModelRef)
        HudRef:updateElementState(parent, {
        name = "model_validation",
        menu = HudRef,
        modelValue = Engine.GetModelValue(ModelRef),
        modelName = "UIVisibilityBit." .. VisiblityBit
    })
    end)
end

Wzu.SubState = function(InstanceRef, HudRef, parent, ModelName)
    parent:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), ModelName), function(ModelRef)
        HudRef:updateElementState(parent, {
        name = "model_validation",
        menu = HudRef,
        modelValue = Engine.GetModelValue(ModelRef),
        modelName = ModelName
    })
    end)
end

Wzu.LinkWidgetToState = function(self, parent, menu, modelName)
    self:linkToElementModel(parent, modelName, true, function(model)
        menu:updateElementState(self, {
            name = "model_validation",
            menu = menu,
            modelValue = Engine.GetModelValue(model),
            modelName = modelName
        })
    end)
end

Wzu.SubscribeToText = function(self, controller, modelName)
    Wzu.Subscribe(self, controller, modelName, function(modelValue)
        self:setText(Engine.Localize(modelValue))
    end)
end

Wzu.SubscribeToText_ToUpper = function(self, controller, modelName)
    Wzu.Subscribe(self, controller, modelName, function(modelValue)
        self:setText(LocalizeToUpperString(modelValue))
    end)
end

Wzu.LinkToWidgetText = function(self, parent, modelName)
    Wzu.LinkToWidget(self, parent, modelName, function(modelValue)
        self:setText(Engine.Localize(modelValue))
    end)
end

Wzu.SubscribeToImage = function(self, controller, modelName)
    Wzu.Subscribe(self, controller, modelName, function(modelValue)
        self:setImage(RegisterImage(modelValue))
    end)
end

--- Subscribes a parent to a Script Notify event.
---@param controller number The controller index of the client
---@param self userdata parent to link the notify to
---@param notifyName string The name of the script notify
---@param callback function A callback function that will receive notify data.
Wzu.ScriptNotify = function(controller, self, notifyName, callback)
    self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
        if IsParamModelEqualToString(ModelRef, notifyName) then
            callback(CoD.GetScriptNotifyData(ModelRef))
        end
    end)
end

Wzu.ScaleWidgetToLabel = {}

Wzu.ScaleWidgetToLabel.Centered = function(parent, label, padding)
    if label == nil then
		return 
	else
		local parent_leftAnchor, parent_rightAnchor, parent_startPos, parent_endPos = parent:getLocalLeftRight()

		local centerPosition = (parent_endPos + parent_startPos) / 2
		local widgetWidth = label:getTextWidth() + padding * 2 * _ResolutionScalar

		parent:setLeftRight(parent_leftAnchor, parent_rightAnchor, centerPosition - widgetWidth / 2, centerPosition + widgetWidth / 2)
	end
end

Wzu.ScaleWidgetToLabel.CenteredDownscale = function(parent, label, padding)
    if label == nil then
		return 
	else
		local parent_leftAnchor, parent_rightAnchor, parent_startPos, parent_endPos = parent:getLocalLeftRight()

		local centerPosition = (parent_endPos + parent_startPos) / 2
		local widgetWidth = (label:getTextWidth() / _ResolutionScalar) + padding * 2

		parent:setLeftRight(parent_leftAnchor, parent_rightAnchor, centerPosition - widgetWidth / 2, centerPosition + widgetWidth / 2)
	end
end

Wzu.ScaleWidgetToLabel.CenteredWithMinimum = function(parent, label, padding, minimum)
    if label == nil then
		return 
	else
		local parent_leftAnchor, parent_rightAnchor, parent_startPos, parent_endPos = parent:getLocalLeftRight()

		local centerPosition = (parent_endPos + parent_startPos) / 2
        local textWidth = math.max(label:getTextWidth(), minimum)
		local widgetWidth = textWidth + padding * 2 * _ResolutionScalar

		parent:setLeftRight(parent_leftAnchor, parent_rightAnchor, centerPosition - widgetWidth / 2, centerPosition + widgetWidth / 2)
	end
end

Wzu.ScaleWidgetToLabel.WithMinimum = function(parent, label, padding, minimum)
    if label == nil then
        return 
    end

    local LeftAnchor, RightAnchor, LeftRightStart, LeftRightEnd = parent:getLocalLeftRight()
    local TextWidth = label:getTextWidth()

    if Engine.IsCurrentLanguageReversed() then
        if 0 < TextWidth then
            local ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd = label:getLocalLeftRight()
            parent.savedWidth = TextWidth + 2 * ElemLeftRightStart + padding

            if parent.savedWidth < minimum then --like seriously?
                parent.savedWidth = minimum
            end

            if not parent.widthOverridden then
                parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightEnd - parent.savedWidth, LeftRightEnd)
                if ElemLeftAnchor + ElemRightAnchor == 0 then
                    label:setLeftRight(ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightStart + TextWidth)
                elseif ElemLeftAnchor == 0 and ElemRightAnchor == 1 then
                    label:setLeftRight(ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd)
                end
            end
        else
            parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightEnd, LeftRightEnd)
        end
        return 
    end
    local ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd = label:getLocalLeftRight()
    if 0 < TextWidth then
        parent.savedWidth = TextWidth + 2 * ElemLeftRightStart + padding

        if parent.savedWidth < minimum then --like seriously?
            parent.savedWidth = minimum
        end
        
        if not parent.widthOverridden then
            parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightStart, LeftRightStart + parent.savedWidth)
        end
    else
        parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightStart, LeftRightStart)
    end
end

Wzu.ScaleWidgetToLabel.DownscaleWithMinimum = function(parent, label, padding, minimum)
    if label == nil then
        return 
    end

    local LeftAnchor, RightAnchor, LeftRightStart, LeftRightEnd = parent:getLocalLeftRight()
    local TextWidth = (label:getTextWidth() / _ResolutionScalar)

    if Engine.IsCurrentLanguageReversed() then
        if 0 < TextWidth then
            local ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd = label:getLocalLeftRight()
            parent.savedWidth = TextWidth + 2 * ElemLeftRightStart + padding

            if parent.savedWidth < minimum then --like seriously?
                parent.savedWidth = minimum
            end

            if not parent.widthOverridden then
                parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightEnd - parent.savedWidth, LeftRightEnd)
                if ElemLeftAnchor + ElemRightAnchor == 0 then
                    label:setLeftRight(ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightStart + TextWidth)
                elseif ElemLeftAnchor == 0 and ElemRightAnchor == 1 then
                    label:setLeftRight(ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd)
                end
            end
        else
            parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightEnd, LeftRightEnd)
        end
        return 
    end
    local ElemLeftAnchor, ElemRightAnchor, ElemLeftRightStart, ElemLeftRightEnd = label:getLocalLeftRight()
    if 0 < TextWidth then
        parent.savedWidth = TextWidth + 2 * ElemLeftRightStart + padding

        if parent.savedWidth < minimum then --like seriously?
            parent.savedWidth = minimum
        end
        
        if not parent.widthOverridden then
            parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightStart, LeftRightStart + parent.savedWidth)
        end
    else
        parent:setLeftRight(LeftAnchor, RightAnchor, LeftRightStart, LeftRightStart)
    end
end