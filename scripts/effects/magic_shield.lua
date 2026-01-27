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
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 3 then
        effect:addMod(xi.mod.MAGIC_ABSORB, 100)
    elseif power == 2 then
        effect:addMod(xi.mod.FIRE_ABSORB, 100)
        effect:addMod(xi.mod.EARTH_ABSORB, 100)
        effect:addMod(xi.mod.WATER_ABSORB, 100)
        effect:addMod(xi.mod.WIND_ABSORB, 100)
        effect:addMod(xi.mod.ICE_ABSORB, 100)
        effect:addMod(xi.mod.LTNG_ABSORB, 100)
        effect:addMod(xi.mod.LIGHT_ABSORB, 100)
        effect:addMod(xi.mod.DARK_ABSORB, 100)
    elseif power == 1 then
        effect:addMod(xi.mod.UDMGMAGIC, -10000)
    else
        effect:addMod(xi.mod.DMGMAGIC, -5000)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
