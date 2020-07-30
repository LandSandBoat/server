-----------------------------------
--
-- Magic Shield BLOCKS all magic attacks
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    if effect:getPower() == 3 then -- arcane stomp
        target:addMod(tpz.mod.FIRE_ABSORB, 100)
        target:addMod(tpz.mod.EARTH_ABSORB, 100)
        target:addMod(tpz.mod.WATER_ABSORB, 100)
        target:addMod(tpz.mod.WIND_ABSORB, 100)
        target:addMod(tpz.mod.ICE_ABSORB, 100)
        target:addMod(tpz.mod.LTNG_ABSORB, 100)
        target:addMod(tpz.mod.LIGHT_ABSORB, 100)
        target:addMod(tpz.mod.DARK_ABSORB, 100)
    elseif effect:getPower() < 2 then
        target:addMod(tpz.mod.UDMGMAGIC, -101)
        if target:isPC() and target:hasTrait(77) then -- Iron Will
            target:addMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
        end
    else
        target:addMod(tpz.mod.MAGIC_ABSORB, 100)
    end
end

function onEffectLose(target, effect)
    if effect:getPower() == 3 then -- arcane stomp
        target:delMod(tpz.mod.FIRE_ABSORB, 100)
        target:delMod(tpz.mod.EARTH_ABSORB, 100)
        target:delMod(tpz.mod.WATER_ABSORB, 100)
        target:delMod(tpz.mod.WIND_ABSORB, 100)
        target:delMod(tpz.mod.ICE_ABSORB, 100)
        target:delMod(tpz.mod.LTNG_ABSORB, 100)
        target:delMod(tpz.mod.LIGHT_ABSORB, 100)
        target:delMod(tpz.mod.DARK_ABSORB, 100)
    elseif effect:getPower() < 2 then
        target:delMod(tpz.mod.UDMGMAGIC, -101)
        if target:isPC() and target:hasTrait(77) then -- Iron Will
            target:delMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
        end
    else
        target:delMod(tpz.mod.MAGIC_ABSORB, 100)
    end
end
