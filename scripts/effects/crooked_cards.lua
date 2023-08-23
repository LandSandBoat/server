-----------------------------------
-- xi.effect.CROOKED_CARDS
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PHANTOM_ROLL, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PHANTOM_ROLL, 100)
end

return effectObject
