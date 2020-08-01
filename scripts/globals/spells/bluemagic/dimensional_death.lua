-----------------------------------------
-- Spell: Dimensional Death
-- Damage varies with TP
-- Spell cost: 48 MP
-- Monster Type: Undead
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 5
-- Stat Bonus: DEX+1, CHR+1, HP+5
-- Level: 60
-- Casting Time: 0.5 seconds
-- Recast Time: 23.75 seconds
-- Skillchain Properties: Impaction (can open Liquefaction or Detonation can close Impaction or Fusion)
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
    params.tpmod = TPMOD_ATTACK
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_IMPACTION
    params.numhits = 1
    params.multiplier = 2.25
    params.tp150 = 1.2
    params.tp300 = 1.4
    params.azuretp = 1.5
    params.duppercap = 70 --guesstimated attack % bonuses
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
