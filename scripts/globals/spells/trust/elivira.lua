-----------------------------------
-- Trust: Elivira
-----------------------------------
require("scripts/globals/trust")
require("scripts/globals/ability")
require("scripts/globals/gambits")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)
	
		mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.EVOKERS_ROLL, ai.r.JA, ai.s.SPECIFIC, xi.ja.EVOKERS_ROLL)  -- Refresh
		mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.WARLOCKS_ROLL, ai.r.JA, ai.s.SPECIFIC, xi.ja.WARLOCKS_ROLL) -- Magic Accuracy

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0, 10)

    -- Notable: Uses a balance of melee and ranged attacks.
    -- TODO: Observe his WS behaviour on retail
    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
