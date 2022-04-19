Warzone.WeaponPickupCompRow = InheritFrom(LUI.UIElement)

local function PostLoadFunc(self, controller, menu)
    self.setMetricModel = function(self, modelName)
        Util.SubscribeToText(self.label, controller, modelName .. ".label")
        Util.SubscribeToText(self.metric, controller, modelName .. ".metric")
        Util.SubscribeToText(self.comparison, controller, modelName .. ".comparisonText")

        self:mergeStateConditions({
            {
                stateName = "Negative",
                condition = function(menu, self, event)
                    return IsModelValueEqualTo(controller, modelName .. ".comparisonBetter", 0)
                end
            }
        })
        Util.SubState(controller, menu, self, modelName .. ".comparisonBetter")
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

    self.label = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, true)
    self.label:setScaledLeftRight(false, true, -300, -205)
    self.label:setScaledTopBottom(true, false, -4, 12)

    Util.AddShadowedElement(self, self.label)

    self.metric = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, true)
    self.metric:setScaledLeftRight(false, true, -300, -66)
    self.metric:setScaledTopBottom(true, false, -4, 12)

    Util.AddShadowedElement(self, self.metric)

    self.comparison = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.WeaponMeterBetter, true)
    self.comparison:setScaledLeftRight(true, false, 240, 300)
    self.comparison:setScaledTopBottom(true, false, 2, 12)

    Util.ClipSequence(self, self.comparison, "Positive", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.WeaponMeterBetter) -- TEMP
        }
    })
    Util.ClipSequence(self, self.comparison, "Negative", {
        {
            duration = 0,
            setRGB = Util.ConvertColorToTable(Util.Swatches.WeaponMeterWorse) -- TEMP
        }
    })
    
    Util.AddShadowedElement(self, self.comparison)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Positive")
            end
        },
        Negative = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Negative")
            end
        }
    }
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end