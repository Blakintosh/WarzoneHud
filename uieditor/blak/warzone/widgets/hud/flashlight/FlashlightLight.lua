Warzone.FlashlightLight = InheritFrom(LUI.UIElement)

function Warzone.FlashlightLight.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.FlashlightLight)
    self.id = "FlashlightLight"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.icon = LUI.UIImage.new()
    self.icon:setScaledLeftRight(true, true, 0, 0)
    self.icon:setScaledTopBottom(true, true, -0, 0)
    self.icon:setImage(RegisterImage("hud_icon_equipment_flashlight"))

    Wzu.ClipSequence(self, self.icon, "Default", {
        {
            duration = 0,
            setAlpha = 0.5
        }
    })
    Wzu.ClipSequence(self, self.icon, "Active", {
        {
            duration = 0,
            setAlpha = 1
        }
    })

    self:addElement(self.icon)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Default")
            end
        },
        Active = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Active")
            end
        }
    }

    self:mergeStateConditions({{
        stateName = "Active",
        condition = function(menu, self, event)
            return IsModelValueEqualTo(controller, "hudItems.flashlightActive", 1)
        end
    }})
    Wzu.SubState(controller, menu, self, "hudItems.flashlightActive")

    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end