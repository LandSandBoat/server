-----------------------------------
-- Trust: Tenzen
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, 1014)
end

spell_object.onSpellCast = function(caster, target, spell)

    -- Records of Eminence: Alter Ego: Tenzen
    if caster:getEminenceProgress(935) then
        xi.roe.onRecordTrigger(caster, 935)
    end

    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.IROHA] = xi.trust.message_offset.TEAMWORK_1,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.HASSO,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.THIRD_EYE)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER, ai.s.HIGHEST)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
