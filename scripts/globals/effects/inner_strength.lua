-----------------------------------
-- xi.effect.INNER_STRENGTH
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPP, 100)
    target:addMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPP, 100)
    target:delMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

return effectObject
