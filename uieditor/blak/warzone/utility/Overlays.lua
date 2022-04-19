require("ui.uieditor.blak.warzone.widgets.overlays.body.twooption.TwoOptionOverlayBody")
require("ui.uieditor.blak.warzone.widgets.overlays.body.large.LargeOverlayBody")

--[[CoD.OverlayUtility.Overlays.EndGamePopup = {
    menuName = "CompactOverlay",
    frameWidget = "Warzone.TwoOptionOverlayBody",
    title = CoD.OverlayUtility.Overlays.EndGamePopup.title, 
    description = CoD.OverlayUtility.Overlays.EndGamePopup.description, 
    categoryType = CoD.OverlayUtility.OverlayTypes.Quit, 
    listDatasource = CoD.OverlayUtility.Overlays.EndGamePopup.listDatasource
}]]

CoD.OverlayUtility.Overlays.EndGamePopup.menuName = "CompactOverlay"
CoD.OverlayUtility.Overlays.EndGamePopup.frameWidget = "Warzone.TwoOptionOverlayBody"

CoD.OverlayUtility.Overlays.RestartGamePopup.menuName = "FullSizeOverlay"
CoD.OverlayUtility.Overlays.RestartGamePopup.frameWidget = "Warzone.LargeOverlayBody"

CoD.OverlayUtility.Overlays.QuitPCGamePopup.menuName = "CompactOverlay"
CoD.OverlayUtility.Overlays.QuitPCGamePopup.frameWidget = "Warzone.TwoOptionOverlayBody"
CoD.OverlayUtility.Overlays.QuitPCGamePopup.title = "WZMENU_CONFIRM_QUIT_TO_DESKTOP"

CoD.OverlayUtility.Overlays.DataStorageConsentPopup = LUI.ShallowCopy(CoD.OverlayUtility.Overlays.RestartGamePopup)
CoD.OverlayUtility.Overlays.DataStorageConsentPopup.title = "Data Storage"
CoD.OverlayUtility.Overlays.DataStorageConsentPopup.description = [[Karelia makes use of an optional ^3data storage ^7utility which stores information regarding map progression and similar locally on the user's machine.

This data storage is performed using ^3Lua's file IO ^7(which will hence Amber-flag community-built tools such as FastScanner). Data saving has a minimal storage footprint, using approximately a maximum of ^3?kB ^7of storage. 

Are you OK with this, or would you like this functionality to be ^3disabled^7? Should you opt to disable this functionality, you will see this popup at the beginning of every match (as not even your preference will be stored).]]

CoD.OverlayUtility.Overlays.DataStorageConsentPopup.listDatasource = function ()
	DataSources.DataStorageConsentPopup_List = DataSourceHelpers.ListSetup("DataStorageConsentPopup_List", function (f228_arg0)
		return {{models = {displayText = Engine.Localize("I Consent (enable)")}, properties = {action = function (f229_arg0, f229_arg1, f229_arg2, f229_arg3, f229_arg4)
			GoBack(f229_arg4, f229_arg2)
		end
}}, {models = {displayText = Engine.Localize("I do not Consent (disable)")}, properties = {action = function (f230_arg0, f230_arg1, f230_arg2, f230_arg3, f230_arg4)
			GoBack(f230_arg4, f230_arg2)
		end
, selectIndex = true}}}
	end, true, nil)
	return "DataStorageConsentPopup_List"
end

CoD.OverlayUtility.Overlays.ChangelogPopup = LUI.ShallowCopy(CoD.OverlayUtility.Overlays.RestartGamePopup)
CoD.OverlayUtility.Overlays.ChangelogPopup.title = "Info / Known Issues"
CoD.OverlayUtility.Overlays.ChangelogPopup.description = [[More menu tweaks have been made including new cursor. OC menu is nearly done.

Known issues:
- Wall next to blue house isn't clipped
- Reflection has been removed due to sound engine issues]]

CoD.OverlayUtility.Overlays.ChangelogPopup.listDatasource = function ()
	DataSources.ChangelogPopup_List = DataSourceHelpers.ListSetup("ChangelogPopup_List", function (f228_arg0)
		return {{models = {displayText = Engine.Localize("MENU_OK")}, properties = {action = function (f229_arg0, f229_arg1, f229_arg2, f229_arg3, f229_arg4)
			GoBack(f229_arg4, f229_arg2)
		end
}}}
	end, true, nil)
	return "ChangelogPopup_List"
end

--[[function Util.QuitGame(f390_arg0, controller, f390_arg2, arg3, menu)
	CoD.OverlayUtility.CreateOverlay(controller, menu, "QuitGamePopup")
end]]