-----------------------------------
-- xi.effect.SNEAK_ATTACK
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SNEAK_ATTACK_EFFECT)
    target:addMod(xi.mod.SNEAK_ATK_DEX, jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SNEAK_ATTACK_EFFECT)
    target:delMod(xi.mod.SNEAK_ATK_DEX, jpValue)
end

return effect_object
