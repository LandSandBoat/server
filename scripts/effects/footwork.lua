-----------------------------------
-- xi.effect.FOOTWORK
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOOTWORK_EFFECT)

    effect:addMod(xi.mod.KICK_ATTACK_RATE, 20)
    effect:addMod(xi.mod.KICK_DMG, effect:getPower() + jpLevel)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
