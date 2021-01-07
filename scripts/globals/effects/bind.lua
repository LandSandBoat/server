-----------------------------------
-- tpz.effect.BIND
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    effect:setPower(target:getSpeed())
    target:setSpeed(0)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setSpeed(effect:getPower())
end

return effecttbl
