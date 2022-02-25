Warzone.HighResolutionContainer = InheritFrom(LUI.UIElement)

function Warzone.HighResolutionContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.HighResolutionContainer)
    self.id = "HighResolutionContainer"
    self.soundSet = "default"
    self:makeFocusable()
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    -- Ammo Widget
    self.ammo = Wzu.CreateContainedHudElement(menu, controller, Warzone.Ammo)
    self.ammo:setScaledLeftRight(false, true, -357, 0)
    self.ammo:setScaledTopBottom(false, true, -117, 0)

    self:addElement(self.ammo)

    -- Squad/Score Widget
    self.squad = Wzu.CreateContainedHudElement(menu, controller, Warzone.Squad)
    self.squad:setScaledLeftRight(true, false, 0, 400)
    self.squad:setScaledTopBottom(false, true, -400, 0)

    self:addElement(self.squad)

    -- Round Widget
    self.round = Wzu.CreateContainedHudElement(menu, controller, Warzone.RoundCounter)
    self.round:setScaledLeftRight(true, false, 19, 92)
    self.round:setScaledTopBottom(true, false, 16, 89)

    self:addElement(self.round)

    -- Cursorhint
    self.cursorHint = Wzu.CreateContainedHudElement(menu, controller, Warzone.CursorHint)
    self.cursorHint:setScaledLeftRight(true, false, 631, 958)
    self.cursorHint:setScaledTopBottom(true, false, 451, 499)

    self:addElement(self.cursorHint)

    -- Out of bounds
    self.oob = Wzu.CreateContainedHudElement(menu, controller, Warzone.OutOfBounds)
    self.oob:setScaledLeftRight(true, true, 0, 0)
    self.oob:setScaledTopBottom(true, true, 0, 0)

    self:addElement(self.oob)

    -- Powerups
    self.powerups = Wzu.CreateContainedHudElement(menu, controller, Warzone.PowerupsList)
    self.powerups:setScaledLeftRight(false, false, -400, 400)
    self.powerups:setScaledTopBottom(true, false, 70, 110)

    self:addElement(self.powerups)

    -- Notification
    self.notification = Wzu.CreateContainedHudElement(menu, controller, Warzone.Notification)
    self.notification:setScaledLeftRight(false, false, -640, 640)
    self.notification:setScaledTopBottom(true, false, 130, 190)

    self:addElement(self.notification)

    -- "Reload"
    self.reload = Wzu.CreateContainedHudElement(menu, controller, Warzone.ReloadPrompt)
    self.reload:setScaledLeftRight(false, false, -640, 640)
    self.reload:setScaledTopBottom(true, false, 420, 470)

    self:addElement(self.reload)

    self.scoreboard = Wzu.CreateContainedScoreboardElement(menu, controller, Warzone.Scoreboard)
    self.scoreboard:setScaledLeftRight(false, false, -485, 485)
    self.scoreboard:setScaledTopBottom(true, false, 150, 330)

    self:addElement(self.scoreboard)
    
    -- Navigation
    self.scoreboard.id = "scoreboard"
    self.scoreboard.contents.id = "contents"

    self:registerEventHandler("gain_focus", function(sender, event)
		if self.m_focusable then
			if self.scoreboard:processEvent(event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(self, event)
    end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.ammo:close()
        self.squad:close()
        self.round:close()
        self.cursorHint:close()
        self.oob:close()
        self.powerups:close()
        self.notification:close()
        self.reload:close()
        self.scoreboard:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end