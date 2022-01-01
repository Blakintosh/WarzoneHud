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
require("ui.uieditor.blak.warzone.widgets.hud.score.Squad")
require("ui.uieditor.blak.warzone.widgets.hud.cursorhint.CursorHint")
require("ui.uieditor.blak.warzone.widgets.hud.oob.OutOfBounds")
require("ui.uieditor.blak.warzone.widgets.hud.powerups.PowerupsList")
require("ui.uieditor.blak.warzone.widgets.hud.weaponpickup.WeaponPickupContainer")

-- Associated Menus
require("ui.uieditor.blak.warzone.menus.overclockmenu.OverclockMenu")

-- Interface elements
require("ui.uieditor.blak.warzone.widgets.userinterface.cursor.MouseCursor")

-- Not part of the Warzone HUD, but necessary for function
require("ui.uieditor.widgets.HUD.Waypoint.GenericWaypointContainer")
require("ui.uieditor.widgets.MPHudWidgets.WaypointBase")
