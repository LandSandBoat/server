-----------------------------------
-- xi.effect.PROWESS
-- Enhanced magic acc. and magic atk
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MATT, effect:getPower())
    target:addMod(xi.mod.MACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MATT, effect:getPower())
    target:delMod(xi.mod.MACC, effect:getPower())
end

return effectObject
