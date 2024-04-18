-----------------------------------
-- Trust: Rahal
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
	[xi.magic.spell.EXCENMILLE] = xi.trust.messageOffset.TEAMWORK_3,
	})
	
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE)
						
	mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50,
						ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.FLASH,
                        ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SENTINEL,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL)
						
	mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.RAMPART,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART)
						
				
	mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2000)
	
	mob:addMod(xi.mod.ENMITY, 15)
	
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
