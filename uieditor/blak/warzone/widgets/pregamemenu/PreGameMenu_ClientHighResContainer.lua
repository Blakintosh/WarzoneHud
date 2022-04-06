require("ui.uieditor.blak.warzone.widgets.pregamemenu.PreGameMenuLogo")
require("ui.uieditor.blak.warzone.widgets.pregamemenu.pregamemenubutton")
require("ui.uieditor.blak.warzone.widgets.userinterface.layout.menufooter")

Warzone.PreGameMenu_ClientHighResContainer = InheritFrom(LUI.UIElement)

function Warzone.PreGameMenu_ClientHighResContainer.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.PreGameMenu_ClientHighResContainer)
    self.id = "PreGameMenu_ClientHighResContainer"
    self.soundSet = "iw8"
    self.anyChildUsesUpdateState = true

    self.logo = Warzone.PreGameMenuLogo.new(menu, controller)
    self.logo:setScaledLeftRight(true, false, 125, 451)
    self.logo:setScaledTopBottom(true, false, -9, 317)
    self.logo:setImage(RegisterImage("cust_hud_zm_karelia_logo"))
    self.logo:setRFTMaterial(LUI.UIImage.GetCachedMaterial("uie_aberration"))
	self.logo:setShaderVector(0, 0.1, 1, 0, 0)
	self.logo:setShaderVector(1, 0, 0, 0, 0)
	self.logo:setShaderVector(2, 0, 0, 0, 0)
	self.logo:setShaderVector(3, 0, 0, 0, 0)
	self.logo:setShaderVector(4, 0, 0, 0, 0)

    Wzu.ClipSequence(self, self.logo, "Default", {
        {
            duration = 0,
            setShaderVector = {0, 0, 1, 0, 0}
        },
        {
            duration = 12000,
            interpolation = Wzu.TweenGraphs.inOutSine,
            setShaderVector = {0, 0.4, 1, 0, 0}
        },
        {
            duration = 12000,
            interpolation = Wzu.TweenGraphs.inOutSine,
            setShaderVector = {0, 0, 1, 0, 0}
        }
    })

    self:addElement(self.logo)

    self.hostInfo = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.hostInfo:setScaledLeftRight(true, false, 125, 451)
    self.hostInfo:setScaledTopBottom(true, false, 188, 202)
    self.hostInfo:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    self.hostInfo:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
    self.hostInfo:setText("Please wait for the host to complete match setup.")

    Wzu.AddShadowedElement(self, self.hostInfo)

    self.buttonList = LUI.UIList.new(menu, controller, 1, 0, nil, false, false, 0, 0, false, false)
    self.buttonList:makeFocusable()
    self.buttonList.id = "buttonList"
    self.buttonList:setScaledLeftRight(true, false, 122, 422)
    self.buttonList:setScaledTopBottom(true, false, 215, 595)
    self.buttonList:setWidgetType(Warzone.PreGameMenuButton)
    self.buttonList:setVerticalCount(7)
    self.buttonList:setSpacing(8)
    self.buttonList:setDataSource("PreGameClient")

    self.buttonList:registerEventHandler("gain_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        elseif Sender.super.gainFocus then
            ReturnVal = Sender:gainFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end)

    self.buttonList:registerEventHandler("lose_focus", function(Sender, Event)
        local ReturnVal = nil
        if Sender.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        elseif Sender.super.loseFocus then
            ReturnVal = Sender:loseFocus(Event)
        end
        CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
        return ReturnVal
    end) -- Change?
    
    menu:AddButtonCallbackFunction(self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function(ItemRef, menu, controller, ParentRef)
        local ActionModelVal = Engine.GetModelValue(Engine.GetModel(ItemRef:getModel(), "action"))
        if ActionModelVal then
            menu:playSound("action")
            ActionModelVal(menu, ItemRef, controller)
        end
        return true
    end, function(ItemRef, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT")
        return true
    end, false)

    self:addElement(self.buttonList)

    self.footer = Warzone.MenuFooter.new(menu, controller)
    self.footer:setScaledLeftRight(true, true, 0, 0)
    self.footer:setScaledTopBottom(false, true, -48, 0)

    self:addElement(self.footer)

    self.mapMaker = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.mapMaker:setScaledLeftRight(false, true, -200, -16)
    self.mapMaker:setScaledTopBottom(false, true, -36, -22)

    self.mapMaker:setText("Map made by Blak: please see Credits for contributors")

    self:addElement(self.mapMaker)

    self.version = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.version:setScaledLeftRight(false, true, -200, -16)
    self.version:setScaledTopBottom(false, true, -22, -8)

    self.version:setText("Version: "..VERSION_WATERMARK)

    self:addElement(self.version)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Default", {
                    looping = true,
                    clipName = "DefaultClip"
                })
            end
        }
    }

    self:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			if Sender.buttonList:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        self.logo:close()
        self.buttonList:close()
        self.footer:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end