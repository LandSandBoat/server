-----------------------------------
-- Trust: Rainemard
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

spell_object.onMobSpawn = function(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.COMPOSURE, ai.r.JA, ai.s.SPECIFIC, xi.ja.COMPOSURE)
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.MPP_LT, 5, ai.r.JA, ai.s.SPECIFIC, xi.ja.CONVERT)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.MELEE, ai.c.NOT_STATUS, xi.effect.HASTE, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.NOT_STATUS, xi.effect.REFRESH, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.REFRESH)
    mob:addSimpleGambit(ai.t.RANGED, ai.c.NOT_STATUS, xi.effect.FLURRY, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.FLURRY)
    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.NOT_STATUS, xi.effect.PHALANX, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.STATUS_FLAG, xi.effectFlag.DISPELABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.DISPEL)
	
	mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.ENBLIZZARD, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ENBLIZZARD, 60)
   	
	mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.DIA, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.DIA, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.SLOW, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SLOW, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.EVASION_DOWN, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.DISTRACT, 60)	
	
	mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
	local power = mob:getMainLvl()
    mob:addMod(xi.mod.MATT, power)
    mob:addMod(xi.mod.MACC, power)
	mob:addMod(xi.mod.DEF, power)
	mob:addMod(xi.mod.MDEF, power)
	mob:addMod(xi.mod.DOUBLE_ATTACK, 50)
	mob:addMod(xi.mod.TRIPLE_ATTACK, 20)
	mob:addMod(xi.mod.ENSPELL_DMG, power)
    mob:addMod(xi.mod.HASTE_MAGIC, power)
	mob:addMod(xi.mod.ATT, power)
	mob:addMod(xi.mod.ACC, power)
	end

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

return spell_object
