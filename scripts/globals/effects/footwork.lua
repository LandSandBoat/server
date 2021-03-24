-----------------------------------
-- xi.effect.FOOTWORK
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOOTWORK_EFFECT)

    target:addMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:addMod(xi.mod.KICK_DMG, effect:getPower() + jpLevel)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOOTWORK_EFFECT)

    target:delMod(xi.mod.KICK_ATTACK_RATE, 20)
    target:delMod(xi.mod.KICK_DMG, effect:getPower() + jpLevel)
end

return effect_object
