require("ui.uieditor.blak.warzone.widgets.hud.oob.ReturnAO")

Warzone.OutOfBounds = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    --[[TimerModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "karelia"), "outOfBoundsTime")
    Engine.SetModelValue(TimerModel, 101)]]
end

function Warzone.OutOfBounds.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OutOfBounds)
    self.id = "OutOfBounds"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.bg1 = LUI.UIImage.new()
    self.bg1:setScaledLeftRight(true, true, 0, 0)
    self.bg1:setScaledTopBottom(true, true, 0, 0)
    self.bg1:setRGB(0, 0, 0)
    self.bg1:setAlpha(0)

    Wzu.ClipSequence(self, self.bg1, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.bg1, "Show", {
        {
            duration = 0,
            setAlpha = 0.2
        }
    })

    self:addElement(self.bg1)

    self.bg2 = LUI.UIImage.new()
    self.bg2:setScaledLeftRight(true, true, 0, 0)
    self.bg2:setScaledTopBottom(true, true, 0, 0)
    self.bg2:setRGB(0.7333, 0.0353, 0)
    self.bg2:setAlpha(0)

    Wzu.ClipSequence(self, self.bg2, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.bg2, "Show", {
        {
            duration = 0,
            setAlpha = 0.1
        }
    })

    self:addElement(self.bg2)

    self.bg3 = LUI.UIImage.new()
    self.bg3:setScaledLeftRight(true, true, 0, 0)
    self.bg3:setScaledTopBottom(true, true, 0, 0)
    self.bg3:setRGB(0.3333, 0, 0)
    self.bg3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_pixel_grid"))
    self.bg3:setAlpha(0)
    self.bg3:setShaderVector(0, 3.0, 3.0, 1.0, 1.0)

    Wzu.ClipSequence(self, self.bg3, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.bg3, "Show", {
        {
            duration = 0,
            setAlpha = 0.2
        }
    })

    self:addElement(self.bg3)

    self.prompt = Warzone.ReturnAO.new(menu, controller)
    self.prompt:setScaledLeftRight(false, false, -300, 300)
    self.prompt:setScaledTopBottom(true, false, 290, 495)
    self.prompt:setAlpha(0)

    Wzu.ClipSequence(self, self.prompt, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.prompt, "Show", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.prompt)

    --[[SubscribeToScriptNotify(controller, self, "karelia_outOfBoundsTime", function(NotifyData)
        if NotifyData[1] then
            Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "karelia.outOfBoundsTime"), NotifyData[1])
        end
    end)]]

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
            condition = function(self, menu, event)
                return IsModelValueLessThan(controller, "karelia.outOfBoundsTime", 101)
            end
        }
    })
    Wzu.SubState(self, controller, "karelia.outOfBoundsTime")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end