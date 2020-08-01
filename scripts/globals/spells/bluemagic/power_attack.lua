-----------------------------------------
-- Spell: Power Attack
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 5 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 1
-- Stat Bonus: MND+1
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain property: Reverberation (Can open Impaction or Induration)
-- Combos: Plantoid Killer
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_CRITICAL
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_REVERBERATION
    params.numhits = 1
    params.multiplier = 1.125
    params.tp150 = 0.5
    params.tp300 = 0.7
    params.azuretp = 0.8
    params.duppercap = 11 -- guesstimated crit %s for TP
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.3
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
