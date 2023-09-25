-----------------------------------
-- xi.effect.MAGIC_SHIELD
-- Blocks Magic damage and effects depending on power
-- Power Notes:
--  0 - 50%  DMGMAGIC (e.g. Fool's Tonic)
--  1 -100% UDMGMAGIC (e.g. Spiritual Incense, Polar Bulwark, Fool's Drink)
--  2 All Element Specific Absorb 100% (Arcane Stomp)
--  3 All Magic (incl. non-elemental) Absorb 100% (e.g. Mind Wall)
--
-- subPower Notes:
--  0 Standard Magic Shield (adds magic immunity)
--  1 Fake Magic Shield (does not resist non-damage spells)
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 3 then
        target:addMod(xi.mod.MAGIC_ABSORB, 100)
    elseif power == 2 then
        target:addMod(xi.mod.FIRE_ABSORB, 100)
        target:addMod(xi.mod.EARTH_ABSORB, 100)
        target:addMod(xi.mod.WATER_ABSORB, 100)
        target:addMod(xi.mod.WIND_ABSORB, 100)
        target:addMod(xi.mod.ICE_ABSORB, 100)
        target:addMod(xi.mod.LTNG_ABSORB, 100)
        target:addMod(xi.mod.LIGHT_ABSORB, 100)
        target:addMod(xi.mod.DARK_ABSORB, 100)
    elseif power == 1 then
        target:addMod(xi.mod.UDMGMAGIC, -10000)
    else
        target:addMod(xi.mod.DMGMAGIC, -5000)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power == 3 then
        target:delMod(xi.mod.MAGIC_ABSORB, 100)
    elseif power == 2 then
        target:delMod(xi.mod.FIRE_ABSORB, 100)
        target:delMod(xi.mod.EARTH_ABSORB, 100)
        target:delMod(xi.mod.WATER_ABSORB, 100)
        target:delMod(xi.mod.WIND_ABSORB, 100)
        target:delMod(xi.mod.ICE_ABSORB, 100)
        target:delMod(xi.mod.LTNG_ABSORB, 100)
        target:delMod(xi.mod.LIGHT_ABSORB, 100)
        target:delMod(xi.mod.DARK_ABSORB, 100)
    elseif power == 1 then
        target:delMod(xi.mod.UDMGMAGIC, -10000)
    else
        target:delMod(xi.mod.DMGMAGIC, -5000)
    end
end

return effectObject
