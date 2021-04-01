-----------------------------------
-- xi.effect.VELOCITY_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATTP, -15)
    target:addMod(xi.mod.HASTE_ABILITY, -1500)
    target:addMod(xi.mod.RATTP, 15)
    target:addMod(xi.mod.RANGED_DELAYP, -10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATTP, -15)
    target:delMod(xi.mod.HASTE_ABILITY, -1500)
    target:delMod(xi.mod.RATTP, 15)
    target:delMod(xi.mod.RANGED_DELAYP, -10)
end

return effect_object
