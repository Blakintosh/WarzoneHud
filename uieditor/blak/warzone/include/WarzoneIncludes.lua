EnableGlobals()

if not Warzone then
    Warzone = {}
end

-- Utility
require("ui.uieditor.blak.warzone.utility.UtilityIncludes")

-- HUD Widgets
require("ui.uieditor.blak.warzone.widgets.hud.shared.HighResolutionContainer")
require("ui.uieditor.blak.warzone.widgets.hud.shared.Container")
require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.shared.Waypoints")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.Ammo")
require("ui.uieditor.blak.warzone.widgets.hud.round.RoundCounter")
require("ui.uieditor.blak.warzone.widgets.hud.notification.Notification")
require("ui.uieditor.blak.warzone.widgets.hud.score.Squad")
require("ui.uieditor.blak.warzone.widgets.hud.scoreboard.Scoreboard")
require("ui.uieditor.blak.warzone.widgets.hud.cursorhint.CursorHint")
require("ui.uieditor.blak.warzone.widgets.hud.oob.OutOfBounds")
require("ui.uieditor.blak.warzone.widgets.hud.powerups.PowerupsList")
require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupContainer")
require("ui.uieditor.blak.warzone.widgets.hud.perkpickup.PerkPickupContainer")
require("ui.uieditor.blak.warzone.widgets.hud.reloadprompt.ReloadPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.crosshair.CentreDotReticle")
require("ui.uieditor.blak.warzone.widgets.hud.hitmarker.Hitmarker")

-- Associated Menus
require("ui.uieditor.blak.warzone.menus.overclockmenu.OverclockMenu")
require("ui.uieditor.blak.warzone.menus.pregamemenu.PreGameMenu")
require("ui.uieditor.blak.warzone.menus.pregamemenu.PreGameMenu_Client")
require("ui.uieditor.blak.warzone.menus.startmenu.StartMenu")
require("ui.uieditor.blak.warzone.menus.startmenu_options.StartMenu_Options")
require("ui.uieditor.blak.warzone.menus.keypadmenu.KeypadMenu")
require("ui.uieditor.blak.warzone.menus.wheelmenu.WheelMenu")

-- Overlays
require("ui.uieditor.blak.warzone.menus.overlays.compact.CompactOverlay")
require("ui.uieditor.blak.warzone.menus.overlays.fullsize.FullSizeOverlay")

-- Interface elements
require("ui.uieditor.blak.warzone.widgets.userinterface.cursor.MouseCursor")

-- Not part of the Warzone HUD, but necessary for function
require("ui.uieditor.widgets.HUD.Waypoint.GenericWaypointContainer")
require("ui.uieditor.widgets.MPHudWidgets.WaypointBase")
