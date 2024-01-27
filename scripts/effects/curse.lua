-----------------------------------
-- xi.effect.CURSE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(xi.mod.HPP, -effect:getPower())
    target:addMod(xi.mod.MPP, -effect:getPower())
    target:addMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(xi.mod.HPP, -effect:getPower())
    target:delMod(xi.mod.MPP, -effect:getPower())
    target:delMod(xi.mod.MOVE_SPEED_WEIGHT_PENALTY, effect:getPower())
end

return effectObject
