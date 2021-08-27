-----------------------------------
-- xi.effect.SUBTLE_SORCERY
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SUBTLE_SORCERY_EFFECT)

    target:addMod(xi.mod.MACC, 100)
    target:addMod(xi.mod.UFASTCAST, jpValue)
end

effect_object.onEffectTick = function(target, effect)
    target:addMod(xi.mod.ENMITY, -20)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SUBTLE_SORCERY_EFFECT)

    target:delMod(xi.mod.MACC, 100)
    target:delMod(xi.mod.ENMITY)
    target:delMod(xi.mod.UFASTCAST, jpValue)
end

return effect_object
