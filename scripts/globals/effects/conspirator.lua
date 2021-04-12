-----------------------------------
-- xi.effect.CONSPIRATOR
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CONSPIRATOR_EFFECT)

    target:addMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:addMod(xi.mod.ACC, effect:getSubPower() + jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CONSPIRATOR_EFFECT)

    target:delMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:delMod(xi.mod.ACC, effect:getSubPower() + jpValue)
end

return effect_object
