-----------------------------------
-- xi.effect.INHIBIT_TP
-- Reduces TP Gain By a % Factor
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INHIBIT_TP, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INHIBIT_TP, effect:getPower())
end

return effectObject
