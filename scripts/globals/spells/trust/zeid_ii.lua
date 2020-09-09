-----------------------------------------
-- Trust: Zeid II
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 906)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.SPAWN)

    -- Stun all the things!
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    -- Non-stun things
    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SOULEATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.LAST_RESORT)

    mob:setTPSkills({
        ['skills'] = {
            { ai.r.WS, tpz.ws.GROUND_STRIKE, 0 },
        },
        ['mode'] = ai.tp.CLOSER,
        ['skill_select'] = ai.s.RANDOM,
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
