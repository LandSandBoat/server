-----------------------------------------
-- Trust: Excenmille
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1004)
end

function onSpellCast(caster, target, spell)
    local SandoriaFirstTrust = caster:getCharVar("SandoriaFirstTrust")
    local zone = caster:getZoneID()

    if SandoriaFirstTrust == 1 and (zone == tpz.zone.WEST_RONFAURE or zone == tpz.zone.EAST_RONFAURE) then
        caster:setCharVar("SandoriaFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    -- TODO: Spells table /cry
    local FLASH  = 112

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.SENTINEL,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SENTINEL)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.FLASH,
                        ai.r.MA, ai.s.SPECIFIC, FLASH)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000,
                        ai.r.WS, ai.s.SPECIFIC, tpz.ws.DOUBLE_THRUST)

    -- Excenmille is a PLD who uses a Polearm, so raise his MAIN_DMG_RATING (up from 1H Sword levels)
    local increase_damage_by_percent = 30
    mob:addMod(tpz.mod.MAIN_DMG_RATING, mob:getWeaponDmg() * (1.0 + (increase_damage_by_percent / 100)))
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
