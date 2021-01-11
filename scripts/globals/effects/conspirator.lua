----------------------------------------
-- tpz.effect.CONSPIRATOR
----------------------------------------
require("scripts/globals/status")
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SUBTLE_BLOW, effect:getPower())
    target:addMod(tpz.mod.ACC, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SUBTLE_BLOW, effect:getPower())
    target:delMod(tpz.mod.ACC, effect:getSubPower())
end

return effect_object
