Warzone.ButtonFocusInfo = InheritFrom(LUI.UIElement)

function Warzone.ButtonFocusInfo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ButtonFocusInfo)
    self.id = "ButtonFocusInfo"
    --self:makeFocusable()
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.cornerLT = LUI.UIImage.new()
    self.cornerLT:setScaledLeftRight(true, false, 0, 1)
    self.cornerLT:setScaledTopBottom(true, false, 0, 6)

    self:addElement(self.cornerLT)

    self.cornerTL = LUI.UIImage.new()
    self.cornerTL:setScaledLeftRight(true, false, 1, 6)
    self.cornerTL:setScaledTopBottom(true, false, 0, 1)

    self:addElement(self.cornerTL)

    self.frameWidget = LUI.UIFrame.new(menu, controller, 0, 0, false)
    self.frameWidget:setScaledLeftRight(true, false, 4, 224)
    self.frameWidget:setScaledTopBottom(true, false, 4, 78)
	self.frameWidget:linkToElementModel(self, nil, false, function (ModelRef)
		self.frameWidget:setModel(ModelRef, controller)
	end)
    
	self.frameWidget.id = "frameWidget"

    self:addElement(self.frameWidget)

    --[[self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        },
        Disabled = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DisabledUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DisabledOver")
            end
        }
    }]]
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end