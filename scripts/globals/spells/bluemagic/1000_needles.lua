-----------------------------------
-- Spell: 1000 Needles
-- Shoots multiple needles at enemies within range
-- Spell cost: 350 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: VIT+3, AGI+3
-- Level: 62
-- Casting Time: 12 seconds
-- Recast Time: 120 seconds
-- Bursts on Light affects accuracy only
-- Combos: Beast Killer
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
        params.tpmod = TPMOD_CRITICAL
        params.attackType = xi.attackType.MAGICAL
        params.damageType = xi.damageType.LIGHT
        params.scattr = SC_COMPRESSION
        params.numhits = 1
        params.multiplier = 1.5
        params.tp150 = 1.5
        params.tp300 = 1.5
        params.azuretp = 1.5
        params.duppercap = 49
        params.str_wsc = 1.0
        params.dex_wsc = 1.5
        params.vit_wsc = 0.0
        params.agi_wsc = 0.0
        params.int_wsc = 2.0
        params.mnd_wsc = 1.0
        params.chr_wsc = 1.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
	if target:isNM() then
		damage = 0
	else
		damage = 1000
	end
	-- add convergence bonus
	if caster:hasStatusEffect(tpz.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(tpz.merit.CONVERGENCE) / 100)
		damage = damage * ConvergenceBonus
		caster:delStatusEffectSilent(tpz.effect.CONVERGENCE)
	end

    return damage
end

return spell_object
