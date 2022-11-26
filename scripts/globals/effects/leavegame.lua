-----------------------------------
-- xi.effect.LEAVEGAME
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setAnimation(33)
    target:messageSystem(effect:getPower(), 30)
end

effectObject.onEffectTick = function(target, effect)
    if effect:getTickCount() > 5 then
        target:leaveGame()
    else
        target:messageSystem(effect:getPower(), 30 - effect:getTickCount() * 5)
    end
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimation(0)
end

return effectObject
