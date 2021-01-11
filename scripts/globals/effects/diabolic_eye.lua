-----------------------------------
-- tpz.effect.DIABOLIC_EYE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ACC, 15 + effect:getPower())
    target:addMod(tpz.mod.HPP, -15)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ACC, 15 + effect:getPower())
    target:delMod(tpz.mod.HPP, -15)
end

return effect_object
