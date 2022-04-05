require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menutitle")

Warzone.StartMenu_OptionsHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.StartMenu_OptionsHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.StartMenu_OptionsHighResContainer)
    self.id = "StartMenu_OptionsHighResContainer"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true
    --[[self:makeFocusable()
    self.onlyChildrenFocusable = true]]
    
    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    self.bg = LUI.UIImage.new()
    self.bg:setScaledLeftRight(true, true, 0, 0)
    self.bg:setScaledTopBottom(true, true, 0, 0)
    self.bg:setRGB(0, 0, 0)
    self.bg:setAlpha(0.5)

    self:addElement(self.bg)

    -- Title bar
    self.title = Warzone.MenuTitle.new(menu, controller)
    self.title:setScaledLeftRight(true, false, 0, 150)
    self.title:setScaledTopBottom(true, false, 26, 64)
    self.title.title:setText(Engine.Localize("WZMENU_OPTIONS_GAME_CAPS"))

    self:addElement(self.title)

    self.footer = Warzone.MenuFooter.new(menu, controller)
    self.footer:setScaledLeftRight(true, true, 0, 0)
    self.footer:setScaledTopBottom(false, true, -48, 0)

    self:addElement(self.footer)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.title:close()
        self.footer:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end