-----------------------------------
-- xi.effect.CONSPIRATOR
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:addMod(xi.mod.ACC, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:delMod(xi.mod.ACC, effect:getSubPower())
end

return effect_object
