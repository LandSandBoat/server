-----------------------------------
-- xi.effect.TRICK_ATTACK
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRICK_ATTACK_EFFECT)
    target:addMod(xi.mod.TRICK_ATK_AGI, jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRICK_ATTACK_EFFECT)
    target:delMod(xi.mod.TRICK_ATK_AGI, jpValue)
end

return effect_object
