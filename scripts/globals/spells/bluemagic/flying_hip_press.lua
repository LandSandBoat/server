-----------------------------------------
-- Spell: Flying Hip Press
-- Deals wind damage to enemies within range
-- Spell cost: 125 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 58
-- Casting Time: 5.75 seconds
-- Recast Time: 34.5 seconds
-- Magic Bursts On: Detonation, Fragmentation, and Light
-- Combos: Max HP Boost
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WIND
    params.multiplier = 2.775
    params.tMultiplier = 2.912
    params.duppercap = 58
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.5
    params.chr_wsc = 0.2
    local HP = caster:getHP()
	local damage = (HP / 3)
	-- add convergence bonus
	if caster:hasStatusEffect(xi.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(xi.merit.CONVERGENCE) / 100)
		damage = damage * ConvergenceBonus
		caster:delStatusEffectSilent(xi.effect.CONVERGENCE)
	end
	-- add SDT penalty
	    --[[local SDT = target:getMod(xi.mod.SDT_WIND)
		if SDT < 100 then
			damage = damage * (SDT / 100)
		end]]
    
	damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
return spell_object