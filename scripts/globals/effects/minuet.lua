-----------------------------------
-- tpz.effect.MINUET
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATT, effect:getPower())
    target:addMod(tpz.mod.RATT, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATT, effect:getPower())
    target:delMod(tpz.mod.RATT, effect:getPower())
end

return effect_object
