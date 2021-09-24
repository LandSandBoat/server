-----------------------------------
-- Trust: Prishe
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, 1011)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ULMIA] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.CHERUKIKI] = xi.trust.message_offset.TEAMWORK_2,
        [xi.magic.spell.KUKKI_CHEBUKKI] = xi.trust.message_offset.TEAMWORK_3,
        [xi.magic.spell.MAKKI_CHEBUKKI] = xi.trust.message_offset.TEAMWORK_4,
        [xi.magic.spell.MILDAURION] = xi.trust.message_offset.TEAMWORK_5,
    })

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
