-----------------------------------
-- xi.effect.DARK_SEAL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Overwrites
    target:delStatusEffectSilent(xi.effect.DIVINE_EMBLEM)
    target:delStatusEffectSilent(xi.effect.DIVINE_SEAL)
    target:delStatusEffectSilent(xi.effect.ELEMENTAL_SEAL)

    effect:addMod(xi.mod.DARK_MAGIC_CAST, -effect:getPower())
    effect:addMod(xi.mod.DARK_MAGIC_DURATION, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
