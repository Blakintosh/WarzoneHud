Util.TextElement = function(font, color, shadow)
    local self = LUI.UIText.new()

    self:setTTF(font)
    self:setText(Engine.Localize("MENU_NEW"))
    Util.SetRGBFromTable(self, color)

    if shadow then
        self.shadow = LUI.UIText.new()
        self.shadow:setTTF(font)
        self.shadow:setText(Engine.Localize("MENU_NEW"))
        Util.SetRGBFromTable(self.shadow, Util.Swatches.HUDShadow)
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

Util.TightTextElement = function(font, color)
    local self = LUI.UITightText.new()

    self:setTTF(font)
    self:setText(Engine.Localize("MENU_NEW"))
    Util.SetRGBFromTable(self, color)

    return self
end

Util.AddShadowedElement = function(parent, self)
    parent:addElement(self.shadow)
    parent:addElement(self)
end

Util.ContainedShadowTextElement = function(font, color)
    local self = LUI.UIElement.new()

    self.text = Util.TextElement(font, color, true)
    self.text:setScaledLeftRight(true, true, 0, 0)
    self.text:setScaledTopBottom(true, true, 0, 0)

    Util.AddShadowedElement(self, self.text)

    return self
end

Util.GetModel = function(controller, modelName)
    return Engine.GetModel(Engine.GetModelForController(controller), modelName)
end

Util.SetElementModel = function(self, controller, modelPt1, modelPt2)
    self:subscribeToGlobalModel(controller, modelPt1, modelPt2, function(model)
        self:setModel(model, controller)
    end)
end

Util.SetElementModel_Create = function(self, controller, modelPt1, modelPt2)
    self:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), modelPt1), modelPt2), function(model)
        self:setModel(model, controller)
    end)
end

Util.Subscribe = function(self, controller, modelName, callback)
    self:subscribeToModel(Util.GetModel(controller, modelName), function(model)
        local modelValue = Engine.GetModelValue(model)
        if modelValue then
            callback(modelValue)
        end
    end)
end

Util.SubscribeMultiple = function(self, controller, modelNames, callback)
    for k, v in ipairs(modelNames) do
        self:subscribeToModel(Util.GetModel(controller, v), function(model)
            local modelValue = Engine.GetModelValue(model)
            if modelValue then
                callback(modelValue)
            end
        end)
    end
end

Util.LinkToWidget = function(self, parent, modelName, callback)
    self:linkToElementModel(parent, modelName, true, function(model)
        local modelValue = Engine.GetModelValue(model)
        if modelValue ~= nil then
            callback(modelValue)
        end
    end)
end

Util.LinkWidgetToElementModel = function(self, parent, controller)
    self:linkToElementModel(parent, nil, false, function(model)
        self:setModel(model, controller)
    end)
end

Util.SubVisBit = function(InstanceRef, HudRef, parent, VisiblityBit)
    parent:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. VisiblityBit), function(ModelRef)
        HudRef:updateElementState(parent, {
        name = "model_validation",
        menu = HudRef,
        modelValue = Engine.GetModelValue(ModelRef),
        modelName = "UIVisibilityBit." .. VisiblityBit
    })
    end)
end

Util.SubState = function(InstanceRef, HudRef, parent, ModelName)
    parent:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), ModelName), function(ModelRef)
        HudRef:updateElementState(parent, {
			name = "model_validation",
			menu = HudRef,
			modelValue = Engine.GetModelValue(ModelRef),
			modelName = ModelName
    	})
    end)
end

Util.LinkWidgetToState = function(self, parent, menu, modelName)
    self:linkToElementModel(parent, modelName, true, function(model)
        menu:updateElementState(self, {
            name = "model_validation",
            menu = menu,
            modelValue = Engine.GetModelValue(model),
            modelName = modelName
        })
    end)
end

Util.SubscribeToText = function(self, controller, modelName)
    Util.Subscribe(self, controller, modelName, function(modelValue)
        self:setText(Engine.Localize(modelValue))
    end)
end

Util.SubscribeToText_ToUpper = function(self, controller, modelName)
    Util.Subscribe(self, controller, modelName, function(modelValue)
        self:setText(LocalizeToUpperString(modelValue))
    end)
end

Util.LinkToWidgetText = function(self, parent, modelName, toUpper)
    toUpper = toUpper or false
    Util.LinkToWidget(self, parent, modelName, function(modelValue)
        if toUpper then
            self:setText(LocalizeToUpperString(modelValue))
        else
            self:setText(Engine.Localize(modelValue))
        end
    end)
end

Util.SubscribeToImage = function(self, controller, modelName)
    Util.Subscribe(self, controller, modelName, function(modelValue)
        self:setImage(RegisterImage(modelValue))
    end)
end

Util.LinkWidgetToUIModel = function(self, controller, selfModelName, targetModelName)
	Util.LinkToWidget(self, self, selfModelName, function(modelVal)
		Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), targetModelName), modelVal)
	end)
end

--- Subscribes a parent to a Script Notify event.
---@param controller number The controller index of the client
---@param self userdata parent to link the notify to
---@param notifyName string The name of the script notify
---@param callback function A callback function that will receive notify data.
Util.ScriptNotify = function(controller, self, notifyName, callback)
    self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
        if IsParamModelEqualToString(ModelRef, notifyName) then
            callback(CoD.GetScriptNotifyData(ModelRef))
        end
    end)
end

Util.ScaleWidgetToLabel = {}

Util.ScaleWidgetToLabel.Centered = function(parent, label, padding)
    if label == nil then
		return 
	else
		local parent_leftAnchor, parent_rightAnchor, parent_startPos, parent_endPos = parent:getLocalLeftRight()

		local centerPosition = (parent_endPos + parent_startPos) / 2
		local widgetWidth = label:getTextWidth() + padding * 2 * _ResolutionScalar

		parent:setLeftRight(parent_leftAnchor, parent_rightAnchor, centerPosition - widgetWidth / 2, centerPosition + widgetWidth / 2)
	end
end

Util.ScaleWidgetToLabel.CenteredDownscale = function(parent, label, padding)
    if label == nil then
		return 
	else
		local parent_leftAnchor, parent_rightAnchor, parent_startPos, parent_endPos = parent:getLocalLeftRight()

		local centerPosition = (parent_endPos + parent_startPos) / 2
		local widgetWidth = (label:getTextWidth() / _ResolutionScalar) + padding * 2

		parent:setLeftRight(parent_leftAnchor, parent_rightAnchor, centerPosition - widgetWidth / 2, centerPosition + widgetWidth / 2)
	end
end

Util.ScaleWidgetToLabel.CenteredWithMinimum = function(parent, label, padding, minimum)
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

Util.ScaleWidgetToLabel.WithMinimum = function(parent, label, padding, minimum)
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

Util.ScaleWidgetToLabel.DownscaleWithMinimum = function(parent, label, padding, minimum)
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

-- Menu based setup mourse cursor function
-- Important: you can't use (true, true, 0, 0) on the menu dimensions with this, as it makes getLocalRect not work as needed
Util.SetupMouseCursor = function(menu, controller)
    local cursorModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "mouseCursor"), "cursorImage")
    Engine.SetModelValue(cursorModel, "ui_cursor_arrow_normal")
    menu.mouseCursor = LUI.UIImage.new()
    menu.mouseCursor:setLeftRight(true, false, 0, 64)
    menu.mouseCursor:setTopBottom(true, false, 0, 64)
    menu.mouseCursor:setImage(RegisterImage("ui_cursor_arrow_normal"))
    menu.mouseCursor:hide()

    --[[Util.Subscribe(menu.mouseCursor, controller, "mouseCursor.cursorImage", function(modelValue)
        if not modelValue or not menu.mouseCursor or not menu.mouseCursor.setImage then
            return
        end

        menu.mouseCursor:setImage(RegisterImage(modelValue))
    end)]]

    menu:addElement(menu.mouseCursor)

    menu.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                menu:setupElementClipCounter(0)
            end,
            Over = function()
                menu:setupElementClipCounter(0)
            end
        }
    }

    menu:setHandleMouse( true )
	if menu.mouseCursor then
		local cursorStartX, cursorStartY, cursorEndX, cursorEndY = menu.mouseCursor:getLocalRect()
		menu.mouseCursorWidth = cursorEndX - cursorStartX
		menu.mouseCursorHeight = cursorEndY - cursorStartY
		if menu.mouseCursorWidth and menu.mouseCursorHeight then
			menu:registerEventHandler( "mousemove", function ( element, event )
                menu.mouseCursor:show()
				local whether, xCoord, yCoord = LUI.UIElement.IsMouseInsideElement( element, event )
				local unitStartX, unitStartY, unitEndX, unitEndY = element:getLocalRect()
				local unitSizeX = unitEndX - unitStartX
				local unitSizeY = unitEndY - unitStartY
				local startDimX, startDimY, endDimX, endDimY = element:getRect()

                if startDimX == nil or endDimX == nil then
                    return
                end
				local dimSizeX = endDimX - startDimX
				local dimSizeY = endDimY - startDimY
				local xPosition = CoD.ClampColor( (xCoord - startDimX) / dimSizeX * unitSizeX, 0, unitSizeX )
				local yPosition = CoD.ClampColor( (yCoord - startDimY) / dimSizeY * unitSizeY, 0, unitSizeY )
				element.mouseCursor:setLeftRight( true, false, xPosition - (element.mouseCursorWidth / 2), xPosition + (element.mouseCursorWidth / 2) )
				element.mouseCursor:setTopBottom( true, false, yPosition - (element.mouseCursorHeight / 2), yPosition + (element.mouseCursorHeight / 2) )
				LUI.UIElement.MouseMoveEvent( element, event )
			end )
		end
	end
	menu:registerEventHandler( "mouseenter", function ( element, event )
		HideMouseCursor( menu )
		element:playClip( "Over" )
	end )
	menu:registerEventHandler( "mouseleave", function ( element, event )
		ShowMouseCursor( menu )
		element:playClip( "DefaultClip" )
	end )
    menu:registerEventHandler( "menu_loaded", function( element, event )
        HideMouseCursor(menu)
    end )
	LUI.OverrideFunction_CallOriginalFirst( menu, "close", function ()
		ShowMouseCursor( menu )
	end )
end

Util.SetCursorType = function(type, controller)
    --local model = Engine.GetModel(Engine.GetModelForController(controller), "mouseCursor.cursorImage")
    --Engine.SetModelValue(model, type)
end

Util.PrepareFont = function(self, font)
	local dummy = LUI.UIText.new()

	dummy:setLeftRight(true, false, 0, 1280)
	dummy:setTopBottom(true, false, -36, 0)
	dummy:setTTF(font)
	dummy:setText("The quick brown fox jumps over the lazy dog")

	self:addElement(dummy)
end