-----------------------------------
-- Effect: Geo-Weight
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
end

return effectObject
