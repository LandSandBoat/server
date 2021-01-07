-----------------------------------
-- tpz.effect.ASTRAL_FLOW
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:recalculateAbilitiesTable()
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:recalculateAbilitiesTable()
end

return effect_object
