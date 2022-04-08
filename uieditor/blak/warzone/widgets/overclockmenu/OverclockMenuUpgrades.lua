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
    self.progressMeter:setScaledTopBottom(true, false, 34, 62)

    self:addElement(self.progressMeter)

    self.upgradeButtons = Warzone.OverclockMenuUpgradeButtons.new(menu, controller)
    self.upgradeButtons:setScaledLeftRight(true, true, 0, 0)
    self.upgradeButtons:setScaledTopBottom(true, false, 56, 138)

    self:addElement(self.upgradeButtons)

    self.overclockButton1 = Warzone.OverclockMenuButton.new(menu, controller)
    self.overclockButton1:setScaledLeftRight(false, false, -228.5, -188.5)
    self.overclockButton1:setScaledTopBottom(true, false, 76, 98)
    self.overclockButton1.index = 1

    Wzu.SetElementModel_Create(self.overclockButton1, controller, "overclockTree", "1")

    self:addElement(self.overclockButton1)

    self.overclockButton2 = Warzone.OverclockMenuButton.new(menu, controller)
    self.overclockButton2:setScaledLeftRight(false, false, -20, 20)
    self.overclockButton2:setScaledTopBottom(true, false, 76, 98)
    self.overclockButton2.index = 2

    Wzu.SetElementModel_Create(self.overclockButton2, controller, "overclockTree", "2")

    self:addElement(self.overclockButton2)

    self.overclockButton3 = Warzone.OverclockMenuButton.new(menu, controller)
    self.overclockButton3:setScaledLeftRight(false, true, -120, -80)
    self.overclockButton3:setScaledTopBottom(true, false, 76, 98)
    self.overclockButton3.index = 3

    Wzu.SetElementModel_Create(self.overclockButton3, controller, "overclockTree", "3")

    self:addElement(self.overclockButton3)

    self.overclockButton1.navigation = {right = self.overclockButton2}
    self.overclockButton2.navigation = {left = self.overclockButton1, right = self.overclockButton3}
    self.overclockButton3.navigation = {left = self.overclockButton2}

    CoD.Menu.AddNavigationHandler(menu, menu, controller)

    self.overclockButton1.id = "overclockButton1"
    self.overclockButton2.id = "overclockButton2"
    self.overclockButton3.id = "overclockButton3"

    self:registerEventHandler("gain_focus", function(sender, event)
        if sender.m_focusable then
            local overclocks = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentWeapon.weaponOverclocks"))
            if overclocks and overclocks < 3 then
                if sender["overclockButton" .. tostring(overclocks + 1)]:processEvent(event) then
                    return true
                end
            elseif sender.overclockButton1:processEvent(event) then
                return true
            end
        end
        return LUI.UIElement.gainFocus(sender, event)
    end)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end