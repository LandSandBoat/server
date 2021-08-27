-----------------------------------
-- xi.effect.LEAVEGAME
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setAnimation(33)
    target:messageSystem(effect:getPower(), 30)
end

effect_object.onEffectTick = function(target, effect)
    if (effect:getTickCount() > 5) then
        target:leaveGame()
    else
        target:messageSystem(effect:getPower(), 30-effect:getTickCount()*5)
    end
end

effect_object.onEffectLose = function(target, effect)
    target:setAnimation(0)
end

return effect_object
