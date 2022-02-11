require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.flashlight.FlashlightMode")
require("ui.uieditor.blak.warzone.widgets.hud.flashlight.FlashlightLight")


DataSources.FlashlightModes = DataSourceHelpers.ListSetup("FlashlightModes", function(controller)
    local returnTable = {}

    table.insert(returnTable, {
        models = {
            displayText = "AUTO",
            elementId = 0
        }
    })
    table.insert(returnTable, {
        models = {
            displayText = "ON",
            elementId = 1
        }
    })
    table.insert(returnTable, {
        models = {
            displayText = "OFF",
            elementId = 2
        }
    })
    
    return returnTable
end, true)

Warzone.Flashlight = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    local flModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "flashlightMode")
    Engine.SetModelValue(flModel, 0)

    local flAmodel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "flashlightActive")
    Engine.SetModelValue(flAmodel, 0)
end

function Warzone.Flashlight.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Flashlight)
    self.id = "Flashlight"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.icon = Warzone.FlashlightLight.new(menu, controller)
    self.icon:setScaledLeftRight(true, false, 0, 32)
    self.icon:setScaledTopBottom(false, false, -16, 16)

    Wzu.ClipSequence(self, self.icon, "DefaultClip", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, 76, 108},
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.icon, "Update", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, 0, 32},
            setAlpha = 1
        },
        {
            duration = 3000,
            setScaledLeftRight = {true, false, 0, 32},
            setAlpha = 1
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScaledLeftRight = {true, false, 0, 32},
            setAlpha = 0
        },
        {
            duration = 0,
            setScaledLeftRight = {true, false, 76, 108},
            setAlpha = 0
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScaledLeftRight = {true, false, 76, 108},
            setAlpha = 1
        }
    })

    self:addElement(self.icon)

    self.button = Warzone.ButtonPrompt.new(menu, controller)
    self.button:setScaledLeftRight(true, false, 44, 60)
    self.button:setScaledTopBottom(false, false, -8, 8)
    self.button:setButtonPrompt("actionslot 1", "actionslot 1")

    Wzu.ClipSequence(self, self.button, "DefaultClip", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, 120, 136},
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.button, "Update", {
        {
            duration = 0,
            setScaledLeftRight = {true, false, 44, 60},
            setAlpha = 1
        },
        {
            duration = 3000,
            setScaledLeftRight = {true, false, 44, 60},
            setAlpha = 1
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScaledLeftRight = {true, false, 44, 60},
            setAlpha = 0
        },
        {
            duration = 0,
            setScaledLeftRight = {true, false, 120, 136},
            setAlpha = 0
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setScaledLeftRight = {true, false, 120, 136},
            setAlpha = 1
        }
    })

    self:addElement(self.button)

    self.modeList = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.modeList:makeFocusable()
    self.modeList:setScaledLeftRight(true, false, 72, 120)
    self.modeList:setScaledTopBottom(false, false, -8, 8)
	self.modeList:setWidgetType(Warzone.FlashlightMode)
	self.modeList:setDataSource("FlashlightModes")
    self.modeList:setHorizontalCount(3)
    self.modeList:setSpacing(16)

    Wzu.ClipSequence(self, self.modeList, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.modeList, "Update", {
        {
            duration = 0,
            setAlpha = 1
        },
        {
            duration = 3000,
            setAlpha = 1
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.inQuad,
            setAlpha = 0
        }
    })
    
    self:addElement(self.modeList)

    --[[self.auto = Warzone.FlashlightMode.new(menu, controller)
    self.auto:setScaledLeftRight(true, false, 72, 88)
    self.auto:setScaledTopBottom(false, false, -8, 8)
    self.auto.text:setText("AUTO")

    self:addElement(self.auto)]]

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultClip")
            end,
            Update = function()
                Wzu.AnimateSequence(self, "Update")
            end
        }
    }

    Wzu.Subscribe(self, controller, "hudItems.flashlightMode", function(modelValue)
        self:playClip("Update")
    end)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end