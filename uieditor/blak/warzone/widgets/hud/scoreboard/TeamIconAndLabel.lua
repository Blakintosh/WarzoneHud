Warzone.TeamIconAndLabel = InheritFrom(LUI.UIElement)

function Warzone.TeamIconAndLabel.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.TeamIconAndLabel)
    self.id = "TeamIconAndLabel"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.teamIcon = LUI.UIImage.new()
    self.teamIcon:setScaledLeftRight(true, false, 0, 128)
    self.teamIcon:setScaledTopBottom(true, false, 0, 128)
    self.teamIcon:setImage(RegisterImage("h2_faction_128_taskforce141"))

    self:addElement(self.teamIcon)

    self.teamLabelBg = LUI.UIImage.new()
    self.teamLabelBg:setScaledLeftRight(true, false, 46, 224)
    self.teamLabelBg:setScaledTopBottom(true, false, 83, 105)
    Wzu.SetRGBFromTable(self.teamLabelBg, Wzu.Colors.Black)
    self.teamLabelBg:setAlpha(0.6)

    self:addElement(self.teamLabelBg)

    self.teamLabel = Wzu.TextElement(Wzu.Fonts.MainLight, Wzu.Swatches.HUDMain, false)
    self.teamLabel:setScaledLeftRight(true, false, 48, 160)
    self.teamLabel:setScaledTopBottom(true, false, 80, 108)
    self.teamLabel:setText("TASK FORCE 141")

    self:addElement(self.teamLabel)


    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end