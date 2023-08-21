-----------------------------------
-- xi.effect.PROWESS
-- Enhanced accuracy and ranged accuracy
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
-- This might not be % in retail. If not a % just change ACCP to just ACC
    target:addMod(xi.mod.ACC, effect:getPower())
    target:addMod(xi.mod.RACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, effect:getPower())
    target:delMod(xi.mod.RACC, effect:getPower())
end

return effectObject
