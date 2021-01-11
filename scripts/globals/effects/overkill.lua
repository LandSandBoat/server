----------------------------------------
-- tpz.effect.OVERKILL
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
    target:addMod(tpz.mod.TRIPLE_ATTACK, 33)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
    target:delMod(tpz.mod.TRIPLE_ATTACK, 33)
end

return effect_object
