Warzone.AltWeaponPromptMode = InheritFrom(LUI.UIElement)

function Warzone.AltWeaponPromptMode.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.AltWeaponPromptMode)
    self.id = "AltWeaponPromptMode"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setScaledLeftRight(true, false, 0, 16)
    self:setScaledTopBottom(true, false, 0, 24)

    self.image = LUI.UIImage.new()
    self.image:setScaledLeftRight(false, false, -8, 8)
    self.image:setScaledTopBottom(false, false, -8, 8)
    self.image:setImage(RegisterImage("ui_firetype_fullauto"))

    Util.LinkToWidget(self.image, self, "iconSub", function(modelValue)
        Util.SubscribeToImage(self.image, controller, modelValue)
    end)

    Util.ClipSequence(self, self.image, "Default", {
        {
            duration = 0,
            setAlpha = 0.5
        }
    })
    Util.ClipSequence(self, self.image, "Active", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.image)

    self.footer = LUI.UIImage.new()
    self.footer:setScaledLeftRight(false, false, -8, 8)
    self.footer:setScaledTopBottom(false, true, -1, 0)

    Util.ClipSequence(self, self.footer, "Default", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        }
    })
    Util.ClipSequence(self, self.footer, "Active", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -0, 0}
        },
        {
            duration = 200,
            interpolation = Util.TweenGraphs.inOutSine,
            setScaledLeftRight = {false, false, -8, 8}
        }
    })

    self:addElement(self.footer)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Default")
            end
        },
        Active = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Active")
            end
        }
    }

    self:mergeStateConditions({{
        stateName = "Active",
        condition = function(menu, self, event)
            local modelValue = Engine.GetModelValue(Engine.GetModel(self:getModel(), "elementId"))
            if modelValue then
                return IsModelValueEqualTo(controller, "currentWeapon.altWeaponState", modelValue)
            end
            return false
        end
    }})
    Util.SubState(controller, menu, self, "currentWeapon.altWeaponState")

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end