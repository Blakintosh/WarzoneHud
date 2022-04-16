--require("ui.uieditor.SubscriptionUtils")
require("ui.uieditor.blak.warzone.widgets.ui3d.tablet.KillstreakTabletUI3D")

Warzone.KillstreakTablet = InheritFrom(LUI.UIElement)

local function PreLoadFunc(self, controller)
    self:setupReticle(controller)
end

function Warzone.KillstreakTablet.new(menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(Warzone.KillstreakTablet)
	self.id = "KillstreakTablet"
	self.soundSet = "HUD"
	self:setLeftRight(true, false, 0.000000, 1024.000000)
	self:setTopBottom(true, false, 0.000000, 790.000000)
	self.anyChildUsesUpdateState = true
    
    self.ui3d = Warzone.KillstreakTabletUI3D.new(menu, controller)
    self.ui3d:setLeftRight(true, true, 0, 0)
    self.ui3d:setTopBottom(true, true, 0, 0)
    
    Engine.SetupUI3DWindow(controller, 3.000000, 1024.000000, 790.000000)
	self.ui3d:setUI3DWindow(3.000000)
    
    self.ui3d:subscribeToGlobalModel(controller, "CurrentWeapon", nil, function(ModelRef)
        self.ui3d:setModel(ModelRef, controller)
    end)
    
    self:addElement(self.ui3d)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(sender)
        sender.ui3d:close()
    end)
    
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end