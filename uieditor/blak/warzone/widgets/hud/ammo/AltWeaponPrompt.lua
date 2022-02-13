require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.AltWeaponPromptMode")


DataSources.AltWeaponPromptModes = DataSourceHelpers.ListSetup("AltWeaponPromptModes", function(controller)
    local returnTable = {}

    table.insert(returnTable, {
        models = {
            icon = "ui_firetype_fullauto",
            elementId = 0
        }
    })
    table.insert(returnTable, {
        models = {
            icon = "ui_firetype_semiauto",
            elementId = 1
        }
    })
    
    return returnTable
end, true)

Warzone.AltWeaponPrompt = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    local awaModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "altWeaponEquipped")
    Engine.SetModelValue(awaModel, 0)
end

function Warzone.AltWeaponPrompt.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.AltWeaponPrompt)
    self.id = "AltWeaponPrompt"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.button = Warzone.ButtonPrompt.new(menu, controller)
    self.button:setScaledLeftRight(true, false, 0, 16)
    self.button:setScaledTopBottom(false, false, -8, 8)
    self.button:setButtonPrompt("actionslot 3", "actionslot 3")

    Wzu.ClipSequence(self, self.button, "UnderbarrelAlt", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.button, "Underbarrel", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.button, "AltWeapon", {
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

    self.modeList = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.modeList:makeFocusable()
    self.modeList:setScaledLeftRight(true, false, 32, 72)
    self.modeList:setScaledTopBottom(false, false, -12, 12)
	self.modeList:setWidgetType(Warzone.AltWeaponPromptMode)
	self.modeList:setDataSource("AltWeaponPromptModes")
    self.modeList:setHorizontalCount(2)
    self.modeList:setSpacing(16)

    Wzu.ClipSequence(self, self.modeList, "UnderbarrelAlt", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.modeList, "Underbarrel", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.modeList, "AltWeapon", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.modeList, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    
    self:addElement(self.modeList)

    self.backWeapon = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Colors.White, false)
    self.backWeapon:setScaledLeftRight(true, false, 24, 100)
    self.backWeapon:setScaledTopBottom(false, false, -8, 6)
    self.backWeapon:setText("For Badass Battle Rifle")

    Wzu.ClipSequence(self, self.backWeapon, "UnderbarrelAlt", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.backWeapon, "Underbarrel", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.backWeapon, "AltWeapon", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.backWeapon, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:addElement(self.backWeapon)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "AltWeapon")
            end
        },
        Underbarrel = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Underbarrel")
            end
        },
        UnderbarrelAlt = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "UnderbarrelAlt")
            end
        },
        AltWeapon = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "AltWeapon")
            end
        }
    }

    --[[Wzu.Subscribe(self, controller, "hudItems.AltWeaponPromptMode", function(modelValue)
        self:playClip("Update")
    end)]]

    --self:setState("UnderbarrelAlt")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end