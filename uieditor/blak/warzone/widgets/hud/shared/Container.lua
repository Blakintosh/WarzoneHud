Warzone.Container = InheritFrom(LUI.UIElement)

function Warzone.Container.new(menu, controller, contentWidget)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Container)
    self.id = "Container"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    self.contents = contentWidget.new(menu, controller)
    self.contents:setScaledLeftRight(true, true, 0, 0)
    self.contents:setScaledTopBottom(true, true, 0, 0)

    Util.ClipSequence(self, self.contents, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 1,
            interpolation = Util.TweenGraphs.inCubic
        }
    })
    Util.ClipSequence(self, self.contents, "Hidden", {
        {
            duration = 0,
            setAlpha = 1
        },
        {
            duration = 300,
            setAlpha = 0,
            interpolation = Util.TweenGraphs.inCubic
        }
    })

    self:addElement(self.contents)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultState")
            end
        },
        Hidden = {
            DefaultClip = function()
                Util.AnimateSequence(self, "Hidden")
            end
        }
    }
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.contents:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end