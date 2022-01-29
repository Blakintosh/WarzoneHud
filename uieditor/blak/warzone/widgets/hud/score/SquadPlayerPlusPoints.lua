require("ui.uieditor.blak.warzone.widgets.hud.score.PlusPointsContainer")

Warzone.SquadPlayerPlusPoints = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "hudItems"), "perkListUpdated")
end

function Warzone.SquadPlayerPlusPoints.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.SquadPlayerPlusPoints)
    self:setScaledLeftRight(true, false, 0, 255)
    self:setScaledTopBottom(false, true, -47, 0)
    self.id = "SquadPlayerPlusPoints"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    
    self.plusPoints = Warzone.PlusPointsContainer.new(menu, controller)
    self.plusPoints:setScaledLeftRight(true, false, 18.5, 151)
    self.plusPoints:setScaledTopBottom(false, true, -18, -4)
    self.plusPoints:setPriority(4)

    Wzu.ClipSequence(self, self.plusPoints, "HasPerks", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -16, -2}
        }
    })
    Wzu.ClipSequence(self, self.plusPoints, "DefaultState", {
        {
            duration = 0,
            setScaledTopBottom = {false, true, -18, -4}
        }
    })
    
    self:addElement(self.plusPoints)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultState")
            end
        },
        HasPerks = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "HasPerks")
            end
        }
    }

    self:mergeStateConditions({
        {
            stateName = "HasPerks",
            condition = function(menu, self, event)
                return (#self.perksList.PerkList.perksList > 0)
            end
        }
    })
    
    Wzu.SubState(controller, menu, self, "hudItems.perkListUpdated")

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.plusPoints:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end