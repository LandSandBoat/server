-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(tpz.mod.HPP, -effect:getPower())
    target:addMod(tpz.mod.MPP, -effect:getPower())
    target:addMod(tpz.mod.MOVE, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(tpz.mod.HPP, -effect:getPower())
    target:delMod(tpz.mod.MPP, -effect:getPower())
    target:delMod(tpz.mod.MOVE, -effect:getPower())
end
