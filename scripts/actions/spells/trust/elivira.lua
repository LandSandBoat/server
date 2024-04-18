-----------------------------------
-- Trust: Elivira
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)
	
		mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.BARRAGE,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.BARRAGE)
						
		mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.BERSERK,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK)
	
		mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.DOUBLE_SHOT,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.DOUBLE_SHOT)
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.DECOY_SHOT,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.DECOY_SHOT)

	mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0)

    mob:setAutoAttackEnabled(true)
	
	mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NO_MOVE)
	
	mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
