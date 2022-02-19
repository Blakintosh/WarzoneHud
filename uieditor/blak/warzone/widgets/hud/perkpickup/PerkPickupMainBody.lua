
require("ui.uieditor.blak.warzone.widgets.hud.perkpickup.PerkPickupName")
require("ui.uieditor.blak.warzone.widgets.hud.perkpickup.PerkPickupCost")
require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")

Warzone.PerkPickupMainBody = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectivePerk"), "specialty")
    Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectivePerk"), "attributes"), "name")
    Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectivePerk"), "attributes"), "effects")
    Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectivePerk"), "attributes"), "color")
    Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "prospectivePerk"), "attributes"), "icon")
end

local function SubRGBToPerk(self, controller)
    Wzu.Subscribe(self, controller, "prospectivePerk.attributes.color", function(modelValue)
        if Wzu.Colors.Perks[modelValue] then
            Wzu.SetRGBFromTable(self, Wzu.Colors.Perks[modelValue])
        else
            Wzu.SetRGBFromTable(self, Wzu.Colors.White)
        end
    end)
end

function Warzone.PerkPickupMainBody.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PerkPickupMainBody)
    self.id = "PerkPickupMainBody"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    self.perkTable = {
        {
            specialty = "specialty_quickrevive",
            name = "Quick Revive",
            effects = "Second chance when downed on Solo.",
            color = "QuickRevive",
            icon = "wz_icon_perk_quickrevive"
        },
        {
            specialty = "specialty_doubletap2",
            name = "Double Tap II",
            effects = "Fire two bullets for every shot.\nWeapon rate of fire increased 25%.",
            color = "DoubleTap2",
            icon = "wz_icon_perk_rof"
        },
        {
            specialty = "specialty_rof",
            name = "Double Tap",
            effects = "Weapon rate of fire increased 25%.",
            color = "Rof",
            icon = "wz_icon_perk_rof"
        },
        {
            specialty = "specialty_fastreload",
            name = "Speed Cola",
            effects = "Weapon reload time reduced 50%.",
            color = "FastReload",
            icon = "wz_icon_perk_fastreload"
        },
        {
            specialty = "specialty_armorvest",
            name = "Jugger-Nog",
            effects = "Player health increased to 250.",
            color = "ArmorVest",
            icon = "wz_icon_perk_armorvest"
        },
        {
            specialty = "specialty_phdflopper",
            name = "PHD Slider",
            effects = "Enables sliding which releases a grenade trail.\nImmunity to self inflicted damage.",
            color = "PhdFlopper",
            icon = "wz_icon_perk_phdflopper"
        },
        {
            specialty = "specialty_extraammo",
            name = "Bandolier Brew",
            effects = "Increases ballistic weapon ammo reserves 50%.",
            color = "ExtraAmmo",
            icon = "wz_icon_perk_extraammo"
        },
        {
            specialty = "specialty_bulletdamage",
            name = "Stopping Power",
            effects = "Doubles ballistic weapon damage.",
            color = "BulletDamage",
            icon = "wz_icon_perk_bulletdamage"
        },
        {
            specialty = "specialty_combat_efficiency",
            name = "Shady Shandy",
            effects = "Able to see nearby zombies through walls.",
            color = "ShadyShandy",
            icon = "wz_icon_perk_combat_efficiency"
        },
        {
            specialty = "specialty_fastmeleerecovery",
            name = "Vigor Vodka",
            effects = "Quintuples melee damage.\nMelee attacks chain to nearby enemies.",
            color = "VigorVodka",
            icon = "wz_icon_perk_fastmeleerecovery"
        }
    }

    self.frameLT = LUI.UIImage.new()
    self.frameLT:setScaledLeftRight(true, false, 0, 9)
    self.frameLT:setScaledTopBottom(true, false, 62, 71)
    self.frameLT:setImage(RegisterImage("ui_fancy_corner"))
    self.frameLT:setZRot(-90)

    SubRGBToPerk(self.frameLT, controller)

    self:addElement(self.frameLT)

    self.frameLB = LUI.UIImage.new()
    self.frameLB:setScaledLeftRight(true, false, 0, 9)
    self.frameLB:setScaledTopBottom(false, true, -9, 0)
    self.frameLB:setImage(RegisterImage("ui_fancy_corner"))

    SubRGBToPerk(self.frameLB, controller)

    self:addElement(self.frameLB)

    self.frameRT = LUI.UIImage.new()
    self.frameRT:setScaledLeftRight(false, true, -9, 0)
    self.frameRT:setScaledTopBottom(true, false, 62, 71)
    self.frameRT:setImage(RegisterImage("ui_fancy_corner"))
    self.frameRT:setZRot(-180)

    SubRGBToPerk(self.frameRT, controller)

    self:addElement(self.frameRT)

    self.frameRB = LUI.UIImage.new()
    self.frameRB:setScaledLeftRight(false, true, -9, 0)
    self.frameRB:setScaledTopBottom(false, true, -9, 0)
    self.frameRB:setImage(RegisterImage("ui_fancy_corner"))
    self.frameRB:setZRot(90)

    SubRGBToPerk(self.frameRB, controller)

    self:addElement(self.frameRB)

    self.weaponInfo = Warzone.PerkPickupName.new(menu, controller)
    self.weaponInfo:setScaledLeftRight(true, false, 12, 150)
    self.weaponInfo:setScaledTopBottom(false, false, -36, 0)

    self:addElement(self.weaponInfo)

    self.buttonPrompt = Warzone.ButtonPrompt.new(menu, controller)
    self.buttonPrompt:setScaledLeftRight(true, false, 0, 16)
    self.buttonPrompt:setScaledTopBottom(false, false, -66, -50)

    self.buttonPrompt:mergeStateConditions({{
        stateName = "Disabled",
        condition = function(menu, self, event)
            local cost = tonumber(Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.cost")))
            return not IsModelValueGreaterThanOrEqualTo(controller, "PlayerList.0.playerScore", cost)
        end
    }})

    Wzu.SubState(controller, menu, self.buttonPrompt, "prospectivePerk.cost")
    Wzu.SubState(controller, menu, self.buttonPrompt, "PlayerList.0.playerScore")

    self:addElement(self.buttonPrompt)

    self.swapPrompt = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.swapPrompt:setScaledLeftRight(true, false, 20, 60)
    self.swapPrompt:setScaledTopBottom(false, false, -64, -52)
    self.swapPrompt:setText("Perk")

    self:addElement(self.swapPrompt)

    self.costPrompt = Warzone.PerkPickupCost.new(menu, controller)
    self.costPrompt:setScaledLeftRight(false, true, -20, 0)
    self.costPrompt:setScaledTopBottom(false, false, -65, -51)

    self:addElement(self.costPrompt)

    self.perkIcon = LUI.UIImage.new()
    self.perkIcon:setScaledLeftRight(false, true, -32, 0)
    self.perkIcon:setScaledTopBottom(true, false, 18, 50)
    
    Wzu.SubscribeToImage(self.perkIcon, controller, "prospectivePerk.attributes.icon")

    self:addElement(self.perkIcon)

    self.perkEffects = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.perkEffects:setScaledLeftRight(true, false, 12, 52)
    self.perkEffects:setScaledTopBottom(true, false, 65, 79)
    self.perkEffects:setText("EFFECTS:")

    self:addElement(self.perkEffects)

    self.perkEffectDesc = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.perkEffectDesc:setScaledLeftRight(true, false, 12, 312)
    self.perkEffectDesc:setScaledTopBottom(true, false, 80, 96)
    self.perkEffectDesc:setText("AMONG US")
    self.perkEffectDesc:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.perkEffectDesc:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)

    Wzu.SubscribeToText(self.perkEffectDesc, controller, "prospectivePerk.attributes.effects")

    self:addElement(self.perkEffectDesc)

    Wzu.Subscribe(self, controller, "prospectivePerk.specialty", function(modelValue)
        for k,v in ipairs(self.perkTable) do
            if v.specialty == modelValue then
                Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.attributes.name"), v.name)
                Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.attributes.effects"), v.effects)
                Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.attributes.color"), v.color)
                Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "prospectivePerk.attributes.icon"), v.icon)
            end
        end
    end)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(sender)
        if sender.weaponInfo and sender.costPrompt and sender.buttonPrompt then
            sender.weaponInfo:close()
            sender.costPrompt:close()
            sender.buttonPrompt:close()
        end
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, menu, controller)
    end
    
    return self
end