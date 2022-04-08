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
    self:makeFocusable()
    self.onlyChildrenFocusable = true
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    -- Title bar
    self.title = Warzone.MenuTitle.new(menu, controller)
    self.title:setScaledLeftRight(true, false, 0, 150)
    self.title:setScaledTopBottom(true, false, 86, 124)
    self.title.title:setText(Engine.Localize("Overclock Weapon"))

    self:addElement(self.title)

    self.score = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.score:setScaledLeftRight(false, true, -150, -60)
    self.score:setScaledTopBottom(true, false, 90, 124)
    self.score:setText("$1200")

    Wzu.Subscribe(self.score, controller, "PlayerList.0.playerScore", function(modelValue)
        self.score:setText("$" .. Engine.Localize(modelValue))
    end)

    self:addElement(self.score)

    self.weaponInfo = Warzone.OverclockMenuWeaponInfo.new(menu, controller)
    self.weaponInfo:setScaledLeftRight(true, true, 60, -60)
    self.weaponInfo:setScaledTopBottom(true, false, 160, 220)

    self:addElement(self.weaponInfo)

    self.upgrades = Warzone.OverclockMenuUpgrades.new(menu, controller)
    self.upgrades:setScaledLeftRight(true, true, -40, 40)
    self.upgrades:setScaledTopBottom(true, false, 265, 460)

    self.upgrades.id = "upgrades"

    self:addElement(self.upgrades)
	
    self.buttons = Warzone.MenuFooterPrompts.new(menu, controller)
	self.buttons:setScaledLeftRight(true, true, 0, 0)
	self.buttons:setScaledTopBottom(true, false, 399, 443)

    self.buttons:registerEventHandler("menu_loaded", function(sender, event)
        self.buttons:setModel(menu.buttonModel, controller)
    end)

	self:addElement(self.buttons)

    self:registerEventHandler("gain_focus", function(sender, event)
        if sender.m_focusable then
            if sender.upgrades:processEvent(event) then
                return true
            end
        end
        return LUI.UIElement.gainFocus(sender, event)
    end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.title:close()
        self.upgrades:close()
        self.weaponInfo:close()
        self.buttons:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end