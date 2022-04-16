--[[
    Made by Blakintosh
    Do not distribute without permission
]]

Warzone.CentreDotReticle = InheritFrom(LUI.UIElement)

--[[
    Hide when:
    - in ADS, reloading, switching weapon, firing.
    Hide instantly but when fading back in, 100ms animation
]]

local function PreLoadFunc(HudRef, InstanceRef)
    -- As you'll see later in this file, I'm usign custom UI Models. As these are made in script, I also need to create them on the LUI side.
    -- any scripted UI model has to be created in LUI as well as GSC/CSC. You'll see them do this for stuff e.g. AAT

    -- Create a model for hudItems if it doesn't exist, and create a sub-model within it of isSwitchingWeapon (equivalent to hudItems.isSwitchingWeapon)
    local IsSwitchingWeaponModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems"), "isSwitchingWeapon")
    Engine.SetModelValue(IsSwitchingWeaponModel, 0) -- Set a default value for the UI Model. It won't behave properly if you don't do this

    local IsReloadingModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems"), "isReloading")
    Engine.SetModelValue(IsReloadingModel, 0)

    local IsFiringModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems"), "isFiring")
    Engine.SetModelValue(IsFiringModel, 0)

    local IsAdsModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems"), "isADS")
    Engine.SetModelValue(IsAdsModel, 0)

    local UseCentreDotModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems"), "useCentreDot")
    Engine.SetModelValue(UseCentreDotModel, 0)
end

function Warzone.CentreDotReticle.new(menu, controller)
    local self = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.CentreDotReticle)
    self.id = "CentreDotReticle"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    self.centreDot = LUI.UIImage.new() -- Generic image element
    -- We'll use the parent widget (CoD.Blak_CentreDotReticle) to control positioning. We'll anchor our centre dot to the same positions
    -- when we do parent positions, it needs to be 8x8 units (based on a 1280x720 screen)
    self.centreDot:setScaledLeftRight(true, true, 0, 0)
    self.centreDot:setScaledTopBottom(true, true, 0, 0)

    self.centreDot:setImage(RegisterImage("hud_reticle_hip_dot")) --loaded 2d image

    Wzu.ClipSequence(self, self.centreDot, "Show", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 100,
            setAlpha = 1
        }
    })
    Wzu.ClipSequence(self, self.centreDot, "Hide", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    -- Add element to parent widget
    self:addElement(self.centreDot)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function() --This is the standard state & clip that will play when all state conditions fail to evaluate as true
                Wzu.AnimateSequence(self, "Show")
            end
        },
        Hidden = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "Hide")
            end
        }
    }
    
    self:mergeStateConditions({
        {
            stateName = "Hidden",
            condition = function(Hud, Element, StateTable)
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
                IsModelValueEqualTo(controller, "hudItems.isSwitchingWeapon", 1) and not
                IsModelValueEqualTo(controller, "hudItems.isReloading", 1) and not
                IsModelValueEqualTo(controller, "hudItems.isFiring", 1) and not
                IsModelValueEqualTo(controller, "hudItems.isADS", 1) and
                IsModelValueEqualTo(controller, "hudItems.useCentreDot", 1) and not
                Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) then
                    return false
                else
                    return true
                end
            end
        }
    })

    -- Model subscriptions are functions that will run when a UI Model is updated, be that by the engine or script. It's how Treyarch ensure, say, that the HUD keeps up with what ammo is in the mag.
    -- here I'm using a simplified system for them by lilrifa which is more intuitive, and cuts down on code. In 3arc code though you'll see a chunky function for each update state subscription.
    -- For these ones, they're calling to re-evaluate the mergeStateConditions functions above whenever their UI model is updated. So, the function for Hidden will run if you open the scoreboard, let's say, or close it
    
    -- These are all generic visibility model subscriptions. They are what hide the HUD when, say, you're in the scoreboard, or other cases where HUD needs to be hidden.
    -- Don't need to understand visibility bits, just have to use them. Though I might remove them depending on how the Bo3 .menu reticle behaves when these things occur
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_GAME_ENDED)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_KILLCAM)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_UI_ACTIVE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IS_SCOPED)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_VEHICLE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC)
    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_EMP_ACTIVE)

    Wzu.SubState(controller, menu, self, "hudItems.playerSpawned")

    -- Extra conditions that I will add to update the HUD
    -- these are all custom UI Models that I'm going to script in gsc/csc
    Wzu.SubState(controller, menu, self, "hudItems.isSwitchingWeapon")
    Wzu.SubState(controller, menu, self, "hudItems.isReloading")
    Wzu.SubState(controller, menu, self, "hudItems.isFiring")
    Wzu.SubState(controller, menu, self, "hudItems.isADS")
    Wzu.SubState(controller, menu, self, "hudItems.useCentreDot")
    
    if PostLoadFunc then
        PostLoadFunc(menu, controller)
    end
    
    return self
end