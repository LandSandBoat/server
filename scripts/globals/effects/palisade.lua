-----------------------------------
-- xi.effect.PALISADE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PALISADE_BLOCK_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PALISADE_BLOCK_BONUS, effect:getPower())
end

return effectObject
