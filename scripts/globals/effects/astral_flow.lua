-----------------------------------
-- tpz.effect.ASTRAL_FLOW
-----------------------------------
local effecttbl = {}

function onEffectGain(target, effect)
    target:recalculateAbilitiesTable()
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:recalculateAbilitiesTable()
end

return effecttbl
