Warzone.CorneredBorder = InheritFrom(LUI.UIElement)

Warzone.CorneredBorder.new = function (menu, controller, cornerLength)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

    cornerLength = cornerLength or 4

	self:setUseStencil(false)
	self:setClass(Warzone.CorneredBorder)
	self.id = "CorneredBorder"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true

    self.leftTop = LUI.UIImage.new()
    self.leftTop:setScaledLeftRight(true, false, 0, 1)
    self.leftTop:setScaledTopBottom(true, false, 0, cornerLength)

    self:addElement(self.leftTop)

    self.leftBottom = LUI.UIImage.new()
    self.leftBottom:setScaledLeftRight(true, false, 0, 1)
    self.leftBottom:setScaledTopBottom(false, true, -cornerLength, 0)

    self:addElement(self.leftBottom)

    self.rightTop = LUI.UIImage.new()
    self.rightTop:setScaledLeftRight(false, true, -1, 0)
    self.rightTop:setScaledTopBottom(true, false, 0, cornerLength)

    self:addElement(self.rightTop)

    self.rightBottom = LUI.UIImage.new()
    self.rightBottom:setScaledLeftRight(false, true, -1, 0)
    self.rightBottom:setScaledTopBottom(false, true, -cornerLength, 0)

    self:addElement(self.rightBottom)

    self.topLeft = LUI.UIImage.new()
    self.topLeft:setScaledLeftRight(true, false, 1, cornerLength)
    self.topLeft:setScaledTopBottom(true, false, 0, 1)

    self:addElement(self.topLeft)

    self.topRight = LUI.UIImage.new()
    self.topRight:setScaledLeftRight(false, true, -cornerLength, -1)
    self.topRight:setScaledTopBottom(true, false, 0, 1)

    self:addElement(self.topRight)

    self.bottomLeft = LUI.UIImage.new()
    self.bottomLeft:setScaledLeftRight(true, false, 1, cornerLength)
    self.bottomLeft:setScaledTopBottom(false, true, -1, 0)

    self:addElement(self.bottomLeft)

    self.bottomRight = LUI.UIImage.new()
    self.bottomRight:setScaledLeftRight(false, true, -cornerLength, -1)
    self.bottomRight:setScaledTopBottom(false, true, -1, 0)

    self:addElement(self.bottomRight)

    self.setRGB = function(self, r, g, b)
        self.leftTop:setRGB(r, g, b)
        self.leftBottom:setRGB(r, g, b)
        self.rightTop:setRGB(r, g, b)
        self.rightBottom:setRGB(r, g, b)
        self.topLeft:setRGB(r, g, b)
        self.topRight:setRGB(r, g, b)
        self.bottomLeft:setRGB(r, g, b)
        self.bottomRight:setRGB(r, g, b)
    end
    -- might add a setCornerLength in future, but not right now.
    
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

