LUI.UIMouseCursor = {}
Warzone.MouseCursor = {}
Warzone.MouseCursor.priority = 1000
local mouseMove = function (self, event)
	local rootXCoordinate, rootYCoordinate = ProjectRootCoordinate(event.rootName, event.x, event.y)
	if rootXCoordinate ~= nil and rootYCoordinate ~= nil then
		local eventRoot = event.root
		if not eventRoot then
			eventRoot = LUI.roots[event.rootName]
		end
		local unitXCoordinate, unitYCoordinate = eventRoot:pixelsToUnits(rootXCoordinate, rootYCoordinate)
		if unitXCoordinate ~= nil and unitYCoordinate ~= nil then
			local sizeOffset = self.size / 2
			self:beginAnimation("default")
			self:setLeftRight(true, false, unitXCoordinate - sizeOffset, unitXCoordinate + sizeOffset)
			self:setTopBottom(true, false, unitYCoordinate - sizeOffset, unitYCoordinate + sizeOffset)
		end
	end
	self:dispatchEventToChildren(event)
end

Warzone.MouseCursor.new = function()
	local self = LUI.UIImage.new()
    self:setImage(RegisterImage(Wzu.CursorTypes.Normal))
	self:setPriority(Warzone.MouseCursor.priority)
	self:registerEventHandler("mousemove", mouseMove)
	self.size = 64

    Wzu.SetCursorType = function(type)
        self:setImage(RegisterImage(type))
    end

    local lockInputFunc = Engine.LockInput

    function Engine.LockInput(controller, active)
        if active then
            self:setAlpha(1)
            lockInputFunc(controller, true)
            HideMouseCursor(self)
        else
            self:setAlpha(0)
            lockInputFunc(controller, false)
            --ShowMouseCursor(self)
        end
    end

    --[[function HideMouseCursor(sender)
        if CoD.isPC then
            self:setAlpha(0)
            sender.mouseCursorHidden = true
        end
    end
    
    function ShowMouseCursor(sender)
        if CoD.isPC then
            self:setAlpha(1)
            sender.mouseCursorHidden = nil
        end
    end]]

	return self
end

--LUI.UIMouseCursor.new = Warzone.MouseCursor.new

if not LUI.roots.UIRootFull.mouseCursor then
    local cursor = Warzone.MouseCursor.new()
    LUI.roots.UIRootFull:addElement(cursor)
    LUI.roots.UIRootFull.mouseCursor = cursor
end