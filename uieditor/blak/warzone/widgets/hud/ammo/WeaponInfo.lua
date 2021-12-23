Warzone.WeaponInfo = InheritFrom(LUI.UIElement)

local function PreLoadFunc(menu, controller)
    Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "currentWeapon"), "weaponOverclockName"), "")
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

    self.weaponName = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, true)
    self.weaponName:setScaledLeftRight(true, false, 0.5, 200)
    self.weaponName:setScaledTopBottom(true, false, -1.5, 14)

    Wzu.SubscribeToText(self.weaponName, controller, "currentWeapon.weaponName")

    Wzu.ClipSequence(self, self.weaponName, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.weaponName, "NewWeapon", {
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

    Wzu.AddShadowedElement(self, self.weaponName)

    self.ammoName = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.Overcharged, true)
    self.ammoName:setScaledLeftRight(true, false, 0.5, 200)
    self.ammoName:setScaledTopBottom(true, false, 16, 29)
    self.ammoName:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)

    Wzu.SubscribeToText(self.ammoName, controller, "currentWeapon.weaponTierName")

    Wzu.ClipSequence(self, self.ammoName, "DefaultClip", {
        {
            duration = 0,
            setAlpha = 0
        }
    })
    Wzu.ClipSequence(self, self.ammoName, "NewWeapon", {
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

    Wzu.AddShadowedElement(self, self.ammoName)
    
    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultClip")
            end,
            NewWeapon = function()
                Wzu.AnimateSequence(self, "NewWeapon")
            end
        }
    }

    Wzu.Subscribe(self, controller, "currentWeapon.weapon", function(modelValue)
        PlayClip(self, "NewWeapon", controller)
    end)
    
    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return self
end