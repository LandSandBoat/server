-----------------------------------
-- xi.effect.DOUBLE_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.DOUBLE_SHOT_EFFECT)

    target:addMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.DOUBLE_SHOT_EFFECT)

    target:delMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end

return effect_object
