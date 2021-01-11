----------------------------------------
-- tpz.effect.WEAKNESS
----------------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --reduce HP and MP by the power amount. Add 100% slow
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(tpz.mod.HPP, -75)
    target:addMod(tpz.mod.MPP, -75)

    -- 100% Slow -- FIXME: Weakness should probably be its own source of slow
    target:addMod(tpz.mod.HASTE_MAGIC, -10000)

    if effect:getPower() == 2 then
        -- handle double weakness
        target:addMod(tpz.mod.RACC, -999)
        target:addMod(tpz.mod.MATT, -999)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(tpz.mod.HPP, -75)
    target:delMod(tpz.mod.MPP, -75)
    target:delMod(tpz.mod.HASTE_MAGIC, -10000)

    if (effect:getPower() == 2) then
        -- handle double weakness
        target:delMod(tpz.mod.RACC, -999)
        target:delMod(tpz.mod.MATT, -999)
    end
end

return effect_object
