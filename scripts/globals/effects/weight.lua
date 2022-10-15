-----------------------------------
-- xi.effect.WEIGHT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setSpeed(target:getSpeed() - effect:getPower())
    target:addMod(xi.mod.EVA, -10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setSpeed(target:getSpeed() + effect:getPower())
    target:delMod(xi.mod.EVA, -10)
end

return effectObject
