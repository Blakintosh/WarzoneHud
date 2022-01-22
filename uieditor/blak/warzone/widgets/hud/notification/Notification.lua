
require("ui.uieditor.blak.warzone.widgets.hud.notification.NotificationStripes")
require("ui.uieditor.blak.warzone.widgets.hud.notification.NotificationArrow")

Warzone.Notification = InheritFrom(LUI.UIElement)

function Warzone.Notification.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.Notification)
    self.id = "Notification"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self.notificationQueue = {}
    self.currentNotification = nil

    self.stripes = Warzone.NotificationStripes.new(menu, controller)
    self.stripes:setScaledLeftRight(true, true, 0, 0)
    self.stripes:setScaledTopBottom(true, true, 0, 0)

    Wzu.ClipSequence(self, self.stripes, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.stripes, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 500,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0.6
        },
        {
            duration = 1900,
            setAlpha = 0.6
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    self:addElement(self.stripes)

    self.background2 = LUI.UIImage.new()
    self.background2:setScaledLeftRight(false, false, -601, 601)
    self.background2:setScaledTopBottom(true, true, 0, 0)
    self.background2:setImage(RegisterImage("widg_gradient_center_out"))
    self.background2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
    Wzu.SetRGBFromTable(self.background2, Wzu.Swatches.FriendlyTeamDark)

    Wzu.ClipSequence(self, self.background2, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0,
            setScaledLeftRight = {false, false, -601, 601}
        }
    })

    Wzu.ClipSequence(self, self.background2, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0,
            setScaledLeftRight = {false, false, -601, 601}
        },
        {
            duration = 200,
            setAlpha = 1,
            setScaledLeftRight = {false, false, -601, 601}
        },
        {
            duration = 300,
            interpolation = Wzu.TweenGraphs.outQuad,
            setAlpha = 0.7,
            setScaledLeftRight = {false, false, -1601, 1601}
        },
        {
            duration = 2200,
            setAlpha = 0.7
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    self:addElement(self.background2)

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(false, false, -850, 850)
    self.background:setScaledTopBottom(true, true, 0, 0)
    self.background:setImage(RegisterImage("widg_gradient_center_out"))
    Wzu.SetRGBFromTable(self.background, Wzu.Swatches.FriendlyTeam)

    Wzu.ClipSequence(self, self.background, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.background, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0
        },
        {
            duration = 200,
            setAlpha = 0.7
        },
        {
            duration = 2200,
            setAlpha = 0.7
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    self:addElement(self.background)
    
    self.message = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, true)
    self.message:setScaledLeftRight(false, false, -150, 150)
    self.message:setScaledTopBottom(true, false, 9, 51)
    self.message:setText("MAX AMMO!")
    Wzu.SetRGBFromTable(self.message, Wzu.Swatches.FriendlyTeamTextHighlight)

    Wzu.ClipSequence(self, self.message, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.message, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0
        },
        {
            duration = 200,
            setAlpha = 1
        },
        {
            duration = 2200,
            setAlpha = 1
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    Wzu.AddShadowedElement(self, self.message)

    self.arrowL = Warzone.NotificationArrow.new(menu, controller)
    self.arrowL:setScaledLeftRight(true, false, 250, 350)
    self.arrowL:setScaledTopBottom(true, true, 0, 0)
    self.arrowL.image:setZRot(270)
    Wzu.SetRGBFromTable(self.arrowL, Wzu.Swatches.FriendlyTeamTextHighlight)

    Wzu.ClipSequence(self, self.arrowL, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.arrowL, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 240,
            setAlpha = 0
        },
        {
            duration = 60,
            setAlpha = 1
        },
        {
            duration = 2400,
            setAlpha = 1
        },
        {
            duration = 200,
            setAlpha = 0
        }
    })

    self:addElement(self.arrowL)

    self.arrowR = Warzone.NotificationArrow.new(menu, controller)
    self.arrowR:setScaledLeftRight(false, true, -350, -250)
    self.arrowR:setScaledTopBottom(true, true, 0, 0)
    self.arrowR.image:setZRot(90)
    Wzu.SetRGBFromTable(self.arrowR, Wzu.Swatches.FriendlyTeamTextHighlight)

    Wzu.ClipSequence(self, self.arrowR, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.arrowR, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 240,
            setAlpha = 0
        },
        {
            duration = 60,
            setAlpha = 1
        },
        {
            duration = 2400,
            setAlpha = 1
        },
        {
            duration = 200,
            setAlpha = 0
        }
    })

    self:addElement(self.arrowR)

    self.imageL = LUI.UIImage.new()
    self.imageL:setScaledLeftRight(false, false, -250, -200)
    self.imageL:setScaledTopBottom(false, false, -25, 25)
    self.imageL:setImage(RegisterImage("hud_icon_ammo_resupply"))

    Wzu.ClipSequence(self, self.imageL, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.imageL, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0
        },
        {
            duration = 200,
            setAlpha = 1
        },
        {
            duration = 2200,
            setAlpha = 1
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    self:addElement(self.imageL)

    self.imageR = LUI.UIImage.new()
    self.imageR:setScaledLeftRight(false, false, 200, 250)
    self.imageR:setScaledTopBottom(false, false, -25, 25)
    self.imageR:setImage(RegisterImage("hud_icon_ammo_resupply"))

    Wzu.ClipSequence(self, self.imageR, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })

    Wzu.ClipSequence(self, self.imageR, "NotifBlueStripes", {
        {
            duration = 0,
            setAlpha = 0
        },
        {
            duration = 300,
            setAlpha = 0
        },
        {
            duration = 200,
            setAlpha = 1
        },
        {
            duration = 2200,
            setAlpha = 1
        },
        {
            duration = 300,
            setAlpha = 0
        }
    })

    self:addElement(self.imageR)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultClip")
            end,
            NotifBlueStripes = function()
                Wzu.AnimateSequence(self, "NotifBlueStripes")
            end
        }
    }
    
    self.playNotification = function(self, notificationTable)
        self.currentNotification = notificationTable
        -- First set the title up
        self.message:setText(notificationTable.title)
        -- And set the icons
        self.imageL:setImage(notificationTable.icon)
        self.imageR:setImage(notificationTable.icon)
        -- Then play the clip itself
        self:playClip(notificationTable.clip)
        self.stripes:playClip(notificationTable.clip)

        self:registerEventHandler("clip_over", function(sender, event)
            local index = #self.notificationQueue
            -- there's a notification in the queue
            if index ~= 0 then
                local nextNotif = LUI.ShallowCopy(self.notificationQueue[1])

                local oldNotifQueue = LUI.ShallowCopy(self.notificationQueue)
                self.notificationQueue[1] = nil
                self.notificationQueue = {}
                for k,v in ipairs(oldNotifQueue) do
                    if k ~= 1 then
                        self.notificationQueue[k - 1] = v
                    end
                end
                self:playNotification(nextNotif)
            else
                self.currentNotification = nil
            end
        end)
    end

    self.appendNotification = function(self, notificationTable)
        local index = #self.notificationQueue

        if index == 0 and self.currentNotification == nil then
            self:playNotification(notificationTable)
        else
            self.notificationQueue[index + 1] = notificationTable
        end
    end

    local NotificationIconTable = {
        [0] = RegisterImage("hud_icon_ammo_resupply"),
        [1] = RegisterImage("icon_killstreak_tablet_airstrike")
    }
    
    Wzu.ScriptNotify(controller, self, "zombie_notification", function(notifyData)
        self:appendNotification({
            clip = "NotifBlueStripes",
            title = LocalizeToUpperString(Engine.GetIString(notifyData[1], "CS_LOCALIZED_STRINGS")),
            icon = NotificationIconTable[notifyData[2]]
        })
    end)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(Sender)
        Sender.stripes:close()
    end)
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end