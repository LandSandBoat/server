-----------------------------------
-- xi.effect.DOOM
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- minimum time is 10 seconds!
    if effect:getPower() < 10 then
        effect:setPower(10)
    end
end

effectObject.onEffectTick = function(target, effect)
    local remainingTicks = 1 + (effect:getTimeRemaining() / 1000) / 3

    -- doom counter
    target:messagePublic(112, target, remainingTicks, remainingTicks)
end

effectObject.onEffectLose = function(target, effect)
    if effect:getTimeRemaining() == 0 then
        target:setHP(0)
    end
end

return effectObject
