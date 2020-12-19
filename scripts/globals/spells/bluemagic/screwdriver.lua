-----------------------------------------
-- Spell: Screwdriver
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 21 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1, CHR+1, HP+10
-- Level: 26
-- Casting Time: 0.5 seconds
-- Recast Time: 14 seconds
-- Skillchain Element(s): Light (Primary) and Earth (Secondary) -- (can open Compression, Reverberation, Detonation, Liquefaction, or Distortion can close Transfixion, Scission, or Distortion)
-- Combos: Evasion Bonus
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
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.scattr2 = SC_SCISSION
    params.numhits = 1
    params.multiplier = 1.375
    params.tp150 = 1.375
    params.tp300 = 1.375
    params.azuretp = 1.375
    params.duppercap = 27
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.2
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
