-----------------------------------
-- Trust: Volker
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spell_object = {}

local message_page_offset = 7

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.CID] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KLARA] = tpz.trust.message_offset.TEAMWORK_3,
    })

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)
end

spell_object.onMobDespawn = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end

return spell_object
