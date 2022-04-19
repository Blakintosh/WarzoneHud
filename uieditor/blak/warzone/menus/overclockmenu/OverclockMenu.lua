require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenubackground")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenuhighrescontainer")
require("ui.uieditor.blak.warzone.widgets.overclockmenu.overclockmenubutton")

local function PreLoadFunc(menu, controller)
    menu.disablePopupOpenCloseAnim = true
    menu.disableBlur = true
    menu.disableDarkenElement = true

    Engine.LockInput(controller, true)
    Engine.SetUIActive(controller, true)
    
    local function CreateSubModelsForOverclock(Overclock)
        local Name = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "name")
        local Description = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "description")
        local Cost = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "cost")
        local Available = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "available")
        local Comment = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "comment")
        local Index = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "index")
        Engine.SetModelValue(Index, Overclock)
    end

    CreateSubModelsForOverclock("1")
    CreateSubModelsForOverclock("2")
    CreateSubModelsForOverclock("3")

    Engine.CreateModel(Engine.GetModel(Engine.GetModelForController(controller), "currentWeapon"), "rootWeaponName")

    local ModelTable = { "name", "description", "cost", "available", "comment" }

    Util.ScriptNotify(controller, menu, "zm_overclockMenu", function(NotifyData)
        if NotifyData[1] then
            local TreeNumber = NotifyData[1] + 1

            local i = 2
            for k, v in pairs(ModelTable) do
                Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "overclockTree." .. tostring(TreeNumber) .. "." .. v), NotifyData[i])
                i = i + 1
            end
        end
    end)

    -- This is a pretty ghetto solution to sending the weapon comment to the info widget, but I had a lot of trouble getting anything to work so even though I found the problem, I cba changing this
    --[[menu.setWeaponInformation = function(menu, ModelRef)
        local CommentVal = Engine.GetModelValue(Engine.GetModel(ModelRef, "comment"))

        if CommentVal then
            local CostVal = Engine.GetModelValue(Engine.GetModel(ModelRef, "cost"))
            if CostVal then
                menu.weaponInformation.comment:setText(Engine.Localize(Engine.GetIString(CommentVal, "CS_LOCALIZED_STRINGS"), CostVal))
            else
                menu.weaponInformation.comment:setText(Engine.Localize(Engine.GetIString(CommentVal, "CS_LOCALIZED_STRINGS")))
            end
        end
    end]]
end

--LUI.hudMenuType.OverclockMenu = "hud"
function LUI.createMenu.OverclockMenu(controller)
	local menu = CoD.Menu.NewForUIEditor("OverclockMenu")

	if PreLoadFunc then
		PreLoadFunc(menu, controller)
	end

	menu.soundSet = "iw8"
    menu.id = "OverclockMenu"
	menu:setOwner(controller)
    menu:makeFocusable()
    menu:setLeftRight(false, false, -373, 373)
	menu:setTopBottom(true, false, 176, 635)
	menu:playSound("menu_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "OverclockMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true
    
    menu.background = Warzone.OverclockMenuBackground.new(menu, controller)
    menu.background:setLeftRight(true, true, 0, 0)
    menu.background:setTopBottom(true, true, 60, -60)

    menu:addElement(menu.background)

    menu.container = Warzone.OverclockMenuHighResContainer.new(menu, controller)
    menu.container:setScaledLeftRight(false, false, -373, 373)
    menu.container:setScaledTopBottom(false, false, -229.5, 229.5)
    menu.container:setScale(1 / _ResolutionScalar)
    menu.container:linkToElementModel(menu, nil, false, function (model)
		menu.container:setModel(model, controller)
	end)

    menu.container.id = "container"

    menu:addElement(menu.container)
    
    menu.container:processEvent({name = "gain_focus", controller = controller})
    
    menu:registerEventHandler("menu_loaded", function(Sender, Event)
        return Sender:dispatchEventToChildren(Event)
    end)

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
        Engine.SendMenuResponse(controller, "OverclockMenu", "closed")
        Close(menu, controller)
    end, function(ItemRef, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK")
        return true
    end, false)
	
	menu:processEvent({
        name = "menu_loaded",
        controller = controller
    })
	
	menu:processEvent({
        name = "update_state",
        menu = menu
    })
    
	LUI.OverrideFunction_CallOriginalSecond(menu, "close", function(self)
        self.background:close()
        self.container:close()
        Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "OverclockMenu.buttonPrompts"))
    end)

	if PostLoadFunc then
		PostLoadFunc(menu, controller)
	end

	return menu
end

