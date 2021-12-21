EnableGlobals()

if not Blak then
    Blak = {}
end

Blak.DebugUtils = {}

Blak.DebugUtils.DumpVariableInfo = function(Variable)
    local function ReportTableWidgets(TableRef, Indent)
        local IndentVal = ""
        if Indent then
            IndentVal = Indent
        end
        local ReturnVal = IndentVal
        for k, v in pairs(TableRef) do
            if type(v) == "number" or type(v) == "string" or type(v) == "boolean" then
                ReturnVal = ReturnVal .. "Key: "..k.." | Value: "..tostring(v).."\n" .. Indent
            elseif type(v) == "table" then
                ReturnVal = ReturnVal .. "NEW TABLE -----\n" .. ReportTableWidgets(v,  Indent .. "  ") .. Indent
            else
                ReturnVal = ReturnVal .. "Key: "..k.." | Value: cannot display (type "..type(v)..")\n" .. Indent
            end
        end

        return ReturnVal
    end

    local Report = ""

    if type(Variable) == "nil" then
        Report = Report .. "Variable is nil"
    elseif type(Variable) == "function" then
        Report = Report .. "Variable is a function pointer."
    elseif type(Variable) == "number" or type(Variable) == "string" or type(Variable) == "boolean" then
        Report = Report .. "Variable is a "..type(Variable)..". Value: "..tostring(Variable)
    elseif type(Variable) == "table" then
        Report = Report .. "Variable is a table. Table Widgetents:\n"
        
        for k, v in pairs(Variable) do
            if type(v) == "number" or type(v) == "string" or type(v) == "boolean" then
                Report = Report .. "Key: "..k.." | Value: "..tostring(v).."\n"
            elseif type(v) == "table" then
                Report = Report .. "Key: "..k.." | Value is a new table --------------------------\n" .. ReportTableWidgets(v,  "  ")
            else
                Report = Report .. "Key: "..k.." | Value: cannot display (type "..type(v)..")\n"
            end
        end 
    else
        Report = "Variable data, type is: "..type(Variable)
    end

    return Report
end

Blak.DebugUtils.DumpVariableInfoToFile = function(Variable, File)
    File = File or "test.txt"
    local Info = Blak.DebugUtils.DumpVariableInfo(Variable)
    
    local file = io.open(File, "wb")
    file:write(Info)
    file:close()
end

Blak.DebugUtils.Log = function(Text, File)
    File = File or "log.txt"

    local file = io.open(File, "ab")
    file:write(Text.."\r\n")
    file:close()
end

Blak.DebugUtils.SafeRunFunction = function(FunctionRef, Note, WriteToLogs)
    local ok, result = pcall(FunctionRef)
    
    if not ok and result then
        if not Note then
            if not WriteToLogs then
                Engine.ComError(Enum.errorCode.ERROR_UI, "Blak.DebugUtils.SafeRunFunction call failed. Error:\n"..result)
            else
                Blak.DebugUtils.Log("Blak.DebugUtils.SafeRunFunction call failed. Error:\n"..result)
            end
            
        else
            if not WriteToLogs then
                Engine.ComError(Enum.errorCode.ERROR_UI, "Blak.DebugUtils.SafeRunFunction call failed (Noted as: "..Note.."). Error:\n"..result)
            else
                Blak.DebugUtils.Log("Blak.DebugUtils.SafeRunFunction call failed (Noted as: "..Note.."). Error:\n"..result)
            end
        end
    elseif result then
        return result
    end
end

Blak.DebugWidget = InheritFrom(LUI.UIElement)

local DebugWidget_PreLoadFunc = function(InstanceRef, SubscriptionPt1, Subscription)
    local SubscriptionModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), SubscriptionPt1), Subscription)
    Engine.SetModelValue(SubscriptionModel, 0)
end

Blak.DebugWidget.new = function(HudRef, InstanceRef, SubscriptionPt1, Subscription) --use a huditems thx
    local Widget = LUI.UIElement.new()
    
    if PreLoadFunc then
        PreLoadFunc(InstanceRef, SubscriptionPt1, Subscription)
    end
    
    Widget:setUseStencil(false)
    Widget:setClass(Blak.DebugWidget)
    Widget.id = "DebugWidget"
    Widget.soundSet = "default"
    Widget.anyChildUsesUpdateState = true
    
    Widget.title = LUI.UIText.new()
    Widget.title:setLeftRight(true, false, 0, 60)
    Widget.title:setTopBottom(true, false, 0, 12)
    Widget.title:setText("DEBUG WIDGET")
    
    Widget:addElement(Widget.title)

    Widget.data = LUI.UIText.new()
    Widget.data:setLeftRight(true, false, 0, 60)
    Widget.data:setTopBottom(true, false, 12, 42)
    Widget.data:setText("0")

    Widget.data:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), SubscriptionPt1.."."..Subscription), function(ModelRef)
        local ModelVal = Engine.GetModelValue(ModelRef)
        if ModelVal then
            Widget.data:setText(ModelVal)
        end
    end)
    
    Widget:addElement(Widget.data)
    
    if PostLoadFunc then
        PostLoadFunc(HudRef, InstanceRef)
    end
    
    return Widget
end