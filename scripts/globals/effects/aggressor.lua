-----------------------------------
-- xi.effect.AGGRESSOR
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.AGGRESSOR_EFFECT)

    target:addMod(xi.mod.RACC, effect:getPower() + jpLevel)
    target:addMod(xi.mod.ACC, 25 + jpLevel)
    target:addMod(xi.mod.EVA, -25)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.AGGRESSOR_EFFECT)

    target:delMod(xi.mod.RACC, effect:getPower() + jpLevel)
    target:delMod(xi.mod.ACC, 25 + jpLevel)
    target:delMod(xi.mod.EVA, -25)
end

return effectObject
