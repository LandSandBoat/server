-----------------------------------
-- xi.effect.DOOM
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- minimum time is 10 seconds!
    if (effect:getPower() < 10) then
        effect:setPower(10)
    end
end

effect_object.onEffectTick = function(target, effect)
    local remainingTicks = 1 + (effect:getTimeRemaining() / 1000) / 3

    -- doom counter
    target:messagePublic(112, target, remainingTicks, remainingTicks)
end

effect_object.onEffectLose = function(target, effect)
    if (effect:getTimeRemaining() == 0) then
        target:setHP(0)
    end
end

return effect_object
