-----------------------------------
--
-- tpz.effect.BIND
--
-----------------------------------

function onEffectGain(target, effect)
    effect:setPower(target:speed())
    target:speed(0)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:speed(effect:getPower())
end
