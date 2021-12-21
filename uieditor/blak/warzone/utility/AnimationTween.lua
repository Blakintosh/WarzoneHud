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

local function NextInterpolationStep(self, timeElapsed, duration, tween, tweenUpdateCallback)
    local dur = 50 -- 20 hz. Do not increase as we approach the limits of the VM

    self:beginAnimation("keyframe", dur, false, false, CoD.TweenType.Linear)

    timeElapsed = timeElapsed + dur

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
                NextInterpolationStep(widget, timeElapsed, duration, tween, tweenUpdateCallback)
                return
            end
        else
            widget:processEvent({
                name = "tween_complete",
                interrupted = true
            })
            return
        end
    end)
end

Wzu.Tween.interpolate = function(self, duration, tween, tweenUpdateCallback)
    tweenUpdateCallback(0)
    NextInterpolationStep(self, 0, duration, tween, tweenUpdateCallback)
end