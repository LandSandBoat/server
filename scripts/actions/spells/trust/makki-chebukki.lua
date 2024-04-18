-----------------------------------
-- Trust: Makki-Chebukki
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
	
    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 2000,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.FLASHY_SHOT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.BARRAGE,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.BARRAGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SHARPSHOT,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.SHARPSHOT)
	
	mob:addSimpleGambit(ai.t.TARGET, ai.c.TP_LT, 3000, ai.r.RATTACK, 0, 0)

    mob:setAutoAttackEnabled(false)
	
	mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.LONG_RANGE)	
	
	mob:setTrustTPSkillSettings(ai.tp.RANDOM, ai.s.RANDOM, 2000)

	mob:addMod(xi.mod.NO_SPELL_MP_DEPLETION, 50)
	
	mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)

    local power = mob:getMainLvl() / 10
    mob:addMod(xi.mod.MATT, power)
    mob:addMod(xi.mod.MACC, power)

 end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
