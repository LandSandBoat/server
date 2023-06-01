-----------------------------------
-- xi.effect.OVERKILL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_SHOT_RATE, 100)
    target:addMod(xi.mod.TRIPLE_ATTACK, 33)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_SHOT_RATE, 100)
    target:delMod(xi.mod.TRIPLE_ATTACK, 33)
end

return effectObject
