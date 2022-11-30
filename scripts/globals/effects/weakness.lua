-----------------------------------
-- xi.effect.WEAKNESS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    --reduce HP and MP by the power amount. Add 100% slow
    --NOTE: The power amount dictates the amount to REDUCE MAX VALUES BY. E.g. Power=75 means 'reduce max hp/mp by 75%'
    target:addMod(xi.mod.HPP, -75)
    target:addMod(xi.mod.MPP, -75)

    -- 100% Slow -- FIXME: Weakness should probably be its own source of slow
    target:addMod(xi.mod.HASTE_MAGIC, -10000)

    if effect:getPower() > 1 then
        -- handle double weakness
        target:addMod(xi.mod.RACC, -999)
        target:addMod(xi.mod.MATT, -999)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    --restore HP and MP to its former state. Remove 100% slow
    target:delMod(xi.mod.HPP, -75)
    target:delMod(xi.mod.MPP, -75)
    target:delMod(xi.mod.HASTE_MAGIC, -10000)

    if effect:getPower() > 1 then
        -- handle double weakness
        target:delMod(xi.mod.RACC, -999)
        target:delMod(xi.mod.MATT, -999)
    end
end

return effectObject
