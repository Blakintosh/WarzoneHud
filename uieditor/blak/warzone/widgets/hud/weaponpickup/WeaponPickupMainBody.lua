require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupCompRow")
require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupTiers")
require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupName")
require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupCost")
require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")

Warzone.WeaponPickupMainBody = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    for k, v in ipairs({"weaponName", "weaponClass", "weaponTier", "weaponOverclocks", "weaponRarity", "cost", "buyString"}) do
        Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectiveWeapon"), "attributes"), v)
    end

    for k, v in ipairs({"damage", "ammo", "dps"}) do
        for ke, va in ipairs({"label", "metric", "comparisonText", "comparisonBetter"}) do
            Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectiveWeapon"), v), va)
        end
    end
end

local function SubRGBToRarity(self, controller)
    Util.Subscribe(self, controller, "prospectiveWeapon.attributes.weaponRarity", function(modelValue)
        if Util.Swatches.RaritiesLight[modelValue + 1] then
            Util.SetRGBFromTable(self, Util.Swatches.RaritiesLight[modelValue + 1])
        else
            Util.SetRGBFromTable(self, Util.Swatches.RaritiesLight[1])
        end
    end)
end

function Warzone.WeaponPickupMainBody.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponPickupMainBody)
    self.id = "WeaponPickupMainBody"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.frameLT = LUI.UIImage.new()
    self.frameLT:setScaledLeftRight(true, false, 0, 9)
    self.frameLT:setScaledTopBottom(true, false, 62, 71)
    self.frameLT:setImage(RegisterImage("ui_fancy_corner"))
    self.frameLT:setZRot(-90)

    SubRGBToRarity(self.frameLT, controller)

    self:addElement(self.frameLT)

    self.frameLB = LUI.UIImage.new()
    self.frameLB:setScaledLeftRight(true, false, 0, 9)
    self.frameLB:setScaledTopBottom(false, true, -9, 0)
    self.frameLB:setImage(RegisterImage("ui_fancy_corner"))

    SubRGBToRarity(self.frameLB, controller)

    self:addElement(self.frameLB)

    self.frameRT = LUI.UIImage.new()
    self.frameRT:setScaledLeftRight(false, true, -9, 0)
    self.frameRT:setScaledTopBottom(true, false, 62, 71)
    self.frameRT:setImage(RegisterImage("ui_fancy_corner"))
    self.frameRT:setZRot(-180)

    SubRGBToRarity(self.frameRT, controller)

    self:addElement(self.frameRT)

    self.frameRB = LUI.UIImage.new()
    self.frameRB:setScaledLeftRight(false, true, -9, 0)
    self.frameRB:setScaledTopBottom(false, true, -9, 0)
    self.frameRB:setImage(RegisterImage("ui_fancy_corner"))
    self.frameRB:setZRot(90)

    SubRGBToRarity(self.frameRB, controller)

    self:addElement(self.frameRB)

    self.damageRow = Warzone.WeaponPickupCompRow.new(menu, controller)
    self.damageRow:setScaledLeftRight(true, true, 0, 0)
    self.damageRow:setScaledTopBottom(true, false, 72, 84)
    self.damageRow:setMetricModel("prospectiveWeapon.damage")
    
    self:addElement(self.damageRow)

    self.ammoRow = Warzone.WeaponPickupCompRow.new(menu, controller)
    self.ammoRow:setScaledLeftRight(true, true, 0, 0)
    self.ammoRow:setScaledTopBottom(true, false, 90, 102)
    self.ammoRow:setMetricModel("prospectiveWeapon.ammo")
    
    self:addElement(self.ammoRow)

    self.dpsRow = Warzone.WeaponPickupCompRow.new(menu, controller)
    self.dpsRow:setScaledLeftRight(true, true, 0, 0)
    self.dpsRow:setScaledTopBottom(true, false, 108, 120)
    self.dpsRow:setMetricModel("prospectiveWeapon.dps")
    
    self:addElement(self.dpsRow)

    self.tiersInfo = Warzone.WeaponPickupTiers.new(menu, controller)
    self.tiersInfo:setScaledLeftRight(false, true, -150, 0)
    self.tiersInfo:setScaledTopBottom(false, false, -36, 0)

    self:addElement(self.tiersInfo)

    self.weaponInfo = Warzone.WeaponPickupName.new(menu, controller)
    self.weaponInfo:setScaledLeftRight(true, false, 12, 150)
    self.weaponInfo:setScaledTopBottom(false, false, -36, 0)

    self:addElement(self.weaponInfo)

    self.buttonPrompt = Warzone.ButtonPrompt.new(menu, controller)
    self.buttonPrompt:setScaledLeftRight(true, false, 0, 16)
    self.buttonPrompt:setScaledTopBottom(false, false, -66, -50)

    self.buttonPrompt:mergeStateConditions({{
        stateName = "Disabled",
        condition = function(menu, self, event)
            local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectiveWeapon.attributes.cost")))
            return not IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
        end
    }})

    Util.SubState(controller, menu, self.buttonPrompt, "prospectiveWeapon.attributes.cost")
    Util.SubState(controller, menu, self.buttonPrompt, "PlayerList.0.playerScore")

    self:addElement(self.buttonPrompt)

    self.swapPrompt = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.swapPrompt:setScaledLeftRight(true, false, 20, 60)
    self.swapPrompt:setScaledTopBottom(false, false, -64, -52)
    self.swapPrompt:setText("Swap")

    Util.SubscribeToText(self.swapPrompt, controller, "prospectiveWeapon.attributes.buyString")

    self:addElement(self.swapPrompt)

    self.costPrompt = Warzone.WeaponPickupCost.new(menu, controller)
    self.costPrompt:setScaledLeftRight(false, true, -20, 0)
    self.costPrompt:setScaledTopBottom(false, false, -65, -51)

    self:addElement(self.costPrompt)

    -- CHECK: Seems to be creating sporadic UI errors
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(sender)
        if sender then
            if sender.weaponInfo and sender.tiersInfo and sender.buttonPrompt and sender.dpsRow and sender.ammoRow and sender.damageRow and sender.costPrompt then
                sender.weaponInfo:close()
                sender.tiersInfo:close()
                sender.buttonPrompt:close()
                sender.dpsRow:close()
                sender.ammoRow:close()
                sender.damageRow:close()
                sender.costPrompt:close()
            end
        end
    end)
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end