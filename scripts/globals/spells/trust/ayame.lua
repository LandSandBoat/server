-----------------------------------
-- Trust: Ayame
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spell_object = {}

local message_page_offset = 4

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return tpz.trust.canCast(caster, spell, tpz.magic.spell.AYAME_UC)
end

spell_object.onSpellCast = function(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.GILGAMESH] = tpz.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.HASSO,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 1000,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.SPECIAL_AYAME)
end

spell_object.onMobDespawn = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end

return spell_object
