-----------------------------------
-- xi.effect.INNER_STRENGTH
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPP, 100)
    target:addMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPP, 100)
    target:delMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

return effect_object
