require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenuprogressmeter")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenuupgradebuttons")

Warzone.OverclockMenuUpgrades = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuUpgrades.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuUpgrades)
    self.id = "OverclockMenuUpgrades"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:makeFocusable()
    self.onlyChildrenFocusable = true

    self.title = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.title:setScaledLeftRight(true, false, 100, 300)
    self.title:setScaledTopBottom(true, false, 0, 18)
    self.title:setText("DAMAGE UPGRADES")

    self:addElement(self.title)

    self.progressMeter = Warzone.OverclockMenuProgressMeter.new(menu, controller)
    self.progressMeter:setScaledLeftRight(true, true, 100, -100)
    self.progressMeter:setScaledTopBottom(true, false, 38, 62)

    self:addElement(self.progressMeter)

    self.upgradeButtons = Warzone.OverclockMenuUpgradeButtons.new(menu, controller)
    self.upgradeButtons:setScaledLeftRight(true, true, 0, 0)
    self.upgradeButtons:setScaledTopBottom(true, false, 56, 138)

    self:addElement(self.upgradeButtons)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end