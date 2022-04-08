Warzone.OverclockMenuButtonInfoBody = InheritFrom(LUI.UIElement)

function Warzone.OverclockMenuButtonInfoBody.new(menu, controller)
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc(menu, controller)
    end
    
    self:setUseStencil(false)
    self:setClass(Warzone.OverclockMenuButtonInfoBody)
    self.id = "OverclockMenuButtonInfoBody"
    self:setScaledLeftRight(true, false, 0, 228)
    self:setScaledTopBottom(true, false, 0, 74)
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.background = LUI.UIImage.new()
    self.background:setScaledLeftRight(true, true, 0, 0)
    self.background:setScaledTopBottom(true, true, 0, 0)
    Wzu.SetRGBFromTable(self.background, Wzu.Colors.Black)
    self.background:setAlpha(0.6)

    self:addElement(self.background)

    self.title = Wzu.TextElement(Wzu.Fonts.MainBold, Wzu.Swatches.HUDMain, false)
    self.title:setScaledLeftRight(true, false, 8, 120)
    self.title:setScaledTopBottom(true, false, 2, 15)
    self.title:setText("RADICALLY INVASIVE (Overclock 2)")

    Wzu.LinkToWidget(self.title, self, "name", function(modelValue)
        local index = Engine.GetModelValue(Engine.GetModel(self:getModel(), "index"))
        if index then
            self.title:setText(LocalizeToUpperString(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")) .. " " .. Engine.Localize("KARELIA_CALIBER_OVERCLOCK_INDEX", index))
        else
            self.title:setText(LocalizeToUpperString(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")))
        end
    end)

    self:addElement(self.title)

    self.subtitle = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain, false)
    self.subtitle:setScaledLeftRight(true, false, 8, 120)
    self.subtitle:setScaledTopBottom(true, false, 15, 28)
    self.subtitle:setText("^1You don't have the previous Caliber")

    Wzu.LinkToWidget(self.subtitle, self, "comment", function(modelValue)
        local cost = Engine.GetModelValue(Engine.GetModel(self:getModel(), "cost"))
        if cost then
            self.subtitle:setText(Engine.Localize(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS"), cost))
        end
    end)

    self:addElement(self.subtitle)

    self.body = Wzu.TextElement(Wzu.Fonts.MainRegular, Wzu.Swatches.HUDMain)
    self.body:setScaledLeftRight(true, false, 8, 220)
    self.body:setScaledTopBottom(true, false, 28, 41)
    self.body:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    self.body:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
    self.body:setText("Radically Invasive rounds fragment apart upon entry, offering a significant damage boost. Capable of 2.5x damage potential.")

    LUI.OverrideFunction_CallOriginalFirst(self.body, "setText", function(widget, text)
        ScaleWidgetToLabelWrappedLeftAlign(self, widget, 0, -80)
    end)
    Wzu.LinkToWidget(self.body, self, "description", function(modelValue)
        self.body:setText(Engine.Localize(Engine.GetIString(modelValue, "CS_LOCALIZED_STRINGS")))
    end)

    self:addElement(self.body)

    --[[self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DefaultUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DefaultOver")
            end
        },
        Disabled = {
            DefaultClip = function()
                Wzu.AnimateSequence(self, "DisabledUp")
            end,
            Focus = function()
                Wzu.AnimateSequence(self, "DisabledOver")
            end
        }
    }]]
    
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end
    
    return self
end