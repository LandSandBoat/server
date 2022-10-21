-----------------------------------
-- xi.effect.PHYSICAL_SHIELD
-- Blocks physical damage and effects depending on Power
--
-- Power Notes:
--  0 - 50%  DMGPHYS (e.g. Fanatics Tonic)
--  1 -100% UDMGPHYS (e.g. Carnal Incense, Pyric Bulwark, Fanatic's Drink)
--  2  100% PHYS_ABSORB (e.g. Transmogrification)
--
-- subPower Notes: --TODO plumb in logic for special use cases.
--  0 - DMG Reduction applies to Physical Damage and Physical WS/TP Moves
--  1 - DMG Reduction applies to Physical Damage, Physical WS/TP Moves, and certain Magical TP Moves
--  2 - DMG Reduction applies to Physical Damage (but not WS/TP Moves, specific to Carnal Incense)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 2 then
        target:addMod(xi.mod.PHYS_ABSORB, 100) -- Percent not /10000
    elseif power == 1 then
        target:addMod(xi.mod.UDMGPHYS, -10000)
    else
        target:addMod(xi.mod.DMGPHYS, -5000)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power == 2 then
        target:delMod(xi.mod.PHYS_ABSORB, 100) -- Percent not /10000
    elseif power == 1 then
        target:delMod(xi.mod.UDMGPHYS, -10000)
    else
        target:delMod(xi.mod.DMGPHYS, -5000)
    end
end

return effectObject
