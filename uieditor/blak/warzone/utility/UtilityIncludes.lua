EnableGlobals()

if not Wzu then
    Wzu = {}
end

DebugPrint = function(message)
    Blak.DebugUtils.Log(message)
end

VERSION_WATERMARK = "^1closed alpha ^7private build published on 10/04/2022"

require("ui.uieditor.blak.warzone.utility.Common")
require("ui.uieditor.blak.warzone.utility.HudUtility")
require("ui.uieditor.blak.warzone.utility.WidgetUtility")
require("ui.uieditor.blak.warzone.utility.Overlays")
require("ui.uieditor.blak.warzone.utility.Sequences")
require("ui.uieditor.blak.warzone.utility.Resolution")
require("ui.uieditor.blak.warzone.utility.AnimationTween")