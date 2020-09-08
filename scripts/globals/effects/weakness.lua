-----------------------------------
--
-- Weakness
--
-----------------------------------
require("scripts/globals/status")
function onEffectGain(target, effect)
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

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
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
