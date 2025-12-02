-----------------------------------
-- xi.effect.MAGIC_DEF_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MDEF, -effect:getPower()) -- Reduce MDB by N
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
