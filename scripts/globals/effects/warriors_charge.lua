-----------------------------------
-- xi.effect.WARRIORS_CHARGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.TRIPLE_ATTACK, effect:getPower())
    target:addMod(xi.mod.DOUBLE_ATTACK, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.TRIPLE_ATTACK, effect:getPower())
    target:delMod(xi.mod.DOUBLE_ATTACK, 100)
end

return effect_object
