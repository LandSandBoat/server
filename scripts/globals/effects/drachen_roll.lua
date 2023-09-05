-----------------------------------
-- xi.effect.DRACHEN_ROLL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addPetMod(xi.mod.ACC, effect:getPower())
    target:addPetMod(xi.mod.RACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.ACC, effect:getPower())
    target:delPetMod(xi.mod.RACC, effect:getPower())
end

return effectObject
