-----------------------------------
-- Trust: Iroha II
-- Made by Graves
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/utils")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, 997)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)
	
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.THIRD_EYE)
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.HASSO, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO)
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 1000, ai.r.JA, ai.s.SPECIFIC, xi.ja.MEDITATE)
	
	mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.SHELL, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELLRA)
	
	mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLARE_II, 60)
	
	mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
	local power = mob:getMainLvl()
    mob:addMod(xi.mod.MATT, power)
    mob:addMod(xi.mod.MACC, power)
	mob:addMod(xi.mod.DEF, power)
	mob:addMod(xi.mod.MDEF, power)
	mob:addMod(xi.mod.ATT, power*2)
	mob:addMod(xi.mod.ACC, power*3)
	mob:addMod(xi.mod.SUBTLE_BLOW, 25)
	mob:addMod(xi.mod.DOUBLE_ATTACK, 20)
	mob:addMod(xi.mod.TRIPLE_ATTACK, 9)
	mob:addMod(xi.mod.STORETP, 400)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
