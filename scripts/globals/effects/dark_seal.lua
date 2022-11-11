-----------------------------------
-- xi.effect.DARK_SEAL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DARK_MAGIC_CAST, -effect:getPower())
    target:addMod(xi.mod.DARK_MAGIC_DURATION, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DARK_MAGIC_CAST, -effect:getPower())
    target:delMod(xi.mod.DARK_MAGIC_DURATION, effect:getSubPower())
end

return effectObject
