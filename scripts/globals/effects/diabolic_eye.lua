-----------------------------------
-- xi.effect.DIABOLIC_EYE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15 + effect:getPower())
    target:addMod(xi.mod.HPP, -15)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15 + effect:getPower())
    target:delMod(xi.mod.HPP, -15)
end

return effect_object
