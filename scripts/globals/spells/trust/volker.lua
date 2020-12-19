-----------------------------------------
-- Trust: Volker
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 7

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.CID] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KLARA] = tpz.trust.message_offset.TEAMWORK_3,
    })

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
