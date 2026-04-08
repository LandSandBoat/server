-----------------------------------
-- xi.effect.BARAERO
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.WIND_MEVA, effect:getPower())
    effect:addMod(xi.mod.MDEF, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
