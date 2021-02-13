-----------------------------------
-- tpz.effect.WARRIORS_CHARGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.TRIPLE_ATTACK, effect:getPower())
    target:addMod(tpz.mod.DOUBLE_ATTACK, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.TRIPLE_ATTACK, effect:getPower())
    target:delMod(tpz.mod.DOUBLE_ATTACK, 100)
end

return effect_object
