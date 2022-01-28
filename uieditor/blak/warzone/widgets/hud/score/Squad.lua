require("ui.uieditor.blak.warzone.widgets.hud.score.SquadPlayer")
require("ui.uieditor.blak.warzone.widgets.hud.score.SquadMate")
require("ui.uieditor.blak.warzone.widgets.hud.score.PlusPoints")

DataSources.ZMPlayerList = {getModel = function (controller)
	return Engine.CreateModel(Engine.GetModelForController(controller), "PlayerList")
end}

Warzone.Squad = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    for clientNum = 0, 4 - 1, 1 do
        Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "PlayerList"), "client" .. clientNum), "health")
    end
end

local CreateNewPlusPointsElement = function ( element, score, controller, menu, small, table )
	if score == 0 or score < -10000 or score > 10000 then
		return
	end

    

    local newPlusPointsElement = Warzone.PlusPoints.new(menu, controller)
    newPlusPointsElement:setScaledLeftRight(true, false, 0, 200)
    newPlusPointsElement:setScaledTopBottom(true, true, 0, 0)
    newPlusPointsElement.label:setText("50")

	newPlusPointsElement.scoreEmitterInfo = table

	if score > 0 then
		newPlusPointsElement.label:setText( "+" .. score )
		newPlusPointsElement:playClip( "DefaultClip" )
	else
		newPlusPointsElement.label:setText( score )
		newPlusPointsElement:playClip( "DefaultClip" )
	end

	--[[newPlusPointsElement:setLeftRight( element:getLocalLeftRight() )
	newPlusPointsElement:setTopBottom( element:getLocalTopBottom() )]]

	--[[if not newPlusPointsElement:hasClip( "Anim" .. element.lastAnim ) then
		element.lastAnim = 1
	end]]

	--local parent = element:getParent()
	element:addElement( newPlusPointsElement )

	--newPlusPointsElement:playClip( "Anim" .. element.lastAnim )
end

local PostLoadFunc = function ( self, controller, menu )
	local scoreAwards = {
		damage = 10,
		death_normal = 50,
		death_torso = 60,
		death_neck = 70,
		death_head = 100,
		death_melee = 130
	}

	CoD.perController[controller].scoreEmitterCount = {}
	
	for index = 0, 3, 1 do
		local playerIdx = index

		local element = self["player" .. playerIdx].plusPoints
		--element:setAlpha( 0 )
		element.lastAnim = 0

		CoD.perController[controller].scoreEmitterCount[playerIdx] = {}
		CoD.perController[controller].scoreEmitterCount[playerIdx].delayed = 0
		CoD.perController[controller].scoreEmitterCount[playerIdx].instant = 0

		local clientNum = Engine.GetModel( Engine.GetModelForController( controller ), "PlayerList." .. playerIdx .. ".clientNum" )

		if clientNum then
			clientNum = Engine.GetModelValue( clientNum )
		end

		if clientNum ~= nil then
			local client = Engine.GetModel( Engine.GetModelForController( controller ), "PlayerList.client" .. clientNum )

			if client ~= nil then
				for key, value in pairs( scoreAwards ) do
					element:registerEventHandler( "delayed_score", function ( element, event )
						CreateNewPlusPointsElement( element, event.score, controller, menu, playerIdx > 0, {
							controller = controller,
							index = playerIdx,
							type = "delayed"
						} )
					end )

					element:subscribeToModel( Engine.CreateModel( client, "score_cf_" .. key ), function ( modelRef )
						if Engine.GetModelValue( modelRef ) ~= nil then
							local score = value

							local doublePointsStatus = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.doublePointsActive" )

							if doublePointsStatus ~= nil and Engine.GetModelValue( doublePointsStatus ) == 1 then
								score = value * 2
							end

							if element.accountedForScore ~= nil then
								element.accountedForScore = element.accountedForScore + score
							end

							if true then
								CoD.perController[controller].scoreEmitterCount[playerIdx].delayed = CoD.perController[controller].scoreEmitterCount[playerIdx].delayed + 1
								self:addElement( LUI.UITimer.new( 16 * Engine.GetModelValue( modelRef ) % 3, {
									name = "delayed_score",
									score = score
								}, true, element ) )
							end
						end
					end )
				end
			end
		end

		local client = Engine.GetModel( Engine.GetModelForController( controller ), "PlayerList." .. playerIdx .. ".playerScore" )

		element.accountedForScore = Engine.GetModelValue( client )

		element:subscribeToModel( client, function ( modelRef )
			local modelValue = Engine.GetModelValue( modelRef )

			if element.accountedForScore == nil then
				element.accountedForScore = modelValue
			end

			if modelValue ~= element.accountedForScore then
				if true then
					CoD.perController[controller].scoreEmitterCount[playerIdx].instant = CoD.perController[controller].scoreEmitterCount[playerIdx].instant + 1
					CreateNewPlusPointsElement( element, modelValue - element.accountedForScore, controller, menu, playerIdx > 0, {
						controller = controller,
						index = playerIdx,
						type = "instant"
					} )
				end

				element.accountedForScore = modelValue
			end
		end )
	end

	Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.doublePointsActive" )
end

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

    --[[self.player0 = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
	self.player0:makeFocusable()
    self.player0:setScaledLeftRight(true, false, 24, 279)
    self.player0:setScaledTopBottom(false, true, -67, -20)
	self.player0:setWidgetType(Warzone.SquadPlayer)
	self.player0:setDataSource("PlayerListZM")
    
    self:addElement(self.player0)]]

    self.player0 = Warzone.SquadPlayer.new(menu, controller)
    self.player0:setScaledLeftRight(true, false, 24, 279)
    self.player0:setScaledTopBottom(false, true, -67, -20)
    Wzu.SetElementModel(self.player0, controller, "ZMPlayerList", "0")
    
    self:addElement(self.player0)

    self.player1 = Warzone.SquadMate.new(menu, controller)
    self.player1:setScaledLeftRight(true, false, 24, 219)
    self.player1:setScaledTopBottom(false, true, -112, -72)
    Wzu.SetElementModel(self.player1, controller, "ZMPlayerList", "1")
    
    self:addElement(self.player1)

    self.player2 = Warzone.SquadMate.new(menu, controller)
    self.player2:setScaledLeftRight(true, false, 24, 219)
    self.player2:setScaledTopBottom(false, true, -157, -117)
    Wzu.SetElementModel(self.player2, controller, "ZMPlayerList", "2")
    
    self:addElement(self.player2)

    self.player3 = Warzone.SquadMate.new(menu, controller)
    self.player3:setScaledLeftRight(true, false, 24, 219)
    self.player3:setScaledTopBottom(false, true, -202, -162)
    Wzu.SetElementModel(self.player3, controller, "ZMPlayerList", "3")
    
    self:addElement(self.player3)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.player0:close()
        Sender.player1:close()
        Sender.player2:close()
        Sender.player3:close()
    end)
    
    if PostLoadFunc then
        SafeCall(function()
        PostLoadFunc(self, controller, menu)
        end)
    end
    
    return self
end