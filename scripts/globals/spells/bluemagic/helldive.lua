-----------------------------------------
-- Spell: Helldive
-- Damage varies with TP
-- Spell cost: 16 MP
-- Monster Type: Birds
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: CHR+1, HP+5
-- Level: 16
-- Casting Time: 0.5 seconds
-- Recast Time: 11.25 seconds
-- Skillchain Property: Transfixion (can open Compression, Reverberation, or Distortion)
-- Combos: None
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
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_TRANSFIXION
    params.numhits = 1
    params.multiplier = 1.25
    params.tp150 = 1.625
    params.tp300 = 2.00
    params.azuretp = 2.125
    params.duppercap = 19
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
