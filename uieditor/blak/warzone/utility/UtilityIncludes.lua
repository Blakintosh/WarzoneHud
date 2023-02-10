EnableGlobals()

if not Util then
    Util = {}
end

DebugPrint = function(message)
    Blak.DebugUtils.Log(message)
end

VERSION_WATERMARK = "^1alpha Jan 16 2023"

require("ui.uieditor.blak.warzone.utility.Common")
require("ui.uieditor.blak.warzone.utility.HudUtility")
require("ui.uieditor.blak.warzone.utility.WidgetUtility")
require("ui.uieditor.blak.warzone.utility.Overlays")
require("ui.uieditor.blak.warzone.utility.Sequences")
require("ui.uieditor.blak.warzone.utility.Resolution")
require("ui.uieditor.blak.warzone.utility.AnimationTween")