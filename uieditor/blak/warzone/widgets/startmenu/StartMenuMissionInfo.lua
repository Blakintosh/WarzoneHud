Warzone.StartMenuMissionInfo = InheritFrom(LUI.UIElement)

function Warzone.StartMenuMissionInfo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.StartMenuMissionInfo)
    self.id = "StartMenuMissionInfo"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true
    
    self.mapName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.mapName:setScaledLeftRight(true, false, 4, 100)
    self.mapName:setScaledTopBottom(true, false, 0, 14)

    self.mapName:setText("Karelia")

    self:addElement(self.mapName)
    
    self.factionName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, false)
    self.factionName:setScaledLeftRight(false, true, -100, -4)
    self.factionName:setScaledTopBottom(true, false, 0, 14)

    self.factionName:setText("Task Force 141")

    self:addElement(self.factionName)

    self.divider = LUI.UIImage.new()
    self.divider:setScaledLeftRight(true, true, 0, 0)
    self.divider:setScaledTopBottom(true, false, 20, 21)
    Util.SetRGBFromTable(self.divider, Util.Swatches.HUDMain)
    self.divider:setAlpha(0.8)

    self:addElement(self.divider)

    self.modeIcon = LUI.UIImage.new()
    self.modeIcon:setScaledLeftRight(true, false, 0, 80)
    self.modeIcon:setScaledTopBottom(true, false, 48, 128)
    self.modeIcon:setImage(RegisterImage("icon_mode_wz_br_zombies"))

    self:addElement(self.modeIcon)

    self.gamemode = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.gamemode:setScaledLeftRight(true, false, 104, 304)
    self.gamemode:setScaledTopBottom(true, false, 48, 72)

    self.gamemode:setText("Survival")

    self:addElement(self.gamemode)

    self.modeDescription = Util.TextElement(Util.Fonts.MainRegular, Util.Colors.Grey191, false)
    self.modeDescription:setScaledLeftRight(true, false, 104, 504)
    self.modeDescription:setScaledTopBottom(true, false, 86, 102)
    self.modeDescription:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.modeDescription:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)

    self.modeDescription:setText("Investigate the hamlet.\nSurvive for as long as possible against the undead.")

    self:addElement(self.modeDescription)
    -- 86
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end