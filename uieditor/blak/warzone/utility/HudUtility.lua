Util.CreateContainedHudElement = function(menu, controller, type)
    local self = Warzone.Container.new(menu, controller, type)

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
                Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) then
                    return false
                else
                    return true
                end
            end
        }
    })
    
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_GAME_ENDED)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_KILLCAM)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_UI_ACTIVE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IS_SCOPED)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_VEHICLE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC)
    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_EMP_ACTIVE)

    Util.SubState(controller, menu, self, "hudItems.playerSpawned")

    return self
end

Util.CreateContainedScoreboardElement = function(menu, controller, type)
    local self = Warzone.Container.new(menu, controller, type)
    self:makeFocusable()
    self.onlyChildrenFocusable = true

    Util.ClipSequence(self, self.contents, "DefaultState", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 0,
            setAlpha = 1
        }
    })
    Util.ClipSequence(self, self.contents, "Hidden", {
        {
            duration = 0,
            setAlpha = 1
        },
        {
            duration = 0,
            setAlpha = 0
        }
    })

    self:mergeStateConditions({
        {
            stateName = "Hidden",
            condition = function(Hud, Element, StateTable)
                if not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not
                IsModelValueEqualTo(InstanceRef, "forceScoreboard", 1) then
                    return true
                else
                    return false
                end
            end
        }
    })

    Util.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    Util.SubState(controller, menu, self, "forceScoreboard")

    return self
end