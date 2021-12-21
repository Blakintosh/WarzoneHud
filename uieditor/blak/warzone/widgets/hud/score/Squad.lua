require("ui.uieditor.blak.warzone.widgets.hud.score.SquadPlayer")
require("ui.uieditor.blak.warzone.widgets.hud.score.SquadMate")

DataSources.ZMPlayerList = {getModel = function (controller)
	return Engine.CreateModel(Engine.GetModelForController(controller), "PlayerList")
end}

Warzone.Squad = InheritFrom(LUI.UIElement)

function Warzone.Squad.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Squad)
    self.id = "Squad"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.player = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.player:makeFocusable()
    self.player:setScaledLeftRight(true, false, 24, 279)
    self.player:setScaledTopBottom(false, true, -67, -20)
	self.player:setWidgetType(Warzone.SquadPlayer)
	self.player:setDataSource("PlayerListZM")
    
    self:addElement(self.player)

    self.player2 = Warzone.SquadMate.new(menu, controller)
    self.player2:setScaledLeftRight(true, false, 24, 219)
    self.player2:setScaledTopBottom(false, true, -112, -72)
    Wzu.SetElementModel(self.player2, controller, "ZMPlayerList", "1")
    
    self:addElement(self.player2)

    self.player3 = Warzone.SquadMate.new(menu, controller)
    self.player3:setScaledLeftRight(true, false, 24, 219)
    self.player3:setScaledTopBottom(false, true, -157, -117)
    Wzu.SetElementModel(self.player3, controller, "ZMPlayerList", "2")
    
    self:addElement(self.player3)

    self.player4 = Warzone.SquadMate.new(menu, controller)
    self.player4:setScaledLeftRight(true, false, 24, 219)
    self.player4:setScaledTopBottom(false, true, -202, -162)
    Wzu.SetElementModel(self.player4, controller, "ZMPlayerList", "3")
    
    self:addElement(self.player4)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.player:close()
        Sender.player2:close()
        Sender.player3:close()
        Sender.player4:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end