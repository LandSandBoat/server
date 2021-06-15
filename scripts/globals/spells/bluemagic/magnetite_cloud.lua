-----------------------------------------
-- Spell: Magnetite Cloud
-- Deals earth damage to enemies within a fan-shaped area originating from the caster. Additional effect: Weight
-- Spell cost: 86 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2
-- Level: 46
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Scission, Gravitation, and Darkness
-- Combos: Magic Defense Bonus
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
    params.damageType = xi.damageType.EARTH
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.multiplier = 2.0
    params.tMultiplier = 1.0
    params.duppercap = 56
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.2

    local resist = applyResistance(caster, target, spell, params)
    local HP = caster:getHP()
    local LVL = caster:getMainLvl()
    local damage = (HP / 6) + (LVL / 1.875)
	-- add convergence bonus
	if caster:hasStatusEffect(xi.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(xi.merit.CONVERGENCE) / 100)
		damage = damage * ConvergenceBonus
		caster:delStatusEffectSilent(xi.effect.CONVERGENCE)
	end
	-- add SDT penalty
	  --[[  local SDT = target:getMod(xi.mod.SDT_EARTH)
		if SDT < 100 then
			damage = damage * (SDT / 100)
		end]]
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (damage > 0 and resist >= 0.5) then
        local typeEffect = xi.effect.WEIGHT
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 50, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    return damage
end
return spell_object