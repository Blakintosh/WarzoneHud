require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.AltWeaponPromptMode")


DataSources.AltWeaponPromptModes = DataSourceHelpers.ListSetup("AltWeaponPromptModes", function(controller)
    local returnTable = {}

    table.insert(returnTable, {
        models = {
            iconSub = "currentWeapon.altWeaponLeftIcon",
            elementId = 1
        }
    })
    table.insert(returnTable, {
        models = {
            iconSub = "currentWeapon.altWeaponRightIcon",
            elementId = 2
        }
    })
    
    return returnTable
end, true)

Warzone.AltWeaponPrompt = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "altWeaponState")
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "altWeaponLeftIcon")
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "altWeaponRightIcon")
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

    Util.ClipSequence(self, self.button, "AltWeapon", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.button, "DefaultState", {
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

    Util.ClipSequence(self, self.modeList, "AltWeapon", {
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.modeList, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    
    self:addElement(self.modeList)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        AltWeapon = {
            DefaultClip = function()
                Util.AnimateSequence(self, "AltWeapon")
            end
        }
    }

    self:mergeStateConditions({{
        stateName = "AltWeapon",
        condition = function(menu, self, event)
            return IsModelValueGreaterThan(controller, "currentWeapon.altWeaponState", 0)
        end
    }})

    Util.SubState(controller, menu, self, "currentWeapon.altWeaponState")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end