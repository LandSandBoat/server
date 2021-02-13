-----------------------------------
-- tpz.effect.DEFENDER
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEFP, 25)
    target:addMod(tpz.mod.RATTP, -25)
    target:addMod(tpz.mod.ATTP, -25)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEFP, 25)
    target:delMod(tpz.mod.ATTP, -25)
    target:delMod(tpz.mod.RATTP, -25)
end

return effect_object
