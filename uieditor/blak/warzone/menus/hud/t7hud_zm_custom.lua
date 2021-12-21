-- The Giant Hud Base, Rebuilt from the ground up by the D3V Team

require("ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer")
require("ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmoContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_Score.ZMScr")
require("ui.uieditor.widgets.DynamicContainerWidget")
require("ui.uieditor.widgets.Notifications.Notification")
require("ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotifBGB_ContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_CursorHint.ZMCursorHint")
require("ui.uieditor.widgets.HUD.CenterConsole.CenterConsole")
require("ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate")
require("ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr")
require("ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown")
require("ui.uieditor.widgets.Scoreboard.CP.ScoreboardWidgetCP")
require("ui.uieditor.widgets.HUD.ZM_TimeBar.ZM_BeastmodeTimeBarWidget")
require("ui.uieditor.widgets.ZMInventory.RocketShieldBluePrint.RocketShieldBlueprintWidget")
require("ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer")
require("ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame")

require("ui.uieditor.blak.warzone.utility.DebugUtils")

-- Includes for WZ Hud
require("ui.uieditor.blak.warzone.include.WarzoneIncludes")


CoD.Zombie.CommonHudRequire()

require("ui.util.T7Overcharged")

InitializeT7Overcharged({
	mapname = "zm_wz_hud",
	filespath = [[.\usermaps\zm_wz_hud\]],
	workshopid = "4672347623"
})

local function PreLoadCallback(menu, controller)
    CoD.Zombie.CommonPreLoadHud(menu, controller)
    --StartHotReload(menu, controller)
end

local function PostLoadCallback(menu, controller)
    CoD.Zombie.CommonPostLoadHud(menu, controller)
end

function LUI.createMenu.T7Hud_zm_factory(controller)
    -- TIP: LUA t7hud finding is coded such that you can call your HUD T7Hud_(zm_mapname) and it will still load. You don't need to override t7hud_zm_factory - just make sure you override all the references in here.
    -- Likewise, renaming t7hud_zm_custom to t7hud_(zm_mapname) also doesn't affect anything, just make sure to change the LUILoad call in CSC to match this

    -- Other note; you might not recognise this "menu/self/controller" naming that I'm gonna use throughout this HUD. It might look wrong, but this is what 3arc themselves use
    -- We know this because Jari decompiled the Bo3 beta scripts where variables, etc, were still named
    local menu = CoD.Menu.NewForUIEditor("T7Hud_zm_factory")
    
    if PreLoadCallback then
        PreLoadCallback(menu, controller)
    end

    T7Overcharged.RemoveUiErrorHash()

    -- Make sure that the list was not already setup, we must include the stock perks as well!
    --[[if not CoD.ZMPerksFactory then
        -- Add our perks (hudItems.perks.key = imageName) (sync with csc clientuimodel)
        CoD.ZMPerksFactory =
        {
			additional_primary_weapon = "legends_mule",
            dead_shot = "legends_deadshot",
            doubletap2 = "legends_dt",
            juggernaut = "legends_jug",
            marathon = "legends_staminup",
            quick_revive = "legends_revive",
            sleight_of_hand = "legends_speed",
            widows_wine = "legends_widows",
            electric_cherry = "legends_echerry",
            snails_pace = "legends_snails",
            slider = "legends_slider",
            directionalfire = "legends_vigor",
			wind = "legends_wind",
            madgaz_moonshine = "legends_moonshine",
            banana_colada = "legends_colada",
            bull_ice_blast = "legends_bull", 
            crusaders_ale = "legends_crusaders",
            salvage_shake = "legends_salvage",
            atomic_liqueur = "legends_atomic", 
            cryo_slide = "legends_cryo",
			ffyl = "legends_ffyl",
			icu	= "legends_icu",
			bloodwolf = "legends_bloodwolf",
            winterwail = "legends_winterwail",
            razor = "legends_razor",
            bandolier = "legends_bandolier",
            blazephase = "legends_blazephase",
            stronghold = "legends_stronghold",
            zombshell = "legends_zombshell"
        }
    end]]
    
    -- Include the new perk container, and resume normal widget usage!
    --require("ui.uieditor.widgets.hud.customperksfactory")
    
    menu.soundSet = "HUD"
    menu:setOwner(controller)
    menu:setLeftRight(true, true, 0, 0)
    menu:setTopBottom(true, true, 0, 0)
    menu:playSound("menu_open", controller)
    
    menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "T7Hud_zm_factory.buttonPrompts")
    menu.anyChildUsesUpdateState = true

    -- ===============================================================
    -- Warzone HUD
    -- ===============================================================

    -- Ammo Widget
    menu.warzoneContainer = Warzone.HighResolutionContainer.new(menu, controller)
    menu.warzoneContainer:setScale(1 / _ResolutionScalar)
    menu.warzoneContainer:setScaledLeftRight(false, false, -640, 640)
    menu.warzoneContainer:setScaledTopBottom(false, false,  -360, 360)

    menu:addElement(menu.warzoneContainer)

    --[[local PerksWidget = CoD.ZMPerksContainerFactory.new(menu, controller)
    PerksWidget:setLeftRight(true, false, 130.000000, 281.000000)
    PerksWidget:setTopBottom(false, true, -62.000000, -26.000000)
	
	PerksWidget.ZMPerksContainerFactory.PerkList:setHorizontalCount(10)
    PerksWidget.ZMPerksContainerFactory.PerkList:setVerticalCount(3)
    
    menu:addElement(PerksWidget)
    menu.ZMPerksContainerFactory = PerksWidget]]
    
    --[[local RoundCounter = CoD.ZmRndContainer.new(menu, controller)
    RoundCounter:setLeftRight(true, false, -32.000000, 192.000000)      -- AnchorLeft, AnchorRight, Left, Right
    RoundCounter:setTopBottom(false, true, -174.000000, 18.000000)   -- AnchorTop, AnchorBottom, Top, Bottom
    RoundCounter:setScale(0.8)  -- Scale (Of 1.0)
    
    menu:addElement(RoundCounter)
    menu.Rounds = RoundCounter]]
    
    local ScoreWidget = CoD.ZMScr.new(menu, controller)
    ScoreWidget:setLeftRight(true, false, 30.000000, 164.000000)
    ScoreWidget:setTopBottom(false, true, -256.000000, -128.000000)
    ScoreWidget:setYRot(30.000000)
    
    local function HudStartScore(Unk1, Unk2, Unk3)
        if IsModelValueTrue(controller, "hudItems.playerSpawned") and
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) and not
        Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) then
            return true
        else
            return false
        end
    end
    
    ScoreWidget:mergeStateConditions({{stateName = "HudStart", condition = HudStartScore}})
    
    local function PlayerSpawnCallback(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "hudItems.playerSpawned"})
    end
    
    local function MergeBitVisible(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation", 
            menu = menu, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
    end
    
    local function MergeBitWeapon(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE})
    end
    
    local function MergeBitHardcore(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
    end
    
    local function MergeBitEndGame(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED})
    end
    
    local function MergeBitDemoMovie(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM})
    end
    
    local function MergeBitDemoHidden(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN})
    end
    
    local function MergeBitInKillcam(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM})
    end
    
    local function MergeBitFlash(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
    end
    
    local function MergeBitActive(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
    end
    
    local function MergeBitScoped(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED})
    end
    
    local function MergeBitVehicle(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE})
    end
    
    local function MergeBitMissile(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
    end
    
    local function MergeBitBoardOpen(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
    end
    
    local function MergeBitStaticKill(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC})
    end
    
    local function MergeBitEmpActive(ModelRef)
        menu:updateElementState(ScoreWidget, {name = "model_validation",
            menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE})
    end
    
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "hudItems.playerSpawned"), PlayerSpawnCallback)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), MergeBitVisible)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE), MergeBitWeapon)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), MergeBitHardcore)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), MergeBitEndGame)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), MergeBitDemoMovie)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), MergeBitDemoHidden)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM), MergeBitInKillcam)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), MergeBitFlash)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), MergeBitActive)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), MergeBitScoped)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), MergeBitVehicle)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), MergeBitMissile)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), MergeBitBoardOpen)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), MergeBitStaticKill)
    ScoreWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), MergeBitEmpActive)
    
    --menu:addElement(ScoreWidget)
    menu.Score = ScoreWidget
    
    local DynaWidget = CoD.DynamicContainerWidget.new(menu, controller)
    DynaWidget:setLeftRight(false, false, -640.000000, 640.000000)
    DynaWidget:setTopBottom(false, false, -360.000000, 360.000000)
    
    menu:addElement(DynaWidget)
    menu.fullscreenContainer = DynaWidget
    
    local NotificationWidget = CoD.Notification.new(menu, controller)
    NotificationWidget:setLeftRight(true, true, 0.000000, 0.000000)
    NotificationWidget:setTopBottom(true, true, 0.000000, 0.000000)
    
    menu:addElement(NotificationWidget)
    menu.Notifications = NotificationWidget
    
    local GumWidget = CoD.ZmNotifBGB_ContainerFactory.new(menu, controller)
    GumWidget:setLeftRight(false, false, -156.000000, 156.000000)
    GumWidget:setTopBottom(true, false, -6.000000, 247.000000)
    GumWidget:setScale(0.750000)
    
    local function GumCallback(ModelRef)
        if IsParamModelEqualToString(ModelRef, "zombie_bgb_token_notification") then
            AddZombieBGBTokenNotification(menu, GumWidget, controller, ModelRef) -- Add a popup for a 'free hit'
        elseif IsParamModelEqualToString(ModelRef, "zombie_bgb_notification") then
            AddZombieBGBNotification(menu, GumWidget, ModelRef) -- Add a popup for the gum you got
        elseif IsParamModelEqualToString(ModelRef, "zombie_notification") then
            AddZombieNotification(menu, GumWidget, ModelRef) -- Add a popup for a powerup
        end
    end
    
    GumWidget:subscribeToGlobalModel(controller, "PerController", "scriptNotify", GumCallback)
    
    menu:addElement(GumWidget)
    menu.ZmNotifBGBContainerFactory = GumWidget
    
    local CenterCon = CoD.CenterConsole.new(menu, controller)
    CenterCon:setLeftRight(false, false, -370.000000, 370.000000)
    CenterCon:setTopBottom(true, false, 68.500000, 166.500000)
    
    menu:addElement(CenterCon)
    menu.ConsoleCenter = CenterCon
    
    local DeadOverlay = CoD.DeadSpectate.new(menu, controller)
    DeadOverlay:setLeftRight(false, false, -150.000000, 150.000000)
    DeadOverlay:setTopBottom(false, true, -180.000000, -120.000000)
    
    menu:addElement(DeadOverlay)
    menu.DeadSpectate = DeadOverlay
    
    local ScoreBd = CoD.MPScr.new(menu, controller)
    ScoreBd:setLeftRight(false, false, -50.000000, 50.000000)
    ScoreBd:setTopBottom(true, false, 233.500000, 258.500000)
    
    local function MpCallback(ModelRef)
        if IsParamModelEqualToString(ModelRef, "score_event") then
            PlayClipOnElement(menu, {elementName = "MPScore",  clipName = "NormalScore"}, controller)
            SetMPScoreText(menu, ScoreBd, controller, ModelRef)
        end
    end
    
    menu:subscribeToGlobalModel(controller, "PerController", "scriptNotify", MpCallback)
    
    menu:addElement(ScoreBd)
    menu.MPScore = ScoreBd
    
    local PreMatch = CoD.ZM_PrematchCountdown.new(menu, controller)
    PreMatch:setLeftRight(false, false, -640.000000, 640.000000)
    PreMatch:setTopBottom(false, false, -360.000000, 360.000000)
    
    menu:addElement(PreMatch)
    menu.ZMPrematchCountdown0 = PreMatch
    
    local ScoreCP = CoD.ScoreboardWidgetCP.new(menu, controller)
    ScoreCP:setLeftRight(false, false, -503.000000, 503.000000)
    ScoreCP:setTopBottom(true, false, 247.000000, 773.000000)
    
    menu:addElement(ScoreCP)
    menu.ScoreboardWidget = ScoreCP
    
    local BeastTimer = CoD.ZM_BeastmodeTimeBarWidget.new(menu, controller)
    menu:setLeftRight(false, false, -242.500000, 321.500000)
    menu:setTopBottom(false, true, -174.000000, -18.000000)
    
    menu:addElement(BeastTimer)
    menu.ZMBeastBar = BeastTimer
    
    local ShieldWidget = CoD.RocketShieldBlueprintWidget.new(menu, controller)
    ShieldWidget:setLeftRight(true, false, -36.500000, 277.500000)
    ShieldWidget:setTopBottom(true, false, 104.000000, 233.000000)
    ShieldWidget:setScale(0.800000)
    
    local function ShieldCallback(Unk1, Unk2, Unk3)
        if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then end
        return AlwaysFalse() -- Because the shield isn't available...
    end
    
    ShieldWidget:mergeStateConditions({{stateName = "Scoreboard", condition = ShieldCallback}})
    
    local function ShieldParts(ModelRef)
        menu:updateElementState(ShieldWidget, {name = "model_validation",
            menu = menu, menu = menu, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "zmInventory.widget_shield_parts"})
    end
    
    local function ShieldBitOpen(ModelRef)
        menu:updateElementState(ShieldWidget, {name = "model_validation", 
            menu = menu, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
    end
    
    ShieldWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "zmInventory.widget_shield_parts"), ShieldParts)
    ShieldWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), ShieldBitOpen)
    
    menu:addElement(ShieldWidget)
    menu.RocketShieldBlueprintWidget = ShieldWidget
    
    local ChatContainer = CoD.IngameChatClientContainer.new(menu, controller)
    ChatContainer:setLeftRight(true, false, 0.000000, 360.000000)
    ChatContainer:setTopBottom(true, false, -2.500000, 717.500000)
    
    menu:addElement(ChatContainer)
    menu.IngameChatClientContainer = ChatContainer
    
    local ChatContainer2 = CoD.IngameChatClientContainer.new(menu, controller)
    ChatContainer2:setLeftRight(true, false, 0.000000, 360.000000)
    ChatContainer2:setTopBottom(true, false, -2.500000, 717.500000)
    
    menu:addElement(ChatContainer2)
    menu.IngameChatClientContainer0 = ChatContainer2
    
    local GumPack = CoD.BubbleGumPackInGame.new(menu, controller)
    GumPack:setLeftRight(false, false, -184.000000, 184.000000)
    GumPack:setTopBottom(true, false, 36.000000, 185.000000)
    
    menu:addElement(GumPack)
    menu.BubbleGumPackInGame = GumPack
    
    ScoreWidget.navigation = {up = ScoreCP, right = ScoreCP}
    ScoreCP.navigation = {left = ScoreWidget, down = ScoreWidget}
    
    CoD.Menu.AddNavigationHandler(menu, menu, controller)
    
    local function MenuLoadedCallback(HudObj, EventObj)
        SizeToSafeArea(HudObj, controller)
        return HudObj:dispatchEventToChildren(EventObj)
    end
    
    menu:registerEventHandler("menu_loaded", MenuLoadedCallback)
    
    -- Not sure why these are explicitly set, but they are
    ScoreWidget.id = "Score"
    ScoreCP.id = "ScoreboardWidget"
    
    menu:processEvent({name = "menu_loaded", controller = controller})
    menu:processEvent({name = "update_state", menu = menu})
    
    if not menu:restoreState() then
        menu.ScoreboardWidget:processEvent({name = "gain_focus", controller = controller})
    end
    
    local function HudCloseCallback(SenderObj)
        --SenderObj.ZMPerksContainerFactory:close()
        -- Warzone
        SenderObj.ammo:close()
        SenderObj.squad:close()
        -- Not warzone
        SenderObj.Score:close()
        SenderObj.fullscreenContainer:close()
        SenderObj.Notifications:close()
        SenderObj.ZmNotifBGBContainerFactory:close()
        SenderObj.ConsoleCenter:close()
        SenderObj.DeadSpectate:close()
        SenderObj.MPScore:close()
        SenderObj.ZMPrematchCountdown0:close()
        SenderObj.ScoreboardWidget:close()
        SenderObj.ZMBeastBar:close()
        SenderObj.RocketShieldBlueprintWidget:close()
        SenderObj.IngameChatClientContainer:close()
        SenderObj.IngameChatClientContainer0:close()
        SenderObj.BubbleGumPackInGame:close()
        
        Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "T7Hud_zm_factory.buttonPrompts"))
    end
    
    LUI.OverrideFunction_CallOriginalSecond(menu, "close", HudCloseCallback)
    
    if PostLoadCallback then
        PostLoadCallback(menu, controller)
    end

    return menu
end