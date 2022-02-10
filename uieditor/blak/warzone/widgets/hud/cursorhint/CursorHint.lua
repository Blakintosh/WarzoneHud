Warzone.CursorHint = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "suppressCursorHintDisplay")
end

function Warzone.CursorHint.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.CursorHint)
    self.id = "CursorHint"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.button = Warzone.ButtonPrompt.new(menu, controller)
    self.button:setScaledLeftRight(true, false, 0, 16)
    self.button:setScaledTopBottom(true, false, 0, 16)

    self.button:setButtonPrompt("activate", "activate")

    Wzu.ClipSequence(self, self.button, "Show", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.button, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.button)

    self.prompt = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.prompt:setScaledLeftRight(true, false, 27, 327)
    self.prompt:setScaledTopBottom(true, false, -2, 18)
    self.prompt:setText(Engine.Localize("MENU_NEW"))
    self.prompt:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)

    self.prompt:subscribeToGlobalModel(controller, "HUDItems", "cursorHintText", function (model)
		local modelValue = Engine.GetModelValue(model)
		if modelValue then
			self.prompt:setText(Engine.Localize(modelValue))
		end
	end)

    Wzu.ClipSequence(self, self.prompt, "Show", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.prompt, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.AddShadowedElement(self, self.prompt)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        Show = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Show")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "Show",
            condition = function(menu, self, event)
                if IsModelValueTrue(controller, "hudItems.showCursorHint") then
                    if not IsModelValueEqualTo(controller, "hudItems.cursorHintText", "") then
                        return not IsModelValueEqualTo(controller, "hudItems.suppressCursorHintDisplay", 1)
                    end
                end
                return false
            end
        }
    })

    Wzu.SubState(controller, menu, self, "hudItems.cursorHintText")
    Wzu.SubState(controller, menu, self, "hudItems.showCursorHint")
    Wzu.SubState(controller, menu, self, "hudItems.suppressCursorHintDisplay")
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.button:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end