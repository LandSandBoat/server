-----------------------------------------
-- Trust: Ajido-Marujido
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------------

local message_page_offset = 8

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.SHANTOTTO] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.STAR_SIBYL] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KORU_MORU] = tpz.trust.message_offset.TEAMWORK_3,
        [tpz.magic.spell.KARAHA_BARUHA] = tpz.trust.message_offset.TEAMWORK_4,
        [tpz.magic.spell.SEMIH_LAFIHNA] = tpz.trust.message_offset.TEAMWORK_5,
    })

    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0,
                        ai.r.MA, ai.s.MB_ELEMENT, tpz.magic.spellFamily.NONE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLOW, 60)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.NONE, 60)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
