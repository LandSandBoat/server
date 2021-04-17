-----------------------------------
-- Trust: Ajido-Marujido
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

local message_page_offset = 8

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, message_page_offset, {
        [xi.magic.spell.SHANTOTTO] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.STAR_SIBYL] = xi.trust.message_offset.TEAMWORK_2,
        [xi.magic.spell.KORU_MORU] = xi.trust.message_offset.TEAMWORK_3,
        [xi.magic.spell.KARAHA_BARUHA] = xi.trust.message_offset.TEAMWORK_4,
        [xi.magic.spell.SEMIH_LAFIHNA] = xi.trust.message_offset.TEAMWORK_5,
    })

    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0,
                        ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25,
                        ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.SLOW,
                        ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SLOW, 60)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0,
                        ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE, 60)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, message_page_offset, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, message_page_offset, xi.trust.message_offset.DEATH)
end

return spell_object
