Wzu.Tween = {}
Wzu.TweenGraphs = {}

-- Introducing: Ricochet Anti-Cheat.
Wzu.TweenGraphs.inOutSine = function(x)
    return -(( math.cos(math.pi * x) - 1) / 2)
end
Wzu.TweenGraphs.linear = function(x)
    return x
end
-- Quintic graphs
Wzu.TweenGraphs.outQuint = function(x)
    return (1 - (1 - x)^5)
end
-- Cubic graphs
Wzu.TweenGraphs.inCubic = function(x)
    return x^3
end
-- Quadratic graphs
Wzu.TweenGraphs.inOutQuad = function(x)
    if x < 0.5 then
        return (2 * x * x)
    else
        return (1 - (-2 * x + 2)^2 / 2)
    end
end
Wzu.TweenGraphs.inQuad = function(x)
    return x*x
end
Wzu.TweenGraphs.outQuad = function(x)
    return (1 - (1 - x) * (1 - x))
end

local function NextInterpolationStep(self, startClock, timeElapsed, duration, tween, tweenUpdateCallback)
    local dur = 25 -- 40 hz.
    --local dur = 50 -- 20 hz. Do not increase as we approach the limits of the VM

    --[[
        1000 start
        1250 current
        say we're at step 4 (100)
        then we need to catch up by 150
            6 iterations in one
        1250 - 1000 = 250
        4 * 25 = 100
        250-100 = 150
        150 / 25 = 6

    ]]
    local amendedDur = dur

    local currentStepClock = Engine.CurrentGameTime()
    local timeStep = (currentStepClock - startClock)
    local outOfSync = (timeStep - timeElapsed)
    local iterationsToDo = math.floor(outOfSync / dur) + 1
    if iterationsToDo < 6 and iterationsToDo > 1 then
        amendedDur = dur * iterationsToDo
    end

    self:beginAnimation("keyframe", dur, false, false, CoD.TweenType.Linear)

    timeElapsed = timeElapsed + amendedDur

    if timeElapsed > duration then
        timeElapsed = duration
    end

    local progression = (timeElapsed / duration)
    
    local tv = tween(progression)

    tweenUpdateCallback(tv)

    self:registerEventHandler("transition_complete_keyframe", function(widget, event)
        if not event.interrupted then
            if timeElapsed >= duration then
                widget:processEvent({
                    name = "tween_complete"
                })
                return
            else
                NextInterpolationStep(widget, startClock, timeElapsed, duration, tween, tweenUpdateCallback)
                return
            end
        else
            widget:processEvent({
                name = "tween_complete",
                interrupted = true,
                progress = tv
            })
            return
        end
    end)
end

Wzu.Tween.interpolate = function(self, duration, tween, tweenUpdateCallback)
    tweenUpdateCallback(0)

    local startClock = Engine.CurrentGameTime()
    NextInterpolationStep(self, startClock, 0, duration, tween, tweenUpdateCallback)
end