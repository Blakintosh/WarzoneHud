Warzone.WeaponPickupCompRow = InheritFrom(LUI.UIElement)

local function PostLoadFunc(self, controller, menu)
    self.setMetricModel = function(self, modelName)
        Wzu.SubscribeToText(self.label, controller, modelName .. ".label")
        Wzu.SubscribeToText(self.metric, controller, modelName .. ".metric")
        Wzu.SubscribeToText(self.comparison, controller, modelName .. ".comparisonText")

        self:mergeStateConditions({
            {
                stateName = "Negative",
                condition = function(menu, self, event)
                    return IsModelValueLessThan(controller, modelName .. ".comparisonValue", 1.0)
                end
            }
        })
        Wzu.SubState(controller, menu, self.comparison, modelName .. ".comparisonValue")
    end
end

function Warzone.WeaponPickupCompRow.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponPickupCompRow)
    self.id = "WeaponPickupCompRow"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.label = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.label:setScaledLeftRight(false, true, -300, -205)
    self.label:setScaledTopBottom(true, false, -4, 12)

    Wzu.AddShadowedElement(self, self.label)

    self.metric = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.metric:setScaledLeftRight(false, true, -300, -66)
    self.metric:setScaledTopBottom(true, false, -4, 12)

    Wzu.AddShadowedElement(self, self.metric)

    self.comparison = Wzu.TextElement(Wzu.Fonts.KillstreakRegular, Wzu.Swatches.HUDWarning, true)
    self.comparison:setScaledLeftRight(true, false, 240, 300)
    self.comparison:setScaledTopBottom(true, false, 2, 12)

    Wzu.ClipSequence(self, self.comparison, "Positive", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.Cash) -- TEMP
        }
    })
    Wzu.ClipSequence(self, self.comparison, "Negative", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning) -- TEMP
        }
    })
    
    Wzu.AddShadowedElement(self, self.comparison)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Positive")
            end
        },
        Negative = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Negative")
            end
        }
    }
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end