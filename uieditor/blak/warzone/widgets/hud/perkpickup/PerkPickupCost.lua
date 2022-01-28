Warzone.PerkPickupCost = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    --Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "PlayerList"), "client0"), "score")
end

function Warzone.PerkPickupCost.new(menu, controller)
    local self = LUI.UIHorizontalList.new({left = 0, top = 0, right = 0, bottom = 0, leftAnchor = true, topAnchor = true, rightAnchor = true, bottomAnchor = true, spacing = 0})
    self:setAlignment(LUI.Alignment.Right)
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PerkPickupCost)
    self.id = "PerkPickupCost"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.costs = Wzu.TightTextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.costs:setScaledLeftRight(true, false, 0, 300)
    self.costs:setScaledTopBottom(true, true, 0, 0)
    self.costs:setText("Costs ")

    self.costValue = Wzu.TightTextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDWarningDanger)
    self.costValue:setScaledLeftRight(true, false, 0, 300)
    self.costValue:setScaledTopBottom(true, true, 0, 0)
    self.costValue:setText("0")

    Wzu.ClipSequence(self, self.costValue, "Default", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.costValue, "CanAfford_Limit", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.costValue, "CantAfford_BelowLimit", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })
    Wzu.ClipSequence(self, self.costValue, "CantAfford_Limit", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })

    Wzu.SubscribeToText(self.costValue, controller, "prospectivePerk.cost")

    self.perkLeft = Wzu.TightTextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.perkLeft:setScaledLeftRight(true, false, 0, 300)
    self.perkLeft:setScaledTopBottom(true, true, 1, -1)
    self.perkLeft:setText(" [")

    self.perkCount = Wzu.TightTextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.perkCount:setScaledLeftRight(true, false, 0, 300)
    self.perkCount:setScaledTopBottom(true, true, 1, -1)
    self.perkCount:setText("0/4")

    Wzu.SubscribeToText(self.perkCount, controller, "prospectivePerk.perkCountString")

    Wzu.ClipSequence(self, self.perkCount, "Default", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainRegular,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.perkCount, "CanAfford_Limit", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainBold,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })
    Wzu.ClipSequence(self, self.perkCount, "CantAfford_BelowLimit", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainRegular,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDMain)
        }
    })
    Wzu.ClipSequence(self, self.perkCount, "CantAfford_Limit", {
        {
            duration = 0,
            setTTF = Wzu.Fonts.MainBold,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning)
        }
    })
    
    self.perkRight = Wzu.TightTextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.perkRight:setScaledLeftRight(true, false, 0, 300)
    self.perkRight:setScaledTopBottom(true, true, 1, -1)
    self.perkRight:setText(" Perks]")

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Default")
            end
        },
        CanAfford_Limit = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "CanAfford_Limit")
            end
        },
        CantAfford_BelowLimit = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "CantAfford_BelowLimit")
            end
        },
        CantAfford_Limit = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "CantAfford_Limit")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "CanAfford_Limit",
            condition = function(menu, self, event)
                if IsModelValueEqualTo(controller, "prospectivePerk.atPerkLimit", 1) then
                    local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.cost")))
                    --Engine.ComError(Enum.errorCode.ERROR_UI, "hi")
                    return IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
                end
                return false
            end
        },
        {
            stateName = "CantAfford_Limit",
            condition = function(menu, self, event)
                if IsModelValueEqualTo(controller, "prospectivePerk.atPerkLimit", 1) then
                    local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.cost")))
                    return not IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
                end
                return false
            end
        },
        {
            stateName = "CantAfford_BelowLimit",
            condition = function(menu, self, event)
                if IsModelValueEqualTo(controller, "prospectivePerk.atPerkLimit", 0) then
                    local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.cost")))
                    return not IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
                end
                return false
            end
        }
    })

    Wzu.SubState(controller, menu, self, "prospectivePerk.atPerkLimit")
    Wzu.SubState(controller, menu, self, "PlayerList.0.playerScore")

    -- Must be added in reverse due to the way Right-align Horiz. lists work
    self:addElement(self.perkRight)
    self:addElement(self.perkCount)
    self:addElement(self.perkLeft)
    self:addElement(self.costValue)
    self:addElement(self.costs)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end