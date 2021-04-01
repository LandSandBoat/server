-----------------------------------
-- xi.effect.CURSE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(xi.mod.HPP, -effect:getPower())
    target:addMod(xi.mod.MPP, -effect:getPower())
    target:addMod(xi.mod.MOVE, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(xi.mod.HPP, -effect:getPower())
    target:delMod(xi.mod.MPP, -effect:getPower())
    target:delMod(xi.mod.MOVE, -effect:getPower())
end

return effect_object
