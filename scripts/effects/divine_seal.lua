-----------------------------------
-- xi.effect.DIVINE_SEAL
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Overwrites
    target:delStatusEffectSilent(xi.effect.DARK_SEAL)
    target:delStatusEffectSilent(xi.effect.DIVINE_EMBLEM)
    target:delStatusEffectSilent(xi.effect.ELEMENTAL_SEAL)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
