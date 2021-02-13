-----------------------------------
-- Trust: Prishe
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

local message_page_offset = 17

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1011)
end

spell_object.onSpellCast = function(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.ULMIA] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.CHERUKIKI] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KUKKI_CHEBUKKI] = tpz.trust.message_offset.TEAMWORK_3,
        [tpz.magic.spell.MAKKI_CHEBUKKI] = tpz.trust.message_offset.TEAMWORK_4,
        [tpz.magic.spell.MILDAURION] = tpz.trust.message_offset.TEAMWORK_5,
    })

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)
end

spell_object.onMobDespawn = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end

return spell_object
