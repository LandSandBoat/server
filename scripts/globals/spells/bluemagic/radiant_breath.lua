-----------------------------------------
-- Spell: Radiant Breath
-- Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
-- Spell cost: 116 MP
-- Monster Type: Wyverns
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+1, HP+5
-- Level: 54
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local multi = 2.90
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 0.50
    end

    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.LIGHT
    params.multiplier = multi
    params.tMultiplier = 1.5
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0

    local resist = applyResistance(caster, target, spell, params)
    local HP = caster:getHP()
    local LVL = caster:getMainLvl()
    local damage = (HP / 5) + (LVL / 0.75)
	local demon = (target:getSystem() == 9)
	
	if demon then
		damage = damage * 1.25
	end
	-- add convergence bonus
	if caster:hasStatusEffect(xi.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(xi.merit.CONVERGENCE) / 100)
		damage = damage * ConvergenceBonus
		caster:delStatusEffectSilent(xi.effect.CONVERGENCE)
	end
	-- add SDT penalty
	    --[[local SDT = target:getMod(xi.mod.SDT_LIGHT)
		if SDT < 100 then
			damage = damage * (SDT / 100)
		end]]
	
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.SLOW
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 3500, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
        target:delStatusEffect(xi.effect.SILENCE)
        target:addStatusEffect(xi.effect.SILENCE, 25, 0, getBlueEffectDuration(caster, resist, xi.effect.SILENCE))
    end

    return damage
end
return spell_object