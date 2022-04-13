-----------------------------------
-- Trust: Maximilian
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
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)
	
-- Shadows are represented by xi.effect.COPY_IMAGE, but with different icons depending on the tier
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.COPY_IMAGE, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.UTSUSEMI)

	mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.HIGHEST)
	local power = mob:getMainLvl()
    mob:addMod(xi.mod.MATT, power)
    mob:addMod(xi.mod.MACC, power)
	mob:addMod(xi.mod.DEF, power)
	mob:addMod(xi.mod.MDEF, power)
	mob:addMod(xi.mod.ATT, power)
	mob:addMod(xi.mod.ACC, power*2) 
	mob:addMod(xi.mod.TRIPLE_ATTACK, 5)
	mob:addMod(xi.mod.DUAL_WIELD, 10)
	mob:addMod(xi.mod.TREASURE_HUNTER, 1)
	mob:addMod(xi.mod.DOUBLE_ATTACK, 15)
	end
	
spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object




