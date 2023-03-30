-----------------------------------
-- Trust: August
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ARCIELA]   = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.TEODOR]    = xi.trust.message_offset.TEAMWORK_2,
        [xi.magic.spell.ROSULATIA] = xi.trust.message_offset.TEAMWORK_3,
        [xi.magic.spell.MORIMAR]   = xi.trust.message_offset.TEAMWORK_4,
    })

    mob:setMobSkillAttack(1197)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2500)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
