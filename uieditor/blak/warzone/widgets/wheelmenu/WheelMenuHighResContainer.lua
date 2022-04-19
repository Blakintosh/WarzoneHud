require("ui.uieditor.blak.warzone.widgets.wheelmenu.WheelButton")

Warzone.WheelMenuHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.WheelMenuHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WheelMenuHighResContainer)
    self.id = "WheelMenuHighResContainer"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true
    self:makeFocusable()
    self.onlyChildrenFocusable = true
    
	self.innerBg = LUI.UIImage.new()
	self.innerBg:setScaledLeftRight(false, false, -170, 170)
	self.innerBg:setScaledTopBottom(false, false, -170, 170)
	self.innerBg:setImage(RegisterImage("radial_inner_base"))
	Util.SetRGBFromTable(self.innerBg, Util.Colors.Black)
	self.innerBg:setAlpha(0.7)

	self:addElement(self.innerBg)

	self.wheelButton1 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton1.id = "wheelButton1"
	self.wheelButton1:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton1:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton1:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.1"), controller)
	self.wheelButton1:setWheelRotation(0)

	self:addElement(self.wheelButton1)

	self.wheelButton2 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton2.id = "wheelButton2"
	self.wheelButton2:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton2:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton2:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.2"), controller)
	self.wheelButton2:setWheelRotation(45)

	self:addElement(self.wheelButton2)

	self.wheelButton3 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton3.id = "wheelButton3"
	self.wheelButton3:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton3:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton3:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.3"), controller)
	self.wheelButton3:setWheelRotation(90)

	self:addElement(self.wheelButton3)

	self.wheelButton4 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton4.id = "wheelButton4"
	self.wheelButton4:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton4:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton4:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.4"), controller)
	self.wheelButton4:setWheelRotation(135)

	self:addElement(self.wheelButton4)

	self.wheelButton5 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton5.id = "wheelButton5"
	self.wheelButton5:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton5:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton5:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.5"), controller)
	self.wheelButton5:setWheelRotation(180)

	self:addElement(self.wheelButton5)

	self.wheelButton6 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton6.id = "wheelButton6"
	self.wheelButton6:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton6:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton6:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.6"), controller)
	self.wheelButton6:setWheelRotation(225)

	self:addElement(self.wheelButton6)

	self.wheelButton7 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton7.id = "wheelButton7"
	self.wheelButton7:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton7:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton7:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.7"), controller)
	self.wheelButton7:setWheelRotation(270)

	self:addElement(self.wheelButton7)

	self.wheelButton8 = Warzone.WheelButton.new(menu, controller)
	self.wheelButton8.id = "wheelButton8"
	self.wheelButton8:setScaledLeftRight(false, false, -170, 170)
	self.wheelButton8:setScaledTopBottom(false, false, -170, 170)
	self.wheelButton8:setModel(Engine.GetModel(Engine.GetModelForController(controller), "WheelMenu.WheelMenuOptions.8"), controller)
	self.wheelButton8:setWheelRotation(315)

	self:addElement(self.wheelButton8)
    
	self.arrow = LUI.UIImage.new()
	self.arrow:setScaledLeftRight(false, false, -166, 166)
	self.arrow:setScaledTopBottom(false, false, -166, 166)
	self.arrow:setImage(RegisterImage("radial_select_arrow"))
	Util.SetRGBFromTable(self.arrow, Util.Colors.CodeLightBlue)

	self.arrow:registerEventHandler("mousemove", function(sender, event)
		local x, y = ProjectRootCoordinate(event.rootName, event.x, event.y)
		local root = event.root
		if not root then
			root = LUI.roots[event.rootName]
		end
		local unitX, unitY = root:pixelsToUnits(x, y)
		if unitX ~= nil and unitY ~= nil then
			local offsetFromCentreX = unitX - 640
			local offsetFromCentreY = unitY - 360

			local angle = 90 + math.deg(math.atan2(offsetFromCentreY, offsetFromCentreX))
			self.arrow:setZRot(-angle)
		end
	end)

	self:addElement(self.arrow)
    
	self.selectLine = LUI.UIImage.new()
	self.selectLine:setScaledLeftRight(false, false, -166, 166)
	self.selectLine:setScaledTopBottom(false, false, -166, 166)
	self.selectLine:setImage(RegisterImage("radial_select_line"))

	self:addElement(self.selectLine)

	self.label = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.ButtonTextFocus, true)
	self.label:setScaledLeftRight(false, false, -100, 100)
	self.label:setScaledTopBottom(false, false, -9, 7)
	self.label:setText("Flashlight")

	Util.SubscribeToText(self.label, controller, "WheelMenu.focusedName")

	Util.AddShadowedElement(self, self.label)

	self.wheelButton1.navigation = {
		left = self.wheelButton8,
		right = self.wheelButton2
	}
	self.wheelButton2.navigation = {
		left = self.wheelButton1,
		down = self.wheelButton3
	}
	self.wheelButton3.navigation = {
		up = self.wheelButton3,
		down = self.wheelButton4
	}
	self.wheelButton4.navigation = {
		up = self.wheelButton4,
		left = self.wheelButton5
	}
	self.wheelButton5.navigation = {
		right = self.wheelButton4,
		left = self.wheelButton6
	}
	self.wheelButton6.navigation = {
		right = self.wheelButton5,
		up = self.wheelButton7
	}
	self.wheelButton7.navigation = {
		down = self.wheelButton6,
		up = self.wheelButton8
	}
	self.wheelButton8.navigation = {
		down = self.wheelButton7,
		right = self.wheelButton1
	}

	CoD.Menu.AddNavigationHandler( menu, self, controller )

    self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.wheelButton1:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.wheelButton1:close()
        self.wheelButton2:close()
        self.wheelButton3:close()
        self.wheelButton4:close()
        self.wheelButton5:close()
        self.wheelButton6:close()
        self.wheelButton7:close()
        self.wheelButton8:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    
    return self
end