-----------------------------------
-- xi.effect.BERSERK
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.ATTP, power)
    target:addMod(xi.mod.RATTP, power)
    target:addMod(xi.mod.DEFP, -power)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.ATTP, power)
    target:delMod(xi.mod.RATTP, power)
    target:delMod(xi.mod.DEFP, -power)
end

return effect_object
