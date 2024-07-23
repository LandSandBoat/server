-----------------------------------
-- xi.effect.HASTE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Overwrites regular Flurry Effect
    target:delStatusEffect(xi.effect.FLURRY_II)

    effect:addMod(xi.mod.HASTE_MAGIC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
