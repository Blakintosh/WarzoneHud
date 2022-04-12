EnableGlobals();

require("ui.util.T7OverchargedUtil")

-- Initialize everything, table needs to have the following properties:
--    mapname or modname: Enables debug mode and hot reloading when launched via the launcher
--    filespath: The path to the mod or map files that will be used for hot reloading eg [[.\maps\zm_factory\]]
--    workshopid: The id of the workshop item so the dll can be found
function InitializeT7Overcharged(options)
    if T7Overcharged then return false end

    local debug = false
    if options.mapname and Engine.GetCurrentMap() == options.mapname or
        options.modname and Engine.UsingModsUgcName() == options.modname then
        debug = true
    end

    -- The path that we copy the dll's from
    local dllPath = debug and options.filespath .. [[zone\]] or [[..\..\workshop\content\311210\]] .. options.workshopid .. "\\"
    local dll = "T7Overcharged.dll"

    SafeCall(function()
      EnableGlobals()
      local dllInit = require("package").loadlib(dllPath..dll, "init")

      -- Check if the dll was properly loaded
      if not dllInit then
        Engine.ComError( Enum.errorCode.ERROR_UI, "Unable to initialize T7Overcharged install the latest VCRedist" )
        return
      end

      -- Execute the dll
      dllInit()
    end)

    UIErrorHash.Remove()
    if debug then
<<<<<<< HEAD
      --HotReload.Start(options.filespath)
=======
      HotReload.Start(options.filespath)
>>>>>>> 5652735e0ed17ab8db29fabac5807724390f575e
    end
end
