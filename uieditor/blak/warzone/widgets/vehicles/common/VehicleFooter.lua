require("ui.uieditor.blak.warzone.widgets.userinterface.layout.MenuFooterPrompts")

Warzone.VehicleFooter = InheritFrom(LUI.UIElement)

function Warzone.VehicleFooter.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.VehicleFooter)
    self.id = "VehicleFooter"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.bg = LUI.UIImage.new()
    self.bg:setScaledLeftRight(true, true, 0, 0)
    self.bg:setScaledTopBottom(false, true, -48, 0)
    self.bg:setAlpha(0.2)
    self.bg:setRGB(0, 0, 0)

    self:addElement(self.bg)

    self.buttonPrompts = Warzone.MenuFooterPrompts.new(menu, controller)
    self.buttonPrompts:setScaledLeftRight(true, false, 76, 1076)
    self.buttonPrompts:setScaledTopBottom(false, false, -11, 11)
    
    self:addElement(self.buttonPrompts)

    self:registerEventHandler("menu_loaded", function(sender, event)
        self.buttonPrompts:setModel(menu.buttonModel, controller)
    end)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function (Sender)
		Sender.buttonPrompts:close()
	end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end