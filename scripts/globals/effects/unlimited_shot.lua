-----------------------------------
-- xi.effect.UNLIMITED_SHOT
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNLIMITED_SHOT_EFFECT)

    target:addMod(xi.mod.ENMITY, -2 * jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNLIMITED_SHOT_EFFECT)

    target:delMod(xi.mod.ENMITY, -2 * jpValue)
end

return effect_object
