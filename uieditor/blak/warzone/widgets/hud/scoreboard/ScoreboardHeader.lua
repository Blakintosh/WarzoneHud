Warzone.ScoreboardHeader = InheritFrom(LUI.UIElement)

function Warzone.ScoreboardHeader.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.ScoreboardHeader)
    self.id = "ScoreboardHeader"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setScaledLeftRight(true, false, 0, 714)
    self:setScaledTopBottom(true, false, 0, 30)

    self.col0 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.col0:setScaledLeftRight(false, true, -476, -426)
    self.col0:setScaledTopBottom(true, false, 0, 16)
    self.col0:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	self.col0:setText(Engine.Localize(GetScoreboardColumnName(controller, 0, "Score")))

    Wzu.AddShadowedElement(self, self.col0)

    self.col1 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.col1:setScaledLeftRight(false, true, -396, -346)
    self.col1:setScaledTopBottom(true, false, 0, 16)
    self.col1:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	self.col1:setText(Engine.Localize(GetScoreboardColumnName(controller, 1, "Score")))

    Wzu.AddShadowedElement(self, self.col1)

    self.col2 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.col2:setScaledLeftRight(false, true, -316, -266)
    self.col2:setScaledTopBottom(true, false, 0, 16)
    self.col2:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	self.col2:setText(Engine.Localize(GetScoreboardColumnName(controller, 2, "Score")))

    Wzu.AddShadowedElement(self, self.col2)

    self.col3 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.col3:setScaledLeftRight(false, true, -236, -186)
    self.col3:setScaledTopBottom(true, false, 0, 16)
    self.col3:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	self.col3:setText(Engine.Localize(GetScoreboardColumnName(controller, 3, "Score")))

    Wzu.AddShadowedElement(self, self.col3)

    self.col4 = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.col4:setScaledLeftRight(false, true, -154, -96)
    self.col4:setScaledTopBottom(true, false, 0, 16)
    self.col4:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	self.col4:setText(Engine.Localize(GetScoreboardColumnName(controller, 4, "Score")))

    Wzu.AddShadowedElement(self, self.col4)

    self.ping = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.ping:setScaledLeftRight(false, true, -66, -16)
    self.ping:setScaledTopBottom(true, false, 0, 16)
    self.ping:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    self.ping:setText(Engine.Localize("CGAME_SB_PING"))

    Wzu.AddShadowedElement(self, self.ping)

    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end