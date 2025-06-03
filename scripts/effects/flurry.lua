-----------------------------------
-- xi.effect.FLURRY
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Overwrites regular Haste Effect
    target:delStatusEffect(xi.effect.HASTE)

    effect:addMod(xi.mod.SNAPSHOT, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
