-----------------------------------
-- tpz.effect.INHIBIT_TP
-- Reduces TP Gain By a % Factor
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.INHIBIT_TP, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.INHIBIT_TP, effect:getPower())
end

return effect_object
