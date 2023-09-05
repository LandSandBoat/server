-----------------------------------
-- xi.effect.BEAST_ROLL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addPetMod(xi.mod.ATTP, effect:getPower())
    target:addPetMod(xi.mod.RATTP, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.ATTP, effect:getPower())
    target:delPetMod(xi.mod.RATTP, effect:getPower())
end

return effectObject
