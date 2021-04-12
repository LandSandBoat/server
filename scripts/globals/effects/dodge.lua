-----------------------------------
-- xi.effect.DODGE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DODGE_EFFECT) * 2
    target:addMod(xi.mod.EVA, effect:getPower() + jpLevel)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DODGE_EFFECT) * 2
    target:delMod(xi.mod.EVA, effect:getPower() + jpLevel)
end

return effect_object
