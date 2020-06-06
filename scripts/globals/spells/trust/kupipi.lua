-----------------------------------------
-- Trust: Kupipi
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/utils")
require("scripts/globals/weaponskillids")
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
    local CURE_I   = 1
    local POISONA  = 14
    local PARALYNA = 15
    local BLINDNA  = 16
    local SILENA   = 17
    local STONA    = 18
    local VIRUNA   = 19
    local CURSENA  = 20
    local FLASH    = 112
    local ERASE    = 143

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, CURE_I)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, CURE_I)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.PROTECTRA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.SHELL, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SHELLRA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC, POISONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, PARALYNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, BLINDNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, CURSENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_II, ai.r.MA, ai.s.SPECIFIC, CURSENA)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, ERASE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, ERASE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.PARALYZE, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLOW, 60)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.FLASH, ai.r.MA, ai.s.SPECIFIC, FLASH, 60)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000, ai.r.WS, ai.s.SPECIFIC, tpz.ws.STARLIGHT)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
