-----------------------------------
-- tpz.effect.BIND
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    effect:setPower(target:getSpeed())
    target:setSpeed(0)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setSpeed(effect:getPower())
end

return effect_object
