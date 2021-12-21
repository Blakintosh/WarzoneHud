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

Wzu.SubVisBit = function(InstanceRef, HudRef, Widget, VisiblityBit)
    Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. VisiblityBit), function(ModelRef)
        HudRef:updateElementState(Widget, {
        name = "model_validation",
        menu = HudRef,
        modelValue = Engine.GetModelValue(ModelRef),
        modelName = "UIVisibilityBit." .. VisiblityBit
    })
    end)
end

Wzu.SubState = function(InstanceRef, HudRef, Widget, ModelName)
    Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), ModelName), function(ModelRef)
        HudRef:updateElementState(Widget, {
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

Wzu.ScriptNotify = function(InstanceRef, Widget, NotifyName, Callback)
    Widget:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", function(ModelRef)
        if IsParamModelEqualToString(ModelRef, NotifyName) then
            Callback(CoD.GetScriptNotifyData(ModelRef))
        end
    end)
end