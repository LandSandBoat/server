-----------------------------------
-- xi.effect.WARDING_CIRCLE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.WARDING_CIRCLE_EFFECT)

    target:addMod(xi.mod.DEMON_KILLER, effect:getPower() + jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.WARDING_CIRCLE_EFFECT)

    target:delMod(xi.mod.DEMON_KILLER, effect:getPower() + jpValue)
end

return effect_object
