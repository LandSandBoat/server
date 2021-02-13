-----------------------------------
-- tpz.effect.CHAOS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATTP, effect:getPower())
    target:addMod(tpz.mod.RATTP, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATTP, effect:getPower())
    target:delMod(tpz.mod.RATTP, effect:getPower())
end

return effect_object
