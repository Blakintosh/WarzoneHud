require("ui.uieditor.SubscriptionUtils")
--require("ui.uieditor.widgets.blak.mw19.common.mw19cornerwidget")

Warzone.KillstreakTabletUI3D = InheritFrom(LUI.UIElement)

function Warzone.KillstreakTabletUI3D.new(menu, controller)
	local self = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end
	self:setUseStencil(false)
	self:setClass(Warzone.KillstreakTabletUI3D)
	self.id = "KillstreakTabletUI3D"
	self.soundSet = "HUD"
	self:setLeftRight(true, false, 0.000000, 1024.000000)
	self:setTopBottom(true, false, 0.000000, 790.000000)
	self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setLeftRight(true, true, 0, 0)
    self.background:setTopBottom(false, false, -512, 512)
    self.background:setImage(RegisterImage("hud_tablet_killstreak_background"))

    self:addElement(self.background)

    self.GlowT = LUI.UIImage.new()
    self.GlowT:setLeftRight(false, false, -512, 512)
    self.GlowT:setTopBottom(true, false, 104, 116)
    self.GlowT:setImage(RegisterImage("hud_glow"))
    self.GlowT:setRGB(0.6, 0.75, 0.9)

    self:addElement(self.GlowT)

    self.GlowB = LUI.UIImage.new()
    self.GlowB:setLeftRight(false, false, -512, 512)
    self.GlowB:setTopBottom(false, true, -96, -84)
    self.GlowB:setImage(RegisterImage("hud_glow"))
    self.GlowB:setRGB(0.6, 0.75, 0.9)

    self:addElement(self.GlowB)

    --[[self.CornerTL = CoD.MW19CornerWidget.new(menu, controller)
    self.CornerTL:setLeftRight(true, false, 80, 138)
    self.CornerTL:setTopBottom(true, false, 110, 168)

    self:addElement(self.CornerTL)

    self.CornerTR = CoD.MW19CornerWidget.new(menu, controller)
    self.CornerTR:setLeftRight(false, true, -138, -80)
    self.CornerTR:setTopBottom(true, false, 110, 168)
    self.CornerTR:setZRot(-90)

    self:addElement(self.CornerTR)

    self.CornerBR = CoD.MW19CornerWidget.new(menu, controller)
    self.CornerBR:setLeftRight(false, true, -138, -80)
    self.CornerBR:setTopBottom(false, true, -148, -90)
    self.CornerBR:setZRot(180)

    self:addElement(self.CornerBR)

    self.CornerBL = CoD.MW19CornerWidget.new(menu, controller)
    self.CornerBL:setLeftRight(true, false, 80, 138)
    self.CornerBL:setTopBottom(false, true, -148, -90)
    self.CornerBL:setZRot(90)

    self:addElement(self.CornerBL)]]

    self.ksIcon = LUI.UIImage.new()
    self.ksIcon:setLeftRight(false, false, -256, 256)
    self.ksIcon:setTopBottom(false, false, -256, 256)
    --Widget.ksIcon:setImage()
    self.ksIcon:setRGB(0.3, 0.6, 0.8)

    self.ksIcon:linkToElementModel(self, "tabletStreakIcon", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.ksIcon:setImage(RegisterImage(ModelVal))
        end
    end)

    self:addElement(self.ksIcon)

    self.button = LUI.UIImage.new()
    self.button:setLeftRight(false, true, -512, 0)
    self.button:setTopBottom(false, true, -148, -20)
    self.button:setImage(RegisterImage("hud_tablet_killstreak_button"))

    self:addElement(self.button)

    self.launch = LUI.UIText.new()
    self.launch:setLeftRight(false, true, -250, -180)
    self.launch:setTopBottom(true, false, 680, 728)
    self.launch:setText("LAUNCH")
    self.launch:setRGB(0.65, 0.8, 0.95)
    self.launch:setTTF("fonts/main_regular.ttf")

    self:addElement(self.launch)

    self.label = LUI.UIText.new()
    self.label:setLeftRight(false, false, -100, 100)
    self.label:setTopBottom(true, false, 30, 70)
    self.label:setText("Cheddar Cheese, Ain't My Lover")
    self.label:setTTF("fonts/main_regular.ttf")
    self.label:setRGB(0.95, 0.95, 0.95)

    self.label:linkToElementModel(self, "tabletStreakName", true, function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            self.label:setText(Engine.Localize(ModelVal))
        end
    end)

    self:addElement(self.label)

    self.telemetry = LUI.UIImage.new()
    self.telemetry:setLeftRight(true, false, 20, 492)
    self.telemetry:setTopBottom(false, true, -168, -40)
    self.telemetry:setImage(RegisterImage("hud_tablet_killstreak_blue_tab_texture"))

    self:addElement(self.telemetry)

    self.grid = LUI.UIImage.new()
    self.grid:setLeftRight(true, true, 0, 0)
    self.grid:setTopBottom(true, true, 0, 0)
    self.grid:setImage(RegisterImage("hud_tablet_killstreak_blue_grid"))

    self:addElement(self.grid)
    
    --[[Widget.clipsPerState = ({
        DefaultState = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)
                
                Widget.ammoText:completeAnimation()
                Widget.ammoText:setRGB(0.412, 0.757, 0.808)
                
                Widget.clipFinished(Widget.ammoText, {})
                
                Widget.ammoTextFlicker:completeAnimation()
                Widget.ammoTextFlicker:setAlpha(0)
                
                Widget.clipFinished(Widget.ammoTextFlicker, {})
            end
        },
        MidAmmo = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)
                
                Widget.ammoText:completeAnimation()
                Widget.ammoText:setRGB(0.753, 0.427, 0.114)
                
                Widget.clipFinished(Widget.ammoText, {})
                
                Widget.ammoTextFlicker:completeAnimation()
                Widget.ammoTextFlicker:setAlpha(0)
                
                Widget.clipFinished(Widget.ammoTextFlicker, {})
            end
        },
        LowAmmo = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)
                
                Widget.ammoText:completeAnimation()
                Widget.ammoText:setRGB(0.808, 0.192, 0.161)
                
                Widget.clipFinished(Widget.ammoText, {})
                
                Widget.ammoTextFlicker:completeAnimation()
                Widget.ammoTextFlicker:setAlpha(0)
                
                Widget.clipFinished(Widget.ammoTextFlicker, {})
            end
        },
        NoAmmo = {
            DefaultClip = function()
                Widget:setupElementClipCounter(2)
                
                Widget.ammoText:completeAnimation()
                Widget.ammoText:setRGB(0.808, 0.192, 0.161)
                
                Widget.clipFinished(Widget.ammoText, {})
                
                Widget.ammoTextFlicker:completeAnimation()
                
                Widget.ammoTextFlicker:beginAnimation("keyframe", 400, false, false, CoD.TweenType.Linear)
                Widget.ammoTextFlicker:setAlpha(0)
                
                Widget.ammoTextFlicker:registerEventHandler("transition_complete_keyframe", function(Element, Event)
                    if not Event.interrupted then
                        Widget.ammoTextFlicker:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
                    end
                    
                    if Event.interrupted then
                        Widget.ammoTextFlicker:setAlpha(0)
                        Widget.clipFinished(Element, Event)
                    else
                        Widget.ammoTextFlicker:setAlpha(1)
                        Element:registerEventHandler("transition_complete_keyframe", function(Element2, Event2)
                            if not Event2.interrupted then
                                Element2:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
                            end
                            Element2:setAlpha(0)
                            
                            if Event2.interrupted then
                                Widget.clipFinished(Element2, Event2)
                            else
                                Element2:registerEventHandler("transition_complete_keyframe", function(Element3, Event3)
                                    if not Event3.interrupted then
                                        PlayClip(Widget, "DefaultClip", InstanceRef)
                                    end
                                    Widget.clipFinished(Element3, Event3)
                                end)
                            end
                        end)
                    end
                end)
            end
        }
    })
    
    Widget:mergeStateConditions({
        {
            stateName = "NoAmmo",
            condition = function(Hud, Element, StateTable)
                return (Engine.GetModelValue(Engine.GetModel(Widget:getModel(), "ammoInClip")) == 0)
            end
        },
        {
            stateName = "LowAmmo",
            condition = function(Hud, Element, StateTable)
                return ( (Engine.GetModelValue(Engine.GetModel(Widget:getModel(), "ammoInClip"))/Engine.GetModelValue(Engine.GetModel(Widget:getModel(), "clipMaxAmmo"))) <= 0.2)
            end
        },
        {
            stateName = "MidAmmo",
            condition = function(Hud, Element, StateTable)
                return ( (Engine.GetModelValue(Engine.GetModel(Widget:getModel(), "ammoInClip"))/Engine.GetModelValue(Engine.GetModel(Widget:getModel(), "clipMaxAmmo"))) <= 0.6)
            end
        }
    })
    
    LinkToElementModelAndUpdateState(HudRef, Widget, "ammoInClip", true)
    LinkToElementModelAndUpdateState(HudRef, Widget, "weapon", true)
    
    LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function(Sender)
        Sender.ammoText:close()
        Sender.ammoTextFlicker:close()
    end)]]
    
	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end
	return self
end

