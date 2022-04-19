
Warzone.NotificationStripes = InheritFrom(LUI.UIElement)

function Warzone.NotificationStripes.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.NotificationStripes)
    self.id = "NotificationStripes"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.strip1 = LUI.UIImage.new()
    self.strip1:setScaledLeftRight(false, false, -2813, 0)
    self.strip1:setScaledTopBottom(true, true, -2, 0)
    self.strip1:setZRot(180)
    self.strip1:setAlpha(0.6)
    self.strip1:setImage(RegisterImage("hud_tablet_warning_stripes"))
    Util.SetRGBFromTable(self.strip1, Util.Swatches.FriendlyTeam)

    Util.ClipSequence(self, self.strip1, "DefaultClip", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -2813, 0}
        }
    })

    Util.ClipSequence(self, self.strip1, "NotifBlueStripes", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, -2813, 0}
        },
        {
            duration = 2500,
            setScaledLeftRight = {false, false, -2213, 600}
        }
    })

    self:addElement(self.strip1)

    self.strip2 = LUI.UIImage.new()
    self.strip2:setScaledLeftRight(false, false, 0, 2813)
    self.strip2:setScaledTopBottom(true, true, -2, 0)
    self.strip2:setZRot(180)
    self.strip2:setAlpha(0.6)
    self.strip2:setImage(RegisterImage("hud_tablet_warning_stripes"))
    Util.SetRGBFromTable(self.strip2, Util.Swatches.FriendlyTeam)

    Util.ClipSequence(self, self.strip1, "DefaultClip", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, 0, 2813}
        }
    })

    Util.ClipSequence(self, self.strip2, "NotifBlueStripes", {
        {
            duration = 0,
            setScaledLeftRight = {false, false, 0, 2813}
        },
        {
            duration = 2500,
            setScaledLeftRight = {false, false, 600, 3413}
        }
    })

    self:addElement(self.strip2)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultClip")
            end,
            NotifBlueStripes = function()
                Util.AnimateSequence(self, "NotifBlueStripes")
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        --[[Sender.player:close()
        Sender.player2:close()
        Sender.player3:close()
        Sender.player4:close()]]
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end