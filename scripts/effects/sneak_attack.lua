-----------------------------------
-- xi.effect.SNEAK_ATTACK
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SNEAK_ATTACK_EFFECT)
    target:addMod(xi.mod.SNEAK_ATK_DEX, jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SNEAK_ATTACK_EFFECT)
    target:delMod(xi.mod.SNEAK_ATK_DEX, jpValue)
end

return effectObject
