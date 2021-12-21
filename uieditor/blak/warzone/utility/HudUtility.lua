Wzu.CreateContainedHudElement = function(menu, controller, type)
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

    return self
end

Wzu.CreateContainedScoreboardElement = function(menu, controller, type)
    local self = Warzone.Container.new(menu, controller, type)

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

    Wzu.SubVisBit(controller, menu, self, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    Wzu.SubState(controller, menu, self, "forceScoreboard")

    return self
end