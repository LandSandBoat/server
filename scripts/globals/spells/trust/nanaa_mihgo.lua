-----------------------------------------
-- Trust: Nanaa Mihgo
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
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
    -- TODO: Table me
    local KING_COBRA_CLAMP = 3189
    
    tpz.trust.teamworkMessage(mob, {
        [tpz.magic.spell.ROMAA_MIHGO] = tpz.trust.message_offset.TEAMWORK_1,
    })

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.DESPOIL)

    mob:setTPSkills({
        ['skills'] = {
            { ai.r.WS, tpz.ws.WASP_STING, 0 },
            { ai.r.WS, tpz.ws.DANCING_EDGE, 0 },

            { ai.r.MS, KING_COBRA_CLAMP, 0 },
        },
        ['mode'] = ai.tp.OPENER,
        ['skill_select'] = ai.s.HIGHEST,
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
