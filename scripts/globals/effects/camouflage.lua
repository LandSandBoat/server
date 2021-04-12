-----------------------------------
-- xi.effect.CAMOUFLAGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CAMOUFLAGE_EFFECT)

    target:addMod(xi.mod.ENMITY, -25)
    target:addMod(xi.mod.CRITHITRATE, jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CAMOUFLAGE_EFFECT)

    target:delMod(xi.mod.ENMITY, -25)
    target:delMod(xi.mod.CRITHITRATE, jpValue)
end

return effect_object
