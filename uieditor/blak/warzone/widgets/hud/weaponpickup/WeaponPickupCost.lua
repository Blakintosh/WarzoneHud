Warzone.WeaponPickupCost = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    --Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "PlayerList"), "client0"), "score")
end

function Warzone.WeaponPickupCost.new(menu, controller)
    local self = LUI.UIHorizontalList.new({left = 0, top = 0, right = 0, bottom = 0, leftAnchor = true, topAnchor = true, rightAnchor = true, bottomAnchor = true, spacing = 0})
    self:setAlignment(LUI.Alignment.Right)
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponPickupCost)
    self.id = "WeaponPickupCost"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.costs = Wzu.TightTextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.costs:setScaledLeftRight(true, false, 0, 300)
    self.costs:setScaledTopBottom(true, true, 0, 0)
    self.costs:setText("Costs ")

    Wzu.ClipSequence(self, self.costs, "Default", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.costs, "CantAfford", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.costs, "Hidden", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self.costValue = Wzu.TightTextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDWarningDanger)
    self.costValue:setScaledLeftRight(true, false, 0, 300)
    self.costValue:setScaledTopBottom(true, true, 0, 0)
    self.costValue:setText("0")

    Wzu.ClipSequence(self, self.costValue, "Default", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDCaution),
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.costValue, "CantAfford", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning),
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.costValue, "Hidden", {
        {
            duration = 0,
            setRGB = Wzu.ConvertColorToTable(Wzu.Swatches.HUDWarning),
            setAlpha = 0
        }
    })

    Wzu.SubscribeToText(self.costValue, controller, "prospectiveWeapon.attributes.cost")

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Default")
            end
        },
        CantAfford = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "CantAfford")
            end
        },
        Hidden = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Hidden")
            end
        }
    }
    
    self:mergeStateConditions({
        {
            stateName = "Hidden",
            condition = function(menu, self, event)
                return IsModelValueEqualTo(controller, "prospectiveWeapon.attributes.cost", 0)
            end
        },
        {
            stateName = "CantAfford",
            condition = function(menu, self, event)
                local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectiveWeapon.attributes.cost")))
                return not IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
            end
        }
    })

    Wzu.SubState(controller, menu, self, "prospectiveWeapon.attributes.cost")
    Wzu.SubState(controller, menu, self, "PlayerList.0.playerScore")

    -- Must be added in reverse due to the way Right-align Horiz. lists work
    self:addElement(self.costValue)
    self:addElement(self.costs)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end