-----------------------------------
-- tpz.effect.OBLIVISCENCE
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:recalculateStats()
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:recalculateStats()
end

return effect_object
