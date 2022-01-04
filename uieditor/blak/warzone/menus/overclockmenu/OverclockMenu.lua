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
        local Cost = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "cost")
        local Available = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "available")
        local Comment = Engine.CreateModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), Overclock), "comment")

        --[[Engine.SetModelValue(Name, "MENU_NEW")
        Engine.SetModelValue(Cost, 0)
        Engine.SetModelValue(Available, 0)
        Engine.SetModelValue(Comment, "MENU_NEW")]]
    end

    CreateSubModelsForOverclock("1")
    CreateSubModelsForOverclock("2")
    CreateSubModelsForOverclock("3")

    Engine.CreateModel(Engine.GetModel(Engine.GetModelForController(controller), "currentWeapon"), "rootWeaponName")

    local ModelTable = { "name", "cost", "available", "comment" }

    Wzu.ScriptNotify(controller, menu, "zm_overclockMenu", function(NotifyData)
        if NotifyData[1] then
            local Index = math.mod(NotifyData[1] - 1, 4) + 1
            local TreeNumber = ((NotifyData[1] - Index) / 4) + 1
            Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "overclockTree." .. tostring(TreeNumber) .. "." .. ModelTable[Index]), NotifyData[2])
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
	menu:setTopBottom(true, false, 236, 575)
	menu:playSound("menu_open", controller)
	menu.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "OverclockMenu.buttonPrompts")
	menu.anyChildUsesUpdateState = true
    menu:setForceMouseEventDispatch(true)
    
    menu.background = Warzone.OverclockMenuBackground.new(menu, controller)
    menu.background:setLeftRight(true, true, 0, 0)
    menu.background:setTopBottom(true, true, 0, 0)

    menu:addElement(menu.background)

    menu.container = Warzone.OverclockMenuHighResContainer.new(menu, controller)
    menu.container:setScaledLeftRight(false, false, -373, 373)
    menu.container:setScaledTopBottom(false, false, -169.5, 169.5)
    menu.container:setScale(1 / _ResolutionScalar)
    menu.container:linkToElementModel(menu, nil, false, function (model)
		menu.container:setModel(model, controller)
	end)

    menu:addElement(menu.container)

    menu.overclockButton1 = Warzone.OverclockMenuButton.new(menu, controller)
    menu.overclockButton1:setLeftRight(false, false, -228.5, -188.5)
    menu.overclockButton1:setTopBottom(true, false, 281, 303)
    menu.overclockButton1.index = 1

    Wzu.SetElementModel_Create(menu.overclockButton1, controller, "overclockTree", "1")

    menu:addElement(menu.overclockButton1)

    menu.overclockButton2 = Warzone.OverclockMenuButton.new(menu, controller)
    menu.overclockButton2:setLeftRight(false, false, -20, 20)
    menu.overclockButton2:setTopBottom(true, false, 281, 303)
    menu.overclockButton2.index = 2

    Wzu.SetElementModel_Create(menu.overclockButton2, controller, "overclockTree", "2")

    menu:addElement(menu.overclockButton2)

    menu.overclockButton3 = Warzone.OverclockMenuButton.new(menu, controller)
    menu.overclockButton3:setLeftRight(false, true, -80, -40)
    menu.overclockButton3:setTopBottom(true, false, 281, 303)
    menu.overclockButton3.index = 3

    Wzu.SetElementModel_Create(menu.overclockButton3, controller, "overclockTree", "3")

    menu:addElement(menu.overclockButton3)

    menu.overclockButton1.navigation = {right = menu.overclockButton2}
    menu.overclockButton2.navigation = {left = menu.overclockButton1, right = menu.overclockButton3}
    menu.overclockButton3.navigation = {left = menu.overclockButton2}

    CoD.Menu.AddNavigationHandler(menu, menu, controller)

    menu.overclockButton1.id = "overclockButton1"
    menu.overclockButton2.id = "overclockButton2"
    menu.overclockButton3.id = "overclockButton3"
    
    if not menu:restoreState() then
		menu.overclockButton1:processEvent({name = "gain_focus", controller = controller})
	end

    --[[menu.frame = CoD.MWRGenericFrame.new(menu, controller)
    menu.frame:setLeftRight(true, true, -4, 4)
    menu.frame:setTopBottom(true, true, -2, 2)

    menu:addElement(menu.frame)

    menu.title = LUI.UIText.new()
    menu.title:setLeftRight(true, false, 15, 100)
    menu.title:setTopBottom(true, false, 15, 39)
    menu.title:setTTF("fonts/CarbonOTBold.otf")
    menu.title:setText("Overclock Weapon")

    menu:addElement(menu.title)

    menu.weaponInformation = CoD.MWROverclockWeaponInformation.new(menu, controller)
    menu.weaponInformation:setLeftRight(true, true, 20, -20)
    menu.weaponInformation:setTopBottom(true, false, 50, 80)

    menu:addElement(menu.weaponInformation)]]

    --[[menu.damageMeter = CoD.MWROverclockDamageMeter.new(menu, controller)
    menu.damageMeter:setLeftRight(true, true, 20, -20)
    menu.damageMeter:setTopBottom(true, false, 90, 125)

    menu:addElement(menu.damageMeter)]]

    --[[menu.overclock1 = CoD.MWROverclockEntry.new(menu, controller)
    menu.overclock1:setLeftRight(true, false, 50, 110)
    menu.overclock1:setTopBottom(true, false, 140, 220)

    menu.overclock1:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), "1"), function(ModelRef)
        menu.overclock1:setModel(ModelRef, controller)
    end)

    menu:addElement(menu.overclock1)

    menu.overclock2 = CoD.MWROverclockEntry.new(menu, controller)
    menu.overclock2:setLeftRight(false, false, -30, 30)
    menu.overclock2:setTopBottom(true, false, 140, 220)
    menu.overclock2.caliberIndex:setText("2")

    menu.overclock2:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), "2"), function(ModelRef)
        menu.overclock2:setModel(ModelRef, controller)
    end)

    menu:addElement(menu.overclock2)

    menu.overclock3 = CoD.MWROverclockEntry.new(menu, controller)
    menu.overclock3:setLeftRight(false, true, -110, -50)
    menu.overclock3:setTopBottom(true, false, 140, 220)
    menu.overclock3.caliberIndex:setText("3")

    menu.overclock3:subscribeToModel(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(controller), "overclockTree"), "3"), function(ModelRef)
        menu.overclock3:setModel(ModelRef, controller)
    end)

    menu:addElement(menu.overclock3)

    menu.overclock1.navigation = {right = menu.overclock2}
    menu.overclock2.navigation = {left = menu.overclock1, right = menu.overclock3}
    menu.overclock3.navigation = {left = menu.overclock2}
    
    CoD.Menu.AddNavigationHandler(menu, menu, controller)]]
    
    menu:registerEventHandler("menu_loaded", function(Sender, Event)
        SizeToSafeArea(Sender, controller)
        return Sender:dispatchEventToChildren(Event)
    end)

    --[[if not menu:restoreState() then
        menu.container:processEvent({name = "gain_focus", controller = controller})
    end]]

    --[[menu.overclock1.id = "overclock1"
    menu.overclock1.index = 1
    menu.overclock2.id = "overclock2"
    menu.overclock2.index = 2
    menu.overclock3.id = "overclock3"
    menu.overclock3.index = 3
    
    if not menu:restoreState() then
		menu.overclock1:processEvent({name = "gain_focus", controller = controller})
	end]]

    --[[menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
        Engine.SendMenuResponse(controller, "OverclockMenu", "closed")
        Close(menu, controller)
    end, function(ItemRef, menu, controller)
        return nil
    end, false)]]

    menu:AddButtonCallbackFunction(menu, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK", function(ItemRef, menu, controller, ParentRef)
        Engine.SendMenuResponse(controller, "OverclockMenu", "closed")
        Close(menu, controller)
    end, function(ItemRef, menu, controller)
        return nil
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

    
    menu:setLeftRight(false, false, -373, 373)
	menu:setTopBottom(true, false, 236, 575)

	return menu
end

