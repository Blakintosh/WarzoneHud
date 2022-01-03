require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menutitle")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenuweaponinfo")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenuupgrades")

Warzone.OverclockMenuHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuHighResContainer)
    self.id = "OverclockMenuHighResContainer"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    --[[self:makeFocusable()
    self.onlyChildrenFocusable = true]]
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    -- Title bar
    self.title = Warzone.MenuTitle.new(menu, controller)
    self.title:setScaledLeftRight(true, false, 0, 150)
    self.title:setScaledTopBottom(true, false, 26, 64)
    self.title.title:setText(Engine.Localize("Overclock Weapon"))

    self:addElement(self.title)

    self.weaponInfo = Warzone.OverclockMenuWeaponInfo.new(menu, controller)
    self.weaponInfo:setScaledLeftRight(true, true, 60, -60)
    self.weaponInfo:setScaledTopBottom(true, false, 100, 160)

    self:addElement(self.weaponInfo)

    self.upgrades = Warzone.OverclockMenuUpgrades.new(menu, controller)
    self.upgrades:setScaledLeftRight(true, true, -40, 40)
    self.upgrades:setScaledTopBottom(true, false, 205, 400)

    self:addElement(self.upgrades)

    self:registerEventHandler("record_curr_focused_elem_id", function(self, event)
        Blak.DebugUtils.Log("Curr focus: "..self.id)
        return LUI.UIElement.RecordCurrFocusedElemID(self, event)
    end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.title:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end