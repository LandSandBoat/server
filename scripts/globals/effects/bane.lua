-----------------------------------
-- tpz.effect.BANE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(tpz.mod.HPP, -effect:getPower())
    target:addMod(tpz.mod.MPP, -effect:getPower())
    target:addMod(tpz.mod.MOVE, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(tpz.mod.HPP, -effect:getPower())
    target:delMod(tpz.mod.MPP, -effect:getPower())
    target:addMod(tpz.mod.MOVE, -effect:getPower())
end

return effect_object
