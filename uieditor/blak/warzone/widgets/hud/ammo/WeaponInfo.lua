Warzone.WeaponInfo = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponOverclockName"), "")
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponOverclocks"), 0)
end

function Warzone.WeaponInfo.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.WeaponInfo)
    self.id = "WeaponInfo"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.weaponName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.HUDMain, true)
    self.weaponName:setScaledLeftRight(true, false, 0.5, 200)
    self.weaponName:setScaledTopBottom(true, false, -1.5, 14)

    Util.SubscribeToText(self.weaponName, controller, "currentWeapon.weaponName")

    Util.ClipSequence(self, self.weaponName, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.weaponName, "NewWeapon", {
        {
            duration = 0,
            setAlpha = 1
        },
        {
            duration = 5000,
            setAlpha = 1
        },
        {
            duration = 500,
            setAlpha = 0
        }
    })

    Util.AddShadowedElement(self, self.weaponName)

    self.ammoName = Util.TextElement(Util.Fonts.MainRegular, Util.Swatches.Overcharged, true)
    self.ammoName:setScaledLeftRight(true, false, 0.5, 200)
    self.ammoName:setScaledTopBottom(true, false, 16, 29)
    self.ammoName:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)

    Util.SubscribeToText(self.ammoName, controller, "currentWeapon.weaponTierName")

    Util.SubscribeMultiple(self.ammoName, controller, {"currentWeapon.weaponTierName", "currentWeapon.weaponOverclocks"}, function(modelValue)
        local tierValue = Engine.GetModelValue(Util.GetModel(controller, "currentWeapon.weaponTierName"))
        local ocValue = Engine.GetModelValue(Util.GetModel(controller, "currentWeapon.weaponOverclocks"))

        if tierValue then
            if ocValue and ocValue > 0 then
                self.ammoName:setText(Engine.Localize(tierValue) .. " (".. ocValue .." Overclocks)")
            else
                self.ammoName:setText(Engine.Localize(tierValue))
            end
        end
    end)

    Util.ClipSequence(self, self.ammoName, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Util.ClipSequence(self, self.ammoName, "NewWeapon", {
        {
            duration = 0,
            setAlpha = 1
        },
        {
            duration = 5000,
            setAlpha = 1
        },
        {
            duration = 500,
            setAlpha = 0
        }
    })

    Util.AddShadowedElement(self, self.ammoName)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Util.AnimateSequence(self, "DefaultClip")
            end,
            NewWeapon = function()
                Util.AnimateSequence(self, "NewWeapon")
            end
        }
    }

    Util.Subscribe(self, controller, "currentWeapon.weapon", function(modelValue)
        PlayClip(self, "NewWeapon", controller)
    end)
    
    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end