EnableGlobals()

if not Warzone then
    Warzone = {}
end

-- Utility
require("ui.uieditor.blak.warzone.utility.UtilityIncludes")

-- Widgets
require("ui.uieditor.blak.warzone.widgets.hud.shared.HighResolutionContainer")
require("ui.uieditor.blak.warzone.widgets.hud.shared.Container")
require("ui.uieditor.blak.warzone.widgets.hud.shared.ButtonPrompt")
require("ui.uieditor.blak.warzone.widgets.hud.ammo.Ammo")
require("ui.uieditor.blak.warzone.widgets.hud.round.RoundCounter")
require("ui.uieditor.blak.warzone.widgets.hud.score.Squad")
require("ui.uieditor.blak.warzone.widgets.hud.cursorhint.CursorHint")
require("ui.uieditor.blak.warzone.widgets.hud.oob.OutOfBounds")
require("ui.uieditor.blak.warzone.widgets.hud.powerups.PowerupsList")
