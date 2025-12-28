-----------------------------------
-- xi.effect.REFRESH
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getTier() >= 3 then
        target:delStatusEffect(xi.effect.SUBLIMATION_ACTIVATED)
        target:delStatusEffect(xi.effect.SUBLIMATION_COMPLETE)
    end

    effect:addMod(xi.mod.REFRESH, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
