require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipWeapon")
require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipVision")
require("ui.uieditor.blak.warzone.widgets.vehicles.gunship.GunshipCrosshair")

Warzone.GunshipHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.GunshipHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.GunshipHighResContainer)
    self.id = "GunshipHighResContainer"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true
    
    -- Top right
	self.killstreakLabel = Util.TextElement(Util.Fonts.KillstreakRegular, Util.Swatches.HUDMain, false)
    self.killstreakLabel:setScaledLeftRight(false, true, -310, -100)
    self.killstreakLabel:setScaledTopBottom(true, false, 80, 92)
    self.killstreakLabel:setText("AC-130 ONLINE")

    self:addElement(self.killstreakLabel)

	-- Top left
	self.visionLabel = Warzone.GunshipVision.new(menu, controller)
	self.visionLabel:setScaledLeftRight(true, false, 100, 400)
	self.visionLabel:setScaledTopBottom(true, false, 70, 114)

	self:addElement(self.visionLabel)

	-- Weapons
	self.weapons = LUI.UIList.new(menu, controller, 0, 0, nil, false, false, false, 0, 0, false, false)
	self.weapons:setScaledLeftRight(true, false, 490, 790)
	self.weapons:setScaledTopBottom(true, false, 550, 650)
	self.weapons:setWidgetType(Warzone.GunshipWeapon)
	self.weapons:setDataSource("GunshipWeapons")
	self.weapons:setHorizontalCount(3)

	self.weapons:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "ac130datasourcerefresh"), function(ModelRef)
		self.weapons:updateDataSource()
	end)

	self:addElement(self.weapons)

	self.crosshair = Warzone.GunshipCrosshair.new(menu, controller)
	self.crosshair:setScaledLeftRight(false, false, -300, 300)
	self.crosshair:setScaledTopBottom(true, false, 100, 620)

	self:addElement(self.crosshair)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        --self.weapons:close()
        self.crosshair:close()
        self.visionLabel:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end