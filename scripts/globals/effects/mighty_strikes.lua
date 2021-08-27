-----------------------------------
-- xi.effect.MIGHTY_STRIKES
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.MIGHTY_STRIKES_EFFECT)

    target:addMod(xi.mod.CRITHITRATE, 100)
    target:addMod(xi.mod.ACC, jpLevel * 2)
    target:addMod(xi.mod.RACC, jpLevel * 2)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.MIGHTY_STRIKES_EFFECT)

    target:addMod(xi.mod.CRITHITRATE, -100)
    target:delMod(xi.mod.ACC, jpLevel * 2)
    target:delMod(xi.mod.RACC, jpLevel * 2)
end

return effect_object
