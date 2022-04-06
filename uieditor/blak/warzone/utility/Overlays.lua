require("ui.uieditor.blak.warzone.widgets.overlays.body.twooption.TwoOptionOverlayBody")

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

CoD.OverlayUtility.Overlays.RestartGamePopup.menuName = "CompactOverlay"
CoD.OverlayUtility.Overlays.RestartGamePopup.frameWidget = "Warzone.TwoOptionOverlayBody"

CoD.OverlayUtility.Overlays.QuitPCGamePopup.menuName = "CompactOverlay"
CoD.OverlayUtility.Overlays.QuitPCGamePopup.frameWidget = "Warzone.TwoOptionOverlayBody"
CoD.OverlayUtility.Overlays.QuitPCGamePopup.title = "WZMENU_CONFIRM_QUIT_TO_DESKTOP"

--[[function Wzu.QuitGame(f390_arg0, controller, f390_arg2, arg3, menu)
	CoD.OverlayUtility.CreateOverlay(controller, menu, "QuitGamePopup")
end]]