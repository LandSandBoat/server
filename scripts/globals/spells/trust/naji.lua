-----------------------------------------
-- Trust: Naji
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    local BastokFirstTrust = caster:getCharVar("BastokFirstTrust")
    local zone = caster:getZoneID()

    if BastokFirstTrust == 1 and (zone == tpz.zone.NORTH_GUSTABERG or zone == tpz.zone.SOUTH_GUSTABERG) then
        caster:setCharVar("BastokFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000,
                        ai.r.WS, ai.s.SPECIFIC, tpz.ws.BURNING_BLADE)

    -- Naji is a WAR who uses a 1H Sword, so lower his MAIN_DMG_RATING (down from G.Axe levels)
    local reduce_damage_by_percent = 30
    mob:addMod(tpz.mod.MAIN_DMG_RATING, mob:getWeaponDmg() * (reduce_damage_by_percent / 100) * -1.0)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
