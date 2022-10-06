-----------------------------------
-- xi.effect.PAX
--
-- Reduces Enmity Generation (Enmity -)
-- note: Value should be Negative in Item/Spell Script
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.ENMITY, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.ENMITY, power)
end

return effectObject
