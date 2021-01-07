-----------------------------------
--
-- tpz.effect.COSTUME
--
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:costume(effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:costume(0)
end

return effecttbl
