-----------------------------------------
-- Trust: Kupipi
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/gambits")
require("scripts/globals/status")
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

    mob:addGambit(ai.s.PARTY, ai.t.HPP_LTE, 25, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.rm.SELECT_SPECIFIC, CURE_I)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.rm.SELECT_SPECIFIC, CURE_I)

    mob:addGambit(ai.s.PARTY, ai.t.HPP_LTE, 75, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addGambit(ai.s.PARTY, ai.t.NOT_STATUS, tpz.effect.PROTECT, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.PROTECTRA)
    mob:addGambit(ai.s.PARTY, ai.t.NOT_STATUS, tpz.effect.SHELL, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.SHELLRA)

    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.POISON, ai.r.MA, ai.rm.SELECT_SPECIFIC, POISONA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.rm.SELECT_SPECIFIC, PARALYNA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.rm.SELECT_SPECIFIC, BLINDNA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.rm.SELECT_SPECIFIC, SILENA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.rm.SELECT_SPECIFIC, STONA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.rm.SELECT_SPECIFIC, VIRUNA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.rm.SELECT_SPECIFIC, CURSENA)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS, tpz.effect.CURSE_II, ai.r.MA, ai.rm.SELECT_SPECIFIC, CURSENA)

    mob:addGambit(ai.s.SELF, ai.t.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.rm.SELECT_SPECIFIC, ERASE)
    mob:addGambit(ai.s.PARTY, ai.t.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.rm.SELECT_SPECIFIC, ERASE)

    mob:addGambit(ai.s.TARGET, ai.t.NOT_STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.PARALYZE, 60)
    mob:addGambit(ai.s.TARGET, ai.t.NOT_STATUS, tpz.effect.SLOW, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.SLOW, 60)

    mob:addGambit(ai.s.TARGET, ai.t.NOT_STATUS, tpz.effect.FLASH, ai.r.MA, ai.rm.SELECT_SPECIFIC, FLASH, 60)
end
