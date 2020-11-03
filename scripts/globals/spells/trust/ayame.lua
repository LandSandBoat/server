-----------------------------------------
-- Trust: Ayame
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 4

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, tpz.magic.spell.AYAME_UC)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.GILGAMESH] = tpz.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.HASSO,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)

    mob:addFullGambit({
        ['predicates'] =
        {
            {
                ['target'] = ai.t.SELF, ['condition'] = ai.c.TP_LT, ['argument'] = 1000,
            },
            {
                ['target'] = ai.t.MASTER, ['condition'] = ai.c.TP_GTE, ['argument'] = 1000,
            },
        },
        ['actions'] =
        {
            {
                ['reaction'] = ai.r.JA, ['select'] = ai.s.SPECIFIC, ['argument'] = tpz.ja.MEDITATE,
            },
        },
    })

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.SPECIAL_AYAME)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
