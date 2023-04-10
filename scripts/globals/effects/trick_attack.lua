-----------------------------------
-- xi.effect.TRICK_ATTACK
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRICK_ATTACK_EFFECT)
    target:addMod(xi.mod.TRICK_ATK_AGI, jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRICK_ATTACK_EFFECT)
    target:delMod(xi.mod.TRICK_ATK_AGI, jpValue)
end

return effectObject
