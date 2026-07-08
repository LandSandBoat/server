-----------------------------------
-- xi.effect.DOOM
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    local remainingTicks = math.floor(effect:getTimeRemaining() / 1000 - 0.5) / 3

    -- doom counter
    target:messagePublic(xi.msg.basic.DOOM_COUNTER, target, remainingTicks, remainingTicks)
end

effectObject.onEffectLose = function(target, effect)
    if effect:getTimeRemaining() == 0 then
        target:setHP(0)
    end
end

return effectObject
