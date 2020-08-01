-----------------------------------------
-- Spell: Frenetic Rip
-- Delivers a threefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Demon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: INT+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Ice (can open Impaction, Compression, or Fragmentation can close Induration)
-- Combos: Accuracy Bonus
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
    params.scattr = SC_INDURATION
    params.numhits = 3
    params.multiplier = 1.36
    params.tp150 = 2.08
    params.tp300 = 2.36
    params.azuretp = 2.61
    params.duppercap = 75 -- D upper >=69
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
