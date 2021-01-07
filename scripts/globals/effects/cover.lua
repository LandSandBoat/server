-----------------------------------
-- tpz.mod.COVER_EFFECT
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setLocalVar("COVER_ABILITY_TARGET", 0)
end

return effect_object
