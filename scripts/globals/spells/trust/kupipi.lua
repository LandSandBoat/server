-----------------------------------------
-- Trust: Kupipi
-----------------------------------------
require("scripts/globals/trust")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    local WindurstFirstTrust = caster:getCharVar("WindurstFirstTrust")
    local zone = caster:getZoneID()

    if WindurstFirstTrust == 1 and (zone == tpz.zone.EAST_SARUTABARUTA or zone == tpz.zone.WEST_SARUTABARUTA) then
        caster:setCharVar("WindurstFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addListener("COMBAT_TICK", "KUPIPI_COMBAT_TICK", function(trust, master, target)
        function round(x)
            return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
        end
        
        local party = master:getPartyWithTrusts()
        local lvl = trust:getMainLvl()
        local maxCure = utils.clamp(round(lvl/8), 1, 6)

        for _, member in ipairs(party) do
            if member:getHPP() <= 75 then
                trust:castSpell(maxCure, member)
            end
        end
    end)
end
