-----------------------------------------
-- Spell: Smite of Rage
-- Damage varies with TP
-- Spell cost: 28 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+3
-- Level: 34
-- Casting Time: 0.5 seconds
-- Recast Time: 13 seconds
-- Skillchain Element(s): Wind (can open Scission or Gravitation can close Detonation)
-- Combos: Undead Killer
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
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_DETONATION
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 2.25
    params.tp300 = 2.5
    params.azuretp = 2.53125
    params.duppercap = 35
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
