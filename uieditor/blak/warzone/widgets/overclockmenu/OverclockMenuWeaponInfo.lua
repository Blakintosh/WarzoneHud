require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenutier")

Warzone.OverclockMenuWeaponInfo = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuWeaponInfo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuWeaponInfo)
    self.id = "OverclockMenuWeaponInfo"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.title = Util.TextElement(Util.Fonts.MainBold, Util.Swatches.HUDMain, false)
    self.title:setScaledLeftRight(true, false, 0, 200)
    self.title:setScaledTopBottom(true, false, 0, 18)
    self.title:setText("YOUR WEAPON")

    self:addElement(self.title)

    self.weaponName = Util.TextElement(Util.Fonts.MainLight, Util.Swatches.HUDMain, false)
    self.weaponName:setScaledLeftRight(true, false, 0, 200)
    self.weaponName:setScaledTopBottom(true, false, 22, 56)

    Util.SubscribeToText(self.weaponName, controller, "currentWeapon.rootWeaponName")

    self:addElement(self.weaponName)

    self.tiersInfo = Warzone.OverclockMenuTier.new(menu, controller)
    self.tiersInfo:setScaledLeftRight(false, true, -330, 0)
    self.tiersInfo:setScaledTopBottom(true, false, 0, 52)

    self:addElement(self.tiersInfo)

    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end