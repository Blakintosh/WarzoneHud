EnableGlobals()

-- 1 = 720p, 2 = 1440p, etc.
_ResolutionScalar = 2

LUI.UIElement.setScaledLeftRight = function(self, leftAnchor, rightAnchor, startPos, endPos)
    self:setLeftRight(leftAnchor, rightAnchor, _ResolutionScalar * startPos, _ResolutionScalar * endPos)
end

LUI.UIElement.setScaledTopBottom = function(self, leftAnchor, rightAnchor, startPos, endPos)
    self:setTopBottom(leftAnchor, rightAnchor, _ResolutionScalar * startPos, _ResolutionScalar * endPos)
end