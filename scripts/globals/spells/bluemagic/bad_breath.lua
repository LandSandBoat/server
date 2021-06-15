-----------------------------------------
-- Spell: Bad Breath
-- Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster
-- Spell cost: 212 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 5
-- Stat Bonus: INT+2, MND+2
-- Level: 61
-- Casting Time: 8.75 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: Fast Cast
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
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    local multi = 2.08
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 0.50
    end
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.EARTH
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
    local HP = caster:getHP()
    local LVL = caster:getMainLvl()
    local damage = (HP / 8) + (LVL / 3)
	local vermin = (target:getSystem() == 20)
	local beast = (target:getSystem() == 6)
	
	if beast then
		damage = damage * 1.25
	elseif vermin then
		damage = damage * 0.75
	end
	-- add convergence bonus
	if caster:hasStatusEffect(xi.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(xi.merit.CONVERGENCE) / 100)
		damage = damage * ConvergenceBonus
		caster:delStatusEffectSilent(xi.effect.CONVERGENCE)
	end
	-- add SDT penalty
	    --[[local SDT = target:getMod(xi.mod.SDT_EARTH)
		if SDT < 100 then
			damage = damage * (SDT / 100)
		end]]
	
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local params = {}
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)

    if (damage > 0 and resist >= 0.5) then
        local typeEffect = xi.effect.PARALYSIS
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 25, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.WEIGHT
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 40, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.POISON
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 4, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.SLOW
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 2000, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.SILENCE
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 25, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.BIND
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 1, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end
    if (damage > 0 and resist >= 0.5) then
    local typeEffect = xi.effect.BLINDNESS
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 25, 0, getBlueEffectDuration(caster, resist, typeEffect, false))
    end

    return damage

end

return spell_object
