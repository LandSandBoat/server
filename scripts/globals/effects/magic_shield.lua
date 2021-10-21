-----------------------------------
-- xi.effect.MAGIC_SHIELD
-- BLOCKS all magic attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if effect:getPower() == 3 then -- arcane stomp
        target:addMod(xi.mod.FIRE_ABSORB, 100)
        target:addMod(xi.mod.EARTH_ABSORB, 100)
        target:addMod(xi.mod.WATER_ABSORB, 100)
        target:addMod(xi.mod.WIND_ABSORB, 100)
        target:addMod(xi.mod.ICE_ABSORB, 100)
        target:addMod(xi.mod.LTNG_ABSORB, 100)
        target:addMod(xi.mod.LIGHT_ABSORB, 100)
        target:addMod(xi.mod.DARK_ABSORB, 100)
    elseif effect:getPower() < 2 then
        target:addMod(xi.mod.UDMGMAGIC, -10000)
        if target:isPC() and target:hasTrait(77) then -- Iron Will
            target:addMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
        end
    else
        target:addMod(xi.mod.MAGIC_ABSORB, 100)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if effect:getPower() == 3 then -- arcane stomp
        target:delMod(xi.mod.FIRE_ABSORB, 100)
        target:delMod(xi.mod.EARTH_ABSORB, 100)
        target:delMod(xi.mod.WATER_ABSORB, 100)
        target:delMod(xi.mod.WIND_ABSORB, 100)
        target:delMod(xi.mod.ICE_ABSORB, 100)
        target:delMod(xi.mod.LTNG_ABSORB, 100)
        target:delMod(xi.mod.LIGHT_ABSORB, 100)
        target:delMod(xi.mod.DARK_ABSORB, 100)
    elseif effect:getPower() < 2 then
        target:delMod(xi.mod.UDMGMAGIC, -10000)
        if target:isPC() and target:hasTrait(77) then -- Iron Will
            target:delMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
        end
    else
        target:delMod(xi.mod.MAGIC_ABSORB, 100)
    end
end

return effect_object
