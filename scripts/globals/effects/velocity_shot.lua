-----------------------------------
-- tpz.effect.VELOCITY_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATTP, -15)
    target:addMod(tpz.mod.HASTE_ABILITY, -1500)
    target:addMod(tpz.mod.RATTP, 15)
    target:addMod(tpz.mod.RANGED_DELAYP, -10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATTP, -15)
    target:delMod(tpz.mod.HASTE_ABILITY, -1500)
    target:delMod(tpz.mod.RATTP, 15)
    target:delMod(tpz.mod.RANGED_DELAYP, -10)
end

return effect_object
