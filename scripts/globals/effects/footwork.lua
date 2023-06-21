-----------------------------------
-- xi.effect.FOOTWORK
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOOTWORK_EFFECT)

    target:addMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:addMod(xi.mod.KICK_DMG, effect:getPower() + jpLevel)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOOTWORK_EFFECT)

    target:delMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:delMod(xi.mod.KICK_DMG, effect:getPower() + jpLevel)
end

return effectObject
