--[[
    MODERN WARFARE REMASTERED style Black Ops III HUD by Blakintosh
    Do not distribute without permission
]]

Warzone.PlusPoints = InheritFrom(LUI.UIElement)

function Warzone.PlusPoints.new(menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.PlusPoints)
	self.id = "PlusPoints"
	self.soundSet = "HUD"

    self.label = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.Cash, false)
    self.label:setScaledLeftRight(true, false, 0, 18)
    self.label:setScaledTopBottom(true, true, 0, 0)

    Wzu.ClipSequence(self, self.label, "PlusPoints", {
        {
            duration = 0,
            setAlpha = 0.4,
            setScaledLeftRight = {true, false, 0, 18}
        },
        {
            duration = 1000,
            setAlpha = 0,
            setScaledLeftRight = {true, false, 100, 118}
        }
    })

    self:addElement(self.label)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "PlusPoints")
            end
        }
    }

    self:registerEventHandler( "clip_over", function ( self, event )
        self:close()
    end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end
