-----------------------------------------
-- Trust: Trion
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, {
        [tpz.magic.spell.CURILLA] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.RAHAL] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.HALVER] = tpz.trust.message_offset.TEAMWORK_3,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.FLASH,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.FLASH)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    -- TODO: Table me
    local ROYAL_BASH = 3193
    local ROYAL_SAVIOUR = 3194
    mob:setTPSkills({
        ['skills'] = {
            { ai.r.MS, ROYAL_BASH, 0 },
            { ai.r.MS, ROYAL_SAVIOUR, 0 },

            { ai.r.WS, tpz.ws.RED_LOTUS_BLADE, 0 },
            { ai.r.WS, tpz.ws.FLAT_BLADE, 0 },
            { ai.r.WS, tpz.ws.SAVAGE_BLADE, 60 },
        },
        ['mode'] = ai.tp.ASAP,
        ['skill_select'] = ai.s.RANDOM,
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
