-----------------------------------------
-- Trust: Iron Eater
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
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
    })

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:setTPSkills({
        ['skills'] = {
            { ai.r.WS, tpz.ws.SHIELD_BREAK, 0 },
            { ai.r.WS, tpz.ws.ARMOR_BREAK, 0 },
            { ai.r.WS, tpz.ws.STEEL_CYCLONE, 60 },
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
