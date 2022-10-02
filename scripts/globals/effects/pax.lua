-----------------------------------
-- xi.effect.PAX
--
-- Reduces Enmity Generation (Enmity -)
-- note: Value should be Negative in Item/Spell Script
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.ENMITY, power)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.ENMITY, power)
end

return effect_object
