-----------------------------------
-- tpz.effect.BIND
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    effect:setPower(target:getSpeed())
    target:setSpeed(0)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setSpeed(effect:getPower())
end

return effect_object
